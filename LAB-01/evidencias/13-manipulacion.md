# Actividad 14 — Intentos de manipular la auditoría

Desde PowerShell, `app_ventas` intentó borrar los registros de `auditoria.cambios_clientes` y deshabilitar `trg_auditoria_clientes`. PostgreSQL denegó el primer intento por falta de acceso al esquema `auditoria` y el segundo porque el rol no es dueño de la tabla `clientes`.

Como `postgres`, se deshabilitó el disparador, se cambió a `GAMA780912GHI` el RFC del cliente `3` y se volvió a habilitar el disparador en el mismo bloque. PgAdmin confirmó el último `ALTER TABLE`. El conteo posterior siguió en tres eventos, por lo que esa modificación no generó una fila de auditoría.

La bitácora muestra el intento de `app_ventas` con PID `2012` en las líneas 304 y 306, a las 17:52:42 CST del 8 de noviembre de 2026. El error de propietario aparece en la captura de PowerShell. Las líneas 308 a 310 muestran el bloque ejecutado por `postgres` desde pgAdmin, con PID `12184` e IP `::1`, a las 17:53:27.025 CST. El `UPDATE` y la reactivación del disparador aparecen como continuación del mismo bloque.

## Preguntas de la guía

1. **¿Qué evidencia permite detectar el cambio sin auditar?** La bitácora del servidor conserva la secuencia `DISABLE TRIGGER`, `UPDATE` y `ENABLE TRIGGER`. El conteo de la tabla de auditoría siguió en tres, lo que confirma que ese cambio no generó un evento por fila.
2. **¿Qué control administrativo reduciría el riesgo?** Exigir autorización y revisión por una segunda persona para cambios que deshabiliten controles de auditoría. El registro del cambio debe identificar a quien autorizó, a quien ejecutó y a quien verificó la reactivación.
3. **¿Cómo se aplica la separación de funciones?** El DBA administra la base y un equipo distinto custodia y revisa las bitácoras. La revisión independiente permite contrastar la actividad del DBA con la evidencia conservada fuera de su control directo.
