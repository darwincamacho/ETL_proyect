/*
9.- TEXT FUNCTION

create the email column
(name, _, 2 letters of last, ., type, @consulting.com
*/

SELECT
	CONCAT(
		LOWER(SUBSTRING_INDEX(name, ' ', 1)),
        '_',
        LOWER(SUBSTRING(last_name, 1, 2)),
        '.',
        UPPER(SUBSTRING(type_workmode,1,1)),
        '@consulting.com')
FROM clean;

-- add new lolumn with emails

ALTER TABLE clean
ADD COLUMN email VARCHAR (50);

UPDATE clean
SET email = CONCAT(
				LOWER(SUBSTRING_INDEX(name, ' ', 1)),
				'_',
				LOWER(SUBSTRING(last_name, 1, 2)),
				'.',
				UPPER(SUBSTRING(type_workmode,1,1)),
				'@consulting.com');
                
CALL limp();
