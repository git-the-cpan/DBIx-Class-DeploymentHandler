-- Convert schema 't/sql/_source/deploy/2/001-auto.yml' to 't/sql/_source/deploy/3/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE Foo ADD COLUMN biff VARCHAR(10);

;

COMMIT;

