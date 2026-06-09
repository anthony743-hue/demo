    INSERT INTO Status(designation, sigle) VALUES 
    ('Dossier cree', 'DC'), 
    ('Devis Etude Cree', 'DEC'), 
    ('Devis Etude Acceptee', 'DEA'),
    ('Devis Forage Cree', 'DFC'),
    ('Devis Forage Acceptee','DFA'),
    ('Forage Commence', 'FC'),
    ('Forage Termine', 'FT');

    INSERT INTO parametre (idstatus1, idstatus2, duree, alerte)
    VALUES ()

    ALTER TABLE Status ADD COLUMN sigle VARCHAR(5);