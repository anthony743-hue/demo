INSERT INTO Parametre(id_status1,id_status2,duree,alerte) VALUES 
(4,5,350, 'R'),
(4,5,200,'J');


INSERT INTO Parametre(id_status1,id_status2,duree,alerte) VALUES 
(13,16,10000,'R');

INSERT INTO type_devis(type) VALUES ('Etude'), ('Forage');

ALTER TABLE Devis ADD COLUMN IdType BIGINT;
ALTER TABLE Devis ADD CONSTRAINT for_devis FOREIGN KEY (IdType) REFERENCES type_devis(id);