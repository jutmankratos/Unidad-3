# Actividad 16 — Exportación y conservación de la bitácora

Se exportó la bitácora vigente desde `comercial` a `evidencias/bitacora-lab01.log`. Para leerla en Windows se utilizó `pg_read_binary_file()` con conversión `WIN1252`. La contraseña de prueba se sustituyó por `<REDACTED>` antes de escribir el archivo. La revisión encontró cuatro reemplazos y ninguna aparición de la contraseña original. El SHA-256 recalculado coincide con el de PowerShell y quedó guardado en `bitacora-lab01.sha256`.

## Preguntas de la guía

1. **¿Qué permite demostrar el SHA-256?** Permite comprobar si el archivo conserva los mismos bytes que tenía al calcular un hash de referencia confiable. Si el archivo se modifica, el hash calculado cambia.
2. **¿Dónde se guarda el hash de referencia?** En un repositorio o sistema de evidencias separado, con acceso restringido y control de cambios. Así, quien pueda modificar la bitácora no puede reemplazar también su referencia.
3. **¿Qué riesgo tiene conservar la bitácora solo en el servidor?** Una rotación, un fallo de disco, una reinstalación o una alteración en el servidor puede eliminar la única copia. Una copia separada permite conservar evidencia aunque falle el origen.
4. **¿Cuánto tiempo conservarla?** Para este laboratorio propongo 90 días desde la exportación, suficiente para la revisión y las aclaraciones del curso. Si hay una investigación abierta, se conserva hasta resolverla. Se limita el acceso durante ese plazo.
