-- Create the database
CREATE DATABASE school_db;

-- Use the database (needed only in tools like MySQL Workbench)
\c DATABSE school_db  -- For PostgreSQL (in psql)

-- Create students table
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

-- Insert student names
INSERT INTO students(name) VALUES 
('Alice'), 
('Bob'), 
('Charlie'), 
('Daisy');

-- Create marks table
CREATE TABLE marks (
  mark_id SERIAL PRIMARY KEY,
  student_id INT REFERENCES students(student_id),
  subject VARCHAR(50),
  score INT
);

-- Insert marks for each student in different subjects
INSERT INTO marks(student_id, subject, score) VALUES
(1, 'Math', 85),
(1, 'English', 78),
(2, 'Math', 70),
(2, 'English', 75),
(3, 'Math', 90),
(3, 'English', 88),
(4, 'Math', 60),
(4, 'English', 65);

-- Select all rows from students
SELECT * FROM students;

-- Select all rows from marks
SELECT * FROM marks;

-- INNER JOIN: show each student's name with their marks
SELECT s.name, m.subject, m.score
FROM students AS s
JOIN marks AS m ON s.student_id = m.student_id;

-- LEFT JOIN: show all students even if no marks (not needed here but included)
SELECT s.name, m.subject, m.score
FROM students AS s
LEFT JOIN marks AS m ON s.student_id = m.student_id;

-- WHERE: Find students who scored more than 80
SELECT s.name, m.subject, m.score
FROM students AS s
JOIN marks AS m ON s.student_id = m.student_id
WHERE m.score > 80;

-- WHERE: Students who got marks in Math only
SELECT s.name, m.score
FROM students AS s
JOIN marks AS m ON s.student_id = m.student_id
WHERE m.subject = 'Math';

-- WHERE with LIKE: Students whose name contains 'a'
SELECT * FROM students WHERE name LIKE '%a%';

-- ILIKE : char + a + anything
SELECT * FROM students WHERE name ILIKE '_a%';

-- ORDER BY: List students alphabetically
SELECT * FROM students ORDER BY name ASC;

-- ORDER BY: Students ordered by name, then score descending
SELECT s.name, m.subject, m.score
FROM students AS s
JOIN marks AS m ON s.student_id = m.student_id
ORDER BY s.name ASC, m.score DESC;

-- GROUP BY: Average score by student
SELECT s.name, AVG(m.score) AS average_score
FROM students AS s
JOIN marks AS m ON s.student_id = m.student_id
GROUP BY s.name;

-- HAVING: Show students who gave more than 1 subject
SELECT s.name, COUNT(m.subject) AS subjects_given
FROM students AS s
JOIN marks AS m ON s.student_id = m.student_id
GROUP BY s.name
HAVING COUNT(m.subject) > 1;

-- Subquery: Get students who appeared in 'English'
SELECT * FROM students
WHERE student_id IN (
  SELECT student_id FROM marks WHERE subject = 'English'
);

-- EXISTS: Another way to check if student has marks
SELECT * FROM students
WHERE EXISTS (
  SELECT 1 FROM marks WHERE students.student_id = marks.student_id
);

-- Update: student's name
UPDATE students SET name = 'Alice Smith' WHERE student_id = 1;

-- Delete:  marks entry
DELETE FROM marks WHERE mark_id = 8;
