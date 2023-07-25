INSERT INTO cantiere.capocantiere(nome, cognome) VALUES
('Francesco', 'Petrillo'),
('Domenico', 'Petrillo'),
('Manuel', 'Scarpitta');

INSERT INTO cantiere.amministratore(nome, cognome) VALUES
('Mr', 'Implenia'),
('Richard', 'Benson');

INSERT INTO cantiere.luogo(citta, cap, indirizzo, numero_civico) VALUES
('San Giovanni a Piro','84070', 'Via Iacine', 3),
('Fuorigrotta', '80125', 'Via Mercantini', 10),
('Montreaux', '19200', 'Rue du Guercet', 5);

INSERT INTO cantiere.cantiere(data_inizio, data_fine_prevista, luogo_id, aperto_da) VALUES
('2019-07-17', '2019-08-16', 4, 1),
('2000-02-09', '2005-06-1', 2, 2),
('2023-07-1', '2023-08-30', 3, 1);

INSERT INTO cantiere.area(zona, parte_di, controllato_da) VALUES
('servizi_pubblici', 5, 15),
('zona_verde', 5, 15),
('zona_residenziale', 5, 18),
('zona_ristorazione', 5, 18),
('servizi_pubblici', 4, 13),
('zona_verde', 4, 20),
('servizi_pubblici', 6, 7),
('zona_ristorazione', 6, 5),
('zona_verde', 6, 11);

