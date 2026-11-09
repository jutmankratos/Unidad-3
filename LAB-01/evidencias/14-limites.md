# Actividad 15 — Límites de la auditoría

Desde PowerShell, `soporte_ana` consultó el nombre, el RFC y el teléfono del cliente `3`. `psql` devolvió una fila. En pgAdmin, `postgres` ejecutó `UPDATE clientes SET segmento = 'regular'` y obtuvo `UPDATE 5`.

La bitácora registró una línea para el `UPDATE` masivo. La auditoría por fila mostró seis eventos `UPDATE`, que incluyen el cambio anterior de RFC y los cinco nuevos cambios de segmento, además de un `INSERT` y un `DELETE`. La consulta de lecturas de `soporte_ana` encontró cero coincidencias. Con `log_statement = 'mod'`, el `SELECT` de esta prueba queda fuera del registro de sentencias, y el disparador solo captura cambios de filas.

## Preguntas de la guía

1. **¿Qué ocurriría con un millón de filas?** Si el `UPDATE` modifica un millón de filas y se confirma la transacción, el disparador insertaría un millón de eventos de auditoría. Cada evento conservaría los valores anteriores y posteriores. La bitácora de sentencias registraría el `UPDATE` como una sola sentencia.
2. **¿Quién puede autorizar una depuración?** El responsable de los datos puede autorizarla conforme a la política de retención, con revisión del equipo que custodia la evidencia y de las áreas de seguridad y privacidad. El DBA ejecutaría la operación autorizada.
3. **¿Por qué `all` puede acumular información sensible?** Registra el texto de las consultas, que puede incluir RFC, teléfonos u otros valores literales. Esto aumenta el volumen y amplía el conjunto de archivos cuyo acceso debe controlarse.
