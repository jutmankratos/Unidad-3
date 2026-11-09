# Actividad 4 — Configuración de la bitácora

Se ejecutaron cuatro comandos `ALTER SYSTEM` y `pg_reload_conf()` devolvió `true`. La sesión que ya estaba abierta mostró el prefijo nuevo y `log_statement = ddl`, ambos con origen en el archivo de configuración. Los cuatro parámetros mostraron `pending_restart = false`.

En pgAdmin, `log_connections` aún apareció vacío y `log_disconnections` en `off`, con origen `default`.

Una conexión nueva de `psql` desde PowerShell a `127.0.0.1`, con el usuario `postgres` y la base `comercial`, confirmó `log_connections = receipt,authentication,authorization` y `log_disconnections = on`. Ambos parámetros mostraron `configuration file` como origen.

Se abrió una conexión de prueba desde PowerShell como `app_ventas` en `comercial`, con `application_name=lab01-prueba-bitacora`. La consulta devolvió el PID `19628`. Ese PID permite buscar las entradas de conexión y desconexión de la sesión en `dba.bitacora`.

La búsqueda del PID `19628` en `dba.bitacora` devolvió cuatro eventos: recepción desde `127.0.0.1`, autenticación de `app_ventas` mediante SCRAM-SHA-256, autorización en `comercial` y desconexión. La última entrada identifica la aplicación `lab01-prueba-bitacora` y registra una duración de `0:00:00.055`.
