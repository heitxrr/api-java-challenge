INSERT INTO pais VALUES (1, 'Brasil');

INSERT INTO estado VALUES (1, 'São Paulo', 1);
INSERT INTO estado VALUES (2, 'Rio de Janeiro', 1);

INSERT INTO cidade VALUES (1, 'São Paulo', 1);
INSERT INTO cidade VALUES (2, 'Campinas', 1);
INSERT INTO cidade VALUES (3, 'Rio de Janeiro', 2);

INSERT INTO bairro VALUES (1, 'Centro', 1);
INSERT INTO bairro VALUES (2, 'Jardins', 1);
INSERT INTO bairro VALUES (3, 'Botafogo', 3);

INSERT INTO endereco VALUES (1, 'Rua A', '100', 1);
INSERT INTO endereco VALUES (2, 'Rua B', '200', 2);
INSERT INTO endereco VALUES (3, 'Rua C', '300', 3);

INSERT INTO patio VALUES (1, 'Pátio Central', 1);
INSERT INTO patio VALUES (2, 'Pátio Jardins', 2);
INSERT INTO patio VALUES (3, 'Pátio Botafogo', 3);

INSERT INTO operador VALUES (1, 'João', 'Supervisor', 1);
INSERT INTO operador VALUES (2, 'Maria', 'Assistente', 1);
INSERT INTO operador VALUES (3, 'Carlos', 'Supervisor', 2);
INSERT INTO operador VALUES (4, 'Ana', 'Assistente', 2);
INSERT INTO operador VALUES (5, 'Pedro', 'Fiscal', 3);

INSERT INTO modelo VALUES (1, 'Mottu-Elite', 'Scooter');
INSERT INTO modelo VALUES (2, 'Mottu-Express', 'Scooter');
INSERT INTO modelo VALUES (3, 'Mottu-Cargo', 'Scooter');
INSERT INTO modelo VALUES (4, 'Mottu-Fiscal', 'Scooter');
INSERT INTO modelo VALUES (5, 'Mottu-Suporte', 'Scooter');
