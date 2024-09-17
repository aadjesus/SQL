create or replace function Rabbit_Publish
(
       pExchange IN varchar2,
       pExchange_Key IN varchar2,
       pTexto IN varchar2,
       pHost IN varchar2,
       pPorta IN number,
       pVirtual_Host IN varchar2,
       pUsername IN varchar2,
       pPassword IN varchar2
) return NUMBER as language java name 
'com.zenika.oracle.amqp.RabbitMQPublisher.amqpPublish(
java.lang.String, 
java.lang.String,
java.lang.String,
java.lang.String,
int,
java.lang.String,
java.lang.String,
java.lang.String) 
return int';