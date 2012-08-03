-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sat Jul 21 02:32:29 2012
-- 

;
BEGIN TRANSACTION;
--
-- Table: Foo
--
CREATE TABLE Foo (
  foo INTEGER PRIMARY KEY NOT NULL,
  bar VARCHAR(10) NOT NULL,
  baz VARCHAR(10)
);
COMMIT