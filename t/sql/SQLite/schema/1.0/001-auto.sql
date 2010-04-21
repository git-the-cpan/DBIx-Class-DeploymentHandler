-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Fri Mar 19 09:45:12 2010
-- 


BEGIN TRANSACTION;

--
-- Table: Foo
--
CREATE TABLE Foo (
  foo INTEGER PRIMARY KEY NOT NULL,
  bar VARCHAR(10) NOT NULL
);

--
-- Table: dbix_class_deploymenthandler_versions
--
CREATE TABLE dbix_class_deploymenthandler_versions (
  installed INTEGER PRIMARY KEY NOT NULL,
  version varchar(50) NOT NULL,
  ddl text,
  upgrade_sql text
);

CREATE UNIQUE INDEX dbix_class_deploymenthandler_versions_version ON dbix_class_deploymenthandler_versions (version);

COMMIT;
