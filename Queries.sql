-- 1) Retrieve the list of all students who have enrolled in a specific course.
select *
from student s
        inner join student_course_enrollment sce on s.student_id = sce.student_id
        inner join course_session cs on sce.course_session_id = cs.course_session_id        
        where cs.course_id = 1

-- 2) Retrieve the average grade of a specific assignment across all students.
Select AVG(grade_point) From assignment_submission a Where a.assignment_id = 1

-- 3) Retrieve the list of all courses taken by a specific student.
Select c.course_id, c.course_name
From course c 
        INNER JOIN course_session cs on c.course_id = cs.course_id 
        INNER JOIN student_course_enrollment sce ON sce.course_session_id = cs.course_session_id 
        Where sce.student_id = 1;

-- 4) Retrieve the list of all instructors who teach a specific course.
Select * 
From instructor i 
    INNER JOIN course_session c ON i.instructor_id= c.instructor_id		
    Where c.course_id = 1;

-- 5) Retrieve the total number of students enrolled in a specific course.
select COUNT(*)
from student s
        inner join student_course_enrollment sce on s.student_id = sce.student_id
        inner join course_session cs on sce.course_session_id = cs.course_session_id        
        where cs.course_id = 1;

-- 6) Retrieve the list of all assignments for a specific course.
select *
from assignment a
        inner join course_session cs on a.course_session_id = cs.course_session_id       
        where cs.course_id = 1;

-- 7) Retrieve the highest grade received by a specific student in a specific course.
select sce.student_course_id, cs.course_session_id
from student_course_enrollment sce
        inner join course_session cs on sce.course_session_id = cs.course_session_id       
        where cs.course_id = 1 AND sce.student_id = 1;

-- 8) Retrieve the list of all students who have not completed a specific assignment.
select s.student_name
from student s
         inner join student_course_enrollment sce on s.student_id = sce.student_id
         inner join course_session cs on sce.course_session_id = cs.course_session_id
         inner join assignment a on cs.course_session_id = a.course_session_id
         inner join assignment_submission asub on asub.student_course_id = sce.student_course_id
where asub.assignment_id = 1
AND (asub.status < 2 OR asub.status = null) ;

-- 9) Retrieve the list of all courses that have more than 50 students enrolled.
select c.course_id, c.course_name, COUNT(sce.student_id) as enrolled_students
from course c
     join course_session cs on c.course_id = cs.course_id
     join student_course_enrollment sce on cs.course_session_id = sce.course_session_id
    group by c.course_id, c.course_name
    having COUNT(sce.student_id) > 0;
 
-- 10) Retrieve the list of all students who have an overall grade average of 90% or higher.
select s.student_id, s.student_name, AVG(sce.grade_point) as grade_average
from student s
    join student_course_enrollment sce on s.student_id = sce.student_id
    group by s.student_id, s.student_name
    having AVG(sce.grade_point) > 90;

-- 11) Retrieve the overall average grade for each course.
select c.course_id, c.course_id, AVG(sce.grade_point) as grade_average
from course c
    join course_session cs on c.course_id = cs.course_id
    join student_course_enrollment sce on cs.course_session_id = sce.course_session_id
    group by c.course_id, c.course_id;

-- 12) Retrieve the average grade for each assignment in a specific course.
select c.course_id, c.course_name, a.assignment_id, AVG(ass.grade_point) as grade_average
from course c
    join course_session cs on cs.course_id = c.course_id
    join assignment a on a.course_session_id = cs.course_session_id
    join assignment_submission ass on a.assignment_id = ass.assignment_id
    group by a.assignment_id
    having c.course_id = 1;

-- 13) Retrselect c.course_id, c.course_name, a.assignment_id, AVG(ass.grade_point) as grade_average
select c.course_id, c.course_name, a.assignment_id, AVG(ass.grade_point) as grade_average
from course c
    join course_session cs on cs.course_id = c.course_id
    join assignment a on a.course_session_id = cs.course_session_id
    join assignment_submission ass on a.assignment_id = ass.assignment_id
    group by a.assignment_id
    having c.course_id = 1;

-- 14) Retrieve the top 5 students with the highest overall grade average.
select s.student_id, s.student_name, AVG(sce.grade_point) as grade_average
from student s
    join student_course_enrollment sce on s.student_id = sce.student_id
    group by s.student_id, s.student_name
    order by grade_average desc
    limit 5;

-- 15) Retrieve the instructor with the highest overall average grade for all courses they teach.
select i.instructor_id, i.instructor_name, avg(asub.grade_point) as avg_grade
from instructor i
    join course_session cs on i.instructor_id = cs.instructor_id
    join assignment_submission asub on cs.course_session_id = asub.course_session_id
    group by i.instructor_id, i.instructor_name
    order by avg_grade desc
    limit 1;

