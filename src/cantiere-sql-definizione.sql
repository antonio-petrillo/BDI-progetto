CREATE DATABASE cantiere
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE SCHEMA IF NOT EXISTS cantiere
    AUTHORIZATION postgres;

CREATE TYPE cantiere.ruolo AS ENUM
    ('semplice', 'idraulico', 'macchinista', 'elettricista', 'operatore');

CREATE TYPE cantiere.zona AS ENUM
    ('servizi_pubblici', 'zona_verde', 'zona_residenziale', 'zona_ristorazione');

CREATE TYPE cantiere.tipo AS ENUM
       ('gas', 'rumore');

CREATE TABLE cantiere.amministratore(
       id SERIAL PRIMARY KEY,
       nome VARCHAR(50) NOT NULL,
       cognome VARCHAR(50) NOT NULL);

CREATE TABLE cantiere.capocantiere(
       id SERIAL PRIMARY KEY,
       nome VARCHAR(50) NOT NULL,
       cognome VARCHAR(50) NOT NULL);

CREATE TABLE cantiere.luogo(
       id SERIAL PRIMARY KEY,
       citta VARCHAR(50) NOT NULL,
       CAP VARCHAR(5) NOT NULL,
       indirizzo VARCHAR(50) NOT NULL,
       numero_civico INT);

CREATE TABLE cantiere.cantiere(
       id SERIAL PRIMARY KEY,
       data_inizio DATE NOT NULL,
       data_fine_prevista DATE NOT NULL,
       aperto_da SERIAL,
       luogo_id SERIAL,
       FOREIGN KEY (luogo_id)
               REFERENCES
                cantiere.luogo(id)
                    ON UPDATE CASCADE,
       FOREIGN KEY (aperto_da)
               REFERENCES
                cantiere.amministratore(id)
                    ON UPDATE CASCADE);

CREATE TABLE cantiere.operaio(
       id SERIAL PRIMARY KEY,
       nome VARCHAR(50) NOT NULL,
       cognome VARCHAR(50) NOT NULL,
       ruolo cantiere.RUOLO);

ALTER TABLE cantiere.operaio
            ALTER COLUMN ruolo SET DEFAULT 'semplice';

CREATE TABLE cantiere.area(
       id SERIAL PRIMARY KEY,
       zona cantiere.ZONA NOT NULL,
       parte_di SERIAL,
       controllato_da SERIAL,
       FOREIGN KEY(parte_di)
               REFERENCES cantiere.cantiere(id)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE,
       FOREIGN KEY(controllato_da)
               REFERENCES cantiere.operaio(id)
                          ON UPDATE CASCADE);

CREATE TABLE cantiere.sensore(
       id SERIAL PRIMARY KEY,
       tipo cantiere.TIPO NOT NULL,
       soglia FLOAT8 NOT NULL,
       installato_da SERIAL,
       installato_in SERIAL,
       FOREIGN KEY(installato_da)
               REFERENCES cantiere.operaio(id)
                          ON UPDATE CASCADE
                          ON DELETE SET NULL,
       FOREIGN KEY(installato_in)
               REFERENCES cantiere.area(id)
                          ON UPDATE CASCADE
                          ON DELETE CASCADE);

CREATE TABLE cantiere.valore(
       data_scrittura TIMESTAMP,
       valore_di SERIAL,
       valore FLOAT8 NOT NULL,
       PRIMARY KEY(data_scrittura, valore_di),
       FOREIGN KEY(valore_di)
               REFERENCES cantiere.sensore(id)
                          ON UPDATE CASCADE
                          ON DELETE CASCADE);

CREATE TABLE cantiere.lavora_in(
       cantiere_id SERIAL,
       operaio_id SERIAL,
       PRIMARY KEY(cantiere_id, operaio_id),
       FOREIGN KEY(cantiere_id)
               REFERENCES cantiere.cantiere(id)
                          ON UPDATE CASCADE
                          ON DELETE CASCADE,
       FOREIGN KEY(operaio_id)
               REFERENCES cantiere.operaio(id)
                          ON UPDATE CASCADE
                          ON DELETE CASCADE);

CREATE TABLE cantiere.delega(
       cantiere_id SERIAL,
       amministratore_id SERIAL,
       capocantiere_id SERIAL,
       PRIMARY KEY(cantiere_id, amministratore_id, capocantiere_id),
       FOREIGN KEY(cantiere_id)
               REFERENCES cantiere.cantiere(id)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE,
       FOREIGN KEY(capocantiere_id)
               REFERENCES cantiere.capocantiere(id)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE,
       FOREIGN KEY(amministratore_id)
               REFERENCES cantiere.amministratore(id)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE);

CREATE OR REPLACE FUNCTION
cantiere.delega_univoca()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
BEGIN
    IF EXISTS(SELECT *
              FROM cantiere.delega AS d
              WHERE d.cantiere_id = NEW.cantiere_id
                    AND d.amministratore_id = NEW.amministratore_id)
    THEN
        RAISE EXCEPTION 'il cantiere [%] é stato gía delegato', NEW.cantiere_id;
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER delega_univoca_trig
BEFORE INSERT OR UPDATE ON cantiere.delega
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.delega_univoca();

