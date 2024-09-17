create or replace view view_operador_avisos_n_exp as
SELECT 
       O.id as id_operador,
       A.id as id_avisos,
       A.DESTINATARIO as destinatario,
       C.Id as id_categoria,
       (SELECT COUNT(*) FROM Mtk_OperadorAvisos WHERE
         Mtk_OperadorAvisos.Id_Operador = O.id AND 
         Mtk_OperadorAvisos.Id_Avisos = A.Id AND 
         LIDO = 1
       ) as LIDO
       
FROM Mtk_Avisos A

CROSS JOIN Mtk_Operador O

INNER JOIN Mtk_Avisos_Categoria C ON
C.id = A.id_categoria

WHERE  --Definição de aviso não expirado
      (
       (A.DATA_INICIO <= CURRENT_DATE AND A.DATA_FIM >= CURRENT_DATE) OR
       (A.DATA_INICIO <= CURRENT_DATE AND A.DATA_FIM IS NULL) OR 
       (A.DATA_INICIO IS NULL AND A.DATA_FIM >= CURRENT_DATE) OR
       (A.DATA_INICIO IS NULL AND A.DATA_FIM IS NULL)
      )
       
       