-- 16) Retrieve the list of students who have a grade of A in a specific course.
select s.student_id, s.student_name
from student s
    join student_course_enrollment sce on s.student_id = sce.student_id
    join assignment_submission asub on sce.student_course_id = asub.student_course_id
    where asub.grade = 'A' and sce.course_session_id = 1;

-- 17) Retrieve the list of courses that have no assignments.
select c.course_id, c.course_name
from course c
    left join course_session cs on c.course_id = cs.course_id
    left join assignment a on cs.course_session_id = a.course_session_id
    where a.assignment_id is null;
-- 18) Retrieve the list of students who have the highest grade in a specific course.
select s.student_id, s.student_name
from student s
    join student_course_enrollment sce on s.student_id = sce.student_id
    join assignment_submission asub on sce.student_course_id = asub.student_course_id
    where asub.grade_point = (
        select max(grade_point)
        from assignment_submission
        where course_session_id = 1
    );

-- 19) Retrieve the list of assignments that have the lowest average grade in a specific course.
select a.assignment_id, a.start_date, a.due_date
from assignment a
    join assignment_submission asub on a.assignment_id = asub.assignment_id
    where a.course_session_id = 1
    group by a.assignment_id, a.start_date, a.due_date
    having avg(asub.grade_point) = (
        select min(avg_grade)
        from (
            select avg(grade_point) as avg_grade
            from assignment_submission
            where course_session_id = 1
            group by assignment_id
        ) as avg_grades
    );
-- 20) Retrieve the list of students who have not enrolled in any course.
select s.student_id, s.student_name
from student s
    left join student_course_enrollment sce on s.student_id = sce.student_id
    where sce.student_id is null;

-- 21) Retrieve the list of instructors who are teaching more than one course.
SELECT *
FROM instructor i
WHERE i.instructor_id IN
      (SELECT i1.instructor_id
       FROM instructor i1
                JOIN course_session cs
                     ON i1.instructor_id = cs.instructor_id
       GROUP BY i1.instructor_id
       HAVING COUNT(*) > 1);

-- 22) Retrieve the list of students who have not submitted an assignment for a specific course.
SELECT *
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
         JOIN course_session cs ON sce.course_session_id = cs.course_session_id
         JOIN assignment a ON cs.course_session_id = a.course_session_id
         LEFT JOIN assignment_submission asub ON asub.student_course_id = sce.student_course_id
WHERE cs.course_id = 1
  AND asub.submission_id IS NULL;

-- 23) Retrieve the list of courses that have the highest average grade.
SELECT c.course_id
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN student_course_enrollment sce ON sce.course_session_id = cs.course_session_id
GROUP BY c.course_id
ORDER BY AVG(sce.grade_point) DESC
LIMIT 1;

-- 24) Retrieve the list of assignments that have a grade average higher than the overall grade average.
SELECT asub.assignment_id, AVG(asub.grade_point) AS average_grade
FROM assignment_submission asub
GROUP BY asub.assignment_id
HAVING AVG(asub.grade_point) > (SELECT AVG(grade_point) FROM assignment_submission);

-- 25) Retrieve the list of courses that have at least one student with a grade of F.
SELECT c.*
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
where sce.grade = 'F';

-- 26) Retrieve the list of students who have the same grade in all their courses.
SELECT s.*
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(DISTINCT sce.grade) = 1;

-- 27) Retrieve the list of courses that have the same number of enrolled students.
SELECT c.*
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY cs.course_id
HAVING COUNT(sce.course_session_id);

-- 28) Retrieve the list of instructors who have taught all courses.
SELECT i.instructor_id
FROM instructor i
         JOIN course_session cs ON i.instructor_id = cs.instructor_id
GROUP BY i.instructor_id
HAVING count(DISTINCT (cs.course_id)) = (SELECT count(*) FROM course);

-- 29) Retrieve the list of assignments that have been graded but not returned to the students.
SELECT *
FROM assignment_submission
WHERE grading_status = 2
  AND status = 2;

-- 30) Retrieve the list of courses that have an average grade higher than the overall grade average.
SELECT c.course_id
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY c.course_id
HAVING AVG(sce.grade_point) >
       (SELECT AVG(grade_point) FROM student_course_enrollment);

-- 31) Retrieve the list of students who have submitted all assignments for a specific course.
SELECT s.student_id, s.student_name
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
         JOIN assignment_submission ass ON sce.student_course_id = ass.student_course_id
         JOIN assignment a ON ass.assignment_id = a.assignment_id
         JOIN course_session cs ON sce.course_session_id = cs.course_session_id
WHERE cs.course_id = 1
GROUP BY s.student_id, s.student_name
HAVING COUNT(DISTINCT ass.assignment_id) = (SELECT COUNT(*)
                                            FROM assignment a1
                                                     JOIN course_session cs1 ON a1.course_session_id = cs1.course_session_id
                                            WHERE a1.course_session_id = cs1.course_session_id);


