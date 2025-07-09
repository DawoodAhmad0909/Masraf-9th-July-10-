CREATE DATABASE MD9THJ10_db;
USE MD9THJ10_db;

CREATE TABLE departments(
    dept_id     INT PRIMARY KEY AUTO_INCREMENT,
    dept_name   TEXT,
    building    TEXT,
    budget      DECIMAL(15,2)
);

SELECT * FROM departments ;

INSERT INTO departments(dept_name,building,budget) VALUES
	('Computer Science', 'Engineering', 1500000.00),
	('Mathematics', 'Science', 850000.00),
	('Business Administration', 'Business', 1200000.00),
	('English Literature', 'Humanities', 650000.00);

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

INSERT INTO students(first_name,last_name,date_of_birth,gender,email,phone,address,admission_date,dept_id) VALUES
	('John', 'Smith', '2000-05-15', 'Male', 'john.smith@edu.com', '555-0101', '123 College St, Apt 4B', '2022-09-01', 1),
	('Sarah', 'Johnson', '2001-07-22', 'Female', 'sarah.j@edu.com', '555-0102', '456 University Ave', '2022-09-01', 1),
	('Michael', 'Williams', '1999-11-05', 'Male', 'michael.w@edu.com', '555-0103', '789 Campus Rd', '2021-09-01', 3),
	('Emily', 'Brown', '1998-09-18', 'Female', 'emily.b@edu.com', '555-0104', '321 Scholar Lane', '2023-01-15', 4),
	('David', 'Jones', '1995-04-30', 'Male', 'david.j@edu.com', '555-0105', '654 Graduate Hall', '2020-09-01', 2),
	('Jessica', 'Garcia', '2002-03-12', 'Female', 'jessica.g@edu.com', '555-0106', '987 Library Lane', '2023-09-01', 1);

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

INSERT INTO faculty(first_name,last_name,dept_id,email,phone,hire_date,salary,ranking) VALUES
	('Robert', 'Miller', 1, 'robert.m@edu.com', '555-0201', '2015-08-15', 85000.00, 'Professor'),
	('Jennifer', 'Davis', 1, 'jennifer.d@edu.com', '555-0202', '2018-03-10', 75000.00, 'Associate Prof'),
	('Thomas', 'Wilson', 2, 'thomas.w@edu.com', '555-0203', '2012-07-22', 90000.00, 'Professor'),
	('Lisa', 'Martinez', 3, 'lisa.m@edu.com', '555-0204', '2019-09-01', 80000.00, 'Assistant Prof'),
	('William', 'Anderson', 4, 'william.a@edu.com', '555-0205', '2016-01-15', 95000.00, 'Professor'),
	('Patricia', 'Taylor', 2, 'patricia.t@edu.com', '555-0206', '2020-05-20', 70000.00, 'Lecturer');

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

INSERT INTO courses(course_code,course_name,credits,dept_id,description) VALUES
	('CS101', 'Introduction to Programming', 4, 1, 'Fundamentals of programming using Python'),
	('CS201', 'Data Structures', 4, 1, 'Advanced programming concepts'),
	('MATH101', 'Calculus I', 3, 2, 'Limits, derivatives, and integrals'),
	('BUS101', 'Principles of Management', 3, 3, 'Introduction to business management'),
	('ENG201', 'Shakespeare Studies', 3, 4, 'In-depth analysis of Shakespearean works'),
	('MATH202', 'Linear Algebra', 3, 2, 'Vector spaces and matrix theory');

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

INSERT INTO classes(course_id,faculty_id,semester,year,room,schedule,capacity) VALUES
	(1, 1, 'Fall', 2023, 'ENG-205', 'MWF 10:00-10:50', 30),
	(2, 2, 'Fall', 2023, 'ENG-310', 'TTH 13:00-14:15', 25),
	(3, 3, 'Fall', 2023, 'SCI-105', 'MWF 11:00-11:50', 40),
	(4, 4, 'Fall', 2023, 'BUS-201', 'TTH 10:30-11:45', 35),
	(5, 5, 'Fall', 2023, 'HUM-150', 'MWF 14:00-14:50', 50),
	(6, 6, 'Fall', 2023, 'SCI-205', 'TTH 09:00-10:15', 30);

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

INSERT INTO enrollments(student_id,class_id,enrollment_date,grade) VALUES
	(1, 1, '2023-08-15', NULL),
	(1, 3, '2023-08-15', NULL),
	(2, 1, '2023-08-16', NULL),
	(3, 4, '2023-08-17', NULL),
	(4, 5, '2023-08-18', NULL),
	(5, 3, '2023-08-19', NULL),
	(5, 6, '2023-08-19', NULL),
	(6, 1, '2023-08-20', NULL),
	(6, 2, '2023-08-20', NULL);

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

INSERT INTO assignments(class_id,title,description,due_date,max_score) VALUES
	(1, 'Python Basics', 'Complete coding exercises', '2023-09-15 23:59:00', 100),
	(1, 'Functions Project', 'Implement various functions', '2023-10-01 23:59:00', 100),
	(2, 'Linked Lists', 'Implement linked list operations', '2023-09-20 23:59:00', 100),
	(3, 'Derivatives', 'Solve calculus problems', '2023-09-25 23:59:00', 100),
	(4, 'Case Study', 'Business management analysis', '2023-10-05 23:59:00', 100),
	(6, 'Matrix Operations', 'Linear algebra problems', '2023-09-18 23:59:00', 100);

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

