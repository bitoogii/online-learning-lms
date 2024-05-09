INSERT INTO semester (semester_id, season_name, start_date, end_date, year)
VALUES 
(1, 'SEM A', '2024-01-01', '2025-01-01', '2024'),
(2, 'SEM B', '2024-01-01', '2025-01-01', '2024');


INSERT INTO instructor (instructor_id, instructor_name) VALUES 
(1, 'John Smith'),
(2, 'Emily Johnson'),
(3, 'Michael Williams'),
(4, 'Sarah Brown');


INSERT INTO course (course_id, course_name, course_desc) VALUES
(101, 'Quantum Mechanics Fundamentals', 'Explore the foundational principles and mathematical frameworks of quantum mechanics, from wave-particle duality to Schrödinger''s equation.'),
(102, 'Machine Learning Applications', 'Dive into the practical applications of machine learning algorithms and techniques, covering topics like regression, classification, and clustering.'),
(201, 'Ancient Civilizations and Mythology', 'Unravel the mysteries of ancient civilizations and their myths, from the myths of Egypt to the legends of Mesopotamia.'),
(202, 'Cognitive Neuroscience', 'Investigate the complexities of the human brain and behavior, focusing on understanding disorders such as schizophrenia and bipolar disorder.'),
(301, 'Creative Writing Workshop', 'Embark on a journey of self-expression through the art of creative writing, exploring various genres and techniques to craft compelling narratives.'),
(302, 'World Literature in Translation', 'Immerse yourself in the rich tapestry of world literature, from the epic poems of Homer to the modern masterpieces of Gabriel García Márquez.'),
(401, 'Globalization and International Trade', 'Examine the interconnectedness of economies in the era of globalization, analyzing trade policies, tariffs, and multinational corporations.'),
(402, 'Environmental Economics', 'Explore the economic principles underlying environmental issues, from pollution control to sustainable development strategies.');


-- Seed 20 course sessions with random instructor and course combinations
INSERT INTO course_session (course_session_id, instructor_id, start_date, end_date, course_id)
SELECT 
    cs.course_session_id,
    (SELECT instructor_id FROM instructor ORDER BY RAND() LIMIT 1) AS instructor_id,
    DATE_ADD(CURRENT_DATE(), INTERVAL FLOOR(RAND() * 30) DAY) AS start_date,
    DATE_ADD(CURRENT_DATE(), INTERVAL FLOOR(RAND() * 60) DAY) AS end_date,
    (SELECT course_id FROM course ORDER BY RAND() LIMIT 1) AS course_id
FROM
    (SELECT @i := @i + 1 AS course_session_id
    FROM
        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t1,
        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t2,
        (SELECT @i := 0) r) cs;

INSERT INTO assignment (assignment_id, course_session_id, start_date, due_date)
SELECT 
    assignment_id,
    (SELECT course_session_id FROM course_session ORDER BY RAND() LIMIT 1) AS course_session_id,
    NOW() + INTERVAL FLOOR(RAND() * 30) DAY AS start_date,
    NOW() + INTERVAL FLOOR(RAND() * 60) DAY AS due_date
FROM
    (SELECT @i := @i + 1 AS assignment_id
    FROM
        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t1,
        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t2,
        (SELECT @i := 0) r) a;



