-- Inserting more data into the 'course' table
INSERT INTO course (course_name, course_desc) VALUES
    ('Data Structures and Algorithms', 'Study advanced data structures and algorithms.'),
    ('Machine Learning Fundamentals', 'Explore the basics of machine learning techniques.'),
    ('Network Security', 'Learn about securing computer networks.'),
    ('Software Engineering', 'Master the principles of software engineering.'),
    ('Artificial Intelligence', 'Discover the concepts of artificial intelligence.');

-- Inserting more data into the 'instructor' table
INSERT INTO instructor (instructor_name) VALUES
    ('Emily Brown'),
    ('David Wilson'),
    ('Jennifer Lee'),
    ('Matthew Taylor'),
    ('Olivia Martinez');

-- Inserting more data into the 'student' table
INSERT INTO student (student_name, sex) VALUES
    ('Grace Davis', 'F'),
    ('James Wilson', 'M'),
    ('Sophia Anderson', 'F'),
    ('William Thomas', 'M'),
    ('Emma Garcia', 'F'),
    ('Daniel Martinez', 'M'),
    ('Chloe Lopez', 'F'),
    ('Alexander Perez', 'M'),
    ('Mia Gonzalez', 'F'),
    ('Michael Rodriguez', 'M');

-- Inserting more data into the 'course_session' table
INSERT INTO course_session (instructor_id, start_date, end_date, course_id) VALUES
    (4, '2024-06-15', '2024-08-15', 4),
    (5, '2024-07-01', '2024-09-01', 5),
    (1, '2024-08-01', '2024-10-01', 1),
    (2, '2024-09-01', '2024-11-01', 2),
    (3, '2024-10-01', '2024-12-01', 3);

-- Inserting more data into the 'assignment' table
INSERT INTO assignment (course_session_id, start_date, due_date) VALUES
    (1, '2024-06-20 00:00:00', '2024-07-10 23:59:59'),
    (2, '2024-07-10 00:00:00', '2024-08-10 23:59:59'),
    (3, '2024-08-10 00:00:00', '2024-09-10 23:59:59'),
    (4, '2024-09-10 00:00:00', '2024-10-10 23:59:59'),
    (5, '2024-10-10 00:00:00', '2024-11-10 23:59:59');

-- Inserting more data into the 'student_course_enrollment' table
INSERT INTO student_course_enrollment (student_id, course_session_id, enroll_status, grading_status, grade_point, grade) VALUES
    (1, 1, 0, 0, NULL, NULL),
    (2, 2, 0, 0, NULL, NULL),
    (3, 3, 0, 0, NULL, NULL),
    (4, 4, 0, 0, NULL, NULL),
    (5, 5, 0, 0, NULL, NULL),
    (6, 1, 0, 0, NULL, NULL),
    (7, 2, 0, 0, NULL, NULL),
    (8, 3, 0, 0, NULL, NULL);

-- Inserting more data into the 'assignment_submission' table
INSERT INTO assignment_submission (student_course_id, assignment_id, submission, submit_date, status, grading_status, grade_point, grade) VALUES
    (4, 1, 'Algorithm implementation', '2024-07-08 12:00:00', 2, 2, 92, 'A'),
    (5, 2, 'Machine learning model code', '2024-08-05 15:30:00', 2, 2, 88, 'B'),
    (6, 3, 'Network security report', '2024-09-08 10:00:00', 2, 2, 85, 'B'),
    (7, 4, 'Software engineering project', '2024-10-05 12:00:00', 2, 2, 90, 'A'),
    (8, 5, 'AI research paper', '2024-11-05 15:30:00', 2, 2, 95, 'A'),
    (7, 1, 'Data structure code implementation', '2024-07-15 10:00:00', 2, 2, 90, 'A'),
    (7, 2, 'Machine learning algorithm analysis', '2024-08-20 12:00:00', 2, 2, 87, 'B'),
    (8, 3, 'Network security vulnerability assessment', '2024-09-25 15:30:00', 2, 2, 88, 'B');
