SELECT version();

SHOW data_directory;
SHOW config_file;
SHOW hba_file;

SELECT datname
FROM pg_database
WHERE datname = 'comercial';

SELECT line_number, type, database, user_name, address, auth_method
FROM pg_hba_file_rules
WHERE database = '{all}';
