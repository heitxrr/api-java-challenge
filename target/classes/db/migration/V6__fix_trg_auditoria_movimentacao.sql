-- Corrige a função de trigger de auditoria para usar a coluna existente `data_hora`
-- Anteriormente a função inseria em `data_execucao`, que não existe.

CREATE OR REPLACE FUNCTION trg_auditoria_mov_fn()
RETURNS TRIGGER AS $$
DECLARE
    v_usuario TEXT;
BEGIN
    v_usuario := current_user;

    IF TG_OP = 'INSERT' THEN
        INSERT INTO auditoria_movimentacao (operacao, usuario, data_hora)
        VALUES ('INSERT', v_usuario, NOW());

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO auditoria_movimentacao (operacao, usuario, data_hora)
        VALUES ('UPDATE', v_usuario, NOW());

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO auditoria_movimentacao (operacao, usuario, data_hora)
        VALUES ('DELETE', v_usuario, NOW());
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- A trigger existente continuará executando esta função já atualizada.
