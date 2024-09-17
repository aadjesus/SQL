CREATE OR REPLACE TRIGGER TR_Veic_GlbxToGlb7
    BEFORE INSERT OR UPDATE OR DELETE ON VIASUL180418.frt_cadveiculos
    FOR EACH ROW
DECLARE
    v_TipoOperacao NUMBER;
    v_idTecnologia EscalaTeste2.Tecnologia.Id%TYPE;
BEGIN
    BEGIN
        IF (:NEW.idexterno IS NOT NULL AND
           :NEW.placaatualveic = :OLD.placaatualveic AND
           :NEW.prefixoveic = :OLD.prefixoveic) THEN
            RETURN;
        END IF;
    
        v_TipoOperacao := 0;
        IF DELETING THEN
            v_TipoOperacao := 2;
        END IF;
    
        BEGIN
            SELECT b.id
            INTO v_idTecnologia
            FROM VIASUL180418.frt_tipodefrota a
            INNER JOIN EscalaTeste2.Tecnologia b ON a.idexterno = b.idexterno
            WHERE a.codigotpfrota = :NEW.codigotpfrota;
        EXCEPTION
            WHEN OTHERS THEN
                RETURN;
        END;
    
        IF Inserting OR :NEW.idexterno IS NULL THEN
            :NEW.IdExterno := sys_guid();
            INSERT INTO EscalaTeste2.VEICULO
                (Id
                ,Placa
                ,Prefixo
                ,IdExterno
                ,idtecnologia
                ,IdFilial)
            VALUES
                (SEQ_EmpresaAutorizada.NEXTVAL
                ,REPLACE(:NEW.placaatualveic, '-', '')
                ,:NEW.prefixoveic
                ,:NEW.IdExterno
                ,v_idTecnologia
                ,(SELECT MAX(f.Id)
                 FROM EscalaTeste2.Filial f
                 INNER JOIN EscalaTeste2.Empresa e ON f.IdEmpresa = e.Id
                 WHERE e.Codigo = :NEW.codigoempresa
                       AND f.Codigo = :NEW.codigofl));
        ELSE
            UPDATE EscalaTeste2.VEICULO
            SET Placa = :NEW.placaatualveic
               ,Prefixo = :NEW.prefixoveic
               ,idtecnologia = v_idTecnologia
               ,DataHoraExclusao = (CASE WHEN v_TipoOperacao = 2 THEN SYSDATE ELSE NULL END)
            WHERE IdExterno = :OLD.IdExterno;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(SQLERRM);
    END;

END TR_Veic_GlbxToGlb7;
/