-- 32) Retrieve the list of courses that have at least one assignment that no student has submitted.
SELECT DISTINCT c.course_id, c.course_name
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN assignment a ON cs.course_session_id = a.course_session_id
WHERE a.assignment_id NOT IN (SELECT DISTINCT ass.assignment_id
                              FROM assignment_submission ass);

-- 33) Retrieve the list of students who have submitted the most assignments.
SELECT s.student_id, s.student_name, COUNT(ass.submission_id) AS num_submissions
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
         JOIN assignment_submission ass ON sce.student_course_id = ass.student_course_id
GROUP BY s.student_id, s.student_name
ORDER BY num_submissions DESC
LIMIT 1;

-- 34) Retrieve the list of courses that have the highest average grade among students who have
-- submitted all assignments.
SELECT c.course_id, c.course_name, AVG(sce.grade_point) AS average_grade
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
WHERE sce.student_course_id IN (SELECT sce.student_course_id
                                FROM assignment a
                                         JOIN assignment_submission ass ON a.assignment_id = ass.assignment_id
                                         JOIN student_course_enrollment sce
                                              ON ass.student_course_id = sce.student_course_id
                                GROUP BY sce.student_course_id
                                HAVING COUNT(DISTINCT a.assignment_id) =
                                       (SELECT COUNT(*) FROM assignment WHERE course_session_id = cs.course_session_id))
GROUP BY c.course_id, c.course_name
ORDER BY average_grade DESC
LIMIT 1;

-- 35) Retrieve the list of courses that have the highest average grade among students who have
-- submitted all assignments.
SELECT c.course_id, c.course_name, AVG(sce.grade_point) AS average_grade
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
WHERE sce.student_course_id IN (SELECT sce.student_course_id
                                FROM assignment a
                                         JOIN assignment_submission ass ON a.assignment_id = ass.assignment_id
                                         JOIN student_course_enrollment sce
                                              ON ass.student_course_id = sce.student_course_id
                                GROUP BY sce.student_course_id
                                HAVING COUNT(DISTINCT a.assignment_id) =
                                       (SELECT COUNT(*) FROM assignment WHERE course_session_id = cs.course_session_id))
GROUP BY c.course_id, c.course_name
ORDER BY average_grade DESC
LIMIT 1;

-- 36) Retrieve the list of courses with the highest number of enrollments.
SELECT c.course_id
FROM course c
         JOIN course_session ON c.course_id = course_session.course_id
         JOIN university.student_course_enrollment sce ON course_session.course_session_id = sce.course_session_id
GROUP BY c.course_id
ORDER BY COUNT(sce.student_id) DESC
LIMIT 1;

-- 37) Retrieve the list of assignments that have the lowest submission rate.
SELECT a.assignment_id,
       COUNT(asub.submission_id) / COUNT(DISTINCT sce.student_course_id) AS submission_rate
FROM assignment a
         JOIN assignment_submission asub ON a.assignment_id = asub.assignment_id
         JOIN student_course_enrollment sce ON asub.student_course_id = sce.student_course_id
GROUP BY a.assignment_id
ORDER BY submission_rate
LIMIT 1;

-- 38) Retrieve the list of students who have the highest average grade for a specific course.
SELECT s.student_id
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
         JOIN course_session cs ON sce.course_session_id = cs.course_session_id
         JOIN course c ON cs.course_id = c.course_id
WHERE c.course_id = 1
GROUP BY s.student_id
ORDER BY AVG(s.student_id) DESC
LIMIT 1;

-- 39) Retrieve the list of courses with the highest percentage of students who have completed all
-- assignments.
SELECT cs.course_id,
       COUNT(DISTINCT sce.student_id)                  AS total_students,
       COUNT(DISTINCT CASE
                          WHEN sub_count.total_assignments = sub_count.total_submissions
                              THEN sce.student_id END) AS completed_students,
       COUNT(DISTINCT CASE WHEN sub_count.total_assignments = sub_count.total_submissions THEN sce.student_id END) /
       COUNT(DISTINCT sce.student_id) * 100            AS completion_percentage
FROM course_session cs
         JOIN
     course c ON cs.course_id = c.course_id
         JOIN
     student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
         LEFT JOIN (SELECT sce.course_session_id,
                           COUNT(DISTINCT a.assignment_id)    AS total_assignments,
                           COUNT(DISTINCT asub.submission_id) AS total_submissions
                    FROM student_course_enrollment sce
                             JOIN
                         assignment a ON sce.course_session_id = a.course_session_id
                             LEFT JOIN
                         assignment_submission asub ON sce.student_course_id = asub.student_course_id
                    GROUP BY sce.course_session_id) AS sub_count ON cs.course_session_id = sub_count.course_session_id
GROUP BY cs.course_id, c.course_name
ORDER BY completion_percentage DESC
LIMIT 1;

