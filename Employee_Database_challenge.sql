--Deliverable 1



--Step 1: Retrieve the emp_no, first_name, and last_name columns from the Employees table.
--SELECT emp_no, first_name, last_name
--FROM Employees

--Step 2: Retrieve the title, from_date, and to_date columns from the Titles table.
--SELECT title, from_date, to_date
--FROM Titles

--Step 3: Create a new table using the INTO clause.
--INTO retirement_titles

-- Step 4: Join both tables on the primary key.
--JOIN Titles as t
--ON e.emp_no = t.emp_no

--Step 5: Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
--WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
--ORDER BY e.emp_no

--Completed Query
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN Titles AS t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no

--Step 6: Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

--Step 7: Check if query looks correct

-- Step 8:
-- Use Dictinct with Orderby to remove duplicate rows
--SELECT DISTINCT ON (______) _____,
--______,
--______,
--______

--INTO nameyourtable
--FROM _______
--WHERE _______
--ORDER BY _____, _____ DESC;

--step 9: Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
--SELECT emp_no, first_name, last_name, title
--FROM retirement_titles

--Step 10: Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
--SELECT DISTINCT ON (emp_no) emp_no,first_name,last_name,title
--FROM retirement_titles

--Step 11: Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
--WHERE to_date = '9999-01-01'

--Step 12: Create a Unique Titles table using the INTO clause.
--INTO unique_titles

--Step 13: Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.
--ORDER BY emp_no, to_date DESC

--Completed Query
SELECT DISTINCT ON (emp_no) emp_no,first_name,last_name
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC

--Step 14: Export the Unique Titles table as unique_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

--Step 15: Check if query looks correct

--Step 16: Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.

--Step 17: First, retrieve the number of titles from the Unique Titles table.
--SELECT COUNT(title) 
--FROM unique_titles

--Step 18: Then, create a Retiring Titles table to hold the required information
--INTO retiring_titles

--Step 19: Group the table by title, then sort the count column in descending order.
--GROUP BY title

--Completed Query
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC

--Step 20: Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

--Step 21: Check if query looks correct





--Deliverable 2



--Step 1: Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
--SELECT emp_no, first_name, last_name, birth_date
--FROM employees

--Step 2: Retrieve the from_date and to_date columns from the Department Employee table.
--SELECT from_date, to_date 
--FROM dept_emp

--Step 3: Retrieve the title column from the Titles table.
--SELECT title
--FROM titles

--Step 4: Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
--SELECT DISTINCT ON(e.emp_no) e.emp_no,
--      e.first_name,
--      e.last_name, 
--      de.birth_date,
--      t.titles
--FROM employee AS e

--Step 5: Create a new table using the INTO clause.
--INTO mentorship_eligibility

--Step 6: Join the Employees and the Department Employee tables on the primary key.
--JOIN dept_emp AS de
--ON e.emp_no = de.emp_no

--Step 7: Join the Employees and the Titles tables on the primary key.
--JOIN titles AS t
--ON de.dept_no = t.dept_no