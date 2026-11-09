# Actividad 8 — Errores y operaciones rechazadas

Desde PowerShell, `soporte_ana` se conectó a `comercial` por `127.0.0.1` e intentó ejecutar `DELETE FROM clientes WHERE id = 5`. PostgreSQL rechazó la sentencia con un error de permiso denegado sobre la tabla `clientes`.

En pgAdmin se intentó ejecutar `DROP ROLE soporte_ana` dentro de una transacción de prueba. PostgreSQL devolvió el código `2BP01` e identificó los privilegios sobre `clientes` como la dependencia que impidió eliminar el rol.

El filtro de la guía devolvió cero filas. El filtro adaptado aceptó etiquetas en español e inglés y uno o más espacios después de cada etiqueta. Devolvió 18 filas, entre ellas los errores, los detalles y las sentencias de ambos casos.

| Hora (CST) | PID | Rol y origen | Resultado |
| --- | --- | --- | --- |
| 17:35:09.556 | 18388 | `soporte_ana`, `psql`, `127.0.0.1` | `DELETE` rechazado por falta de permiso sobre `clientes`. |
| 17:37:05.016 | 12184 | `postgres`, pgAdmin, `::1` | `DROP ROLE` rechazado por los privilegios de `soporte_ana` sobre `clientes`. |

## Preguntas de la guía

1. **¿Qué efecto tuvo el intento de `soporte_ana` y por qué se audita?** El control de permisos impidió que se borrara la fila. Registrar el intento permite investigar el uso de una cuenta fuera de sus funciones y detectar si se repite.
2. **¿En qué se distinguen la autenticación y la autorización?** La autenticación comprueba las credenciales al conectarse. La autorización verifica si el rol ya autenticado tiene permiso para ejecutar una operación.
3. **¿En qué orden se da de baja un rol?** Primero se revisan sus dependencias, se revocan sus privilegios y se reasignan sus objetos si los tiene. Después se elimina el rol. En esta prueba el impedimento fueron los privilegios sobre `clientes`.
