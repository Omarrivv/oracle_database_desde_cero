/* -----------------------------------------------------------------
 TEMA      : Gesti�n de Esquemas de Base de Datos desde cero
 PROFESOR  : Jes�s Canales Guando
 CURSO     : Base de Datos 3 
*/ -----------------------------------------------------------------

-- <> Permitir ejecuci�n de script
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- <> INSTANCIA DE BASE DE DATOS
-- Se refiere al motor de la base de datos Oracle.
-- Gestiona todos los recursos de la base de datos.
-- Proporciona un entorno estable para el almacenamiento y la recuperaci�n de datos.
-- Es el responsable de la ejecuci�n SQL y de la gesti�n de transacciones.
-- ## Gesti�n de Instancia
-- Versi�n de base de datos instalada
SELECT * FROM V$VERSION;

-- Ver instancia de base de datos
SELECT * FROM V$INSTANCE;

-- Listar base de datos
SELECT * FROM V$DATABASE;

-- <> TABLESPACE
-- Es una entidad definida por el administrador de la base de datos.
-- Contenedor l�gico que define el almacenamiento f�sico de los datos.
-- Est� asociado a uno o m�s archivos f�sicos del servidor.
-- ## Gesti�n de Tablespace
-- Ver listado de TABLESPACES
SELECT * FROM DBA_TABLESPACES;

-- Listar los archivos asociados a cada tablespace
SELECT * FROM DBA_DATA_FILES;

-- Listar los datafiles y su respectiva ubicaci�n
SELECT tablespace_name, file_name
FROM dba_data_files;

-- Crear un Tablespace
CREATE TABLESPACE TBS_DATASOFT 
DATAFILE '/opt/oracle/oradata/xe/datasoft_01.dbf' 
SIZE 100M;

-- Modificar un Tablespace (agregar datafiles)
ALTER TABLESPACE TBS_DATASOFT
ADD DATAFILE '/opt/oracle/oradata/xe/datasoft_02.dbf'
SIZE 50M;

-- Listar Tablespaces con sus respectivos Datafiles
SELECT tablespace_name, file_name, user_bytes
FROM dba_data_files
WHERE file_name = '/opt/oracle/oradata/xe/datasoft_02.dbf';

-- ## Investigar:
-- Actualizar tama�o un Datafile de DATASOFT
-- Renombrar un Datafile de DATASOFT

-- Eliminar Tablespace
DROP TABLESPACE TBS_DATASOFT
INCLUDING CONTENTS;

-- Si bien se ha eliminado el Tablespace los Datafiles permanecen,
-- por tanto hay que eliminarlo manualmente.

-- <> CREAR TABLESPACE PARA DATASOFT
-- Crear un Tablespace
CREATE TABLESPACE TBS_DATASOFT 
DATAFILE '/opt/oracle/oradata/xe/datasoft_oficial_01.dbf' 
SIZE 100M;

-- <> USUARIO
-- Es la entidad que interact�a con la base de datos.
-- Al crear un usuario se le asigna un esquema por defecto.
-- Tienen asociado permisos que definen qu� operaciones pueden realizar en la base de datos.
-- Tiene control granular sobre qui�n puede acceder a qu� informaci�n y qu� acciones puede realizar.
-- ## Gesti�n de Usuarios
-- Crear un nuevo usuario
-- debe contener n�meros, letras y s�mbolo 
-- clave: LLmm123## (12 caracteres)
CREATE USER datasoft 
IDENTIFIED BY OraUser2024; 

-- Verificar a que tablespace esta asociado el usuario
SELECT username, default_tablespace
FROM dba_users;

-- Vamos a asociar el usuario de nuestro Tablespace DATASOFT
ALTER USER datasoft
DEFAULT TABLESPACE TBS_DATASOFT;

-- Listar los usuarios del Tablespace DATASOFT
SELECT username, default_tablespace
FROM dba_users
WHERE default_tablespace = 'TBS_DATASOFT';

-- Eliminar usuario test_##_user
DROP USER datasoft CASCADE;

-- <> CREAR USUARIO admin_##_datasoft en TABLESPACE DATASOFT
-- Crear usuario
CREATE USER datasoft
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- DATO IMPORTANTE: Un usuario reci�n creado no tiene asignado ning�n permiso

