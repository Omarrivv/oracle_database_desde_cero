ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- Crear usuarios con sus privilegios
CREATE USER OmarRiveraFelix IDENTIFIED BY Sistema123456;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE TRIGGER, CREATE SEQUENCE, CREATE SYNONYM, UNLIMITED TABLESPACE TO OmarRiveraFelix;

CREATE USER GracielaCaceres IDENTIFIED BY Sistema123456;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE TRIGGER, CREATE SEQUENCE, CREATE SYNONYM, UNLIMITED TABLESPACE TO GracielaCaceres;

-- Otorgar permisos entre usuarios
-- Desde OmarRiveraFelix a GracielaCaceres
GRANT ALL ON OmarRiveraFelix.usuario TO GracielaCaceres;

-- Desde GracielaCaceres a OmarRiveraFelix
GRANT ALL ON GracielaCaceres.categorias TO OmarRiveraFelix;
GRANT ALL ON GracielaCaceres.productos TO OmarRiveraFelix;
GRANT ALL ON GracielaCaceres.ventas TO OmarRiveraFelix;
GRANT ALL ON GracielaCaceres.detalle_venta TO OmarRiveraFelix;

