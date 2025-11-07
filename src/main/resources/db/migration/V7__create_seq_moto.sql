-- Migration para criar sequence usada pela tabela moto e setar default no id_moto
-- Garante que o próximo valor da sequence começa após o maior id já existente

CREATE SEQUENCE IF NOT EXISTS seq_moto;

-- Ajusta o valor da sequence para (max(id_moto) OR 0). Usando is_called = true
-- para que o próximo nextval retorne max(id_moto) + 1
SELECT setval('seq_moto', COALESCE((SELECT MAX(id_moto) FROM moto), 0), true);

ALTER SEQUENCE seq_moto OWNED BY moto.id_moto;

ALTER TABLE moto ALTER COLUMN id_moto SET DEFAULT nextval('seq_moto');
