DECLARE
    V_SQL VARCHAR2(200);    
    v_deletar VARCHAR2(100);   
    CURSOR C_CONSTRAINTS IS
         SELECT A.TABLE_NAME
              , A.COLUMN_NAME
              , A.CONSTRAINT_NAME
           FROM USER_CONS_COLUMNS   A
     INNER JOIN USER_CONSTRAINTS    B ON A.CONSTRAINT_NAME   = B.CONSTRAINT_NAME
     INNER JOIN USER_CONSTRAINTS    C ON B.R_CONSTRAINT_NAME = C.CONSTRAINT_NAME
     INNER JOIN USER_OBJECTS        D ON A.TABLE_NAME        = D.OBJECT_NAME     
          WHERE C.TABLE_NAME = 'MTK_OPERADOR'
       ORDER BY D.OBJECT_ID DESC;
BEGIN
    FOR ITEM_CONSTRAINT IN C_CONSTRAINTS
    LOOP      
        select max(column_value)
          into v_deletar          
          from SYS.ODCIVARCHAR2LIST('MTK_TICKET_SEGUIDOR'
                                             ,'MTK_TICKET_VISITA'
                                             ,'MTK_TICKET_VISUALIZACAO'
                                             ,'MTK_TRAMITE'
                                             ,'MTK_NOTIFICACAO'
                                             ,'MTK_TICKET')           
         where column_value = ITEM_CONSTRAINT.TABLE_NAME ;                                             
                
         if v_deletar is null then
           V_SQL := 'DELETE ' || ITEM_CONSTRAINT.TABLE_NAME  || 
                    ' WHERE ' || ITEM_CONSTRAINT.COLUMN_NAME ||' = {0}';
         else
           V_SQL := 'UPDATE ' || ITEM_CONSTRAINT.TABLE_NAME  || 
                    '   SET ' || ITEM_CONSTRAINT.COLUMN_NAME ||' = {1}'||
                    ' WHERE ' || ITEM_CONSTRAINT.COLUMN_NAME ||' = {0}';
         end if;                
        
        --EXECUTE IMMEDIATE V_SQL;
        Dbms_Output.Put_Line(V_SQL);
    END LOOP;
END;

--rollback
     

/*select * from BDC_ARTIGO                where rownum =1 ;
select * from BDC_ARTIGO_AVALIACAO      where rownum =1 ;
select * from MTK_APROVACONTATO         where rownum =1 ; -- delete
select * from MTK_NOTIFICACAO           where rownum =1 ;
select * from MTK_OPERADORAVISOS        where rownum =1 ; -- Obs
select * from MTK_OPERADORCLIENTE       where rownum =1 ; -- Obs
select * from MTK_OPERADORSTATUS        where rownum =1 ; -- delete
select * from MTK_OPERADORTOUR          where rownum =1 ; -- delete
select * from MTK_OPERADOR_ARTIGO       where rownum =1 ; -- delete
select * from MTK_PARAMETROSOPERADOR    where rownum =1 ; -- delete -obs
select * from MTK_PERSONALIZACAO_GRID   where rownum =1 ; -- delete -obs
select * from MTK_PESQUISASSALVAS       where rownum =1 ; -- delete -obs
select * from MTK_RELACIONA_OPER_CLI    where rownum =1 ; -- obs
select * from MTK_SOLICITACAODESENHA    where rownum =1 ; -- delete
select * from MTK_TICKET                where rownum =1 ;
select * from MTK_TICKET_SEGUIDOR       where rownum =1 ; -- delete -obs
select * from MTK_TICKET_VISITA         where rownum =1 ;
select * from MTK_TICKET_VISUALIZACAO   where rownum =1 ; -- delete -obs
select * from MTK_TRAMITE               where rownum =1 ;
select * from MTK_TREINAMENTO_DESEJADO  where rownum =1 ;
select * from MTK_USUARIOCHAVE          where rownum =1 ; -- delete -obs -selec se já existe
     */