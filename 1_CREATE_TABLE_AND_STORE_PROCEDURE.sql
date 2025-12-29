-- ====================================================================
--                   DATA CLEANING IN MySQL (ETL)
-- ====================================================================

/*
1.- CREATE TABLE AND STORE PROCEDURE 
*/

CREATE DATABASE IF NOT EXISTS clean;

USE clean;

SELECT * 
FROM empleados_staging
LIMIT 10;

-- store procesure

DROP PROCEDURE IF EXISTS limp1;

DELIMITER //

CREATE PROCEDURE limp1()
BEGIN 
	SELECT * 
FROM with_duplicate
LIMIT 10;
END //

DELIMITER ;

CALL limp1();












