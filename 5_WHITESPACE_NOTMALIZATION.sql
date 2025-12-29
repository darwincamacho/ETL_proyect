/*
5.- WHITESPACE NOTMALIZATION
*/

-- identify and update table (name)

SELECT name
FROM clean
WHERE LENGTH(name) - LENGTH(TRIM(name)) > 0; -- audit

-- update table

SELECT
	name,
    TRIM(name) AS clean_name
FROM clean
WHERE LENGTH(name) - LENGTH(TRIM(name)) > 0;

UPDATE clean
SET name = TRIM(name)
WHERE LENGTH(name) - LENGTH(TRIM(name)) > 0;

CALL limp();

-- identify and update table (last_name)

SELECT last_name
FROM clean
WHERE LENGTH(last_name) - LENGTH(TRIM(last_name)) > 0;

SELECT 
	last_name,
    TRIM(last_name)
FROM clean
WHERE LENGTH(last_name) - LENGTH(TRIM(last_name)) > 0;

-- update table

UPDATE clean
SET last_name = TRIM(last_name)
WHERE LENGTH(last_name) - LENGTH(TRIM(last_name)) > 0;

CALL limp();

-- Remove spaces between two words

UPDATE clean
SET area = REPLACE(area, ' ', '     ');

SELECT area
FROM clean
WHERE area REGEXP '\\s{2,}';

-- audit

SELECT
	area,
	TRIM(REGEXP_REPLACE(area, '\\s{2,}', ' ')) as assay
FROM clean;

-- update table with out spaces

UPDATE clean
SET area = REGEXP_REPLACE(area, '\\s{2,}', ' ');

CALL limp();
