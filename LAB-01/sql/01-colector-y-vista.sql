SELECT pg_current_logfile();

SELECT convert_from(
    pg_read_binary_file(pg_current_logfile(), 0, 4096),
    'WIN1252'
) AS inicio_bitacora;

CREATE SCHEMA IF NOT EXISTS dba;
REVOKE ALL ON SCHEMA dba FROM PUBLIC;

CREATE OR REPLACE VIEW dba.bitacora AS
SELECT linea, num
FROM regexp_split_to_table(
    convert_from(pg_read_binary_file(pg_current_logfile()), 'WIN1252'),
    E'\\r?\\n'
) WITH ORDINALITY AS b(linea, num);

REVOKE ALL ON dba.bitacora FROM PUBLIC;

SELECT count(*) AS lineas_leidas
FROM dba.bitacora
WHERE linea <> '';
