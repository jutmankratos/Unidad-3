# Actividad 10 — Diseño del registro de auditoría

En `comercial`, se creó el esquema `auditoria`, se revocó el acceso del rol `PUBLIC` al esquema y se creó `auditoria.cambios_clientes`. PgAdmin confirmó el resultado con `CREATE TABLE`.

| Campo | Tipo | Qué permite saber | ¿Puede ser nulo? |
| --- | --- | --- | --- |
| `id_evento` | BIGSERIAL | Qué entrada identifica el cambio. | No, es la clave primaria. |
| `momento` | TIMESTAMPTZ | Cuándo ocurrió el cambio. | No, tiene `NOT NULL` y el valor por defecto `now()`. |
| `usuario_sesion` | TEXT | Qué rol inició sesión. | No, se toma de `session_user`. |
| `usuario_efectivo` | TEXT | Con qué rol efectivo se insertó la evidencia. | No, se toma de `current_user`. |
| `aplicacion` | TEXT | Qué nombre de aplicación declaró el cliente. | El esquema admite `NULL`. Si la sesión no declara un nombre, el valor por defecto puede ser una cadena vacía. |
| `ip_cliente` | INET | Desde qué dirección llegó la conexión. | Sí, una conexión por socket Unix no tiene IP. |
| `operacion` | TEXT | Si el cambio fue un alta, una modificación o una baja. | No, la operación es obligatoria. |
| `id_cliente` | BIGINT | A qué cliente corresponde el cambio. | El esquema admite `NULL`. El disparador de la guía toma la clave primaria de la fila afectada. |
| `valores_antes` | JSONB | Cómo era el registro antes de la operación. | Sí, un alta no tiene fila previa. |
| `valores_despues` | JSONB | Cómo quedó el registro después de la operación. | Sí, una baja no deja una fila posterior. |

## Preguntas de la guía

1. **¿Por qué `TIMESTAMPTZ`?** Identifica un instante que se puede comparar con eventos registrados en otras zonas horarias. PostgreSQL lo presenta en la zona configurada para la sesión.
2. **¿Por qué guardar la fila completa en `JSONB`?** Permite comparar el estado anterior y posterior, detectar qué campos cambiaron y conservar los campos presentes en ese momento aunque la tabla se modifique después.
3. **¿Qué implica guardar el RFC?** La auditoría contiene datos personales y debe protegerse como tal. Su acceso se limita a los roles autorizados para investigar cambios y sus copias requieren el mismo control.