INSERT INTO student (student_id, student_name, sex) VALUES 
    (1, 'John Doe', 'M'),
    (2, 'Jane Smith', 'F'),
    (3, 'Michael Johnson', 'M'),
    (4, 'Emily Davis', 'F'),
    (5, 'David Wilson', 'M'),
    (6, 'Sarah Brown', 'F'),
    (7, 'Christopher Miller', 'M'),
    (8, 'Amanda Taylor', 'F'),
    (9, 'Matthew Anderson', 'M'),
    (10, 'Jennifer White', 'F'),
    (11, 'Robert Jones', 'M'),
    (12, 'Lisa Taylor', 'F'),
    (13, 'Brian Clark', 'M'),
    (14, 'Karen Martinez', 'F'),
    (15, 'Joseph Harris', 'M'),
    (16, 'Nancy Young', 'F'),
    (17, 'Andrew Allen', 'M'),
    (18, 'Patricia Walker', 'F'),
    (19, 'Daniel Lewis', 'M'),
    (20, 'Laura Hall', 'F'),
    (21, 'Mark Garcia', 'M'),
    (22, 'Stephanie Lopez', 'F'),
    (23, 'Charles Hill', 'M'),
    (24, 'Elizabeth Scott', 'F'),
    (25, 'Thomas Green', 'M'),
    (26, 'Margaret Adams', 'F'),
    (27, 'Kenneth Baker', 'M'),
    (28, 'Donna Gonzalez', 'F'),
    (29, 'Edward Perez', 'M'),
    (30, 'Deborah Nelson', 'F'),
    (31, 'Paul Carter', 'M'),
    (32, 'Ruth Brooks', 'F'),
    (33, 'Steven Wood', 'M'),
    (34, 'Sharon Ramirez', 'F'),
    (35, 'Ronald James', 'M'),
    (36, 'Cynthia Watson', 'F'),
    (37, 'Jerry Brooks', 'M'),
    (38, 'Marilyn Ward', 'F'),
    (39, 'Terry Diaz', 'M'),
    (40, 'Heather Richardson', 'F'),
    (41, 'Jose Martinez', 'M'),
    (42, 'Julie Lee', 'F'),
    (43, 'Jeffrey Taylor', 'M'),
    (44, 'Gloria Perez', 'F'),
    (45, 'Dennis King', 'M'),
    (46, 'Kathleen Hernandez', 'F'),
    (47, 'Carl Parker', 'M'),
    (48, 'Virginia Gonzales', 'F'),
    (49, 'Harry Fisher', 'M'),
    (50, 'Maria Kelly', 'F'),
    (51, 'Larry Collins', 'M'),
    (52, 'Debra Butler', 'F'),
    (53, 'Eugene Washington', 'M'),
    (54, 'Alice Young', 'F'),
    (55, 'Wayne Hall', 'M'),
    (56, 'Jacqueline Allen', 'F'),
    (57, 'Billy Nelson', 'M'),
    (58, 'Ann Long', 'F'),
    (59, 'Louis Scott', 'M'),
    (60, 'Emily Garcia', 'F'),
    (61, 'Craig Lopez', 'M'),
    (62, 'Martha Hill', 'F'),
    (63, 'Jimmy Adams', 'M'),
    (64, 'Susan Baker', 'F'),
    (65, 'Bobby Ramirez', 'M'),
    (66, 'Beverly James', 'F'),
    (67, 'Howard Watson', 'M'),
    (68, 'Teresa Brooks', 'F'),
    (69, 'Ronnie Diaz', 'M'),
    (70, 'Diane Richardson', 'F'),
    (71, 'Carlos Martinez', 'M'),
    (72, 'Joyce Lee', 'F'),
    (73, 'Johnny Taylor', 'M'),
    (74, 'Mildred Perez', 'F'),
    (75, 'Phillip King', 'M'),
    (76, 'Gail Hernandez', 'F'),
    (77, 'Allen Parker', 'M'),
    (78, 'Judy Gonzales', 'F'),
    (79, 'Mark Fisher', 'M'),
    (80, 'Gloria Kelly', 'F'),
    (81, 'William Collins', 'M'),
    (82, 'Pamela Butler', 'F'),
    (83, 'Russell Washington', 'M'),
    (84, 'Carol Young', 'F'),
    (85, 'Keith Hall', 'M'),
    (86, 'Norma Allen', 'F'),
    (87, 'Harry Nelson', 'M'),
    (88, 'Joan Long', 'F'),
    (89, 'Craig Scott', 'M'),
    (90, 'Theresa Garcia', 'F'),
    (91, 'Bruce Lopez', 'M'),
    (92, 'Diana Hill', 'F'),
    (93, 'Jerry Adams', 'M'),
    (94, 'Janice Baker', 'F'),
    (95, 'Randy Ramirez', 'M'),
    (96, 'Phyllis James', 'F'),
    (97, 'Carl Watson', 'M'),
    (98, 'Lillian Brooks', 'F'),
    (99, 'Dennis Johnson', 'M'),
    (100, 'Samantha Scott', 'F');



INSERT INTO student_course_enrollment (student_course_id, student_id, course_session_id, enroll_status, grading_status, grade_point, grade)
SELECT
    (@i := @i + 1) AS student_course_id,
    (SELECT student_id FROM student ORDER BY RAND() LIMIT 1) AS student_id,
    (SELECT course_session_id FROM course_session ORDER BY RAND() LIMIT 1) AS course_session_id,
    FLOOR(RAND() * 3) AS enroll_status,
    FLOOR(RAND() * 4) AS grading_status,
    CASE WHEN FLOOR(RAND() * 100) >= 90 THEN 100
         WHEN FLOOR(RAND() * 100) < 10 THEN 0
         ELSE FLOOR(RAND() * 91) + 10 END AS grade_point,
    CASE WHEN FLOOR(RAND() * 100) >= 90 THEN 'A'
         WHEN FLOOR(RAND() * 100) < 10 THEN 'F'
         WHEN FLOOR(RAND() * 100) >= 80 THEN 'B'
         WHEN FLOOR(RAND() * 100) >= 70 THEN 'C'
         WHEN FLOOR(RAND() * 100) >= 60 THEN 'D'
         ELSE 'F' END AS grade
FROM
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t2,
    (SELECT @i := 25) r
LIMIT 100;



INSERT INTO assignment_submission (submission_id, student_course_id, assignment_id, submission, submit_date, status, grading_status, grade_point, grade)
SELECT
    (@i := @i + 1) AS submission_id,
    (SELECT student_course_id FROM student_course_enrollment ORDER BY RAND() LIMIT 1) AS student_course_id,
    (SELECT assignment_id FROM assignment ORDER BY RAND() LIMIT 1) AS assignment_id,
    CONCAT('Submission for assignment ', (@i)) AS submission,
    (CURDATE() - INTERVAL FLOOR(RAND() * 30) DAY) AS submit_date,
    FLOOR(RAND() * 3) AS status,
    FLOOR(RAND() * 4) AS grading_status,
    CASE WHEN RAND() >= 0.9 THEN 100
         WHEN RAND() < 0.1 THEN 0
         ELSE FLOOR(RAND() * 91) + 10 END AS grade_point,
    CASE WHEN RAND() >= 0.9 THEN 'A'
         WHEN RAND() < 0.1 THEN 'F'
         WHEN RAND() >= 0.8 THEN 'B'
         WHEN RAND() >= 0.7 THEN 'C'
         WHEN RAND() >= 0.6 THEN 'D'
         ELSE 'F' END AS grade
FROM
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t2,
    (SELECT @i := 0) r
LIMIT 100;

