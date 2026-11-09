# Actividad 3 — Incidente sin bitácora

En `comercial`, el RFC ficticio del cliente 3, María García, pasó de `GAMA780912GHI` a `GAMA780912XXX`. La sesión de prueba con `app_ventas` devolvió `UPDATE 1`. La consulta posterior confirmó el valor nuevo y la búsqueda de esa sentencia en `dba.bitacora` devolvió **0 coincidencias**.

1. La ejecución controlada identifica el rol de prueba, pero el archivo activo no ofrece una entrada que permita atribuirle el cambio a partir de la bitácora sola.
2. La ausencia de entradas no permite descartar a `soporte_ana` por sí sola. El permiso de solo lectura indica que ese rol no podía ejecutar directamente el cambio con los permisos concedidos; eso es evidencia de autorización, no un historial de acciones.
3. El control de acceso permitió el cambio porque `app_ventas` tenía permiso de actualizar. Si actualizar el RFC forma parte de su función, no debía impedirlo; si no, se deberían limitar los permisos por columna.
4. Antes del incidente se necesitaba registrar las sentencias de modificación y el contexto de la sesión. Para conservar también el valor anterior y el nuevo, se necesitaba auditoría de cambios en los datos.
