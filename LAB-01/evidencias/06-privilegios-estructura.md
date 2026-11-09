# Actividad 6 — Cambios de privilegios y de estructura

Se ejecutó el bloque de `REVOKE`, `GRANT` y `ALTER TABLE` en pgAdmin. La pestaña Messages mostró `ALTER TABLE` y confirmó que el bloque terminó correctamente. A continuación, se ejecutó el bloque de creación y eliminación de `rol_temporal`. La pestaña Messages mostró `DROP ROLE`.

La consulta de la guía filtró por `statement:` y mostró los encabezados de los bloques. La consulta adicional recuperó también sus líneas contiguas y ocultó la contraseña en la salida. Los bloques quedaron registrados bajo el PID `12184`, con `postgres` en `comercial` desde pgAdmin y el cliente local `::1`.

| Hora (CST) | Líneas de bitácora | Sentencias |
| --- | --- | --- |
| 17:22:44.710 | 128–130 | `REVOKE UPDATE`, `GRANT UPDATE` y `ALTER TABLE` para agregar `segmento`. |
| 17:23:57.965 | 133–134 | `CREATE ROLE rol_temporal` y `DROP ROLE rol_temporal`. |
| 17:25:31.520 | 135–136 | Segunda ejecución del bloque de creación y eliminación del rol temporal. |

## Preguntas de la guía

1. **¿Qué tipo de evento se registró?** `REVOKE` y `GRANT` son cambios de privilegios. `ALTER TABLE` es un cambio de estructura porque agregó una columna a `clientes`.
2. **¿Por qué se registran `GRANT` y `REVOKE` con `log_statement = 'ddl'`?** PostgreSQL incluye en ese nivel las sentencias que administran privilegios, además de las que definen o modifican objetos.
3. **¿Quién debería poder leer la bitácora si contiene contraseñas?** Solo el personal autorizado según sus funciones de administración, auditoría o seguridad. La prueba mostró que el texto de la contraseña quedó en el registro tras eliminar el rol. La consulta solo lo ocultó en su resultado. La evidencia compartida debe usar la salida redactada.
