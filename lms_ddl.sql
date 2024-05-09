create schema lms;

use lms;

create table course (
    course_id int not null primary key,
    course_name varchar(50) null,
    course_desc varchar(300) null
);

create table instructor (
    instructor_id int not null primary key,
    instructor_name varchar(50) null
);

create table semester
(
    semester_id int         not null
        primary key,
    season_name varchar(10) null,
    start_date  date        null,
    end_date    date        null,
    year        year        null
);

create table course_session (
    course_session_id int not null primary key,
    instructor_id int not null,
    start_date date null,
    end_date date null,
    course_id int null,
    semester_id       int  null,
    constraint course_session_course_fk foreign key (course_id) references course (course_id),
    constraint course_session_instructor_fk foreign key (instructor_id) references instructor (instructor_id),
    constraint course_session_semester_fk foreign key (semester_id) references semester (semester_id)
);

create table assignment (
    assignment_id int not null primary key,
    course_session_id int not null,
    start_date datetime not null,
    due_date datetime not null,
    constraint assignment_course_session_fk foreign key (course_session_id) references course_session (course_session_id)
);

create table student (
    student_id int primary key,
    student_name varchar(50) null,
    sex char null -- F,M
);

create table student_course_enrollment (
    student_course_id int primary key,
    student_id int not null,
    course_session_id int not null,
    enroll_status int default 0 not null,
    -- 0: Enrolled, 1: Completed, 2: Dropped
    grading_status int default 0 null,
    -- 0: Not started Grading, 1: Grading In Progress, 2: Completed Grading, 3: Sent to Student
    grade_point int null,
    -- 0~100
    grade char null,
    -- A,B,C,D,F
    constraint student_course_enrollment_course_session_fk foreign key (course_session_id) references course_session (course_session_id),
    constraint student_course_enrollment_student_fk foreign key (student_id) references student (student_id)
);

create table assignment_submission (
    submission_id int not null primary key,
    student_course_id int not null,
    assignment_id int not null,
    submission varchar(255) null,
    submit_date datetime null,
    -- Submitted date only
    status int default 0 null,
    -- 0: Not Started, 1: In Progress, 2: Submitted
    grading_status int default 0 null,
    -- 0: Not started Grading, 1: Grading In Progress, 2: Completed Grading, 3: Sent to Student
    grade_point int default 0 null,
    -- 0~100
    grade char null,
    -- A,B,C,D,F
    constraint assignment_submission_assignment_fk foreign key (assignment_id) references assignment (assignment_id),
    constraint assignment_submission_student_course_enrollment_fk foreign key (student_course_id) references student_course_enrollment (student_course_id)
);