# Actividad 13 — Altas y bajas

PgAdmin devolvió `INSERT 0 1` al crear al cliente de prueba Pedro Ruiz y `DELETE 1` al eliminarlo. En `auditoria.cambios_clientes` permaneció el `UPDATE` anterior como evento `1`. El evento `2` registró el alta del cliente `6` y el evento `3` registró su baja. Ambos quedaron a nombre de `postgres` desde pgAdmin y con IP `::1`.

## Preguntas de la guía

1. **¿Dónde queda la evidencia de que el cliente existió?** En `auditoria.cambios_clientes`. El `INSERT` guardó la fila en `valores_despues` y el `DELETE` la guardó en `valores_antes`. El otro campo quedó en `NULL` en cada caso porque no existía una fila en ese lado de la operación.
2. **¿Por qué la IP está vacía en el ejemplo de la guía?** Una conexión mediante socket Unix no tiene IP de cliente. En esta práctica pgAdmin se conectó por TCP local mediante IPv6, por eso los eventos muestran `::1`.
3. **¿Qué conflicto existe con la retención?** Borrar una fila de `clientes` deja una copia en la auditoría. El responsable de los datos, en coordinación con las áreas de privacidad y auditoría, debe fijar cuánto tiempo conservarla y cuándo eliminarla según su finalidad y las obligaciones aplicables.
