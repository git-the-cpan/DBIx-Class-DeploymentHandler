-- Convert schema 't/sql/_source/deploy/1.0/001-auto.yml' to 't/sql/_source/deploy/2.0/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE Foo ADD COLUMN baz VARCHAR(10);

;

COMMIT;

