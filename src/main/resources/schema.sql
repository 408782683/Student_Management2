CREATE TABLE IF NOT EXISTS sys_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(64) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,
    role VARCHAR(16) NOT NULL,
    name VARCHAR(64),
    phone VARCHAR(32),
    active TINYINT DEFAULT 1
);

CREATE TABLE IF NOT EXISTS college (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64),
    code VARCHAR(32),
    description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS major (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64),
    code VARCHAR(32),
    college_id BIGINT,
    description VARCHAR(255),
    FOREIGN KEY (college_id) REFERENCES college(id)
);

CREATE TABLE IF NOT EXISTS clazz (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64),
    major_id BIGINT,
    grade INT,
    counselor VARCHAR(64),
    FOREIGN KEY (major_id) REFERENCES major(id)
);

CREATE TABLE IF NOT EXISTS student (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_no VARCHAR(64),
    name VARCHAR(64),
    gender VARCHAR(8),
    birthday DATE,
    class_id BIGINT,
    photo_url VARCHAR(255),
    phone VARCHAR(32),
    email VARCHAR(64),
    enrollment_date DATE,
    FOREIGN KEY (class_id) REFERENCES clazz(id)
);

CREATE TABLE IF NOT EXISTS teacher (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    teacher_no VARCHAR(64),
    name VARCHAR(64),
    title VARCHAR(64),
    hired_date DATE,
    college_id BIGINT,
    photo_url VARCHAR(255),
    phone VARCHAR(32),
    email VARCHAR(64),
    FOREIGN KEY (college_id) REFERENCES college(id)
);

CREATE TABLE IF NOT EXISTS course (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(64),
    name VARCHAR(128),
    credit DOUBLE,
    assessment_method VARCHAR(64),
    category VARCHAR(64),
    nature VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS term_plan (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    term VARCHAR(32),
    major_id BIGINT,
    course_id BIGINT,
    FOREIGN KEY (major_id) REFERENCES major(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE IF NOT EXISTS teaching_assignment (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    term_plan_id BIGINT,
    teacher_id BIGINT,
    course_type VARCHAR(64),
    remarks VARCHAR(255),
    FOREIGN KEY (term_plan_id) REFERENCES term_plan(id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
);

CREATE TABLE IF NOT EXISTS grade_record (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id BIGINT,
    course_id BIGINT,
    term VARCHAR(32),
    score DOUBLE,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE IF NOT EXISTS timetable (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    owner_type VARCHAR(16),
    owner_id BIGINT,
    term VARCHAR(32),
    file_name VARCHAR(255),
    file_url VARCHAR(255)
);
