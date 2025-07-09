# Masraf 9th July(10)
## Overview 

The MD9THJ10_db academic database project effectively models a university system by incorporating key entities such as departments, students, faculty, courses, classes, enrollments, assignments, and grades. The schema allows for comprehensive tracking of academic operations, including course offerings, student enrollment, faculty assignments, grading, and performance analysis. The SQL queries developed provide insights into departmental affiliations, course distributions, faculty qualifications, enrollment patterns, class capacities, GPA calculations, and academic honors like the Dean's List.

## Objectives 

To design and implement a comprehensive student database management system for tracking academic records, enrollments, faculty information, and performance metrics to streamline institutional administration and reporting

## Creating Database 
``` sql
CREATE DATABASE MD9THJ10_db;
USE MD9THJ10_db;
```
## Creating Tables
### Table:departments
``` sql
CREATE TABLE departments(
    dept_id     INT PRIMARY KEY AUTO_INCREMENT,
    dept_name   TEXT,
    building    TEXT,
    budget      DECIMAL(15,2)
);

SELECT * FROM departments ;
```
### Table:students
``` sql
CREATE TABLE students(
    student_id        INT PRIMARY KEY AUTO_INCREMENT,
    first_name        TEXT,
    last_name         TEXT,
    date_of_birth     DATE,
    gender            TEXT,
    email             TEXT,
    phone             TEXT,
    address           TEXT,
    admission_date    DATE,
    dept_id           INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

SELECT * FROM students ;
```
### Table:faculty
``` sql
CREATE TABLE faculty(
    faculty_id   INT PRIMARY KEY AUTO_INCREMENT,
    first_name   TEXT,
    last_name    TEXT,
    dept_id      INT,
    email        TEXT,
    phone        TEXT,
    hire_date    DATE,
    salary       DECIMAL(10,2),
    ranking      TEXT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

SELECT * FROM faculty ;
```
### Table:courses
``` sql
CREATE TABLE courses(
    course_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_code  TEXT,
    course_name  TEXT,
    credits      INT,
    dept_id      INT,
    description  TEXT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

SELECT * FROM courses ;
```
### Table:classes
``` sql
CREATE TABLE classes(
    class_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_id   INT,
    faculty_id  INT,
    semester    TEXT,
    year        INT,
    room        TEXT,
    schedule    TEXT,
    capacity    INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

SELECT * FROM classes ;
```
### Table:enrollments
``` sql
CREATE TABLE enrollments(
    enrollment_id   INT PRIMARY KEY AUTO_INCREMENT,
    student_id      INT,
    class_id        INT,
    enrollment_date DATE,
    grade           TEXT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

SELECT * FROM enrollments ;
```
### Table:assignments
``` sql
CREATE TABLE assignments(
    assignment_id  INT PRIMARY KEY AUTO_INCREMENT,
    class_id       INT,
    title          TEXT,
    description    TEXT,
    due_date       DATETIME,
    max_score      INT,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

SELECT * FROM assignments ;
```
### Table:grades
``` sql
CREATE TABLE grades(
    grade_id        INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id   INT,
    assignment_id   INT,
    score           DECIMAL(10,2),
    submission_date DATETIME,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id),
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id)
);

SELECT * FROM grades ;
```
## KEY Queries 

#### 1-Which students belong to which departments?
``` sql
SELECT 
        CONCAT(s.first_name,' ',s.last_name) AS Student_name,d.dept_name
FROM students s 
LEFT JOIN departments d ON d.dept_id=s.dept_id;
```
#### 2-What courses are offered by the Computer Science department?
``` sql
SELECT 
                co.course_code,co.course_name,co.credits,d.dept_name
FROM courses co
LEFT JOIN departments d ON d.dept_id=co.dept_id
WHERE LOWER(d.dept_name) LIKE '%computer science%';
```
#### 3-Who are the faculty members and what are their departments and ranks?
``` sql
SELECT 
        CONCAT(f.first_name,' ',f.last_name) AS Faculty_name,d.dept_name,f.ranking
FROM faculty f
LEFT JOIN departments d ON d.dept_id=f.dept_id;
```
#### 4-How many students are enrolled in each class?
``` sql
SELECT 
        c.class_id,co.course_code,co.course_name,COUNT(e.student_id) AS Enrolled_students
FROM classes c 
LEFT JOIN enrollments e ON e.class_id=c.class_id
LEFT JOIN courses co ON co.course_id=c.course_id
GROUP BY c.class_id,co.course_code,co.course_name;
```
#### 5-Which students are taking more than one course?
``` sql
SELECT 
        CONCAT(s.first_name,' ',s.last_name) AS Student_name,
    COUNT(e.class_id) AS Total_courses 
FROM students s 
JOIN enrollments e ON e.student_id=s.student_id
GROUP BY Student_name
HAVING Total_courses >1;
```
#### 6-What classes are being offered and who teaches them?
``` sql
SELECT 
        c.class_id,co.course_code,co.course_name,
    CONCAT(f.first_name,' ',f.last_name) AS Faculty_name,
    c.semester,c.year
FROM classes c 
LEFT JOIN faculty f ON f.faculty_id=c.faculty_id
LEFT JOIN courses co ON co.course_id=c.course_id;
```
#### 7-What are the average scores for each assignment 
``| sql
SELECT 
        a.title,a.max_score,ROUND(AVG(g.score),2) AS Average_score
