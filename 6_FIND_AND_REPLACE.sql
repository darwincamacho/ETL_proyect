/*
6.- FIND AND REPLACE

- assay
- update table
- change properties
*/

-- gender:

ALTER TABLE clean
CHANGE COLUMN genero_raw gender VARCHAR(20);

CALL limp();

SELECT 
	gender,
    CASE
		WHEN LOWER(TRIM(gender)) = 'hombre' THEN 'male'
        WHEN LOWER(TRIM(gender)) = 'mujer' THEN 'female'
		ELSE gender
	END AS gender_normalized
FROM clean;

UPDATE clean
SET gender = CASE
	WHEN LOWER(TRIM(gender)) = 'hombre' THEN 'male'
    WHEN LOWER(TRIM(gender)) = 'mujer' THEN 'female'
    ELSE gender
END;

CALL limp();

-- type_flag

ALTER TABLE clean
CHANGE COLUMN type_flag type_workmode VARCHAR (50);

SELECT
	type_workmode,
    case
		WHEN type_workmode = 0 THEN 'hybrid'
        WHEN type_workmode = 1 THEN 'remote'
        ELSE type_workmode
	END AS typework_normalized
FROM clean;

DESCRIBE clean;

ALTER TABLE clean 
MODIFY COLUMN type_workmode TEXT;

UPDATE clean
SET type_workmode = CASE
	WHEN type_workmode = 0 THEN 'hybrid'
    WHEN type_workmode = 1 THEN 'remote'
    ELSE type_workmode
END;

CALL limp();