-- 40) Retrieve the list of students who have not submitted any assignments for a specific course.
SELECT s.student_id,
       s.student_name
FROM student s
         JOIN
     student_course_enrollment sce ON s.student_id = sce.student_id
         JOIN
     course_session cs ON sce.course_session_id = cs.course_session_id
         LEFT JOIN
     assignment_submission asub ON sce.student_course_id = asub.student_course_id
WHERE cs.course_id = 1
  AND asub.submission_id IS NULL;

-- 41) Retrieve the list of courses with the lowest average grade.
SELECT c.course_id
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY c.course_id
ORDER BY AVG(sce.grade_point)
LIMIT 1;

-- 42) Retrieve the list of assignments that have the highest average grade.
SELECT a.assignment_id, AVG(asub.grade_point)
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
         JOIN assignment a ON cs.course_session_id = a.course_session_id
         JOIN assignment_submission asub ON sce.student_course_id = asub.student_course_id
GROUP BY a.assignment_id
ORDER BY AVG(asub.grade_point) DESC
LIMIT 1;

-- 43) Retrieve the list of students who have the highest overall grade across all courses.
SELECT s.student_id
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
GROUP BY s.student_id
ORDER BY AVG(sce.grade_point) DESC
LIMIT 1;

-- 44) Retrieve the list of assignments that have not been graded yet.
SELECT asub.assignment_id
FROM assignment a
         LEFT JOIN assignment_submission asub ON a.assignment_id = asub.assignment_id
WHERE asub.grading_status = 0
   OR asub.grading_status IS NULL
GROUP BY asub.assignment_id;

-- 45) Retrieve the list of courses that have not been assigned any assignments yet.
SELECT c.course_id
FROM course c
         JOIN course_session cs ON c.course_id = cs.course_id
         LEFT JOIN assignment a ON cs.course_session_id = a.course_session_id
WHERE a.assignment_id IS NULL
GROUP BY c.course_id;

-- 46) Retrieve the list of students who have completed all assignments for a specific course.
SELECT sce.student_id,
       s.student_name
FROM student_course_enrollment sce
         JOIN
     student s ON sce.student_id = s.student_id
WHERE sce.course_session_id IN (SELECT cs.course_session_id
                                FROM course_session cs
                                WHERE cs.course_id = 1)
  AND NOT EXISTS (SELECT a.assignment_id
                  FROM assignment a
                  WHERE a.course_session_id = sce.course_session_id
                    AND NOT EXISTS (SELECT asub.submission_id
                                    FROM assignment_submission asub
                                    WHERE asub.assignment_id = a.assignment_id
                                      AND asub.grading_status = 2
                                      AND asub.status = 2));

-- 47) Retrieve the list of students who have submitted all assignments but have not received a passing
-- grade for a specific course.
SELECT sce.student_id
FROM student_course_enrollment sce
         JOIN student s ON sce.student_id = s.student_id
WHERE sce.course_session_id IN (SELECT cs.course_session_id
                                FROM course_session cs
                                WHERE cs.course_id = 1
                                  AND NOT EXISTS (SELECT a.assignment_id
                                                  FROM assignment a
                                                  WHERE a.course_session_id = sce.course_session_id
                                                    AND NOT EXISTS (SELECT asub.submission_id
                                                                    FROM assignment_submission asub
                                                                    WHERE asub.assignment_id = a.assignment_id
                                                                      AND asub.grading_status = 2
                                                                      AND asub.status = 2))
                                  AND NOT EXISTS (SELECT asub.submission_id
                                                  FROM assignment_submission asub
                                                  WHERE asub.student_course_id = sce.student_course_id
                                                    AND asub.grade_point >= 70));

-- 48) Retrieve the list of courses that have the highest percentage of students who have received a
-- passing grade.
SELECT cs.course_id,
       COUNT(CASE WHEN sce.grade_point >= 70 THEN 1 END) * 100.0 / COUNT(*) AS passing_percentage
FROM course_session cs
         JOIN course c ON cs.course_id = c.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY cs.course_id, c.course_name
ORDER BY passing_percentage DESC;
-- 49) Retrieve the list of students who have submitted assignments late for a specific course.
SELECT s.student_id,
       asub.assignment_id,
       asub.submit_date
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
         JOIN course_session cs ON sce.course_session_id = cs.course_session_id
         JOIN assignment_submission asub ON sce.student_course_id = asub.student_course_id
         JOIN assignment a ON asub.assignment_id = a.assignment_id
WHERE cs.course_id = 1
  AND asub.submit_date > a.due_date
ORDER BY asub.submit_date;
-- 50) Retrieve the list of courses that have the highest percentage of students who have dropped
-- out.
SELECT cs.course_id,
       c.course_name,
       COUNT(CASE WHEN sce.enroll_status = 2 THEN 1 END) * 100.0 / COUNT(*) AS dropout_percentage
