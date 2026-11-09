# Actividad 11 — Función y disparador de auditoría

PgAdmin confirmó `CREATE TRIGGER`. La consulta de `pg_trigger` devolvió el disparador de `clientes` con `tgenabled = O`, por lo que está habilitado para las operaciones normales de la sesión. El disparador invoca la función por cada fila insertada, modificada o eliminada.

## Preguntas de la guía

1. **¿Por qué se revoca el acceso a la función para `PUBLIC`?** La revocación restringe el permiso de ejecución que PostgreSQL otorga por defecto. El disparador ya quedó creado por un rol autorizado y puede llamar a la función cuando `app_ventas` modifique `clientes`.
2. **¿Qué pasaría sin `SECURITY DEFINER`?** La hipótesis es que el `UPDATE` de `app_ventas` fallaría al intentar guardar la evidencia, porque la función se ejecutaría con los permisos de ese rol y no tendría acceso de escritura a `auditoria.cambios_clientes`.
3. **¿Quedaron registradas las creaciones?** Sí. `dba.bitacora` mostró `CREATE SCHEMA` en la línea 241, `CREATE TABLE` en la 243, `CREATE OR REPLACE FUNCTION` en la 255 y `CREATE TRIGGER` en la 279. La tabla y el disparador aparecen como continuación de sus respectivos bloques. El nivel `mod` también registra las sentencias de definición de datos.
