# Actividad 7 — Modificaciones de datos con `ddl` y `mod`

Con `log_statement = 'ddl'`, `app_ventas` actualizó el RFC del cliente con `id = 3` a `GAMA780912XYZ` desde `app-ventas-web`. PowerShell devolvió `UPDATE 1`. La consulta de las tres entradas más recientes de `app_ventas` mostró la autenticación, la autorización y la desconexión del PID `6340` desde `127.0.0.1`. La sentencia `UPDATE` no apareció en ese resultado.

Como `postgres`, se ejecutó `ALTER SYSTEM SET log_statement = 'mod'` y `pg_reload_conf()` devolvió `true`. En una conexión nueva, `app_ventas` actualizó el teléfono del cliente `id = 3` a `6679990000` y obtuvo `UPDATE 1`. En la misma sesión, el `SELECT` devolvió una fila con el nombre de María García y el RFC `GAMA780912XYZ`.

La consulta de la guía devolvió tres filas relacionadas con `ALTER SYSTEM`. Después, `SHOW log_statement` confirmó el valor efectivo `mod`. La búsqueda por el texto del `UPDATE` encontró la línea 177 del 8 de noviembre de 2026 a las 17:31:24.803 CST, con el PID `4812`, el rol `app_ventas`, la aplicación `app-ventas-web` y el cliente `127.0.0.1`. El registro usó el prefijo `LOG: sentencia:`, de modo que el filtro original por `statement:` omitió esa línea.

## Preguntas de la guía

1. **¿Qué nivel habría registrado la lectura del RFC y qué costo tendría?** El nivel `all` registra las sentencias `SELECT`. En un servidor con miles de consultas por minuto aumentaría el volumen de la bitácora, la escritura a disco y el espacio necesario para conservar los registros.
2. **¿Qué falta para revertir el cambio con certeza?** Falta el valor anterior del teléfono. La sentencia registrada contiene el nuevo número y el identificador del cliente. Para recuperar el valor previo se necesita otra fuente de evidencia, como la auditoría por fila de la Parte B.
