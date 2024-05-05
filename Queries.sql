-- 1) Retrieve the list of all students who have enrolled in a specific course.

-- 2) Retrieve the average grade of a specific assignment across all students.

-- 3) Retrieve the list of all courses taken by a specific student.

-- 4) Retrieve the list of all instructors who teach a specific course.

-- 5) Retrieve the total number of students enrolled in a specific course.

-- 6) Retrieve the list of all assignments for a specific course.

-- 7) Retrieve the highest grade received by a specific student in a specific course.

-- 8) Retrieve the list of all students who have not completed a specific assignment.

-- 9) Retrieve the list of all courses that have more than 50 students enrolled.

-- 10) Retrieve the list of all students who have an overall grade average of 90% or higher.

-- 11) Retrieve the overall average grade for each course.

-- 12) Retrieve the average grade for each assignment in a specific course.

-- 13) Retrieve the number of students who have completed each assignment in a specific course.

-- 14) Retrieve the top 5 students with the highest overall grade average.

-- 15) Retrieve the instructor with the highest overall average grade for all courses they teach.

-- 16) Retrieve the list of students who have a grade of A in a specific course.

-- 17) Retrieve the list of courses that have no assignments.

-- 18) Retrieve the list of students who have the highest grade in a specific course.

-- 19) Retrieve the list of assignments that have the lowest average grade in a specific course.

-- 20) Retrieve the list of students who have not enrolled in any course.

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


-- 23) Retrieve the list of courses that have the highest average grade.

-- 24) Retrieve the list of assignments that have a grade average higher than the overall grade average.

-- 25) Retrieve the list of courses that have at least one student with a grade of F.

-- 26) Retrieve the list of students who have the same grade in all their courses.

-- 27) Retrieve the list of courses that have the same number of enrolled students.

-- 28) Retrieve the list of instructors who have taught all courses.

-- 29) Retrieve the list of assignments that have been graded but not returned to the students.

-- 30) Retrieve the list of courses that have an average grade higher than the overall grade average.

-- 31) Retrieve the list of students who have submitted all assignments for a specific course.

-- 32) Retrieve the list of courses that have at least one assignment that no student has submitted.

-- 33) Retrieve the list of students who have submitted the most assignments.

-- 34) Retrieve the list of courses that have the highest average grade among students who have
-- submitted all assignments.

-- 35) Retrieve the list of courses that have the highest average grade among students who have
-- submitted all assignments.

-- 36) Retrieve the list of courses with the highest number of enrollments.

-- 37) Retrieve the list of assignments that have the lowest submission rate.

-- 38) Retrieve the list of students who have the highest average grade for a specific course.

-- 39) Retrieve the list of courses with the highest percentage of students who have completed all
-- assignments.

-- 40) Retrieve the list of students who have not submitted any assignments for a specific course.

-- 41) Retrieve the list of courses with the lowest average grade.

-- 42) Retrieve the list of assignments that have the highest average grade.

-- 43) Retrieve the list of students who have the highest overall grade across all courses.

-- 44) Retrieve the list of assignments that have not been graded yet.

-- 45) Retrieve the list of courses that have not been assigned any assignments yet.

-- 46) Retrieve the list of students who have completed all assignments for a specific course.

-- 47) Retrieve the list of students who have submitted all assignments but have not received a passing
-- grade for a specific course.

-- 48) Retrieve the list of courses that have the highest percentage of students who have received a
-- passing grade.

-- 49) Retrieve the list of students who have submitted assignments late for a specific course.

-- 50) Retrieve the list of courses that have the highest percentage of students who have dropped
-- out.

-- 51) Retrieve the list of students who have not yet submitted any assignments for a specific
-- course.

-- 52) Retrieve the list of students who have submitted at least one assignment for a specific
-- course but have not completed all assignments.

-- 53) Retrieve the list of assignments that have received the highest average grade.

-- 54) Retrieve the list of students who have received the highest average grade across all
-- courses.

-- 55) Retrieve the list of courses that have the highest average grade.

-- 56) Retrieve the list of courses that have at least one student enrolled but no assignments
-- have been created yet.

-- 57) Retrieve the list of courses that have at least one assignment created but no student has
-- enrolled yet.

-- 58) Retrieve the list of students who have submitted all assignments for a specific course.

-- 59) Retrieve the list of courses where the overall average grade is higher than the average
-- grade of a specific student.

-- 60) Retrieve the list of students who have not yet submitted any assignments for any course.

-- 61) Retrieve the list of students who have completed all the courses they have enrolled in.

-- 62) Retrieve the list of courses where the average grade is lower than a specific threshold.

-- 63) Retrieve the list of courses where the number of students enrolled is less than a specific
-- threshold.

-- 64) Retrieve the list of students who have not completed a specific course but have submitted
-- all the assignments for that course.

-- 65) Retrieve the list of courses where the average grade is higher than the overall average
-- grade of all courses.

-- 66) Retrieve the list of courses where the average grade is higher than a specific threshold
-- and the number of students enrolled is greater than a specific threshold.

-- 67) Retrieve the list of students who have enrolled in at least two courses and have not
-- submitted any assignments in the past month.

-- 68) Retrieve the list of courses where the percentage of students who have submitted all the
-- assignments is higher than a specific threshold.

-- 69) Retrieve the list of students who have enrolled in a course but have not submitted any
-- assignments.

-- 70) Retrieve the list of courses where the percentage of students who have submitted at least
-- one assignment is lower than a specific threshold.

-- 71) Retrieve the list of students who have submitted an assignment after the due date.

-- 72) Retrieve the list of courses where the average grade of female students is higher than that
-- of male students.

-- 73) Retrieve the list of courses that have at least one female student and no male students.

-- 74) Retrieve the list of students who have submitted at least one assignment in all the courses
-- they are enrolled in.

-- 75) Retrieve the list of students who have not enrolled in any courses.

-- 76) Retrieve the list of courses that have the highest number of enrolled students.

-- 77) Retrieve the list of assignments that have the lowest average grade.

-- 78) Retrieve the list of students who have submitted all the assignments in a particular
-- course.

-- 79) Retrieve the list of courses where the average grade of all students is above 80.

-- 80) Retrieve the list of students who have the highest grade in each course.

-- 81) Retrieve the list of students who have submitted all the assignments on time.

-- 82) Retrieve the list of students who have submitted late submissions for any assignment.

-- 83) Retrieve the list of courses that have the lowest average grade for a particular semester.

-- 84) Retrieve the list of students who have not submitted any assignment for a particular
-- course.

-- 85) Retrieve the list of courses where the highest grade is less than 90.

-- 86) Retrieve the list of students who have submitted all the assignments, but their average
-- grade is less than 70.

-- 87) Retrieve the list of courses that have at least one student with an average grade of 90 or
-- above.

-- 88) Retrieve the list of students who have not submitted any assignments for any of their
-- enrolled courses.

-- 89) Retrieve the list of courses that have at least one student who has not submitted any
-- assignments.

-- 90) Retrieve the list of students who have submitted all the assignments for a particular
-- course.

-- 91) Retrieve the list of assignments that have not been graded yet for a particular course.

-- 92) Retrieve the list of students who have not enrolled in any courses.

-- 93) Retrieve the list of students who have submitted an assignment after the due date.

-- 94) Retrieve the list of courses that have more than 50 enrolled students.

-- 95) Retrieve the list of students who have submitted an assignment for a particular course but
-- have not received a grade yet.
