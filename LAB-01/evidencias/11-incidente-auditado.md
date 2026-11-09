# Actividad 12 — El incidente auditado

Desde PowerShell, `app_ventas` se conectó a `comercial` desde `127.0.0.1` con la aplicación `app-ventas-web` y actualizó a `GAMA780912ZZZ` el RFC del cliente con `id = 3`. PostgreSQL devolvió `UPDATE 1`. En una segunda conexión, el mismo rol intentó consultar `auditoria.cambios_clientes` y PostgreSQL devolvió `permiso denegado al esquema auditoria`.

La consulta como `postgres` mostró el evento `1` de tipo `UPDATE` para el cliente `3`, con `app_ventas` como usuario de sesión, `postgres` como usuario efectivo e IP `127.0.0.1`. La comparación identificó `rfc` como el único campo modificado. PgAdmin recortó los valores en la cuadrícula. Las capturas de los comandos y consultas muestran que el valor anterior era `GAMA780912XYZ` y el nuevo es `GAMA780912ZZZ`.

## Preguntas de la guía

1. **¿Qué pasó con la hipótesis de la Actividad 11?** El cambio quedó auditado porque `SECURITY DEFINER` permitió que la función escribiera con los permisos de su propietario, `postgres`. `session_user` conservó el rol que hizo el cambio, `app_ventas`.
2. **¿Cómo se restauraría el RFC anterior?** La siguiente sentencia restauraría el valor y generaría un nuevo evento si el disparador está habilitado.

   ```sql
   UPDATE clientes SET rfc = 'GAMA780912XYZ' WHERE id = 3;
   ```

3. **¿Qué campo es más confiable para investigar el origen?** `ip_cliente` describe la dirección que observó el servidor y ayuda a rastrear la conexión. `aplicacion` aporta contexto, pero el cliente puede elegir ese nombre. Una IP tampoco identifica por sí sola a una persona.
