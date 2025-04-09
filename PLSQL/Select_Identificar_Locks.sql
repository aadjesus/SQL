     SELECT a.session_id
          , b.username
          , b.program
          , c.owner
          , c.object_name
       FROM v$locked_object a
 INNER JOIN v$session       b ON a.session_id = b.sid
 INNER JOIN dba_objects     c ON a.object_id = c.object_id
      WHERE c.object_name = 'ESFISS_NSTECH';

-- Derubar sessão       
-- ALTER SYSTEM KILL SESSION 'SID,SERIAL#';  
    