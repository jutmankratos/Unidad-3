CREATE ROLE app_ventas LOGIN;
CREATE ROLE soporte_ana LOGIN;

GRANT SELECT, UPDATE ON clientes TO app_ventas;
GRANT SELECT ON clientes TO soporte_ana;
