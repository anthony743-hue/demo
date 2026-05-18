INSERT INTO Status(Designation) VALUES('Supprime'), ('Suspendu'), ('Commence');

INSERT INTO Region(Nom) VALUES
('Analamanga'),
('Vakinankaratra'),
('Itasy'),
('Alaotra'),
('Boeny'),
('Betsiboka'),
('Atsinanana'),
('Haute Matsiatra'),
('Atsimo Andrefana'),
('Diana');

INSERT INTO District(Id_Region, Nom) VALUES
(1, 'Antananarivo'),
(2, 'Antsirabe I'),
(3, 'Miarinarivo'),
(4, 'Ambatondrazaka'),
(5, 'Mahajanga I'),
(6, 'Maevatanana'),
(7, 'Toamasina I'),
(8, 'Fianarantsoa I'),
(9, 'Toliara I'),
(10, 'Antsiranana I');

INSERT INTO Commune(Id_District, Nom) VALUES
(1, 'Analakely'),
(2, 'Antsenakely'),
(3, 'Soavinandriana'),
(4, 'Tanambao V'),
(5, 'Mahabibo'),
(6, 'Ambalajia'),
(7, 'Tanamakoa'),
(8, 'Ambatomena'),
(9, 'Mahavatse'),
(10, 'Tanambao I');

INSERT INTO Client(Nom, Adresse, Contact) VALUES
('Rakoto Jean', 'Analakely', '0341100001'),
('Rabe Marie', 'Antsenakely', '0341100002'),
('Randria Paul', 'Soavinandriana', '0341100003'),
('Rasoa Lucie', 'Tanambao V', '0341100004'),
('Rakotoniaina Eric', 'Mahabibo', '0341100005'),
('Razafindrakoto Nina', 'Ambalajia', '0341100006'),
('Ravelomanana Lova', 'Tanamakoa', '0341100007'),
('Ramanitra Hery', 'Ambatomena', '0341100008'),
('Rasoanaivo Tina', 'Mahavatse', '0341100009'),
('Andriamihaja Faly', 'Tanambao I', '0341100010');
