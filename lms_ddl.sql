create table course
(
    course_id   int not null
        primary key,
    course_name int null,
    credits     int null, 
    course_desc int null
);

create table instuctor
(
    instructor_id   int         not null
        primary key,
    instructor_name varchar(50) null
);

create table course_session
(
    course_session_id int         not null
        primary key,
    instructor_id     int         null,
    start_date        date        null,
    end_date          date        null,
    days_time         varchar(20) null, -- ‘MWF 9am-9.50am’ or ‘TR 3.30pm-5.20pm’
    course_id         int         null,
    constraint course_session_course_course_id_fk
        foreign key (course_id) references course (course_id),
    constraint instructor_section___fk
        foreign key (instructor_id) references instuctor (instructor_id)
);

create table assignment
(
    assignment_id int      not null
        primary key,
    course_id     int      null,
    start_date    datetime null,
    due_date      datetime null,
    constraint course_assignment___fk
        foreign key (course_id) references course_session (course_session_id)
);

create table student
(
    student_id    int auto_increment
        primary key,
    student_name  varchar(50)  null,
    sex           char         null, --F,M
    address       varchar(200) null,
    phone         varchar(20)  null,
    major         varchar(5)   null,
    date_of_birth date         null,
    constraint student_pk
        unique (student_id)
);

create table student_course_enrollment
(
    student_course_id int auto_increment
        primary key,
    student_id        int  null,
    course_id         int  null,
    grade_point       int  null, -- 0~100
    grade             char null, -- A,B,C,D,F
    constraint student_course_enrollment_course_id_fk
        foreign key (course_id) references course_session (course_session_id),
    constraint student_course_enrollment_student_s_id_fk
        foreign key (student_id) references student (student_id)
);

create table assignment_submission
(
    submission_id     int           not null
        primary key,
    student_course_id int           null,
    assignment_id     int           null,
    submission        varchar(255)  null,
    submit_date       datetime      null, -- Submitted date only
    status            int default 0 null, -- 0: Not Started, 1: Started, 2: Submitted
    grading_status    int default 0 null, -- 0: Not started Grading, 1: Started Grading, 2: Completed Grading, 3: Sent to Students
    grade_point       int default 0 null, -- 0~100
    grade             char          null, -- A,B,C,D,F
    constraint assignment_course_student_assignment___fk
        foreign key (assignment_id) references assignment (assignment_id),
    constraint sce_course_student_assignment___fk
        foreign key (student_course_id) references student_course_enrollment (student_course_id)
);


