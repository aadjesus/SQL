--select a.conteudoxml from BGM_XML_TERCEIROS a    WHERE ROWNUM = 1

SELECT a.conteudoxml
     , xt.*
FROM BGM_XML_TERCEIROS a,
XMLTABLE(
         '//*:ICMSTot'
         PASSING F_LONG_TO_XML(a.ROWID)
         COLUMNS 
            
        vBC    VARCHAR2(50) PATH 'vBC',
        vICMS  VARCHAR2(50) PATH 'vICMS',
        vProd  VARCHAR2(50) PATH 'vProd',
        vNF    VARCHAR2(50) PATH '*:vNF'            
) xt
WHERE ROWNUM = 1;



