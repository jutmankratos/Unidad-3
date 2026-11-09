# Informe del LAB-01 — Bitácoras y auditoría del dato en PostgreSQL

Diego Villarreal Lopez · Unidad 3 · 8 de noviembre de 2026

## Despliegue y situación inicial

La práctica se realizó en PostgreSQL 18.6 sobre Windows, en la base `comercial`. El colector ya estaba activo y escribía en el directorio `log`. El valor inicial `log_statement = 'none'` dejó fuera el primer cambio de RFC del cliente `3`. La ejecución controlada mostró `UPDATE 1`, pero la búsqueda en la bitácora no devolvió la sentencia.

## Configuración aplicada

Se habilitaron los eventos de recepción, autenticación y autorización mediante `log_connections`, y los cierres mediante `log_disconnections`. El prefijo añadió hora, PID, rol, base, aplicación e IP. Se aplicaron los cambios con `pg_reload_conf()` y se confirmaron los valores de conexión desde una sesión nueva. Se usó primero `log_statement = 'ddl'` y después `mod` para registrar también modificaciones de datos.

## Eventos observados

La bitácora distinguió una contraseña incorrecta de un rol inexistente por el detalle del servidor. El PID permitió enlazar una sesión activa en `pg_stat_activity` con su conexión y desconexión en la bitácora. También se registraron cambios de privilegios y estructura, un borrado denegado, un intento de eliminar un rol con dependencias y el cambio de teléfono ejecutado por `app_ventas`.

## Auditoría de cambios

El disparador de `clientes` guardó un evento por fila en `auditoria.cambios_clientes`, con los estados anterior y posterior en `JSONB`. La función `SECURITY DEFINER` escribió como `postgres`, mientras `session_user` conservó la identidad de `app_ventas`. El evento `1` registró que el RFC del cliente `3` pasó de `GAMA780912XYZ` a `GAMA780912ZZZ`. PostgreSQL rechazó la lectura directa del historial por `app_ventas`.

## Límites y conservación

El cambio masivo de segmento produjo una sentencia en la bitácora y cinco eventos nuevos en la auditoría por fila. La lectura de soporte quedó fuera del registro de sentencias con `mod`. Durante la prueba de desactivación del disparador, el cambio del administrador quedó en la bitácora y el conteo de la tabla de auditoría siguió en tres.

La contraseña de prueba que apareció en el registro se sustituyó por `<REDACTED>` al exportar la bitácora. El SHA-256 se recalculó y coincidió con el valor obtenido en PowerShell. Una copia y un hash bajo custodia separada ayudan a detectar modificaciones y a conservar el registro ante una pérdida del servidor.

## Cronología y conclusión

La cronología identifica 13 eventos y responde las preguntas de Dirección. La bitácora permite identificar el rol, el origen y la sentencia cuando el nivel configurado la registra. La auditoría por fila aporta los valores anterior y posterior cuando el disparador está habilitado.

Las respuestas completas y las capturas están en el [PDF del laboratorio](Informe-LAB-01.pdf). Los números de línea y los identificadores de eventos están en la [cronología](evidencias/15-cronologia.md).