FROM course_session cs
         JOIN course c ON cs.course_id = c.course_id
         JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY cs.course_id, c.course_name
ORDER BY dropout_percentage DESC;

-- 51) Retrieve the list of students who have not yet submitted any assignments for a specific
-- course.
SELECT s.student_id,
       s.student_name
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
         JOIN course_session cs ON sce.course_session_id = cs.course_session_id
         LEFT JOIN assignment_submission asub ON sce.student_course_id = asub.student_course_id
WHERE cs.course_id = 1
  AND asub.assignment_id IS NULL
GROUP BY s.student_id, s.student_name;

-- 52) Retrieve the list of students who have submitted at least one assignment for a specific
-- course but have not completed all assignments.
SELECT s.student_id,
       s.student_name
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
         JOIN course_session cs ON sce.course_session_id = cs.course_session_id
         LEFT JOIN assignment_submission asub ON sce.student_course_id = asub.student_course_id
WHERE cs.course_id = 1
  AND asub.assignment_id IS NOT NULL
  AND NOT EXISTS (SELECT a.assignment_id
                  FROM assignment a
                  WHERE a.course_session_id = cs.course_session_id
                    AND NOT EXISTS (SELECT asub1.submission_id
                                    FROM assignment_submission asub1
                                    WHERE asub1.assignment_id = a.assignment_id
                                      AND asub1.student_course_id = sce.student_course_id))
GROUP BY s.student_id, s.student_name;

-- 53) Retrieve the list of assignments that have received the highest average grade.
SELECT a.assignment_id,
       AVG(asub.grade_point) AS average_grade
FROM assignment a
         JOIN assignment_submission asub ON a.assignment_id = asub.assignment_id
GROUP BY a.assignment_id
ORDER BY average_grade DESC
LIMIT 1;

-- 54) Retrieve the list of students who have received the highest average grade across all
-- courses.
SELECT s.student_id,
       AVG(sce.grade_point) AS average_grade
FROM student s
         JOIN student_course_enrollment sce ON s.student_id = sce.student_id
GROUP BY s.student_id
ORDER BY average_grade DESC
LIMIT 1;

-- 55) Retrieve the list of courses that have the highest average grade.
select c.course_name, avg(sce.grade_point) as average_grade from course c
inner join course_session cs
on cs.course_id = c.course_id
inner join student_course_enrollment sce
on sce.course_session_id = cs.course_session_id
group by c.course_id
order by average_grade desc;

-- 56) Retrieve the list of courses that have at least one student enrolled but no assignments have been created yet.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs ON c.course_id = cs.course_id
LEFT JOIN assignment a ON cs.course_session_id = a.course_session_id
LEFT JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY c.course_id
HAVING COUNT(DISTINCT sce.student_course_id) > 0 AND COUNT(a.assignment_id) = 0;

-- 57) Retrieve the list of courses that have at least one assignment created but no student has enrolled yet.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs ON c.course_id = cs.course_id
LEFT JOIN assignment a ON cs.course_session_id = a.course_session_id
LEFT JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY c.course_id
HAVING COUNT(DISTINCT sce.student_course_id) = 0 AND COUNT(a.assignment_id) > 0;

-- 58) Retrieve the list of students who have submitted all assignments for a specific course.
SELECT s.student_id, s.student_name
FROM student s
INNER JOIN student_course_enrollment sce ON s.student_id = sce.student_id
INNER JOIN assignment_submission ass ON sce.student_course_id = ass.student_course_id
INNER JOIN assignment a ON ass.assignment_id = a.assignment_id
INNER JOIN course_session cs ON sce.course_session_id = cs.course_session_id
WHERE cs.course_id = 1
GROUP BY s.student_id, s.student_name
HAVING COUNT(DISTINCT a.assignment_id) = COUNT(DISTINCT ass.assignment_id);

-- 59) Retrieve the list of courses where the overall average grade is higher than the average grade of a specific student.
SELECT c.course_id, c.course_name, c.course_desc
FROM course c
INNER JOIN course_session cs ON c.course_id = cs.course_id
LEFT JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
WHERE sce.grade_point IS NOT NULL
GROUP BY c.course_id, c.course_name, c.course_desc
HAVING AVG(sce.grade_point) > (
    SELECT AVG(sce2.grade_point)
    FROM student_course_enrollment sce2
    WHERE sce2.student_id = 1
);

-- 60) Retrieve the list of students who have not yet submitted any assignments for any course.
SELECT s.student_id, s.student_name
FROM student s
WHERE NOT EXISTS (
    SELECT 1
    FROM assignment_submission ass
    INNER JOIN student_course_enrollment sce ON ass.student_course_id = sce.student_course_id
    WHERE sce.student_id = s.student_id
);

-- 61) Retrieve the list of students who have completed all the courses they have enrolled in.
SELECT s.student_id, s.student_name
FROM student s
WHERE NOT EXISTS (
    SELECT 1
    FROM student_course_enrollment sce
    WHERE sce.student_id = s.student_id AND enroll_status NOT IN (0 , 2)
);

