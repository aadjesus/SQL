CREATE INDEX idx_elmah$error_app_time_seq ON elmah$error(application, timeutc DESC, sequencenumber DESC)