INSERT INTO cantiere.sensore(tipo, installato_da, installato_in, soglia) VALUES
('gas', 15, 1, 200),
('rumore', 15, 1, 300),
('gas', 15, 2, 200),
('rumore', 15, 2, 300),
('gas', 15, 3, 200),
('rumore', 15, 3, 300),
('gas', 15, 4, 200),
('rumore', 15, 4, 300),
('gas', 5, 5, 400),
('gas', 10, 6, 300),
('rumore', 10, 6, 100),
('rumore', 20, 7, 800),
('gas', 20, 8, 250),
('rumore', 20, 9, 100);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 1, 150),
('2000-05-12 01:00:00-07', 1, 50),
('2001-05-12 02:00:00-07', 1, 75),
('2001-05-12 03:00:00-07', 1, 95),
('2002-05-12 04:00:00-07', 1, 100),
('2002-05-12 05:00:00-07', 1, 50),
('2003-05-12 06:00:00-07', 1, 28),
('2003-05-12 07:00:00-07', 1, 50),
('2004-05-12 08:00:00-07', 1, 60);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 2, 150),
('2000-05-12 01:00:00-07', 2, 50),
('2001-05-12 02:00:00-07', 2, 75),
('2001-05-12 03:00:00-07', 2, 95),
('2002-05-12 04:00:00-07', 2, 100),
('2002-05-12 05:00:00-07', 2, 50),
('2003-05-12 06:00:00-07', 2, 28),
('2003-05-12 07:00:00-07', 2, 50),
('2004-05-12 08:00:00-07', 2, 60);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 3, 150),
('2000-05-12 01:00:00-07', 3, 50),
('2001-05-12 02:00:00-07', 3, 75),
('2001-05-12 03:00:00-07', 3, 95),
('2002-05-12 04:00:00-07', 3, 100),
('2002-05-12 05:00:00-07', 3, 50),
('2003-05-12 06:00:00-07', 3, 28),
('2003-05-12 07:00:00-07', 3, 50),
('2004-05-12 08:00:00-07', 3, 60);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 4, 150),
('2000-05-12 01:00:00-07', 4, 50),
('2001-05-12 02:00:00-07', 4, 75),
('2001-05-12 03:00:00-07', 4, 95),
('2002-05-12 04:00:00-07', 4, 100),
('2002-05-12 05:00:00-07', 4, 50),
('2003-05-12 06:00:00-07', 4, 28),
('2003-05-12 07:00:00-07', 4, 50),
('2004-05-12 08:00:00-07', 4, 60);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 5, 150),
('2000-05-12 01:00:00-07', 5, 50),
('2001-05-12 02:00:00-07', 5, 75),
('2001-05-12 03:00:00-07', 5, 95),
('2002-05-12 04:00:00-07', 5, 100),
('2002-05-12 05:00:00-07', 5, 50),
('2003-05-12 06:00:00-07', 5, 28),
('2003-05-12 07:00:00-07', 5, 50),
('2004-05-12 08:00:00-07', 5, 60);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 6, 150),
('2000-05-12 01:00:00-07', 6, 50),
('2001-05-12 02:00:00-07', 6, 75),
('2001-05-12 03:00:00-07', 6, 95),
('2002-05-12 04:00:00-07', 6, 100),
('2002-05-12 05:00:00-07', 6, 50),
('2003-05-12 06:00:00-07', 6, 28),
('2003-05-12 07:00:00-07', 6, 50),
('2004-05-12 08:00:00-07', 6, 60);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 7, 150),
('2000-05-12 01:00:00-07', 7, 50),
('2001-05-12 02:00:00-07', 7, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 8, 150),
('2000-05-12 01:00:00-07', 8, 50),
('2001-05-12 02:00:00-07', 8, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 9, 150),
('2000-05-12 01:00:00-07', 9, 50),
('2001-05-12 02:00:00-07', 9, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 10, 150),
('2000-05-12 01:00:00-07', 10, 50),
('2001-05-12 02:00:00-07', 10, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 11, 150),
('2000-05-12 01:00:00-07', 11, 50),
('2001-05-12 02:00:00-07', 11, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 12, 150),
('2000-05-12 01:00:00-07', 12, 50),
('2001-05-12 02:00:00-07', 12, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 13, 150),
('2000-05-12 01:00:00-07', 13, 50),
('2001-05-12 02:00:00-07', 13, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 14, 150),
('2000-05-12 01:00:00-07', 14, 50),
('2001-05-12 02:00:00-07', 14, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 15, 150),
('2000-05-12 01:00:00-07', 15, 50),
('2001-05-12 02:00:00-07', 15, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 16, 150),
('2000-05-12 01:00:00-07', 16, 50),
('2001-05-12 02:00:00-07', 16, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 17, 150),
('2000-05-12 01:00:00-07', 17, 50),
('2001-05-12 02:00:00-07', 17, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 18, 150),
('2000-05-12 01:00:00-07', 18, 50),
('2001-05-12 02:00:00-07', 18, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 19, 150),
('2000-05-12 01:00:00-07', 19, 50),
('2001-05-12 02:00:00-07', 19, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 20, 150),
('2000-05-12 01:00:00-07', 20, 50),
('2001-05-12 02:00:00-07', 20, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 21, 150),
('2000-05-12 01:00:00-07', 21, 50),
('2001-05-12 02:00:00-07', 21, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 22, 150),
('2000-05-12 01:00:00-07', 22, 50),
('2001-05-12 02:00:00-07', 22, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 23, 150),
('2000-05-12 01:00:00-07', 23, 50),
('2001-05-12 02:00:00-07', 23, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 24, 150),
('2000-05-12 01:00:00-07', 24, 50),
('2001-05-12 02:00:00-07', 24, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 25, 100),
('2000-05-12 01:00:00-07', 25, 50),
('2001-05-12 02:00:00-07', 25, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 26, 100),
('2000-05-12 01:00:00-07', 26, 50),
('2001-05-12 02:00:00-07', 26, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 27, 100),
('2000-05-12 01:00:00-07', 27, 50),
('2001-05-12 02:00:00-07', 27, 75);

INSERT INTO cantiere.valore(data_scrittura, valore_di, valore) VALUES
('2000-05-12 00:00:00-07', 28, 100),
('2000-05-12 01:00:00-07', 28, 50),
('2001-05-12 02:00:00-07', 28, 75);

INSERT INTO cantiere.delega(cantiere_id, amministratore_id, capocantiere_id) VALUES
(4,1,1),
(5,2,2),
(6,1,3);

INSERT INTO cantiere.lavora_in(cantiere_id, operaio_id) VALUES
(4,1),
(4,2),
(4,3),
(4,4),
(4,5),
(4,6),
(4,7),
(4,8),
(5,9),
(5,10),
(5,11),
(5,12),
(5,13),
(5,14),
(5,15),
(5,16),
(5,17),
(6,18),
(6,19),
(6,20);
