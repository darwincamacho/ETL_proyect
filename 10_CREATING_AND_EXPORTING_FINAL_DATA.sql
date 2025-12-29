/*
10.- CREATING AND EXPORTING THE FINAL DATA
*/

-- select relevant data

SELECT 
	ID_employee,
    name,
    last_name,
    age_employee,
    gender,
    area,
    salary,
    email,
    finish_date
FROM clean
WHERE finish_date <= CURDATE() OR finish_date IS NULL
ORDER BY area, last_name;

-- number of employees

SELECT
	area,
    COUNT(*) AS total_employee
FROM clean
GROUP BY area
ORDER BY total_employee DESC;
