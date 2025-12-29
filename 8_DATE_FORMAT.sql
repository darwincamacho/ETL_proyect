/*
8.- DATE FORMAT

(Date format in SQL is year month day)
*/

-- birth_date_raw

SELECT birth_date_raw
FROM clean;

ALTER TABLE clean
CHANGE COLUMN birth_day birth_date VARCHAR(20);

SELECT birth_date
FROM clean;

SELECT 
	birth_date,
	CASE
    WHEN birth_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
        THEN STR_TO_DATE(birth_date, '%m/%d/%Y')

    WHEN birth_date REGEXP '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$'
        THEN STR_TO_DATE(birth_date, '%m-%d-%Y')

    ELSE birth_date
	END AS new_birth_say
FROM clean;


UPDATE clean 
SET birth_date = CASE

	WHEN birth_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' 
    THEN STR_TO_DATE(birth_date, '%m/%d/%Y')
    
	WHEN birth_date REGEXP '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$' 
    THEN STR_TO_DATE(birth_date, '%m-%d-%Y')
    
	ELSE birth_date
END;

CALL limp();

ALTER TABLE clean
MODIFY COLUMN birth_date DATE;

DESCRIBE clean;

-- start_date_raw

SELECT
	start_date_raw
FROM clean;

ALTER TABLE clean
CHANGE COLUMN start_date_raw start_date VARCHAR (20);

SELECT
	start_date,
    CASE
		WHEN start_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
        THEN STR_TO_DATE(start_date, '%m/%d/%Y')
        
        WHEN start_date REGEXP '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$'
        THEN STR_TO_DATE(start_date, '%m-%d-%Y')
        
        ELSE start_date
        
	END AS new_start_date
        
FROM clean;

UPDATE clean
SET start_date = CASE

	WHEN start_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
	THEN STR_TO_DATE (start_date, '%m/%d/%Y')
    
    WHEN start_date REGEXP '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$'
    THEN STR_TO_DATE (start_date, '%m-%d-%Y')
    
    ELSE start_date
    
END;
    
CALL limp();

ALTER TABLE clean
MODIFY COLUMN start_date DATE;

-- finish_date_raw

ALTER TABLE clean
CHANGE COLUMN finish_date_raw finish_date VARCHAR(50);

CALL limp();

-- create backup column

ALTER TABLE clean
ADD COLUMN date_backup TEXT;

UPDATE clean
SET date_backup = finish_date;

CALL limp();

SELECT 
	finish_date
FROM clean;

SELECT
	finish_date,
    STR_TO_DATE(finish_date, '%Y-%m-%d %H:%i:%s'
        ) AS new_finish_date
FROM clean;
    
UPDATE clean
SET finish_date = STR_TO_DATE(
	finish_date, '%Y-%m-%d %H:%i:%s UTC'
    )
WHERE finish_date <> '';

-- split year and time

ALTER TABLE clean
ADD COLUMN just_date DATE,
ADD COLUMN just_time TIME;

UPDATE clean
SET
	just_date = DATE(finish_date),
    just_time = TIME(finish_date)
WHERE finish_date IS NOT NULL AND finish_date <> '';
    
-- set emty data to null

UPDATE clean
SET finish_date = NULL
WHERE finish_date = '';

CALL limp();

-- count nulls

SELECT 
	COUNT(*) AS COUNT_NULLS
FROM clean
WHERE finish_date IS NULL;

-- modify property of finish_date

ALTER TABLE clean
MODIFY COLUMN finish_date DATETIME;

DESCRIBE clean;

-- calculations with dates (calculate the age of the employee)alter

ALTER TABLE clean
ADD COLUMN age_employee INT;

CALL limp();

SELECT 
	birth_date
FROM clean;

SELECT 
	birth_date,
    CURDATE() AS today,
    TIMESTAMPDIFF(YEAR, birth_date , CURDATE()) AS age_employye
FROM clean;

UPDATE clean
SET age_employee = TIMESTAMPDIFF(YEAR, birth_date, CURDATE())
WHERE age_employee IS NULL
AND birth_date IS NOT NULL;

-- employee entry age

SELECT
	CONCAT(name, ' ', last_name) AS employee_name,
    start_date,
    birth_date,
    TIMESTAMPDIFF(YEAR, birth_date, start_date) AS employee_entry_age
FROM clean;

CALL limp();
