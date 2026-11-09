# Actividad 17 — Cronología y respuestas a Dirección

Los eventos fechados corresponden al 8 de noviembre de 2026, en CST, según la bitácora exportada. `L` indica el número de línea del archivo y `E` el identificador de la fila de auditoría. Las continuaciones de un bloque comparten la hora y el contexto de su primera línea.

| # | Hora CST | Usuario | Cliente | Tipo | Qué ocurrió | ¿Exitoso? | Fuente |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 17:17:31.243 | `app_ventas` | `127.0.0.1` | Acceso | Contraseña incorrecta. | No | L105–106 |
| 2 | 17:17:43.484 | `usuario_inexistente` | `127.0.0.1` | Acceso | Intento con un rol inexistente. | No | L111–112 |
| 3 | 17:17:59.943 | `app_ventas` | `127.0.0.1` | Acceso | Conexión autorizada para `app-ventas-web`. | Sí | L119–120 |
| 4 | 17:22:44.710 | `postgres` | `::1` | Privilegio | `REVOKE` a soporte y `GRANT` a ventas. | Sí | L128–129 |
| 5 | 17:22:44.710 | `postgres` | `::1` | Estructura | Se agregó `clientes.segmento`. | Sí | L128 y L130 |
| 6 | 17:30:55.552 | `postgres` | `::1` | Configuración | Se solicitó `log_statement = 'mod'`. `SHOW` confirmó el valor después. | Sí | L173 y captura de la Actividad 7 |
| 7 | 17:31:24.803 | `app_ventas` | `127.0.0.1` | Datos | Actualizó el teléfono del cliente 3. | Sí | L177 y `UPDATE 1` |
| 8 | 17:35:09.556 | `soporte_ana` | `127.0.0.1` | Error | Se rechazó el borrado del cliente 5. | No | L185–186 |
| 9 | 17:37:05.016 | `postgres` | `::1` | Error | Se rechazó eliminar `soporte_ana` por dependencias. | No | L215–218 |
| 10 | 17:42:25.817 | `soporte_ana` | `127.0.0.1` | Acceso | Cerró `reporte-mensual` tras 90,074 s. | Sí | L238 |
| 11 | 17:48:24.257 | `app_ventas` | `127.0.0.1` | Datos | Cambió el RFC de María García. | Sí | L285 y E1 |
| 12 | 17:53:27.025 | `postgres` | `::1` | Datos | Cambió el RFC entre la desactivación y la reactivación del disparador. | Sí | L308–310 y captura de ejecución |
| 13 | 17:55:43.117 | `postgres` | `::1` | Datos | Actualizó el segmento de cinco clientes. | Sí | L317 y `UPDATE 5` |

## Respuestas a Dirección

1. **¿Quién cambió el RFC?** En las actividades 3 y 7, las capturas de la ejecución controlada identifican a `app_ventas`. Para atribuir esos cambios a partir de la bitácora del servidor, **No hay evidencia**. En la Actividad 12 el rol de sesión fue `app_ventas` (L285 y E1). En la Actividad 14 el bloque de `postgres` quedó en L308–310.
2. **¿Cuándo y desde dónde?** Para la hora exacta de los cambios de las actividades 3 y 7, **No hay evidencia**. Las capturas de PowerShell muestran que el comando usó `app-ventas-web` y `127.0.0.1`. La Actividad 12 quedó registrada a las 17:48:24.257, desde `app-ventas-web` y `127.0.0.1`. La Actividad 14 quedó registrada a las 17:53:27.025, desde pgAdmin y `::1`.
3. **¿Quién cambió el teléfono?** `app_ventas` lo cambió a las 17:31:24.803, desde `app-ventas-web` y `127.0.0.1` (L177). El valor anterior no está en esa sentencia.
4. **¿Hubo intentos de acceso fallidos antes del cambio?** Antes de los cambios auditados aparecen fallos locales desde `127.0.0.1` para `app_ventas` y `usuario_inexistente` (L105 y L111), además de intentos previos de `postgres`. El intento inicial de la Actividad 3 ocurrió antes de activar el registro de conexiones. Para los accesos fallidos anteriores a ese incidente, **No hay evidencia**.
5. **¿Qué RFC había antes de cada cambio?** Las capturas de la práctica muestran `GAMA780912GHI` antes de la Actividad 3 y `GAMA780912XXX` antes de la 7. El evento 1 conserva `GAMA780912XYZ` antes de la 12 y `GAMA780912ZZZ` después. Ese último valor es el último estado observado antes de la 14. En la tabla de auditoría, **No hay evidencia** del valor previo para la 14 porque el disparador estaba deshabilitado.
