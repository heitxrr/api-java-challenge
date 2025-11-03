INSERT INTO movimentacao VALUES (1, SYSDATE, 1, 1, 1, 2);
INSERT INTO movimentacao VALUES (2, SYSDATE, 2, 2, 1, 3);
INSERT INTO movimentacao VALUES (3, SYSDATE, 3, 1, 3, 4);
INSERT INTO movimentacao VALUES (4, SYSDATE, 4, 3, 4, 5);
INSERT INTO movimentacao VALUES (5, SYSDATE, 5, 2, 2, NULL);

CREATE OR REPLACE FUNCTION fn_formatar_mov_json (
    p_id_mov INT,
    p_dt_mov DATE,
    p_placa VARCHAR2,
    p_operador_origem VARCHAR2,
    p_operador_destino VARCHAR2,
    p_setor VARCHAR2
) RETURN VARCHAR2
IS
    v_json VARCHAR2(4000);
BEGIN
    v_json := '{' ||
              '"id_mov":"' || p_id_mov || '",' ||
              '"data":"' || TO_CHAR(p_dt_mov,'DD/MM/YYYY HH24:MI') || '",' ||
              '"placa":"' || p_placa || '",' ||
              '"operador_origem":"' || p_operador_origem || '",' ||
              '"operador_destino":"' || NVL(p_operador_destino,'null') || '",' ||
              '"setor":"' || p_setor || '"' ||
              '}';
RETURN v_json;
EXCEPTION
    WHEN OTHERS THEN
        RETURN '{"erro":"Erro ao gerar JSON"}';
END;
/

CREATE OR REPLACE FUNCTION fn_validar_status_moto (p_id_moto moto.id_moto%TYPE) RETURN VARCHAR2
IS
    v_status moto.mt_status%TYPE;
    v_msg VARCHAR2(200);
BEGIN
SELECT mt_status INTO v_status FROM moto WHERE id_moto = p_id_moto;

IF v_status = 'Ativa' THEN
        v_msg := 'Moto ' || p_id_moto || ' liberada para movimentação.';
    ELSIF v_status = 'Manutenção' THEN
        v_msg := 'Moto ' || p_id_moto || ' está em manutenção. Operação não permitida.';
ELSE
        v_msg := 'Status desconhecido para a moto ' || p_id_moto;
END IF;

RETURN v_msg;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Moto não encontrada (ID ' || p_id_moto || ')';
WHEN TOO_MANY_ROWS THEN
        RETURN 'Mais de um registro encontrado para a moto ' || p_id_moto;
WHEN OTHERS THEN
        RETURN 'Erro inesperado ao validar status da moto ' || p_id_moto;
END;
/

CREATE OR REPLACE PROCEDURE prc_listar_mov_json IS
    CURSOR c_mov IS
SELECT m.id_mov, m.dt_mov, mt.mt_placa,
       op1.nm_operador AS operador_origem,
       op2.nm_operador AS operador_destino,
       s.nm_setor
FROM movimentacao m
         JOIN moto mt ON m.id_moto = mt.id_moto
         JOIN operador op1 ON m.id_operador_origem = op1.id_operador
         LEFT JOIN operador op2 ON m.id_operador_destino = op2.id_operador
         JOIN setor s ON m.id_setor = s.id_setor;
v_json VARCHAR2(4000);
BEGIN
FOR r IN c_mov LOOP
        v_json := fn_formatar_mov_json(r.id_mov, r.dt_mov, r.mt_placa, r.operador_origem, r.operador_destino, r.nm_setor);
        DBMS_OUTPUT.PUT_LINE(v_json);
END LOOP;
END;
/

CREATE OR REPLACE TRIGGER trg_auditoria_mov
AFTER INSERT OR UPDATE OR DELETE ON movimentacao
    FOR EACH ROW
DECLARE
v_usuario VARCHAR2(100);
BEGIN
    v_usuario := SYS_CONTEXT('USERENV','SESSION_USER');
    IF INSERTING THEN
        INSERT INTO auditoria_movimentacao(usuario, operacao, valores_new)
        VALUES (v_usuario, 'INSERT',
                'ID_MOV=' || :NEW.id_mov ||
                ', ID_MOTO=' || :NEW.id_moto ||
                ', ID_SETOR=' || :NEW.id_setor ||
                ', ID_OPERADOR_ORIGEM=' || :NEW.id_operador_origem ||
                ', ID_OPERADOR_DESTINO=' || NVL(TO_CHAR(:NEW.id_operador_destino), 'null'));
    ELSIF UPDATING THEN
        INSERT INTO auditoria_movimentacao(usuario, operacao, valores_old, valores_new)
        VALUES (v_usuario, 'UPDATE',
                'ID_MOV=' || :OLD.id_mov ||
                ', ID_MOTO=' || :OLD.id_moto ||
                ', ID_SETOR=' || :OLD.id_setor ||
                ', ID_OPERADOR_ORIGEM=' || :OLD.id_operador_origem ||
                ', ID_OPERADOR_DESTINO=' || NVL(TO_CHAR(:OLD.id_operador_destino), 'null'),
                'ID_MOV=' || :NEW.id_mov ||
                ', ID_MOTO=' || :NEW.id_moto ||
                ', ID_SETOR=' || :NEW.id_setor ||
                ', ID_OPERADOR_ORIGEM=' || :NEW.id_operador_origem ||
                ', ID_OPERADOR_DESTINO=' || NVL(TO_CHAR(:NEW.id_operador_destino), 'null'));
    ELSIF DELETING THEN
        INSERT INTO auditoria_movimentacao(usuario, operacao, valores_old)
        VALUES (v_usuario, 'DELETE',
                'ID_MOV=' || :OLD.id_mov ||
                ', ID_MOTO=' || :OLD.id_moto ||
                ', ID_SETOR=' || :OLD.id_setor ||
                ', ID_OPERADOR_ORIGEM=' || :OLD.id_operador_origem ||
                ', ID_OPERADOR_DESTINO=' || NVL(TO_CHAR(:OLD.id_operador_destino), 'null'));
END IF;
END;
/
