INSERT INTO moto (mt_placa, mt_status, id_modelo) VALUES ('ABC1A23', 'Ativa', 1);
INSERT INTO moto (mt_placa, mt_status, id_modelo) VALUES ('ABC1A24', 'Ativa', 2);
INSERT INTO moto (mt_placa, mt_status, id_modelo) VALUES ('ABC1A25', 'Ativa', 3);
INSERT INTO moto (mt_placa, mt_status, id_modelo) VALUES ('ABC1A26', 'Manutenção', 4);
INSERT INTO moto (mt_placa, mt_status, id_modelo) VALUES ('ABC1A27', 'Ativa', 5);

INSERT INTO manutencao (dt_manutencao, ds_servico, id_moto) VALUES (CURRENT_TIMESTAMP, 'Troca de óleo', 4);

INSERT INTO setor (nm_setor, id_patio) VALUES ('Setor 1', 1);
INSERT INTO setor (nm_setor, id_patio) VALUES ('Setor 2', 1);
INSERT INTO setor (nm_setor, id_patio) VALUES ('Setor 3', 2);
INSERT INTO setor (nm_setor, id_patio) VALUES ('Setor 4', 2);

INSERT INTO mapa_setor (ds_mapa, id_setor, id_patio) VALUES ('Mapa Entrada', 1, 1);
INSERT INTO mapa_setor (ds_mapa, id_setor, id_patio) VALUES ('Mapa Saída', 2, 1);
INSERT INTO mapa_setor (ds_mapa, id_setor, id_patio) VALUES ('Mapa Lavagem', 3, 2);