CREATE OR REPLACE FUNCTION
cantiere.valore_non_supera_soglia()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    soglia FLOAT8 := 0;
BEGIN
    SELECT s.soglia INTO soglia
    FROM cantiere.sensore AS s
    WHERE s.id = NEW.valore_di;

    IF soglia < NEW.valore
    THEN
        RAISE EXCEPTION '[Allarme] il sensore % ha superato la soglia: %', NEW.valore_di, soglia;
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER valore_non_supera_soglia_trig
BEFORE INSERT OR UPDATE ON cantiere.valore
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.valore_non_supera_soglia();

CREATE OR REPLACE FUNCTION
cantiere.data_fine_plausibile()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
BEGIN
    IF NEW.data_inizio >= NEW.data_fine_prevista
    THEN
        RAISE EXCEPTION 'la data di fine lavori é antecedente a quella di inizio';
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER data_fine_plausibile_trig
BEFORE INSERT OR UPDATE ON cantiere.cantiere
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.data_fine_plausibile();

CREATE OR REPLACE FUNCTION
cantiere.data_nuova_scrittura()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    ultima_scrittura DATE := NULL;
BEGIN
    SELECT v.data_scrittura INTO ultima_scrittura
    FROM cantiere.valore AS v
    WHERE v.valore_di = NEW.valore_di
    ORDER BY v.data_scrittura DESC
    LIMIT 1;

    IF ultima_scrittura >= NEW.data_scrittura
    THEN
        RAISE EXCEPTION 'impossibile inserire una scrittura meno recente';
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER data_nuova_scrittura_trig
BEFORE INSERT OR UPDATE ON cantiere.valore
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.data_nuova_scrittura();

CREATE OR REPLACE FUNCTION
cantiere.amministratore_corretto_delega()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    amministratore_id INTEGER;
BEGIN
    SELECT c.aperto_da INTO amministratore_id
    FROM cantiere.cantiere AS c
    WHERE c.id = NEW.cantiere_id;
    IF amministratore_id <> NEW.amministratore_id
    THEN
        RAISE EXCEPTION 'il cantiere é stato aperto da un altro amministratore';
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER amministratore_corretto_delega_trig
BEFORE INSERT OR UPDATE ON cantiere.delega
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.amministratore_corretto_delega();

CREATE OR REPLACE FUNCTION
cantiere.solo_operatore_installa_sensore()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    ruolo cantiere.RUOLO;
BEGIN
    SELECT o.ruolo INTO ruolo
    FROM cantiere.operaio AS o
    WHERE o.id = NEW.installato_da;
    IF ruolo <> 'operatore'
    THEN
        RAISE EXCEPTION '% non é un operatore', NEW.installato_da;
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER solo_operatore_installa_sensore_trig
BEFORE INSERT OR UPDATE ON cantiere.sensore
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.solo_operatore_installa_sensore();

CREATE OR REPLACE FUNCTION
cantiere.numero_civico_naturale()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
BEGIN
    IF NEW.numero_civico <= 0
    THEN
        RAISE EXCEPTION 'Il numero civico deve essere positivo';
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER solo_operatore_installa_sensore_trig
BEFORE INSERT OR UPDATE ON cantiere.luogo
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.numero_civico_naturale();

CREATE OR REPLACE FUNCTION
cantiere.max_due_sensori_differenti()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    already_installed RECORD := NULL;
BEGIN
    SELECT * INTO already_installed
    FROM cantiere.sensore AS s
    WHERE s.installato_in = NEW.installato_in AND s.tipo = NEW.tipo;
    IF already_installed <> NULL
    THEN
        RAISE EXCEPTION 'sensore di tipo % giá installato in %', NEW.tipo, NEW.installato_in;
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER max_due_sensori_differenti_trig
BEFORE INSERT OR UPDATE ON cantiere.sensore
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.max_due_sensori_differenti();

CREATE OR REPLACE FUNCTION
cantiere.CAP_ha_5_caratteri()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
BEGIN
    IF LENGTH(NEW.CAP) <> 5
    THEN
        RAISE EXCEPTION 'Il CAP deve essere composto di 5 cifre, [%] non é valido', NEW.CAP;
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER CAP_ha_5_caratteri_trig
BEFORE INSERT OR UPDATE ON cantiere.luogo
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.CAP_ha_5_caratteri();

CREATE OR REPLACE FUNCTION
cantiere.CAP_composto_solo_da_cifre()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
BEGIN
    IF LENGTH(REGEXP_REPLACE(NEW.CAP, '[^0-9]', '', 'g')) <> 5
    THEN
        RAISE EXCEPTION '[%] CAP non valido, contiene valori non numerici', NEW.CAP;
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER CAP_composto_solo_da_cifre_trig
BEFORE INSERT OR UPDATE ON cantiere.luogo
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.CAP_composto_solo_da_cifre();

CREATE OR REPLACE FUNCTION
cantiere.luogo_univoco()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    luogo RECORD := NULL;
BEGIN
    SELECT * INTO luogo
    FROM cantiere.luogo AS l
    WHERE l.CAP = NEW.CAP AND
          l.indirizzo = NEW.indirizzo AND
          l.numero_civico = NEW.numero_civico AND
          l.citta = new.citta;

    IF luogo <> NULL
    THEN
        RAISE EXCEPTION 'Luogo giá presente';
    ELSE
        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE TRIGGER luogo_univoco_trig
BEFORE INSERT OR UPDATE ON cantiere.luogo
FOR EACH ROW
    EXECUTE PROCEDURE cantiere.luogo_univoco();
