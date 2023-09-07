CREATE (frPet:CapoCantiere {nome: "Francesco Petrillo"})
CREATE (goat:Amministratore {nome: "Richard Benson"})
CREATE (marioR:Operaio {nome: "Mario Rossi", ruolo: "semplice"})
CREATE (pasqE:Operaio {nome: "Pasquale Esposito", ruolo: "idraulico"})
CREATE (ciroE:Operaio {nome: "Ciro Esposito", ruolo: "macchinista"})
CREATE (joseM:Operaio {nome: "Jose Mirand", ruolo: "elettricista"})
CREATE (braga:Operaio {nome: "Chief Braga", ruolo: "operatore"})
CREATE (sgap:Luogo {nome: "San Giovanni a Piro", cap: "84070", via: "Via Iacine 3"})
CREATE (workZone:Cantiere {start: date('2019-07-17'), end: date('2019-08-16')})
CREATE (area1:Area {tipo: "servizi pubblici"})
CREATE (area2:Area {tipo: "zona verde"})
CREATE (sens1_1:Sensore {tipo: "gas"})
CREATE (sens2_1:Sensore {tipo: "rumore"})
CREATE (sens1_2:Sensore {tipo: "gas"})
CREATE (sens2_2:Sensore {tipo: "rumore"})
CREATE (data_sens1_1:Data {data: date('2000-05-12'), value: 100})
CREATE (data_sens1_2:Data {data: date('2000-05-12'), value: 100})
CREATE (data_sens2_1:Data {data: date('2000-05-12'), value: 100})
CREATE (data1_sens2_2:Data {data: date('2000-05-12'), value: 100})
CREATE (data2_sens2_2:Data {data: date('2000-05-13'), value: 80})
CREATE (data3_sens2_2:Data {data: date('2000-05-14'), value: 70})
CREATE (data4_sens2_2:Data {data: date('2000-05-15'), value: 60})
CREATE
(goat)-[:APRE]->(workZone),
(frPet)-[:AMMINISTRA]->(workZone),
(marioR)-[:LAVORA_IN]->(workZone),
(pasqE)-[:LAVORA_IN]->(workZone),
(cireE)-[:LAVORA_IN]->(workZone),
(joseM)-[:LAVORA_IN]->(workZone),
(braga)-[:LAVORA_IN]->(workZone),
(area1)-[:PARTE_DI]->(workZone),
(area2)-[:PARTE_DI]->(workZone),
(sens1_1)-[:INSTALLATO_IN]->(area1),
(sens2_1)-[:INSTALLATO_IN]->(area1),
(sens1_2)-[:INSTALLATO_IN]->(area2),
(sens2_2)-[:INSTALLATO_IN]->(area2),
(sens1_1)-[:INSTALLATO_DA]->(braga),
(sens1_2)-[:INSTALLATO_DA]->(braga),
(sens1_2)-[:INSTALLATO_DA]->(braga),
(sens2_2)-[:INSTALLATO_DA]->(braga),
(area1)-[:CONTROLLATO_DA]->(marioR),
(area2)-[:CONTROLLATO_DA]->(ciroE),
(data_sens1_1)-[:VALORE_DI]->(sens1_1),
(data_sens1_2)-[:VALORE_DI]->(sens2_1),
(data_sens2_1)-[:VALORE_DI]->(sens2_1),
(data1_sens2_2)-[:VALORE_DI]->(sens2_2),
(data2_sens2_2)-[:VALORE_DI]->(sens2_2),
(data3_sens2_2)-[:VALORE_DI]->(sens2_2),
(data4_sens2_2)-[:VALORE_DI]->(sens2_2);
