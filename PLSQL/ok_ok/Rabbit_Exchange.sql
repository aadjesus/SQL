create or replace function Rabbit_Exchange
(
       pExchange IN varchar2,
       pExchange_Type IN varchar2,
       pHost IN varchar2,
       pPorta IN number,
       pVirtual_Host IN varchar2,
       pUsername IN varchar2,
       pPassword IN varchar2
)
return NUMBER as language java
name 'com.zenika.oracle.amqp.RabbitMQPublisher.amqpExchangeDeclare(
java.lang.String,
java.lang.String,
java.lang.String,
int,
java.lang.String,
java.lang.String,
java.lang.String
) return int';
