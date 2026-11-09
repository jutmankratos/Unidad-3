# LAB-01 — Bitácoras y auditoría del dato en PostgreSQL

Práctica de la Unidad 3 realizada por Diego Villarreal Lopez en PostgreSQL 18.6, instalado de forma nativa en Windows. Se usó la base `comercial`, pgAdmin 4 para las operaciones administrativas y `psql` desde PowerShell para las conexiones de prueba. Las sesiones se conectaron por la interfaz local (`127.0.0.1` o `::1`).

## Entrega

- [Informe](informe.md) y [PDF con capturas](Informe-LAB-01.pdf).
- [Evidencias de las actividades](evidencias/) y [cronología](evidencias/15-cronologia.md).
- [Bitácora exportada con la contraseña de prueba sustituida](evidencias/bitacora-lab01.log) y [SHA-256](evidencias/bitacora-lab01.sha256).

## Scripts

| Archivo | Contenido |
| --- | --- |
| [01-colector-y-vista.sql](sql/01-colector-y-vista.sql) | Consulta el archivo activo y crea la vista `dba.bitacora`. |
| [02-configuracion-bitacora.sql](sql/02-configuracion-bitacora.sql) | Configura las conexiones, las desconexiones, el prefijo y el nivel inicial `ddl`. |
| [03-privilegios-estructura.sql](sql/03-privilegios-estructura.sql) | Reproduce los cambios de permisos y estructura de la Actividad 6. |
| [04-esquema-auditoria.sql](sql/04-esquema-auditoria.sql) | Crea el esquema y la tabla de auditoría. |
| [05-funcion-disparador.sql](sql/05-funcion-disparador.sql) | Crea la función y el disparador de `clientes`. |
| [06-campos-modificados.sql](sql/06-campos-modificados.sql) | Compara los valores anteriores y posteriores de los campos modificados. |

La carpeta `sql/` también conserva los scripts auxiliares de preparación y de verificación. Ejecuta los bloques en una base de práctica siguiendo el orden de las actividades. Ejecuta cada `ALTER SYSTEM` por separado y fuera de una transacción. La Actividad 7 cambia el nivel inicial `ddl` a `mod`.

Para comprobar la integridad de la bitácora desde `LAB-01`, ejecuta `Get-FileHash evidencias/bitacora-lab01.log -Algorithm SHA256` y compara el resultado con el archivo `.sha256`.

[Guía del Laboratorio 1 de FIC Academy](https://academy.ficlabs.com.mx/materias/dba/unidad-03/laboratorios/laboratorio-1-bitacoras-y-auditoria-del-dato-postgresql/)