INSERT INTO grades(enrollment_id,assignment_id,score,submission_date) VALUES
	(1, 1, 92.5, '2023-09-14 15:30:00'),
	(1, 2, 85.0, '2023-09-30 22:15:00'),
	(2, 1, 88.0, '2023-09-14 16:45:00'),
	(5, 4, 95.5, '2023-09-24 14:20:00'),
	(7, 6, 78.0, '2023-09-17 23:45:00'),
	(3, 5, 91.0, '2023-10-04 12:30:00');

-- 1-Which students belong to which departments?
SELECT 
	CONCAT(s.first_name,' ',s.last_name) AS Student_name,d.dept_name
FROM students s 
LEFT JOIN departments d ON d.dept_id=s.dept_id;

-- 2-What courses are offered by the Computer Science department?
SELECT 
		co.course_code,co.course_name,co.credits,d.dept_name
FROM courses co
LEFT JOIN departments d ON d.dept_id=co.dept_id
WHERE LOWER(d.dept_name) LIKE '%computer science%';
	
-- 3-Who are the faculty members and what are their departments and ranks?
SELECT 
	CONCAT(f.first_name,' ',f.last_name) AS Faculty_name,d.dept_name,f.ranking
FROM faculty f
LEFT JOIN departments d ON d.dept_id=f.dept_id;

-- 4-How many students are enrolled in each class?
SELECT 
	c.class_id,co.course_code,co.course_name,COUNT(e.student_id) AS Enrolled_students
FROM classes c 
LEFT JOIN enrollments e ON e.class_id=c.class_id
LEFT JOIN courses co ON co.course_id=c.course_id
GROUP BY c.class_id,co.course_code,co.course_name;
    
-- 5-Which students are taking more than one course?
SELECT 
	CONCAT(s.first_name,' ',s.last_name) AS Student_name,
    COUNT(e.class_id) AS Total_courses 
FROM students s 
JOIN enrollments e ON e.student_id=s.student_id
GROUP BY Student_name
HAVING Total_courses >1;

-- 6-What classes are being offered and who teaches them?
SELECT 
	c.class_id,co.course_code,co.course_name,
    CONCAT(f.first_name,' ',f.last_name) AS Faculty_name,
    c.semester,c.year
FROM classes c 
LEFT JOIN faculty f ON f.faculty_id=c.faculty_id
LEFT JOIN courses co ON co.course_id=c.course_id;

-- 7-What are the average scores for each assignment?
SELECT 
	a.title,a.max_score,ROUND(AVG(g.score),2) AS Average_score
FROM assignments a
LEFT JOIN grades g ON g.assignment_id=a.assignment_id
GROUP BY a.title,a.max_score;

-- 8-Which students scored below 80 on any assignment?
SELECT 
	s.student_id,CONCAT(s.first_name,' ',s.last_name) AS Student_name,
    a.title,a.max_score,g.score
FROM enrollments e 
JOIN students s ON  e.student_id=s.student_id
JOIN grades g ON g.enrollment_id=e.enrollment_id
JOIN assignments a ON a.class_id=e.class_id
WHERE g.score<80.0;

-- 9-What are the estimated GPAs for all students?
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
    
-- 10-How do department budgets compare?
SELECT 
	*
FROM departments
ORDER BY budget DESC;

-- 11-Which faculty members earn above-average salaries?
SELECT 
	CONCAT(first_name,' ',last_name) AS Faculty_name,
    salary,ranking
FROM faculty
WHERE salary>(
	SELECT AVG(salary) FROM faculty);
    
-- 12-How is faculty distributed across departments and ranks?
SELECT 
	d.dept_name,f.ranking,COUNT(*) AS Total_faculty
FROM departments d 
JOIN faculty f ON f.dept_id=d.dept_id
GROUP BY d.dept_name,f.ranking;

-- 13-Which classes have available seats remaining?
SELECT 
    c.class_id,co.course_name,c.capacity,
    COUNT(e.enrollment_id) AS enrolled_students,
    (c.capacity - COUNT(e.enrollment_id)) AS seats_remaining
FROM classes c
JOIN courses co ON c.course_id = co.course_id
LEFT JOIN enrollments e ON c.class_id = e.class_id
GROUP BY c.class_id, co.course_name, c.capacity
HAVING seats_remaining > 0;
    
-- 14-What are the enrollment statistics for each department?
SELECT 
    d.dept_id,d.dept_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    COUNT(DISTINCT e.class_id) AS total_classes,
    COUNT(e.enrollment_id) AS total_enrollments
FROM departments d
JOIN students s ON d.dept_id = s.dept_id
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY d.dept_id, d.dept_name;
    
-- 15-Which students qualify for the Dean's List (GPA > 3.5 equivalent)?
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
    
-- 16-Which students were admitted in the last year?
SELECT 
    s.student_id,CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.admission_date,d.dept_name
FROM students s
JOIN departments d ON s.dept_id = d.dept_id
WHERE admission_date >= DATE_SUB('2023-12-01', INTERVAL 1 YEAR);
    -- Asuming current date is '2023-12-01'. Replace it with CURDATE() to find data for any date
    
-- 17-Which faculty members were hired in the last 5 years?
SELECT 
    f.faculty_id,CONCAT(f.first_name,' ',f.last_name) AS Faculty_name,
    f.hire_date,f.ranking,d.dept_name
FROM faculty f
LEFT JOIN departments d ON f.dept_id = d.dept_id
WHERE f.hire_date >= DATE_SUB('2023-12-01', INTERVAL 5 YEAR);
    -- Asuming current date is '2023-12-01'. Replace it with CURDATE() to find data for any date