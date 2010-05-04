-- Convert schema 't/sql/SQLite/schema/2/001-auto.sql' to 't/sql/SQLite/schema/3/001-auto.sql':;

BEGIN;

ALTER TABLE Foo ADD COLUMN biff VARCHAR(10);


COMMIT;