-- 62) Retrieve the list of courses where the average grade is lower than a specific threshold.
SELECT c.course_id, c.course_name, c.course_desc
FROM course c
INNER JOIN course_session cs ON c.course_id = cs.course_id
INNER JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY c.course_id, c.course_name, c.course_desc
HAVING AVG(sce.grade_point) < 95;

-- 63) Retrieve the list of courses where the number of students enrolled is less than a specific threshold.
SELECT c.course_id, c.course_name, c.course_desc
FROM course c
INNER JOIN course_session cs ON c.course_id = cs.course_id
INNER JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY c.course_id, c.course_name, c.course_desc
HAVING COUNT(DISTINCT sce.student_id) < 5;

-- 64) Retrieve the list of students who have not completed a specific course but have submitted all the assignments for that course.
SELECT s.student_id, s.student_name
FROM student s
INNER JOIN student_course_enrollment sce ON s.student_id = sce.student_id
INNER JOIN course_session cs ON cs.course_session_id = sce.course_session_id
INNER JOIN assignment_submission ass ON sce.student_course_id = ass.student_course_id
INNER JOIN course c ON c.course_id = cs.course_id
WHERE c.course_id = 1
GROUP BY s.student_id, s.student_name
HAVING COUNT(DISTINCT ass.assignment_id) = (
    SELECT COUNT(*)
    FROM assignment a
    INNER JOIN course_session cs2 ON cs2.course_session_id = a.course_session_id
    WHERE cs2.course_id = 1
);

-- 65) Retrieve the list of courses where the average grade is higher than the overall average grade of all courses.
SELECT c.course_id, c.course_name, c.course_desc
FROM course c
INNER JOIN course_session cs ON c.course_id = cs.course_id
INNER JOIN student_course_enrollment sce ON cs.course_session_id = sce.course_session_id
GROUP BY c.course_id, c.course_name, c.course_desc
HAVING AVG(sce.grade_point) > (
    SELECT AVG(sce2.grade_point)
    FROM student_course_enrollment sce2
);

-- 66) Retrieve the list of courses where the average grade is higher than a specific threshold and the number of students enrolled is greater than a specific threshold.
SELECT c.course_id, c.course_name, c.course_desc
FROM course c
INNER JOIN course_session cs ON c.course_id = cs.course_id
INNER JOIN student_course_enrollment sce ON sce.course_session_id = cs.course_session_id
GROUP BY c.course_id, c.course_name, c.course_desc
HAVING AVG(sce.grade_point) > 20
    AND COUNT(DISTINCT sce.student_id) > 1;

-- 67) Retrieve the list of students who have enrolled in at least two courses and have not submitted any assignments in the past month.
SELECT s.student_id, s.student_name
FROM student s
INNER JOIN student_course_enrollment sce ON s.student_id = sce.student_id
INNER JOIN assignment_submission ass ON sce.student_course_id = ass.student_course_id
WHERE sce.student_id IN (
    SELECT student_id
    FROM student_course_enrollment
    GROUP BY student_id
    HAVING COUNT(*) >= 2
)
AND ass.submit_date < DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- 68) Retrieve the list of courses where the percentage of students who have submitted all the assignments is higher than a specific threshold.
SELECT c.course_id, c.course_name, c.course_desc
FROM course c
INNER JOIN course_session cs ON c.course_id = cs.course_id
INNER JOIN student_course_enrollment sce ON sce.course_session_id = cs.course_session_id
INNER JOIN assignment a ON a.course_session_id = cs.course_session_id
INNER JOIN assignment_submission ass ON ass.student_course_id = sce.student_course_id
GROUP BY c.course_id, c.course_name, c.course_desc
HAVING SUM(CASE WHEN ass.status = 2 THEN 1 ELSE 0 END) / COUNT(DISTINCT sce.student_id) > 0.5;

-- 69) Retrieve the list of students who have enrolled in a course but have not submitted any assignments.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
INNER JOIN course_session cs
ON cs.course_session_id = cs.course_session_id
LEFT JOIN assignment_submission ass
ON ass.student_course_id = sce.student_course_id
GROUP BY s.student_id
HAVING SUM(CASE WHEN ass.submission_id IS NULL THEN 0 ELSE 1 END) = 0;

-- 70) Retrieve the list of courses where the percentage of students who have submitted at least one assignment is lower than a specific threshold.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = cs.course_session_id
LEFT JOIN assignment_submission ass
ON ass.student_course_id = sce.student_course_id
GROUP BY c.course_id
HAVING SUM(DISTINCT CASE WHEN ass.submission_id IS NULL THEN 0 ELSE 1 END) / COUNT(DISTINCT sce.student_id) < 0.5;

