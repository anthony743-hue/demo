INSERT INTO Parametre(id_status1,id_status2,duree,alert) VALUES 
(10,12,350, 'R'),
(10,12,200,'J'),
();


INSERT INTO type_devis(type) VALUES ('Etude'), ('Forage');

ALTER TABLE Devis ADD COLUMN IdType BIGINT;
ALTER TABLE Devis ADD CONSTRAINT for_devis FOREIGN KEY (IdType) REFERENCES type_devis(id);