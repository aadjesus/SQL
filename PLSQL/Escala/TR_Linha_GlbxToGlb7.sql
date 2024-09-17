CREATE OR REPLACE TRIGGER TR_Linha_GlbxToGlb7
    BEFORE INSERT OR UPDATE OR DELETE ON bgm_cadlinhas
    FOR EACH ROW
DECLARE
    v_TipoOperacao NUMBER;
BEGIN
    BEGIN
        IF (:NEW.idexterno IS NOT NULL AND
           :NEW.codigolinha = :OLD.codigolinha AND
           :NEW.nomelinha = :OLD.nomelinha) THEN
            RETURN;
        END IF;
    
        v_TipoOperacao := 0;
        IF DELETING THEN
            v_TipoOperacao := 2;
        END IF;
    
        IF Inserting OR :NEW.idexterno IS NULL THEN
            :NEW.IdExterno := sys_guid();
            INSERT INTO EscalaTeste2.Linha
                (Id
                ,codigo
                ,descricao
                ,IdExterno
                ,IdFilial)
            VALUES
                (SEQ_EmpresaAutorizada.NEXTVAL
                ,:NEW.codigolinha
                ,:NEW.nomelinha
                ,:NEW.IdExterno
                ,(SELECT MAX(f.Id)
                 FROM EscalaTeste2.Filial f
                 INNER JOIN EscalaTeste2.Empresa e ON f.IdEmpresa = e.Id
                 WHERE e.Codigo = :NEW.codigoempresa
                       AND f.Codigo = :NEW.codigofl));
        ELSE
            UPDATE EscalaTeste2.Linha
            SET codigo = :NEW.codigolinha
               ,descricao = :NEW.nomelinha
               ,DataHoraExclusao = (CASE WHEN v_TipoOperacao = 2 THEN SYSDATE ELSE NULL END)
            WHERE IdExterno = :OLD.IdExterno;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(SQLERRM);
    END;
END TR_Linha_GlbxToGlb7;
/