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

CREATE TABLE IF NOT EXISTS student_course (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id BIGINT,
    course_id BIGINT,
    term VARCHAR(32),
    UNIQUE KEY uk_student_course (student_id, course_id, term),
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

-- 初始测试数据
INSERT INTO college(name, code, description) VALUES ('计算机学院', 'CSE', '计算机科学与技术学院')
    ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO major(name, code, college_id, description)
SELECT '软件工程', 'SE', c.id, '软件工程专业'
FROM college c WHERE c.code='CSE'
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO clazz(name, major_id, grade, counselor)
SELECT '软件2201', m.id, 2022, '张老师'
FROM major m WHERE m.code='SE'
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO course(code, name, credit, assessment_method, category, nature)
VALUES ('C001', '高等数学', 4, '考试', '公共基础课', '必修')
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO teacher(teacher_no, name, title, hired_date, college_id, phone, email)
SELECT 'T001', '王老师', '讲师', '2022-09-01', c.id, '13800000000', 'teacher@example.com'
FROM college c WHERE c.code='CSE'
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO student(student_no, name, gender, birthday, class_id, phone, email, enrollment_date)
SELECT 'S001', '李学生', '男', '2003-09-01', cl.id, '13900000000', 'student@example.com', '2022-09-01'
FROM clazz cl WHERE cl.name='软件2201'
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO sys_user(username, password, role, name, phone)
VALUES ('admin', 'admin123', 'ADMIN', '管理员', '13000000000'),
       ('teacher1', '123456', 'TEACHER', '王老师', '13800000000'),
       ('student1', '123456', 'STUDENT', '李学生', '13900000000')
ON DUPLICATE KEY UPDATE password=VALUES(password);
