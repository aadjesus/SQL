CREATE OR REPLACE TRIGGER TR_Tecn_GlbxToGlb7
    BEFORE INSERT OR UPDATE OR DELETE ON frt_tipodefrota
    FOR EACH ROW
DECLARE
    v_TipoOperacao NUMBER;
BEGIN
    BEGIN
        IF (:NEW.idexterno IS NOT NULL AND
           :NEW.descricaotpfrota = :OLD.descricaotpfrota) THEN
            RETURN;
        END IF;
    
        v_TipoOperacao := 0;
        IF DELETING THEN
            v_TipoOperacao := 2;
        END IF;
    
        IF Inserting OR :NEW.idexterno IS NULL THEN
            :NEW.IdExterno := sys_guid();
            INSERT INTO EscalaTeste2.Tecnologia
                (Id
                ,descricao
                ,idexterno)
            VALUES
                (SEQ_EmpresaAutorizada.NEXTVAL
                ,:NEW.descricaotpfrota
                ,:NEW.IdExterno);
        ELSE
            UPDATE EscalaTeste2.Tecnologia
            SET descricao = :NEW.descricaotpfrota
               ,DataHoraExclusao = (CASE WHEN v_TipoOperacao = 2 THEN SYSDATE ELSE NULL END)
            WHERE IdExterno = :OLD.IdExterno;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(SQLERRM);
    END;

END TR_Tecn_GlbxToGlb7;
/