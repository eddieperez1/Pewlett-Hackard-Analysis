# Pewlett-Hackard-Analysis

This project uses Postgresql v11.14 for sql and pgadmin 4 v5.7 for database creation and query execution. schema.sql was run to fill the database PH-EmployeeDB in pgAdmin 4 for this project. The data was then imported into the database following the ERD below. queries.sql was run to join and filter data for this project.

![ERD](/EmployeeDB.png )

## Overview of the analysis: 

The purpose of this project is to help a fake company Pewlett-Hackard with employee information to investagate possible retiring employees. The data will be imported into a local database using pgadmin 4 and then queries will be performed to organize and analyze the data. With the results queries, the number of retiring employees per title will be determined, and employees who are eligible to participate in a mentorship program will be identified. Then, the results will be summarized.

## Results: 

## Deliverable 1: The Number of Retiring Employees by Title

The purpose of deliverable 1 is to find the number of retiring employees by title whose birth date is between January 01, 1952 and December 31, 1955. In order to find how many retiring employees, query 1 results were stored in [retirement_titles.csv](/data/retirement_titles.csv). After the number of retiring employees was found, the data has duplicate employee information with different titles. Using Postgres Distinct On in Query 2, the most recent title was found for each retiring employee. Query 2 results were stored in [unique_titles.csv](/data/unique_titles.csv). Now that each employee has the most recent title, the number of retiring employees by title was found using COUNT. The final result was found using query 3 which was stored in [retiring_titles.csv](/data/retiring_titles.csv).

### Query 1
```
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN Titles AS t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no
```
![screenshot of query 1](/screenshots/screenshot_of_retirement_titles_table.PNG)

### Query 2
```
SELECT DISTINCT ON (emp_no) emp_no,first_name,last_name
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC
```
![screenshot of query 2](/screenshots/screenshot_of_unique_titles.PNG)

### Query 3
```
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC
```
![screenshot of query 2](/screenshots/screenshot_of_retiring_titles.PNG)

## Deliverable 2: The Employees Eligible for the Mentorship Program

The purpose of deliverable 2 is to find the employees with a birth date between January 01, 1965 and December 31, 1965 that are eligible to mentor new employees. Query 4 was run and the results were stored in [mentorship_eligibilty.csv](/data/mentorship_eligibilty.csv). To find the number of possible mentors by title to aid analysis, query 5 was run.

### Query 4
```
SELECT DISTINCT ON(e.emp_no) e.emp_no,
    	e.first_name,
    	e.last_name, 
    	e.birth_date,
	ti.from_date,
	ti.to_date,
    	ti.title
INTO mentorship_eligibility
FROM employees AS e
JOIN dept_emp AS de
ON  e.emp_no = de.emp_no
JOIN titles AS ti
ON de.emp_no = ti.emp_no
WHERE (ti.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no
```
![mentorship eligilibity](/screenshots/screenshot_of_mentorship_eligibility.PNG)

### Query 5
```
SELECT COUNT(emp_no), title FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT(emp_no) DESC
```
![count of mentorship eligibility by title](/screenshots/screenshot_of_mentorship_count.PNG )

### Major Points from Analysis
- There are 72,458 employees in the retiring range of birth date between January 01, 1952 and December 31, 1955.
- There are 1,549 employees eligible to mentor with birth date between January 01, 1965 and December 31, 1965.
- Senior Engineer and Senior Staff have the largest number of employees in the retiring range of birth date between January 01, 1952 and December 31, 1955.
- 101% of employees are in the retiring range of birth date between January 01, 1952 and December 31, 1955.

## Summary: 

72,458 roles will need to be filled as the employees whose birth date is between January 01, 1952 and December 31, 1955 begin to retire. There are not enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees since the number of employees in retiring range is 46 times larger than number of employee eligible to mentor.

To further the analysis, query 6 and query 7 find the number of retiring employees by department and the number of employees eligible to mentor by department respectively. These insights give which departments are in need hiring after employees whose birth date is between January 01, 1952 and December 31, 1955 retire and which departments have employees eligible to mentor.

### Query 6
```
SELECT d.dept_name, COUNT(d.dept_no)
FROM retirement_info as ri
JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no
GROUP BY dept_name
ORDER BY COUNT(d.dept_no) DESC
```
![retiring employees by department](/screenshots/screenshot_of_retirement_info_count_by_department.PNG)

### Query 7
```
SELECT d.dept_name, COUNT(d.dept_no)
FROM mentorship_eligibility as me
JOIN dept_emp AS de
ON me.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no
GROUP BY dept_name
ORDER BY COUNT(d.dept_no) DESC
```

![mentorship eligibility by department](/screenshots/screenshot_of_mentorship_count_by_department.PNG)
