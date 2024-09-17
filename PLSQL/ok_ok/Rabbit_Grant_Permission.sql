call dbms_java.grant_permission( 'BB170419', 'SYS:java.net.SocketPermission', '172.16.2.238:15672', 'connect,resolve' );

-- tell the Oracle JVM to prefer IPv4 over IPv6 (if needed)...
call dbms_java.grant_permission( 'BB170419', 'SYS:java.util.PropertyPermission', 'java.net.preferIPv4Stack', 'write' );