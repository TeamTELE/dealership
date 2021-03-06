CREATE TABLE "ADDRESS" (
  "ID" NUMBER(10) PRIMARY KEY,
  "STREET" VARCHAR2(30 CHAR) UNIQUE NOT NULL,
  "NUMBER" NUMBER(5) NOT NULL,
  "CITY" VARCHAR2(20 CHAR) NOT NULL,
  "POSTAL" VARCHAR2(8 CHAR) NOT NULL
);

CREATE SEQUENCE "ADDRESS_SEQ" NOCACHE;

CREATE TRIGGER "ADDRESS_BI"
  BEFORE INSERT ON "ADDRESS"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "ADDRESS_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "BRAND" (
  "ID" NUMBER(10) PRIMARY KEY
);

CREATE SEQUENCE "BRAND_SEQ" NOCACHE;

CREATE TRIGGER "BRAND_BI"
  BEFORE INSERT ON "BRAND"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "BRAND_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "DEALERSHIP" (
  "ID" NUMBER(10) PRIMARY KEY,
  "NAME" VARCHAR2(30 CHAR) UNIQUE NOT NULL,
  "ADDRESS" NUMBER(10) NOT NULL
);

CREATE INDEX "IDX_DEALERSHIP__ADDRESS" ON "DEALERSHIP" ("ADDRESS");

ALTER TABLE "DEALERSHIP" ADD CONSTRAINT "FK_DEALERSHIP__ADDRESS" FOREIGN KEY ("ADDRESS") REFERENCES "ADDRESS" ("ID");

CREATE SEQUENCE "DEALERSHIP_SEQ" NOCACHE;

CREATE TRIGGER "DEALERSHIP_BI"
  BEFORE INSERT ON "DEALERSHIP"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "DEALERSHIP_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "EMPLOYEE" (
  "ID" NUMBER(10) PRIMARY KEY,
  "DEALERSHIP" NUMBER(10) NOT NULL,
  "FIRST_NAME" VARCHAR2(20 CHAR) NOT NULL,
  "LAST_NAME" VARCHAR2(20 CHAR) NOT NULL,
  "classtype" VARCHAR2(1000 CHAR) NOT NULL,
  "MANAGER" NUMBER(10)
);

CREATE INDEX "IDX_EMPLOYEE__DEALERSHIP" ON "EMPLOYEE" ("DEALERSHIP");

CREATE INDEX "IDX_EMPLOYEE__MANAGER" ON "EMPLOYEE" ("MANAGER");

ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "FK_EMPLOYEE__DEALERSHIP" FOREIGN KEY ("DEALERSHIP") REFERENCES "DEALERSHIP" ("ID");

ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "FK_EMPLOYEE__MANAGER" FOREIGN KEY ("MANAGER") REFERENCES "EMPLOYEE" ("ID");

CREATE SEQUENCE "EMPLOYEE_SEQ" NOCACHE;

CREATE TRIGGER "EMPLOYEE_BI"
  BEFORE INSERT ON "EMPLOYEE"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "EMPLOYEE_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "FACTORY" (
  "ID" NUMBER(10) PRIMARY KEY,
  "NAME" VARCHAR2(30 CHAR) UNIQUE NOT NULL,
  "ADDRESS" NUMBER(10) NOT NULL
);

CREATE INDEX "IDX_FACTORY__ADDRESS" ON "FACTORY" ("ADDRESS");

ALTER TABLE "FACTORY" ADD CONSTRAINT "FK_FACTORY__ADDRESS" FOREIGN KEY ("ADDRESS") REFERENCES "ADDRESS" ("ID");

CREATE SEQUENCE "FACTORY_SEQ" NOCACHE;

CREATE TRIGGER "FACTORY_BI"
  BEFORE INSERT ON "FACTORY"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "FACTORY_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "DEALERSHIP_FACTORY" (
  "DEALERSHIP" NUMBER(10) NOT NULL,
  "FACTORY" NUMBER(10) NOT NULL,
  PRIMARY KEY ("DEALERSHIP", "FACTORY")
);

CREATE INDEX "IDX_DEALERSHIP_FACTORY" ON "DEALERSHIP_FACTORY" ("FACTORY");

ALTER TABLE "DEALERSHIP_FACTORY" ADD CONSTRAINT "FK_DEALERSHIP_FACTORY__DEALERS" FOREIGN KEY ("DEALERSHIP") REFERENCES "DEALERSHIP" ("ID");

ALTER TABLE "DEALERSHIP_FACTORY" ADD CONSTRAINT "FK_DEALERSHIP_FACTORY__FACTORY" FOREIGN KEY ("FACTORY") REFERENCES "FACTORY" ("ID");

CREATE TABLE "MODEL" (
  "ID" NUMBER(10) PRIMARY KEY,
  "BRAND" NUMBER(10) NOT NULL,
  "NAME" VARCHAR2(20 CHAR) UNIQUE NOT NULL,
  "GENERATION" NUMBER(3) NOT NULL
);

CREATE INDEX "IDX_MODEL__BRAND" ON "MODEL" ("BRAND");

ALTER TABLE "MODEL" ADD CONSTRAINT "FK_MODEL__BRAND" FOREIGN KEY ("BRAND") REFERENCES "BRAND" ("ID");

CREATE SEQUENCE "MODEL_SEQ" NOCACHE;

CREATE TRIGGER "MODEL_BI"
  BEFORE INSERT ON "MODEL"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "MODEL_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "CAR" (
  "ID" NUMBER(10) PRIMARY KEY,
  "DEALERSHIP" NUMBER(10) NOT NULL,
  "MODEL" NUMBER(10) NOT NULL,
  "IS_NEW" BOOLEAN NOT NULL,
  "SALESMAN" NUMBER(10),
  "IS_DELIVERED" BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX "IDX_CAR__DEALERSHIP" ON "CAR" ("DEALERSHIP");

CREATE INDEX "IDX_CAR__MODEL" ON "CAR" ("MODEL");

CREATE INDEX "IDX_CAR__SALESMAN" ON "CAR" ("SALESMAN");

ALTER TABLE "CAR" ADD CONSTRAINT "FK_CAR__DEALERSHIP" FOREIGN KEY ("DEALERSHIP") REFERENCES "DEALERSHIP" ("ID");

ALTER TABLE "CAR" ADD CONSTRAINT "FK_CAR__MODEL" FOREIGN KEY ("MODEL") REFERENCES "MODEL" ("ID");

ALTER TABLE "CAR" ADD CONSTRAINT "FK_CAR__SALESMAN" FOREIGN KEY ("SALESMAN") REFERENCES "EMPLOYEE" ("ID");

CREATE SEQUENCE "CAR_SEQ" NOCACHE;

CREATE TRIGGER "CAR_BI"
  BEFORE INSERT ON "CAR"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "CAR_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;
