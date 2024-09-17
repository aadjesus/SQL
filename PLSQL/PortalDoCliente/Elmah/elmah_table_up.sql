CREATE TABLE elmah$error
(
    -- if using Oracle 10g and above you can add DEFAULT SYS_GUID() 
    -- to the errorid definition.
    -- Oracle 8i doesn't like it with an NVARCHAR2
    -- haven't tested it against 9i
    errorid         NVARCHAR2(32) NOT NULL,
    application     NVARCHAR2(60) NOT NULL,
    host            NVARCHAR2(30) NOT NULL,
    type            NVARCHAR2(100) NOT NULL,
    source          NVARCHAR2(60),
    message         NVARCHAR2(500) NOT NULL,
    username        NVARCHAR2(50),
    statuscode      NUMBER NOT NULL,
    timeutc         DATE NOT NULL,
    sequencenumber  NUMBER NOT NULL,
    allxml          NCLOB NOT NULL,
    CONSTRAINT idx_elmah$error_pk 
        PRIMARY KEY (errorid) 
        USING INDEX -- TABLESPACE "TABLESPACE FOR INDEX"
) 