-- 71) Retrieve the list of students who have submitted an assignment after the due date.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON s.student_id = sce.student_id
INNER JOIN assignment_submission ass
ON ass.student_course_id = sce.student_course_id
INNER JOIN assignment a
ON a.assignment_id = ass.assignment_id
WHERE ass.submit_date > a.due_date
GROUP BY s.student_id;

-- 72) Retrieve the list of courses where the average grade of female students is higher than that of male students.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = cs.course_session_id
INNER JOIN student s
ON s.student_id = sce.student_id
GROUP BY c.course_id
HAVING
	COUNT(CASE WHEN s.sex = 'F' THEN s.student_id END) > 0
    AND COUNT(CASE WHEN s.sex = 'M' THEN s.student_id END) > 0
	AND AVG(CASE WHEN s.sex = 'F' THEN sce.grade_point END) > AVG(CASE WHEN s.sex = 'M' THEN sce.grade_point END);

-- 73) Retrieve the list of courses that have at least one female student and no male students.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = cs.course_session_id
INNER JOIN student s
ON s.student_id = sce.student_id
GROUP BY c.course_id
HAVING
	COUNT(CASE WHEN s.sex = 'F' THEN s.student_id END) > 0
    AND COUNT(CASE WHEN s.sex = 'M' THEN s.student_id END) = 0;

-- 74) Retrieve the list of students who have submitted at least one assignment in all the courses they are enrolled in.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
LEFT JOIN assignment_submission ass
ON ass.student_course_id = sce.student_course_id
GROUP BY s.student_id
HAVING 
	COUNT(DISTINCT(CASE WHEN ass.student_course_id IS NOT NULL THEN ass.student_course_id END)) = COUNT(DISTINCT(sce.student_course_id));

-- 75) Retrieve the list of students who have not enrolled in any courses.
SELECT student_name
FROM student
WHERE student_id NOT IN (SELECT student_id FROM student_course_enrollment);

-- 76) Retrieve the list of courses that have the highest number of enrolled students.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
WHERE sce.course_session_id = cs.course_session_id
GROUP BY c.course_id
HAVING COUNT(DISTINCT(sce.student_id)) = (
	SELECT COUNT(DISTINCT(sce.student_id))
	FROM course c
	INNER JOIN course_session cs
	ON cs.course_id = c.course_id
	INNER JOIN student_course_enrollment sce
	WHERE sce.course_session_id = cs.course_session_id
	GROUP BY c.course_id
    ORDER BY 1 DESC
	LIMIT 1
);

-- 77) Retrieve the list of assignments that have the lowest average grade.
SELECT a.* 
FROM assignment a
INNER JOIN assignment_submission ass
ON ass.assignment_id = a.assignment_id
GROUP BY a.assignment_id
HAVING AVG(ass.grade_point) = (SELECT MIN(avgGp) FROM (
	SELECT AVG(ass.grade_point) AS avgGp
    FROM assignment a
	INNER JOIN assignment_submission ass
	ON ass.assignment_id = a.assignment_id
	GROUP BY a.assignment_id
) AS sub);

-- 78) Retrieve the list of students who have submitted all the assignments in a particular course.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
INNER JOIN assignment a
ON a.course_session_id = sce.course_session_id
INNER JOIN course_session cs
ON cs.course_session_id = a.course_session_id
LEFT JOIN assignment_submission ass
ON ass.assignment_id = a.assignment_id
WHERE cs.course_id = 1
GROUP BY s.student_id
HAVING COUNT(DISTINCT(a.assignment_id)) = SUM(CASE WHEN ass.status = 2 THEN 1 END);

-- 79) Retrieve the list of courses where the average grade of all students is above 80.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = cs.course_session_id
GROUP BY c.course_id
HAVING AVG(sce.grade_point) > 80;

-- 80) Retrieve the list of students who have the highest grade in each course.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
INNER JOIN course_session cs
ON cs.course_session_id = sce.course_session_id
INNER JOIN (
	SELECT c2.course_id, MAX(sce2.grade_point)
	FROM course c2
	INNER JOIN course_session cs2
	ON cs2.course_id = c2.course_id
	INNER JOIN student_course_enrollment sce2
	ON sce2.course_session_id = cs2.course_session_id
	GROUP BY c2.course_id
) AS sub
ON sub.course_id = cs.course_id;

-- 81) Retrieve the list of students who have submitted all the assignments on time.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
INNER JOIN assignment a
ON a.course_session_id = sce.course_session_id
LEFT JOIN assignment_submission ass
ON ass.assignment_id = a.assignment_id
GROUP BY s.student_id
HAVING COUNT(DISTINCT(a.assignment_id)) = COUNT(CASE WHEN ass.submit_date < a.due_date THEN 1 END);

