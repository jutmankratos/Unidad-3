# Actividad 9 — Sesiones activas con `pg_stat_activity`

La consulta de sesiones de cliente mostró dos conexiones activas de `reporte-mensual` desde `127.0.0.1`, con los PID `19748` y `5348`. Ambas estaban ejecutando `SELECT pg_sleep(90)`. Se eligió el PID `19748`, que corresponde a la conexión iniciada más recientemente, para cotejar la sesión con la bitácora.

El servidor recibió la conexión del PID `19748` desde `127.0.0.1` el 8 de noviembre de 2026 a las 17:40:55.752 CST. Registró la autenticación de `soporte_ana` mediante SCRAM-SHA-256 y la autorización en `comercial` a las 17:40:55.770 CST. Después de que PowerShell devolvió el resultado, la consulta de `dba.bitacora` mostró también la desconexión de `reporte-mensual` a las 17:42:25.817 CST. El servidor registró una duración de 90,074 segundos.

## Preguntas de la guía

1. **¿Cómo se relaciona la sesión con la bitácora?** El campo `pid` de `pg_stat_activity` coincide con el identificador del proceso en el prefijo de la bitácora. En esta prueba fue `19748`.
2. **¿Qué conserva la evidencia cuando termina el reporte?** La bitácora conserva las entradas de conexión y desconexión. `pg_stat_activity` muestra las sesiones presentes en el momento de la consulta.
3. **¿Por qué el ejemplo del administrador no muestra `client_addr`?** Una conexión por socket Unix carece de dirección IP y devuelve `NULL`. En la práctica, pgAdmin usó TCP local y el administrador apareció con `::1`.
