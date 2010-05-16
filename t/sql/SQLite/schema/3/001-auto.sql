-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sat May 15 22:47:01 2010
-- 


BEGIN TRANSACTION;

--
-- Table: Foo
--
DROP TABLE Foo;

CREATE TABLE Foo (
  foo INTEGER PRIMARY KEY NOT NULL,
  bar VARCHAR(10) NOT NULL,
  baz VARCHAR(10),
  biff VARCHAR(10)
);

--
-- Table: dbix_class_deploymenthandler_versions
--
DROP TABLE dbix_class_deploymenthandler_versions;

CREATE TABLE dbix_class_deploymenthandler_versions (
  id INTEGER PRIMARY KEY NOT NULL,
  version varchar(50) NOT NULL,
  ddl text,
  upgrade_sql text
);

CREATE UNIQUE INDEX dbix_class_deploymenthandler_versions_version ON dbix_class_deploymenthandler_versions (version);

COMMIT;
