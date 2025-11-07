-- Migration para criação da sequence usada por movimentacao
-- Esta migration cria a sequence seq_movimentacao, define ownership e ajusta o default
-- Inicia em 6 porque os inserts de exemplo nas migrations anteriores usam ids 1..5

CREATE SEQUENCE IF NOT EXISTS seq_movimentacao START WITH 6;
ALTER SEQUENCE seq_movimentacao OWNED BY movimentacao.id_mov;
ALTER TABLE movimentacao ALTER COLUMN id_mov SET DEFAULT nextval('seq_movimentacao');

-- Garante permissões básicas (opcional, adapte conforme seu usuário/schema)
-- GRANT USAGE, SELECT ON SEQUENCE seq_movimentacao TO PUBLIC;
