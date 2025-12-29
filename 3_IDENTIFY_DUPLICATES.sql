/*
3.-IDENTIFY DUPLICATES
*/

SELECT 
	Id_employee,
    COUNT(*) AS number_duplicates
FROM empleados_staging
GROUP BY ID_employee
HAVING COUNT(*) > 1;

-- count number of duplicates

SELECT 
	COUNT(*)
FROM (
	SELECT 
		Id_employee,
		COUNT(*) AS number_duplicates
	FROM empleados_staging
	GROUP BY ID_employee
	HAVING COUNT(*) > 1
    ) AS sub_query;
    
/*
3.1.- REMOVE DUPLICATES

- Rename the table,
- Create a temporary table (unique values)
- Convert the temporary table to a permanent table
*/

RENAME TABLE empleados_staging TO with_duplicate; 

CREATE TEMPORARY TABLE temp_clean AS 
SELECT DISTINCT *
FROM with_duplicate;

SELECT COUNT(*) AS original
FROM with_duplicate; -- 22222

SELECT COUNT(*) AS unique_data
FROM temp_clean; -- 22213

-- create a new table with out repeted data

CREATE TABLE clean AS 
SELECT *
FROM temp_clean;

DROP TABLE with_duplicate;

DROP PROCEDURE IF EXISTS limp;

DELIMITER //

CREATE PROCEDURE limp()
BEGIN 
	SELECT * 
FROM clean;
END //

DELIMITER ;

CALL limp();

-- disable dql security

SET sql_safe_updates = 0;

CALL limp;