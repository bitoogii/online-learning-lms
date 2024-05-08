INSERT INTO semester (semester_id, season_name, start_date, end_date, year)
VALUES 
(1, 'SEM A', '2024-01-01', '2025-01-01', '2024'),
(2, 'SEM B', '2024-01-01', '2025-01-01', '2024');

INSERT INTO course (course_id, course_name, course_desc) VALUES 
(1, '101', 'Introduction to Computer Science'),
(2, '102', 'Data Structures and Algorithms'),
(3, '201', 'Introduction to Psychology'),
(4, '202', 'Abnormal Psychology'),
(5, '301', 'English Composition'),
(6, '302', 'American Literature'),
(7, '401', 'Introduction to Economics'),
(8, '402', 'Microeconomics');

INSERT INTO instructor (instructor_id, instructor_name) VALUES 
(1, 'John Smith'),
(2, 'Emily Johnson'),
(3, 'Michael Williams'),
(4, 'Sarah Brown');

INSERT INTO course_session (course_session_id, instructor_id, start_date, end_date, course_id, semester_id) VALUES 
(1, 1, '2024-09-01', '2024-12-15', 1, 1),
(2, 2, '2024-09-01', '2024-12-15', 2, 1),
(3, 3, '2024-09-01', '2024-12-15', 3, 1),
(4, 4, '2024-09-01', '2024-12-15', 4, 1),
(5, 1, '2024-09-01', '2024-12-15', 5, 2),
(6, 2, '2024-09-01', '2024-12-15', 6, 2),
(7, 3, '2024-09-01', '2024-12-15', 7, 2),
(8, 4, '2024-09-01', '2024-12-15', 8, 2);

INSERT INTO assignment (assignment_id, course_session_id, start_date, due_date) VALUES 
(1, 1, '2024-09-15', '2024-10-15'),
(2, 2, '2024-09-20', '2024-10-20'),
(3, 3, '2024-09-25', '2024-10-25'),
(4, 4, '2024-09-30', '2024-10-30'),
(5, 5, '2024-10-05', '2024-11-05'),
(6, 6, '2024-10-10', '2024-11-10'),
(7, 7, '2024-10-15', '2024-11-15'),
(8, 8, '2024-10-20', '2024-11-20');

INSERT INTO student (student_id, student_name, sex) VALUES 
(1, 'Alice Johnson', 'F'),
(2, 'Bob Smith', 'M'),
(3, 'Charlie Brown', 'M'),
(4, 'Diana Williams', 'F');

INSERT INTO student_course_enrollment (student_course_id, student_id, course_session_id, enroll_status, grading_status, grade_point, grade) VALUES
    (1, 1, 1, 0, 0, 85, 'B'),
    (2, 2, 2, 1, 1, 92, 'A'),
    (3, 3, 3, 2, 2, 78, 'C'),
    (4, 4, 4, 1, 3, 87, 'B');

INSERT INTO assignment_submission (submission_id, student_course_id, assignment_id, submission, submit_date, status, grading_status, grade_point, grade) VALUES 
(1, 1, 1, 'Submitted file', '2024-10-10 08:00:00', 2, 2, 85, 'B'),
(2, 2, 2, 'Submitted file', '2024-10-15 10:00:00', 2, 2, 92, 'A'),
(3, 3, 3, 'Submitted file', '2024-10-20 12:00:00', 2, 2, 78, 'C'),
(4, 4, 4, 'Submitted file', '2024-10-25 14:00:00', 2, 2, 87, 'B');
