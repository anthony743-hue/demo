CREATE DATABASE Forage;

CREATE TABLE Status(
    id SERIAL PRIMARY KEY,
    Designation VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE Demande(
    id SERIAL PRIMARY KEY,
    region VARCHAR(30) NOT NULL,
    district VARCHAR(30) NOT NULL,
    commune VARCHAR(30) NOT NULL,
    fokontany VaRCHAR(30) NOT NULL,
    NomClient VARCHAR(50) NOT NULL,
    idStatus INT NOT NULL,
    CONSTRAINT Fk_status_demande FOREIGN KEY(idStatus) REFERENCES Status(id)
);



ALTER TABLE Demande ADD COLUMN
Ref VARCHAR(30);

CREATE TABLE Status_Demande(
    id SERIAL PRIMARY KEY,
    idStatus INT NOT NULL,
    idDemande INT NOT NULL,
    Daty TIMESTAMP NOT NULL,
    CONSTRAINT Fk_histo_status FOREIGN KEY (idStatus) REFERENCES Status(id),
    CONSTRAINT Fk_histo_demande FOREIGN KEY (idDemande) REFERENCES Demande(id)
);