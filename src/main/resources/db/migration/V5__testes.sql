SET SERVEROUTPUT ON;

BEGIN
    prc_listar_mov_json;
END;
/

BEGIN
    prc_somar_movimentacao;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_validar_status_moto(1));
    DBMS_OUTPUT.PUT_LINE(fn_validar_status_moto(4));
    DBMS_OUTPUT.PUT_LINE(fn_validar_status_moto(99)); -- Moto inexistente
END;
/

INSERT INTO movimentacao(id_mov, dt_mov, id_moto, id_setor, id_operador_origem, id_operador_destino)
VALUES (6, SYSDATE, 1, 1, 2, 3);

INSERT INTO movimentacao(id_mov, dt_mov, id_moto, id_setor, id_operador_origem, id_operador_destino)
VALUES (7, SYSDATE, 2, 2, 3, 4);

UPDATE movimentacao
SET id_operador_destino = 5
WHERE id_mov = 6;

DELETE FROM movimentacao
WHERE id_mov = 7;

SELECT * FROM auditoria_movimentacao ORDER BY data_hora DESC;