FROM assignments a
LEFT JOIN grades g ON g.assignment_id=a.assignment_id
GROUP BY a.title,a.max_score;
```
#### 8-Which students scored below 80 on any assignment?
``` sql
SELECT 
        s.student_id,CONCAT(s.first_name,' ',s.last_name) AS Student_name,
    a.title,a.max_score,g.score
FROM enrollments e 
JOIN students s ON  e.student_id=s.student_id
JOIN grades g ON g.enrollment_id=e.enrollment_id
JOIN assignments a ON a.class_id=e.class_id
WHERE g.score<80.0;
```
#### 9-What are the estimated GPAs for all students?
``` sql
SELECT 
    s.student_id,CONCAT(s.first_name,' ',s.last_name) AS Student_name,
    ROUND(AVG(
        CASE
            WHEN g.score >= 90 THEN 4.0
            WHEN g.score >= 85 THEN 3.5
            WHEN g.score >= 80 THEN 3.0
            WHEN g.score >= 75 THEN 2.5
            WHEN g.score >= 70 THEN 2.0
            WHEN g.score >= 65 THEN 1.5
            WHEN g.score >= 60 THEN 1.0
            ELSE 0.0
        END
    ), 2) AS estimated_gpa
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
GROUP BY s.student_id, s.first_name, s.last_name;
```
#### 10-How do department budgets compare?
``` sql
SELECT 
        *
FROM departments
ORDER BY budget DESC;

#### 11-Which faculty members earn above-average salaries?
 sql
SELECT 
        CONCAT(first_name,' ',last_name) AS Faculty_name,
    salary,ranking
FROM faculty
WHERE salary>(
        SELECT AVG(salary) FROM faculty);
```
#### 12-How is faculty distributed across departments and ranks?
``` sql
SELECT 
        d.dept_name,f.ranking,COUNT(*) AS Total_faculty
FROM departments d 
JOIN faculty f ON f.dept_id=d.dept_id
GROUP BY d.dept_name,f.ranking;
```
#### 13-Which classes have available seats remaining?
``` sql
SELECT 
    c.class_id,co.course_name,c.capacity,
    COUNT(e.enrollment_id) AS enrolled_students,
    (c.capacity - COUNT(e.enrollment_id)) AS seats_remaining
FROM classes c
JOIN courses co ON c.course_id = co.course_id
LEFT JOIN enrollments e ON c.class_id = e.class_id
GROUP BY c.class_id, co.course_name, c.capacity
HAVING seats_remaining > 0;
```
#### 14-What are the enrollment statistics for each department?
``` sql
SELECT 
    d.dept_id,d.dept_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    COUNT(DISTINCT e.class_id) AS total_classes,
    COUNT(e.enrollment_id) AS total_enrollments
FROM departments d
JOIN students s ON d.dept_id = s.dept_id
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY d.dept_id, d.dept_name;
```
#### 15-Which students qualify for the Dean's List (GPA > 3.5 equivalent)?
``` sql
SELECT 
    s.student_id,CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.dept_name AS department,ROUND(AVG(g.score), 2) AS average_score,
    ROUND(AVG(
        CASE
            WHEN g.score >= 90 THEN 4.0
            WHEN g.score >= 85 THEN 3.5
            WHEN g.score >= 80 THEN 3.0
            WHEN g.score >= 75 THEN 2.5
            WHEN g.score >= 70 THEN 2.0
            WHEN g.score >= 65 THEN 1.5
            WHEN g.score >= 60 THEN 1.0
            ELSE 0.0
        END
    ), 2) AS estimated_gpa
FROM students s
JOIN departments d ON s.dept_id = d.dept_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
GROUP BY s.student_id, student_name, d.dept_name
HAVING estimated_gpa > 3.5;
```
#### 16-Which students were admitted in the last year?
``` sql
SELECT 
    s.student_id,CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.admission_date,d.dept_name
FROM students s
JOIN departments d ON s.dept_id = d.dept_id
WHERE admission_date >= DATE_SUB('2023-12-01', INTERVAL 1 YEAR);
    -- Asuming current date is '2023-12-01'. Replace it with CURDATE() to find data for any date
```
#### 17-Which faculty members were hired in the last 5 years?
``` sql
SELECT 
    f.faculty_id,CONCAT(f.first_name,' ',f.last_name) AS Faculty_name,
    f.hire_date,f.ranking,d.dept_name
FROM faculty f
LEFT JOIN departments d ON f.dept_id = d.dept_id
WHERE f.hire_date >= DATE_SUB('2023-12-01', INTERVAL 5 YEAR);
    -- Asuming current date is '2023-12-01'. Replace it with CURDATE() to find data for any date
```
## Conclusion 

The project demonstrates a solid and scalable relational database design backed by accurate and insightful analytical queries. It enables efficient data retrieval for academic decision-making and performance monitoring. The queries not only validate the integrity of the schema but also provide valuable reports for administration, academic planning, and student evaluation. This foundation can be extended further with stored procedures, views, and BI dashboards for enhanced usability and automation.