-- 82) Retrieve the list of students who have submitted late submissions for any assignment.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
INNER JOIN assignment a
ON a.course_session_id = sce.course_session_id
LEFT JOIN assignment_submission ass
ON ass.assignment_id = a.assignment_id
WHERE ass.submit_date > a.due_date
GROUP BY s.student_id;

-- 83) Retrieve the list of courses that have the lowest average grade for a particular semester.

-- 84) Retrieve the list of students who have not submitted any assignment for a particular course.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
INNER JOIN assignment a
ON a.course_session_id = sce.course_session_id
LEFT JOIN assignment_submission ass
ON ass.assignment_id = a.assignment_id
GROUP BY s.student_id
HAVING COUNT(CASE WHEN ass.submission_id IS NOT NULL THEN 1 END) = 0;

-- 85) Retrieve the list of courses where the highest grade is less than 90.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = cs.course_session_id
GROUP BY c.course_id
HAVING MAX(sce.grade_point) < 90;

-- 86) Retrieve the list of students who have submitted all the assignments, but their average grade is less than 70.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
INNER JOIN assignment a
ON a.course_session_id = sce.course_session_id
LEFT JOIN assignment_submission ass
ON ass.assignment_id = a.assignment_id
GROUP BY s.student_id
HAVING 
	COUNT(a.assignment_id) = COUNT(CASE WHEN ass.submission_id IS NOT NULL THEN 1 END) 
    AND AVG(sce.grade_point) < 70;

-- 87) Retrieve the list of courses that have at least one student with an average grade of 90 or above.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = cs.course_session_id
GROUP BY c.course_id
HAVING AVG(sce.grade_point) >= 90;

-- 88) Retrieve the list of students who have not submitted any assignments for any of their enrolled courses.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = cs.course_session_id
LEFT JOIN assignment_submission ass
ON ass.student_course_id = sce.student_course_id
GROUP BY c.course_id
HAVING COUNT(CASE WHEN ass.submission_id IS NOT NULL THEN 1 END) = 0;

-- 89) Retrieve the list of courses that have at least one student who has not submitted any assignments.
SELECT c.course_name
FROM course c
INNER JOIN course_session cs
ON cs.course_id = c.course_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = cs.course_session_id
LEFT JOIN assignment_submission ass
ON ass.student_course_id = sce.student_course_id
GROUP BY c.course_id
HAVING COUNT(DISTINCT CASE WHEN ass.submit_date IS NULL THEN sce.student_id END) > 1;

-- 90) Retrieve the list of students who have submitted all the assignments for a particular course.
SELECT s.student_name, COUNT(ass.assignment_id)
FROM assignment_submission ass
INNER JOIN student_course_enrollment sce
ON sce.student_course_id = ass.student_course_id
INNER JOIN student s 
ON s.student_id = sce.student_id
GROUP BY s.student_id
HAVING COUNT(ass.assignment_id) = (
	SELECT COUNT(1)
    FROM assignment a
    INNER JOIN course_session cs
    ON cs.course_session_id = a.course_session_id
    WHERE cs.course_id = 1
);

-- 91) Retrieve the list of assignments that have not been graded yet for a particular course.
SELECT DISTINCT(a.assignment_id)
FROM assignment a
INNER JOIN assignment_submission ass
ON ass.assignment_id = a.assignment_id
INNER JOIN course_session cs
ON cs.course_session_id = a.course_session_id
WHERE ass.grading_status = 1 
AND cs.course_id = 1; 

-- 92) Retrieve the list of students who have not enrolled in any courses.
SELECT s.student_name
FROM student s
WHERE s.student_id NOT IN (
	SELECT sce.student_id
    FROM student_course_enrollment sce
);

-- 93) Retrieve the list of students who have submitted an assignment after the due date.
SELECT DISTINCT s.student_id, s.student_name
FROM assignment_submission ass
INNER JOIN assignment a
ON a.assignment_id = ass.assignment_id
INNER JOIN student_course_enrollment sce
ON sce.course_session_id = a.course_session_id
INNER JOIN student s
ON s.student_id = sce.student_id
WHERE ass.submit_date > a.due_date;

-- 94) Retrieve the list of courses that have more than 50 enrolled students.
SELECT c.course_name, COUNT(sce.student_id)
FROM student_course_enrollment sce
INNER JOIN course_session cs
ON sce.course_session_id = sce.course_session_id
INNER JOIN course c
ON c.course_id = cs.course_id
GROUP BY cs.course_id
HAVING COUNT(sce.student_id) > 50;

-- 95) Retrieve the list of students who have submitted an assignment for a particular course but have not received a grade yet.
SELECT s.student_name
FROM student s
INNER JOIN student_course_enrollment sce
ON sce.student_id = s.student_id
INNER JOIN assignment_submission ass
ON ass.student_course_id = sce.student_course_id
INNER JOIN course_session cs
ON cs.course_session_id = sce.course_session_id
WHERE ass.grade_point IS NULL
AND cs.course_id = 1
GROUP BY s.student_id;
