CREATE DATABASE metastore;
USE metastore;
SOURCE /opt/hive/hive/scripts/metastore/upgrade/mysql/hive-schema-0.14.0.mysql.sql;
CREATE USER 'hive'@'%' IDENTIFIED BY 'hivepassword';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hive'@'%';
GRANT SELECT,INSERT,UPDATE,DELETE,LOCK TABLES,EXECUTE ON metastore.* TO 'hive'@'%';
FLUSH PRIVILEGES;
