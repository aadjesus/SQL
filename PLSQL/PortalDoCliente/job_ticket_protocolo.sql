BEGIN
DBMS_SCHEDULER.CREATE_JOB (
   job_name                 =>  'MTK_TICKET_PROTOCOLO',
   start_date               => TO_DATE('2016/06/01', 'YYYY/MM/DD'), 
   job_type                 =>  'PLSQL_BLOCK',
   job_action               =>  'BEGIN EXECUTE IMMEDIATE ''DROP SEQUENCE SEQ_MTK_TICKET_PROTOCOLO''; EXECUTE IMMEDIATE ''CREATE SEQUENCE SEQ_MTK_TICKET_PROTOCOLO minvalue 1 maxvalue 999999 increment by 1 cache 20''; END;',   
   repeat_interval          => 'FREQ=MONTHLY;BYMONTHDAY=1',
   enabled                  => TRUE);
END;

