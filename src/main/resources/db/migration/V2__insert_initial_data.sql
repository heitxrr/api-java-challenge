INSERT INTO pais (nm_pais) VALUES ('Brasil');

INSERT INTO estado (nm_estado, id_pais) VALUES ('São Paulo', 1);
INSERT INTO estado (nm_estado, id_pais) VALUES ('Rio de Janeiro', 1);

INSERT INTO cidade (nm_cidade, id_estado) VALUES ('São Paulo', 1);
INSERT INTO cidade (nm_cidade, id_estado) VALUES ('Campinas', 1);
INSERT INTO cidade (nm_cidade, id_estado) VALUES ('Rio de Janeiro', 2);

INSERT INTO bairro (nm_bairro, id_cidade) VALUES ('Centro', 1);
INSERT INTO bairro (nm_bairro, id_cidade) VALUES ('Jardins', 1);
INSERT INTO bairro (nm_bairro, id_cidade) VALUES ('Botafogo', 3);

INSERT INTO endereco (nm_rua, nr_numero, id_bairro) VALUES ('Rua A', '100', 1);
INSERT INTO endereco (nm_rua, nr_numero, id_bairro) VALUES ('Rua B', '200', 2);
INSERT INTO endereco (nm_rua, nr_numero, id_bairro) VALUES ('Rua C', '300', 3);

INSERT INTO patio (nm_patio, id_endereco) VALUES ('Pátio Central', 1);
INSERT INTO patio (nm_patio, id_endereco) VALUES ('Pátio Jardins', 2);
INSERT INTO patio (nm_patio, id_endereco) VALUES ('Pátio Botafogo', 3);

INSERT INTO operador (nm_operador, cargo_operador, id_patio) VALUES ('João', 'Supervisor', 1);
INSERT INTO operador (nm_operador, cargo_operador, id_patio) VALUES ('Maria', 'Assistente', 1);
INSERT INTO operador (nm_operador, cargo_operador, id_patio) VALUES ('Carlos', 'Supervisor', 2);
INSERT INTO operador (nm_operador, cargo_operador, id_patio) VALUES ('Ana', 'Assistente', 2);
INSERT INTO operador (nm_operador, cargo_operador, id_patio) VALUES ('Pedro', 'Fiscal', 3);

INSERT INTO modelo (nm_modelo, mt_tipo) VALUES ('Mottu-Elite', 'Scooter');
INSERT INTO modelo (nm_modelo, mt_tipo) VALUES ('Mottu-Express', 'Scooter');
INSERT INTO modelo (nm_modelo, mt_tipo) VALUES ('Mottu-Cargo', 'Scooter');
INSERT INTO modelo (nm_modelo, mt_tipo) VALUES ('Mottu-Fiscal', 'Scooter');
INSERT INTO modelo (nm_modelo, mt_tipo) VALUES ('Mottu-Suporte', 'Scooter');
