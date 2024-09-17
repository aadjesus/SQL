CREATE OR REPLACE TRIGGER TR_Func_GlbxToGlb7
    BEFORE UPDATE OR DELETE ON Flp_Funcionarios
    FOR EACH ROW
DECLARE
    v_TipoOperacao NUMBER;
    v_cod_func t_Esc_Paramfunc.cod_func%TYPE;
BEGIN
    BEGIN
        IF (:NEW.idexterno IS NOT NULL AND :NEW.Codfunc = :OLD.Codfunc AND
           :NEW.Chapafunc = :OLD.Chapafunc AND
           :NEW.Nomefunc = :OLD.Nomefunc AND
           :NEW.Apelidofunc = :OLD.Apelidofunc) THEN
            RETURN;
        END IF;
    
        v_TipoOperacao := 0;
        IF DELETING THEN
            v_TipoOperacao := 2;
        END IF;
    
        BEGIN
            SELECT cod_func
            INTO v_cod_func
            FROM t_Esc_Paramfunc
            WHERE cod_func = :OLD.CODINTFUNC;
        EXCEPTION
            WHEN OTHERS THEN
                RETURN;
        END;
    
        UPDATE EscalaTeste2.Funcionario
        SET registro = :NEW.Codfunc
           ,chapa = :NEW.Chapafunc
           ,nome = :NEW.Nomefunc
           ,apelido = :NEW.Apelidofunc
           ,DataHoraExclusao = (CASE WHEN v_TipoOperacao = 2 THEN SYSDATE ELSE NULL END)
        WHERE IdExterno = :OLD.IdExterno;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(SQLERRM);
    END;

END TR_Func_GlbxToGlb7;
/