CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Departments Table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL)
    
-- Professors Table
CREATE TABLE Professors (
    professor_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20));
    
-- Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    enrollment_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id));
    
-- Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT,
    professor_id INT,
    credits INT CHECK (credits > 0),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id));
  
 -- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)); 
  
  
 -- Insert Departments
INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Economics'),
(5, 'English'); 

-- Insert Professors
INSERT INTO Professors VALUES
(1, 'John', 'Smith', 'jsmith@univ.edu', '1111111111'),
(2, 'Alice', 'Johnson', 'ajohnson@univ.edu', '2222222222'),
(3, 'Robert', 'Brown', 'rbrown@univ.edu', '3333333333'),
(4, 'Emily', 'Davis', 'edavis@univ.edu', '4444444444'),
(5, 'Michael', 'Wilson', 'mwilson@univ.edu', '5555555555');

-- Insert Students
INSERT INTO Students (student_id, first_name, last_name, email, phone, date_of_birth, enrollment_date, department_id) VALUES
(1, 'Michael', 'Lee', 'mlee@univ.edu', '9991111111', '2000-05-15', '2019-08-20', 1),
(2, 'Sarah', 'Kim', 'skim@univ.edu', '9992222222', '1999-07-22', '2018-08-20', 2),
(3, 'David', 'Garcia', 'dgarcia@univ.edu', '9993333333', '2001-02-10', '2020-08-20', 1),
(4, 'Sophia', 'Martinez', 'smartinez@univ.edu', '9994444444', '2002-03-14', '2021-08-20', 3),
(5, 'James', 'Taylor', 'jtaylor@univ.edu', '9995555555', '2000-09-18', '2019-08-20', 4),
(6, 'Olivia', 'Hernandez', 'ohernandez@univ.edu', '9996666666', '1999-11-25', '2018-08-20', 5),
(7, 'Ethan', 'Anderson', 'eanderson@univ.edu', '9997777777', '2001-06-10', '2020-08-20', 1),
(8, 'Isabella', 'Thomas', 'ithomas@univ.edu', '9998888888', '2002-02-18', '2021-08-20', 2),
(9, 'William', 'Moore', 'wmoore@univ.edu', '9999999999', '2001-12-12', '2020-08-20', 3),
(10, 'Mia', 'Jackson', 'mjackson@univ.edu', '8881111111', '2000-08-05', '2019-08-20', 4),
(11, 'Alexander', 'Martin', 'amartin@univ.edu', '8882222222', '1999-04-14', '2018-08-20', 1),
(12, 'Charlotte', 'White', 'cwhite@univ.edu', '8883333333', '2002-10-22', '2021-08-20', 2),
(13, 'Benjamin', 'Lopez', 'blopez@univ.edu', '8884444444', '2000-01-30', '2019-08-20', 3),
(14, 'Amelia', 'Gonzalez', 'agonzalez@univ.edu', '8885555555', '2001-07-09', '2020-08-20', 4),
(15, 'Daniel', 'Perez', 'dperez@univ.edu', '8886666666', '2002-09-28', '2021-08-20', 5),
(16, 'Harper', 'Hall', 'hhall@univ.edu', '8887777777', '2000-03-15', '2019-08-20', 1),
(17, 'Elijah', 'Young', 'eyoung@univ.edu', '8888888888', '2001-05-21', '2020-08-20', 2),
(18, 'Avery', 'King', 'aking@univ.edu', '8889999999', '2002-11-11', '2021-08-20', 3),
(19, 'Lucas', 'Scott', 'lscott@univ.edu', '7771111111', '1999-12-20', '2018-08-20', 4),
(20, 'Grace', 'Green', 'ggreen@univ.edu', '7772222222', '2001-01-01', '2020-08-20', 5);


-- Insert Courses
INSERT INTO Courses VALUES
(1, 'Database Systems', 1, 1, 4),
(2, 'Algorithms', 1, 2, 3),
(3, 'Linear Algebra', 2, 2, 3),
(4, 'Operating Systems', 1, 1, 4),
(5, 'Macroeconomics', 4, 4, 3);


-- Insert Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 1, '2019-08-25', 'A'),
(2, 7, 3, '2018-08-25', 'B'),
(3, 3, 1, '2020-08-25', 'A-'),
(4, 16, 4, '2021-08-25', 'B+'),
(5, 5, 5, '2019-08-25', 'A');

-- Question 1. Find the Total Number of Students in Each Department
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM Students s
JOIN Departments d ON s.department_id = d.department_id
GROUP BY d.department_name;

-- Question 2. List All Courses Taught by a Specific Professor
SELECT c.course_name
FROM Courses c
JOIN Professors p ON c.professor_id = p.professor_id
WHERE p.first_name = 'John' AND p.last_name = 'Smith';

-- Question 3. Find the Average Grade of Students in Each Course
SELECT c.course_name,
       AVG(CASE grade
              WHEN 'A' THEN 4
              WHEN 'A-' THEN 3.7
              WHEN 'B+' THEN 3.3
              WHEN 'B' THEN 3
              WHEN 'C' THEN 2
              ELSE NULL END) AS avg_grade
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

-- Question 4. List All Students Who Have Not Enrolled in Any Courses.
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- Question 5. Find the Number of Courses Offered by Each Department
SELECT d.department_name, COUNT(c.course_id) AS total_courses
FROM Courses c
JOIN Departments d ON c.department_id = d.department_id
GROUP BY d.department_name;

-- Question 6. List All Students Who Have Taken a Specific Course (e.g., 'Database Systems')
SELECT s.student_id, s.first_name, s.last_name
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems';

-- Question 7. Find the Most Popular Course Based on Enrollment Numbers
SELECT c.course_name, COUNT(e.student_id) AS total_enrollments
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name
ORDER BY total_enrollments DESC
LIMIT 1;

-- Question  8. Find the Average Number of Credits Per Student in a Department
SELECT d.department_name, AVG(c.credits) AS avg_credits
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Departments d ON s.department_id = d.department_id
GROUP BY d.department_name;

-- Question 9. List All Professors Who Teach in More Than One Department
SELECT p.first_name, p.last_name, COUNT(DISTINCT c.department_id) AS dept_count
FROM Professors p
JOIN Courses c ON p.professor_id = c.professor_id
GROUP BY p.professor_id, p.first_name, p.last_name
HAVING COUNT(DISTINCT c.department_id) > 1;

-- Question 10. Get the Highest and Lowest Grade in a Specific Course (e.g., 'Operating Systems')
SELECT c.course_name,
       MAX(grade) AS highest_grade,
       MIN(grade) AS lowest_grade
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Operating Systems'
GROUP BY c.course_name;
