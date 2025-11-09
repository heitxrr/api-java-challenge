-- INSERÇÕES DE EXEMPLO
INSERT INTO movimentacao (dt_mov, id_moto, id_setor, id_operador_origem, id_operador_destino) 
VALUES (NOW(), 1, 1, 1, 2);
INSERT INTO movimentacao (dt_mov, id_moto, id_setor, id_operador_origem, id_operador_destino) 
VALUES (NOW(), 2, 2, 1, 3);
INSERT INTO movimentacao (dt_mov, id_moto, id_setor, id_operador_origem, id_operador_destino) 
VALUES (NOW(), 3, 1, 3, 4);
INSERT INTO movimentacao (dt_mov, id_moto, id_setor, id_operador_origem, id_operador_destino) 
VALUES (NOW(), 4, 3, 4, 5);
INSERT INTO movimentacao (dt_mov, id_moto, id_setor, id_operador_origem, id_operador_destino) 
VALUES (NOW(), 5, 2, 2, NULL);

-- FUNÇÃO PARA FORMATAR MOVIMENTAÇÃO EM JSON
CREATE OR REPLACE FUNCTION fn_formatar_mov_json(
    p_id_mov INT,
    p_dt_mov TIMESTAMP,
    p_placa VARCHAR,
    p_operador_origem VARCHAR,
    p_operador_destino VARCHAR,
    p_setor VARCHAR
)
RETURNS TEXT AS $$
DECLARE
    v_json TEXT;
BEGIN
    v_json := json_build_object(
        'id_mov', p_id_mov,
        'data', to_char(p_dt_mov, 'DD/MM/YYYY HH24:MI'),
        'placa', p_placa,
        'operador_origem', p_operador_origem,
        'operador_destino', COALESCE(p_operador_destino, 'null'),
        'setor', p_setor
    )::TEXT;

    RETURN v_json;
EXCEPTION
    WHEN OTHERS THEN
        RETURN '{"erro":"Erro ao gerar JSON"}';
END;
$$ LANGUAGE plpgsql;

-- FUNÇÃO PARA VALIDAR STATUS DA MOTO
CREATE OR REPLACE FUNCTION fn_validar_status_moto(p_id_moto INT)
RETURNS TEXT AS $$
DECLARE
    v_status TEXT;
    v_msg TEXT;
BEGIN
    SELECT mt_status INTO v_status FROM moto WHERE id_moto = p_id_moto;

    IF v_status = 'Ativa' THEN
        v_msg := format('Moto %s liberada para movimentação.', p_id_moto);
    ELSIF v_status = 'Manutenção' THEN
        v_msg := format('Moto %s está em manutenção. Operação não permitida.', p_id_moto);
    ELSE
        v_msg := format('Status desconhecido para a moto %s.', p_id_moto);
    END IF;

    RETURN v_msg;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN format('Moto não encontrada (ID %s)', p_id_moto);
    WHEN TOO_MANY_ROWS THEN
        RETURN format('Mais de um registro encontrado para a moto %s', p_id_moto);
    WHEN OTHERS THEN
        RETURN format('Erro inesperado ao validar status da moto %s', p_id_moto);
END;
$$ LANGUAGE plpgsql;

-- PROCEDURE PARA LISTAR MOVIMENTAÇÕES EM JSON
CREATE OR REPLACE PROCEDURE prc_listar_mov_json()
LANGUAGE plpgsql
AS $$
DECLARE
    r RECORD;
    v_json TEXT;
BEGIN
    FOR r IN
        SELECT m.id_mov, m.dt_mov, mt.mt_placa,
               op1.nm_operador AS operador_origem,
               op2.nm_operador AS operador_destino,
               s.nm_setor
        FROM movimentacao m
        JOIN moto mt ON m.id_moto = mt.id_moto
        JOIN operador op1 ON m.id_operador_origem = op1.id_operador
        LEFT JOIN operador op2 ON m.id_operador_destino = op2.id_operador
        JOIN setor s ON m.id_setor = s.id_setor
    LOOP
        v_json := fn_formatar_mov_json(
            r.id_mov, r.dt_mov, r.mt_placa,
            r.operador_origem, r.operador_destino, r.nm_setor
        );
        RAISE NOTICE '%', v_json;
    END LOOP;
END;
$$;

-- TRIGGER DE AUDITORIA DE MOVIMENTAÇÃO
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

CREATE TRIGGER trg_auditoria_mov
AFTER INSERT OR UPDATE OR DELETE ON movimentacao
FOR EACH ROW
EXECUTE FUNCTION trg_auditoria_mov_fn();
