-- Convert schema 't/sql/SQLite/schema/3/001-auto.sql' to 't/sql/SQLite/schema/2/001-auto.sql':;

BEGIN;

CREATE TEMPORARY TABLE Foo_temp_alter (
  foo INTEGER PRIMARY KEY NOT NULL,
  bar VARCHAR(10) NOT NULL,
  baz VARCHAR(10)
);

INSERT INTO Foo_temp_alter SELECT foo, bar, baz FROM Foo;

DROP TABLE Foo;

CREATE TABLE Foo (
  foo INTEGER PRIMARY KEY NOT NULL,
  bar VARCHAR(10) NOT NULL,
  baz VARCHAR(10)
);

INSERT INTO Foo SELECT foo, bar, baz FROM Foo_temp_alter;

DROP TABLE Foo_temp_alter;


COMMIT;

