-- Convert schema 't/sql/SQLite/schema/1/001-auto.sql' to 't/sql/SQLite/schema/2/001-auto.sql':;

BEGIN;

ALTER TABLE Foo ADD COLUMN baz VARCHAR(10);


COMMIT;

