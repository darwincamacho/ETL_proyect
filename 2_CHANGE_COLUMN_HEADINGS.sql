/*
2.-CHANGE COLUMN HEADINGS
*/

ALTER TABLE empleados_staging
CHANGE COLUMN empleado ID_employee VARCHAR(20) NULL;

ALTER TABLE empleados_staging
CHANGE COLUMN apellido last_name VARCHAR(100) NULL;

CALL limp();