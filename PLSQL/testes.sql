--begin
--     dbms_java.grant_permission('BB170419/BB170419','SYS:java.io.FilePermission','<>','execute');
    -- dbms_java.grant_permission('BB170419/BB170419','SYS:java.io.FilePermission','<>','writeFileDescriptor');
  --   dbms_java.grant_permission('BB170419/BB170419','SYS:java.io.FilePermission','<>','readFileDescriptor');
--end;

--select * from all_objects where upper(object_name) like upper('%Rabbit%') 
--select * from v$sgastat where POOL = 'java pool' or NAME = 'free memory'; 
--SELECT comp_id, comp_name FROM dba_registry
--show parameter SHARED_POOL_SIZE;
--SELECT * from  DBA_OBJECTS where upper(object_name) like upper('%Rabbit%') 

SELECT * from  USER_OBJECTS where upper(object_name) like upper('%Rabbit%') 

select * from dba_source where upper(NAME) like upper('%java%');
select * from dba_registry;

SELECT * from USER_OBJECTS where upper(OBJECT_NAME) like upper('%grant%');


--ORA-29532: Java call terminated by uncaught Java exception: java.lang.ExceptionInInitializerError

/*

   call dbms_java.grant_permission('<user_name>','SYS:java.util.logging.LoggingPermission','control', '' );  
   call dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission', 'setFactory', '' ); 
execute dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission','accessClassInPackage.sun.util.calendar','');
execute dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission','getClassLoader','');
execute dbms_java.grant_permission('<user_name>','SYS:java.net.SocketPermission','*','connect,resolve');
execute dbms_java.grant_permission('<user_name>','SYS:java.util.PropertyPermission','*','read,write');
execute dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission','setFactory','');
   call dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission','shutdownHooks', '' );
   call dbms_java.grant_permission('<user_name>','SYS:java.util.logging.LoggingPermission', 'control', '' );
   call dbms_java.grant_permission('<user_name>','SYS:java.util.PropertyPermission','http.proxySet','write');
   call dbms_java.grant_permission('<user_name>','SYS:java.util.PropertyPermission','http.proxyHost', 'write');
   call dbms_java.grant_permission('<user_name>','SYS:java.util.PropertyPermission','http.proxyPort', 'write');
   call dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission','getClassLoader','');
   call dbms_java.grant_permission('<user_name>','SYS:java.net.SocketPermission','*','connect,resolve');
   call dbms_java.grant_permission('<user_name>','SYS:java.util.PropertyPermission','*','read,write');
   call dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission','setFactory','');
   call dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission','accessClassInPackage.sun.util.calendar','');  
   call dbms_java.grant_permission('<user_name>','SYS:oracle.aurora.security.JServerPermission', 'Verifier', '' );
   call dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission', 'accessClassInPackage.sun.util.calendar','' ) ;
   call dbms_java.grant_permission('<user_name>','SYS:java.net.SocketPermission', '<<machineName>>', 'resolve' );
   call dbms_java.grant_permission('<user_name>','SYS:java.net.SocketPermission', '192.168.4.146', 'connect,resolve' );
   call dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission', 'createClassLoader', '' );
   call dbms_java.grant_permission('<user_name>','SYS:java.lang.RuntimePermission', 'setFactory', '' );
   call dbms_java.grant_permission('<user_name>','SYS:java.util.PropertyPermission', 'HTTPClient.socket.idleTimeout', 'write');
   call dbms_java.grant_permission('<user_name>','SYS:java.net.SocketPermission', 'localhost', 'resolve' );
   call dbms_java.grant_permission('<user_name>','SYS:java.net.SocketPermission', '192.168.3.229:80', 'connect,resolve' );
   call dbms_java.grant_permission('<user_name>','SYS:java.util.PropertyPermission', 'HTTPClient.socket.idleTimeout', 'write');*/