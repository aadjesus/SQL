SPOOL C:\DROP.SQL;

SELECT 'ALTER TABLE MOT_MODELOMOTOR DROP CONSTRAINT ' ||CONSTRAINT_NAME|| ';'
FROM USER_CONS_COLUMNS WHERE COLUMN_NAME = 'TPCOMBOPRIMODMOTOR';

SPOOL OFF;

@C:\DROP.SQL;
