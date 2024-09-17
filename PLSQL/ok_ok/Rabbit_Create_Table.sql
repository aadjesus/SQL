CREATE TABLE Rabbit
  (
    HOST      VARCHAR2(255) NOT NULL ENABLE,
    PORT      NUMBER(*) DEFAULT 5672,
    VHOST     VARCHAR2(255 ) DEFAULT '/',
    USERNAME  VARCHAR2(255) ,
    PASSWORD  VARCHAR2(255) ,
    Exchange  VARCHAR2(255) DEFAULT 'BgmRodotec_Manu360',
    Exchange_Type  VARCHAR2(255) DEFAULT 'direct',    
    Declare_Process NUMBER(1) DEFAULT 0,
    Exchange_Key  VARCHAR2(255),    
    CONSTRAINT Rabbit_KEY PRIMARY KEY (HOST, PORT) ENABLE
  ); 
  