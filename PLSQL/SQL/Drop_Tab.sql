DROP SEQUENCE SEQ_GL5_Log;
DROP SEQUENCE SEQ_GL5_Log_sac;

DROP table cascade Gl5_Log_2013_09;
DROP table cascade Gl5_Log_Sac_2013_09;

create sequence SEQ_GL5_Log
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20
order;

create sequence SEQ_GL5_Log_sac
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20
order;
