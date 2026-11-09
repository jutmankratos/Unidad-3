# Actividad 5 — Accesos exitosos y fallidos

Desde PowerShell se probaron tres conexiones a `comercial` en `127.0.0.1`. `psql` mostró un error de autenticación para `app_ventas` con una contraseña incorrecta y para `usuario_inexistente`. Con la contraseña correcta y la aplicación `app-ventas-web`, `app_ventas` ejecutó `SELECT count(*) FROM clientes` y obtuvo cinco filas en la tabla.

Se agregó la columna `num` a `dba.bitacora` para ordenar las entradas por su posición en el archivo. La consulta de la guía filtró por `client=127.0.0.1` y devolvió 48 filas. En las últimas filas se identificaron estos eventos del 8 de noviembre de 2026 en la base `comercial`:

| Hora (CST) | PID | Usuario | Resultado |
| --- | --- | --- | --- |
| 17:17:31.243 | 5316 | `app_ventas` | `FATAL` por contraseña incorrecta. El detalle indica que coincidió una regla de `pg_hba.conf`. |
| 17:17:43.484 | 21604 | `usuario_inexistente` | `FATAL` de autenticación. La línea `DETALLE` indica que el rol no existe. |
| 17:17:59.943 | 14396 | `app_ventas` | Autenticación mediante SCRAM-SHA-256 y conexión autorizada. |
| 17:17:59.983 | 14396 | `app_ventas` | Desconexión de `app-ventas-web` tras 67 ms. |

PowerShell mostró el mismo tipo de error para los dos rechazos. El detalle de la bitácora del servidor permitió identificar el intento con un rol inexistente. El PID `14396` relacionó la autorización con la desconexión de la sesión exitosa.

## Preguntas de la guía

1. **¿Qué demuestra el usuario del intento fallido?** Demuestra que un cliente desde `127.0.0.1` presentó el nombre `app_ventas` e intentó autenticarse. Un cliente puede declarar ese usuario sin ser la aplicación de ventas.
2. **¿Qué detalle queda cuando el rol no existe?** PostgreSQL indica en la bitácora que `usuario_inexistente` no existe. El cliente recibe un error genérico de autenticación, lo que evita revelar qué roles son válidos.
3. **¿Por qué cambia el campo `app`?** En el rechazo, la conexión terminó durante la autenticación y el prefijo aún mostraba la aplicación como desconocida. Al cerrar la sesión exitosa, el prefijo ya incluía el nombre `app-ventas-web` que declaró el cliente.
4. **¿Qué patrón sugiere fuerza bruta?** Muchos fallos en poco tiempo contra el mismo usuario desde una IP, o intentos contra varios usuarios desde el mismo origen. La siguiente consulta propuesta cuenta entradas de autenticación fallida por usuario. Cada entrada representa un fallo registrado por el servidor.

```sql
SELECT substring(linea FROM 'user=([^ ]+) db=') AS usuario,
       count(*) AS intentos_fallidos
FROM dba.bitacora
WHERE linea ~* 'FATAL:.*(password authentication failed|password fall)'
GROUP BY 1
ORDER BY intentos_fallidos DESC, usuario;
```
