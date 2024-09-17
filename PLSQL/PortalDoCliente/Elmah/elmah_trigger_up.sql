CREATE TRIGGER trg_elmah$error_bi
BEFORE INSERT ON elmah$error
FOR EACH ROW
BEGIN
    SELECT elmah$error_seq.NEXTVAL INTO :new.sequencenumber FROM dual;
END trg_elmah$error_bi;