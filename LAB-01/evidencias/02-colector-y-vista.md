# Actividad 2 — Colector y lectura de la bitácora

El colector ya estaba activo. `pg_current_logfile()` devolvió `log/postgresql-2026-11-08_162208.log`. La lectura de los primeros 4096 bytes con `pg_read_file` produjo el error `22021`; el mismo fragmento se pudo leer con `pg_read_binary_file` y `convert_from(..., 'WIN1252')`.

El esquema `dba` y la vista `dba.bitacora` ya existían. PostgreSQL rechazó el intento de crear la vista de nuevo con `42P07`. Los comandos `REVOKE` sobre el esquema y la vista terminaron correctamente. El conteo devolvió **65 líneas no vacías**.

Con `pg_get_viewdef('dba.bitacora'::regclass, true)` se confirmó que la vista obtiene el archivo activo con `pg_current_logfile()`, lo lee con `pg_read_binary_file`, convierte el texto desde `WIN1252` y lo separa por saltos de línea con `regexp_split_to_table`. Se reutilizó la vista existente.
