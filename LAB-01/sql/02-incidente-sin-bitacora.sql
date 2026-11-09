SELECT id, nombre, rfc
FROM clientes
WHERE id = 3;

SELECT count(*) AS registros_del_update
FROM dba.bitacora
WHERE linea ILIKE '%UPDATE clientes SET rfc%'
  AND linea LIKE '%GAMA780912XXX%';
