SET MARKUP CSV ON DELIMITER ~
SET TERMOUT OFF
SPOOL /opt/pool/table_name/exports/table_name_temp_raw.csv
SELECT * FROM SCHEMA.TABLE;
SPOOL OFF
EXIT;
