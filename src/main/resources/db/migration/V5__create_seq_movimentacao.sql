-- Migration para criação da sequence usada por movimentacao
-- Cria a sequence seq_movimentacao, define ownership e ajusta o default
-- Inicia em 6 porque os inserts de exemplo anteriores usam ids 1..5

CREATE SEQUENCE IF NOT EXISTS seq_movimentacao
    START WITH 6
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 1;

-- Define o ownership da sequence para a coluna id_mov da tabela movimentacao
ALTER SEQUENCE seq_movimentacao OWNED BY movimentacao.id_mov;

-- Ajusta a coluna id_mov para usar a sequence como default
ALTER TABLE movimentacao ALTER COLUMN id_mov SET DEFAULT nextval('seq_movimentacao');

-- Opcional: garante permissões básicas para uso público (ou adapte para seu schema)
-- GRANT USAGE, SELECT, UPDATE ON SEQUENCE seq_movimentacao TO PUBLIC;