-- <> GESTION DE PERMISOS, ROLES Y PERFILES
-- PERMISOS: Son autorizaciones individuales de un usuario para realizar acciones espec�ficas.
-- Los tipos de permisos se pueden agrupar en: Permisos de objeto y Permisos de Sistema.
-- -- Ejemplo: asignar permiso sobre gesti�n de datos o creaci�n de objetos.
-- ROLES: Es el conjunto de permisos que se pueden asignar a un usuario. Esto simplifica la gesti�n de permisos.
-- -- Ejemplo: Crear un rol con permisos espec�ficos para usuarios con necesidades similares.
-- PERFIL: Establecen las restricciones a nivel de sistema, recursos y comportamiento.
-- -- Ejemplo: N�mero m�ximo de sesiones concurrentes, tiempo m�ximo de conexi�n y tama�o de transacciones.
-- RESUMEN: Los permisos son el nivel m�s granular, los roles agrupan permisos 
-- -------  y los perfiles establecen restricciones a nivel de sistema. 
-- -------  Esta jerarqu�a permite una gesti�n flexible y escalable de los permisos.
-- ##  EJERCICIOS
-- --- Asignar todos los permisos a DATASOFT
GRANT CREATE SESSION TO datasoft;
GRANT CREATE TABLE TO datasoft;
GRANT CREATE VIEW TO datasoft;
GRANT CREATE PROCEDURE TO datasoft;
GRANT CREATE TRIGGER TO datasoft;
GRANT CREATE SEQUENCE TO datasoft;
GRANT CREATE JOB TO datasoft;
GRANT UNLIMITED TABLESPACE TO datasoft;
GRANT CREATE PUBLIC SYNONYM TO datasoft;
GRANT SELECT ON ALL_SYNONYMS TO datasoft;

-- --- Verificar los permisos o privilegios asignados
SELECT * FROM dba_sys_privs 
WHERE grantee = 'DATASOFT';

-- -<> CREAR DOS USUARIOS DEVELOPER_01 Y DEVELOPER_02
-- --- Creamos usuario developer_01 dentro de TBS_DATASOFT
CREATE USER developer_01
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- --- Asignamos todos los permisos
GRANT CREATE SESSION TO developer_01;
GRANT CREATE TABLE TO developer_01;
GRANT CREATE VIEW TO developer_01;
GRANT CREATE PROCEDURE TO developer_01;
GRANT CREATE TRIGGER TO developer_01;
GRANT CREATE SEQUENCE TO developer_01;
GRANT CREATE JOB TO developer_01;
GRANT UNLIMITED TABLESPACE TO developer_01;
GRANT CREATE PUBLIC SYNONYM TO developer_01;
GRANT SELECT ON ALL_SYNONYMS TO developer_01;

-- --- Creamos usuario developer_02 dentro de TBS_DATASOFT
CREATE USER developer_02
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- --- Asignamos todos los permisos
GRANT CREATE SESSION TO developer_02;
GRANT CREATE TABLE TO developer_02;
GRANT CREATE VIEW TO developer_02;
GRANT CREATE PROCEDURE TO developer_02;
GRANT CREATE TRIGGER TO developer_02;
GRANT CREATE SEQUENCE TO developer_02;
GRANT CREATE JOB TO developer_02;
GRANT UNLIMITED TABLESPACE TO developer_02;
GRANT CREATE PUBLIC SYNONYM TO developer_02;
GRANT SELECT ON ALL_SYNONYMS TO developer_02;

-- <> ESQUEMAS DE BASE DE DATOS
-- Contenedor l�gico que agrupa un conjunto de objetos relacionados.
-- Permite una mejor administraci�n y mantenimiento.
-- Un esquema est� relacionado a un usuario, pero muchos usuarios pueden estar relacionados a un solo esquema

-- <> ELIMINANDO USUARIOSY TABLESPACE
DROP USER datasoft CASCADE;
DROP USER developer_01 CASCADE;
DROP USER developer_02 CASCADE;
DROP TABLESPACE TBS_DATASOFT INCLUDING CONTENTS;
