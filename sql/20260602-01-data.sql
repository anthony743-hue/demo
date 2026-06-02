    INSERT INTO Status(designation, sigle) VALUES 
    ('Demande Cree', 'DC'), ('Demande Refusee', 'DR'),('Devis Etude Cree', 'DEC'),
    ('Devis Etude Accepte', 'DEA'), ('Devis Etude Refuse', 'DER'),
    ('Devis Forage Cree','DFC'),('Devis Forage Acceptee','DFA'),('Devis Forage Refusee','DFR');

    INSERT INTO parametre (idstatus1, idstatus2, duree, alerte)
    VALUES ()

    ALTER TABLE Status ADD COLUMN sigle VARCHAR(5);