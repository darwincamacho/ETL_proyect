/*
7.- FORMAT TEXT INTO NUMBERS
*/

ALTER TABLE clean
CHANGE COLUMN salary_raw salary VARCHAR(50);

CALL limp();

SELECT
	salary,
    CAST(
		TRIM(
			REPLACE(
			REPLACE(salary, '$', ''),
			',',''
			)
		) AS DECIMAL (15,2)
	)
FROM clean;

UPDATE clean
SET salary = CAST(
	TRIM(
		REPLACE(
			REPLACE(salary,'$',''),
            ',',''
            )
		) AS DECIMAL (15,2)
	);
    
CALL limp();

ALTER TABLE clean 
MODIFY COLUMN salary DECIMAL NULL;
