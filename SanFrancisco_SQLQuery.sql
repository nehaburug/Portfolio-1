
/* 
		San Francisco Salary from 2011 to 2014.
        Skills used : Aggregate functions, Group By, Having, Subquery, Arithmetic Operators, insert, update and delete.
*/

-- query all the rows and columns from the table
SELECT * 
FROM sf_salary.salaries;

-- query the unique job titles in the table
SELECT DISTINCT JobTitle 
FROM salaries;

-- Show the average of sum of BasePay, OvertimePay, and OtherPay for each employee
SELECT EmployeeName, (BasePay + OvertimePay + OtherPay)/3 AS avg_of_bp_otp_op 
FROM salaries;

-- Show all job titles with an average base pay of at least 100,000 and order them by the average base pay in descending order.
SELECT JobTitle, AVG(BasePay) AS "avgbp" 
FROM salaries
GROUP BY JobTitle
HAVING avgbp >=100000
ORDER BY avgbp DESC;

-- Query all employees with a job title not equal to "Manager"
SELECT EmployeeName, JobTitle 
FROM salaries
WHERE JobTitle <> 'Manager';

-- Listed the top ten JobTitles with the highest average salary
SELECT JobTitle, AVG(TotalPay) AS avg_tp
FROM salaries
GROUP BY JobTitle
ORDER BY avg_tp DESC
LIMIT 10;

-- Query the highest paid employee
SELECT EmployeeName, TotalPay
FROM salaries
ORDER BY TotalPay DESC
LIMIT 1;

-- Count the no of employees in each  department
SELECT  JobTitle, COUNT(EmployeeName) AS count_ename
FROM salaries
GROUP BY JobTitle
ORDER BY count_ename DESC;

-- Compare the TotalPay of all employees with average of TotalPay
SELECT EmployeeName, JobTitle, TotalPay, (SELECT AVG(TotalPay) FROM salaries) AS avg_pay
FROM salaries;

-- find employees who have JobTitle 'MANAGER VII' but different salaries.
SELECT DISTINCT TotalPay, EmployeeName, JobTitle
FROM salaries
WHERE JobTitle = 'MANAGER VII';

-- Find the distribution of salaries of specific JobTitles
SELECT JobTitle, MIN(TotalPay) AS min_tp, AVG(TotalPay) AS avg_tp, MAX(TotalPay) AS max_tp
FROM salaries
WHERE JobTitle IN ('Police Officer', 'Police Officer 2', 'Police Officer 3')
GROUP BY JobTitle;

-- Identify the JobTitles with the top 10 OverTimePay on average
SELECT JobTitle, AVG(OverTimePay) AS avg_otp
FROM salaries
GROUP BY JobTitle
ORDER BY avg_otp DESC
LIMIT 10;

-- Calculate the average overtime pay for each year
SELECT Year, AVG(OverTimePay) AS avg_otp 
FROM salaries
GROUP BY Year;

-- find no of hires for each department in each year
SELECT JobTitle, Year, COUNT(*) as no_of_hires 
FROM salaries
GROUP BY jobtitle, year
ORDER BY Year, no_of_hires DESC; 

-- Show all employees with totalPayBenifits value between 1,25,000 and 1,50,000 and a job title containing the word "Director"
SELECT EmployeeName, JobTitle, TotalPayBenefits 
FROM salaries
WHERE (TotalPayBenefits BETWEEN 125000 AND 150000) AND 
	   JobTitle LIKE '%Director%';

-- INSERT a new row
INSERT INTO salaries
	(Id, EmployeeName, JobTitle, BasePay, OverTimePay, OtherPay, Benefits, TotalPay, TotalPayBenefits, Year, Notes, Agency, Status)
VALUES
	(148655, 'Joey Bing', 'Custidian', 0, 0, 0, 0, 10000, 10, 2011, ' ', 'San Francisco', 'FT');

-- UPDATE the row
UPDATE salaries
SET JobTitle = 'Custodian', BasePay = 900
WHERE Id = '148655';

-- 	Update the base pay of all employees with the job title containing "Manager" by increasing it by 10%.
update salaries
set BasePay = BasePay * 1.1
where JobTitle Like "%Manager%";

-- DELETE the row
DELETE FROM salaries
WHERE Id = '148655';