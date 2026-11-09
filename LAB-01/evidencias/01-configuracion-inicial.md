# Actividad 1 — Configuración inicial de la bitácora

**Estudiante:** Diego Villarreal Lopez  
**Entorno:** PostgreSQL 18.6 en Windows, base `comercial`.

Se consultaron diez parámetros en `pg_settings` antes de modificar la configuración de registro para esta unidad.

| Parámetro | Valor observado | Origen mostrado |
| --- | --- | --- |
| `log_connections` | Cadena vacía | default |
| `log_destination` | `stderr` | configuration file |
| `log_directory` | `log` | default |
| `log_disconnections` | `off` | default |
| `log_filename` | `postgresql-%Y-%m-%d_%H%M%S.l…` (recortado en la captura) | default |
| `log_line_prefix` | `%t` | configuration file |
| `log_min_error_statement` | `error` | default |
| `log_statement` | `none` | default |
| `log_timezone` | `America/Chihuahua` | configuration file |
| `logging_collector` | `on` | configuration file |

## Respuestas

1. **¿Se registra quién se conecta?** No se registra rutinariamente quién inicia sesión con éxito. En PostgreSQL 18, el valor vacío de `log_connections` desactiva ese registro. Los fallos de autenticación pueden registrarse de todas formas.
2. **¿Se registran los UPDATE?** Los exitosos no se registran de forma general con `log_statement = none`. Una sentencia que provoque un error sí puede aparecer por `log_min_error_statement = error`.
3. **¿El prefijo incluye usuario o IP?** No. `%t` agrega fecha y hora sin milisegundos; el prefijo no incluye campos de usuario ni dirección. Algunos mensajes pueden contener esos datos en su propio texto.
4. **¿En qué zona horaria se registran los eventos?** En `America/Chihuahua`. Identificarla permite ordenar los eventos y compararlos con otros registros que podrían usar UTC u otra zona.
5. **¿Quién decide el destino si el colector está apagado?** Con destino `stderr`, el servicio o mecanismo que inicia PostgreSQL determina cómo se captura esa salida. En este servidor el colector está **activado**, por lo que PostgreSQL recoge la salida y escribe sus archivos de bitácora.

Referencia: [PostgreSQL 18 — Registro de errores y eventos](https://www.postgresql.org/docs/18/runtime-config-logging.html).
