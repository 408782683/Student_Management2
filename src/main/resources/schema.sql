CREATE DATABASE IF NOT EXISTS academic_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE academic_system;

CREATE TABLE IF NOT EXISTS sys_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(64) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,
    role VARCHAR(16) NOT NULL,
    name VARCHAR(64),
    phone VARCHAR(32),
    active TINYINT DEFAULT 1,
    student_id BIGINT NULL,
    teacher_id BIGINT NULL,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
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

-- 初始测试数据（每表至少30条）
INSERT INTO college (id, name, code, description) VALUES
 (1,'计算机学院','CSE','计算机科学与技术学院'),
 (2,'机电学院','MEC','机械与电子工程学院'),
 (3,'管理学院','MAN','管理与经济学院'),
 (4,'文法学院','LAW','人文与法律学院'),
 (5,'外国语学院','ENG','外国语学院'),
 (6,'艺术学院','ART','艺术设计学院'),
 (7,'体育学院','PE','体育学院'),
 (8,'医学部','MED','医学部'),
 (9,'材料学院','MAT','材料科学与工程学院'),
 (10,'能源学院','ENE','能源与动力学院'),
 (11,'自动化学院','AUT','自动化学院'),
 (12,'数学学院','MATH','数学学院'),
 (13,'物理学院','PHY','物理学院'),
 (14,'化学学院','CHEM','化学学院'),
 (15,'环境学院','ENV','环境科学学院'),
 (16,'交通学院','TRA','交通工程学院'),
 (17,'建筑学院','ARC','建筑学院'),
 (18,'农学院','AGR','农业与生物'),
 (19,'海洋学院','SEA','海洋科学'),
 (20,'信息学院','INF','信息科学'),
 (21,'数据学院','DS','数据科学'),
 (22,'软件学院','SWE','软件学院'),
 (23,'航天学院','AERO','航空航天'),
 (24,'地球学院','EAR','地球科学'),
 (25,'心理学院','PSY','心理学'),
 (26,'教育学院','EDU','教育科学'),
 (27,'新闻学院','JOU','新闻传播'),
 (28,'公管学院','PUB','公共管理'),
 (29,'金融学院','FIN','金融学院'),
 (30,'生命学院','BIO','生命科学');

INSERT INTO major (id, name, code, college_id, description) VALUES
 (1,'软件工程','SE01',1,'软件工程方向'),
 (2,'计算机科学','CS01',1,'计算机科学与技术'),
 (3,'网络工程','NE01',1,'网络工程'),
 (4,'人工智能','AI01',1,'人工智能'),
 (5,'大数据','BD01',21,'大数据技术'),
 (6,'机械设计','MEC01',2,'机械设计制造'),
 (7,'机械电子','MEC02',2,'机电一体化'),
 (8,'工业设计','MEC03',2,'工业设计'),
 (9,'工商管理','MAN01',3,'工商管理'),
 (10,'市场营销','MAN02',3,'市场营销'),
 (11,'法律','LAW01',4,'法学'),
 (12,'汉语言文学','HUM01',4,'汉语言'),
 (13,'英语','ENG01',5,'英语'),
 (14,'日语','ENG02',5,'日语'),
 (15,'视觉传达','ART01',6,'视觉传达'),
 (16,'环境设计','ART02',6,'环境设计'),
 (17,'体育教育','PE01',7,'体育教育'),
 (18,'运动训练','PE02',7,'运动训练'),
 (19,'临床医学','MED01',8,'临床医学'),
 (20,'护理学','MED02',8,'护理'),
 (21,'材料科学','MAT01',9,'材料科学'),
 (22,'能源动力','ENE01',10,'能源动力'),
 (23,'自动化','AUT01',11,'自动化'),
 (24,'数学与应用数学','MATH01',12,'数学'),
 (25,'物理学','PHY01',13,'物理学'),
 (26,'化学','CHEM01',14,'化学'),
 (27,'环境工程','ENV01',15,'环境工程'),
 (28,'交通工程','TRA01',16,'交通工程'),
 (29,'建筑学','ARC01',17,'建筑学'),
 (30,'金融学','FIN01',29,'金融学');

INSERT INTO clazz (id, name, major_id, grade, counselor) VALUES
 (1,'软件2201',1,2022,'张老师'),(2,'软件2202',1,2022,'张老师'),(3,'计科2201',2,2022,'李老师'),
 (4,'计科2202',2,2022,'李老师'),(5,'网工2201',3,2022,'王老师'),(6,'网工2202',3,2022,'王老师'),
 (7,'人工智能2201',4,2022,'刘老师'),(8,'人工智能2202',4,2022,'刘老师'),
 (9,'大数据2201',5,2022,'赵老师'),(10,'机械2201',6,2022,'钱老师'),(11,'机电2201',7,2022,'孙老师'),
 (12,'工设2201',8,2022,'周老师'),(13,'管院2201',9,2022,'吴老师'),(14,'营销2201',10,2022,'郑老师'),
 (15,'法学2201',11,2022,'何老师'),(16,'汉语2201',12,2022,'杨老师'),(17,'英语2201',13,2022,'谢老师'),
 (18,'日语2201',14,2022,'蔡老师'),(19,'视觉2201',15,2022,'宋老师'),(20,'环设2201',16,2022,'许老师'),
 (21,'体教2201',17,2022,'韩老师'),(22,'训练2201',18,2022,'唐老师'),(23,'临床2201',19,2022,'冯老师'),
 (24,'护理2201',20,2022,'袁老师'),(25,'材料2201',21,2022,'于老师'),(26,'能源2201',22,2022,'谢老师'),
 (27,'自动化2201',23,2022,'范老师'),(28,'数学2201',24,2022,'鲁老师'),(29,'物理2201',25,2022,'韦老师'),
 (30,'金融2201',30,2022,'葛老师');

INSERT INTO course (id, code, name, credit, assessment_method, category, nature) VALUES
 (1,'C001','高等数学',4,'考试','公共基础课','必修'),
 (2,'C002','线性代数',3,'考试','公共基础课','必修'),
 (3,'C003','大学英语',3,'考试','公共基础课','必修'),
 (4,'C004','数据结构',4,'考试','专业必修','必修'),
 (5,'C005','操作系统',4,'考试','专业必修','必修'),
 (6,'C006','计算机网络',4,'考试','专业必修','必修'),
 (7,'C007','数据库系统',4,'考试','专业必修','必修'),
 (8,'C008','软件工程导论',3,'考试','专业必修','必修'),
 (9,'C009','Web开发',3,'考查','专业选修','选修'),
 (10,'C010','机器学习',3,'考试','专业选修','选修'),
 (11,'C011','嵌入式系统',3,'考查','专业选修','选修'),
 (12,'C012','编译原理',4,'考试','专业必修','必修'),
 (13,'C013','数字电路',3,'考试','专业必修','必修'),
 (14,'C014','大学物理',3,'考试','公共基础课','必修'),
 (15,'C015','概率论',3,'考试','公共基础课','必修'),
 (16,'C016','马克思主义原理',3,'考查','公共基础课','必修'),
 (17,'C017','离散数学',3,'考试','专业必修','必修'),
 (18,'C018','C语言程序设计',3,'考试','公共基础课','必修'),
 (19,'C019','Java程序设计',3,'考试','专业必修','必修'),
 (20,'C020','Python数据分析',3,'考查','专业选修','选修'),
 (21,'C021','移动开发',3,'考查','专业选修','选修'),
 (22,'C022','信息安全导论',3,'考试','专业选修','选修'),
 (23,'C023','云计算',3,'考查','专业选修','选修'),
 (24,'C024','大数据平台',3,'考查','专业选修','选修'),
 (25,'C025','人工智能伦理',2,'考查','通识课','选修'),
 (26,'C026','项目管理',2,'考查','通识课','选修'),
 (27,'C027','创新创业',2,'考查','通识课','选修'),
 (28,'C028','UI/UX设计',2,'考查','专业选修','选修'),
 (29,'C029','算法设计',3,'考试','专业必修','必修'),
 (30,'C030','软件测试',3,'考查','专业必修','必修');

INSERT INTO teacher (id, teacher_no, name, title, hired_date, college_id, photo_url, phone, email) VALUES
 (1,'T001','王老师','讲师','2021-09-01',1,NULL,'13800000001','t001@example.com'),
 (2,'T002','李老师','副教授','2020-09-01',1,NULL,'13800000002','t002@example.com'),
 (3,'T003','张老师','教授','2019-09-01',2,NULL,'13800000003','t003@example.com'),
 (4,'T004','刘老师','讲师','2022-09-01',3,NULL,'13800000004','t004@example.com'),
 (5,'T005','赵老师','讲师','2021-09-01',4,NULL,'13800000005','t005@example.com'),
 (6,'T006','钱老师','副教授','2018-09-01',5,NULL,'13800000006','t006@example.com'),
 (7,'T007','孙老师','讲师','2022-09-01',6,NULL,'13800000007','t007@example.com'),
 (8,'T008','周老师','副教授','2017-09-01',7,NULL,'13800000008','t008@example.com'),
 (9,'T009','吴老师','讲师','2021-09-01',8,NULL,'13800000009','t009@example.com'),
 (10,'T010','郑老师','讲师','2021-09-01',9,NULL,'13800000010','t010@example.com'),
 (11,'T011','冯老师','副教授','2016-09-01',10,NULL,'13800000011','t011@example.com'),
 (12,'T012','陈老师','讲师','2022-09-01',11,NULL,'13800000012','t012@example.com'),
 (13,'T013','褚老师','副教授','2015-09-01',12,NULL,'13800000013','t013@example.com'),
 (14,'T014','卫老师','讲师','2020-09-01',13,NULL,'13800000014','t014@example.com'),
 (15,'T015','蒋老师','讲师','2021-09-01',14,NULL,'13800000015','t015@example.com'),
 (16,'T016','沈老师','副教授','2018-09-01',15,NULL,'13800000016','t016@example.com'),
 (17,'T017','韩老师','讲师','2021-09-01',16,NULL,'13800000017','t017@example.com'),
 (18,'T018','杨老师','讲师','2021-09-01',17,NULL,'13800000018','t018@example.com'),
 (19,'T019','朱老师','讲师','2021-09-01',18,NULL,'13800000019','t019@example.com'),
 (20,'T020','秦老师','副教授','2019-09-01',19,NULL,'13800000020','t020@example.com'),
 (21,'T021','尤老师','讲师','2022-09-01',20,NULL,'13800000021','t021@example.com'),
 (22,'T022','许老师','讲师','2022-09-01',21,NULL,'13800000022','t022@example.com'),
 (23,'T023','何老师','副教授','2017-09-01',22,NULL,'13800000023','t023@example.com'),
 (24,'T024','吕老师','讲师','2021-09-01',23,NULL,'13800000024','t024@example.com'),
 (25,'T025','施老师','讲师','2021-09-01',24,NULL,'13800000025','t025@example.com'),
 (26,'T026','张三','讲师','2021-09-01',25,NULL,'13800000026','t026@example.com'),
 (27,'T027','李四','讲师','2021-09-01',26,NULL,'13800000027','t027@example.com'),
 (28,'T028','王五','讲师','2021-09-01',27,NULL,'13800000028','t028@example.com'),
 (29,'T029','赵六','讲师','2021-09-01',28,NULL,'13800000029','t029@example.com'),
 (30,'T030','钱七','讲师','2021-09-01',29,NULL,'13800000030','t030@example.com');

INSERT INTO student (id, student_no, name, gender, birthday, class_id, photo_url, phone, email, enrollment_date) VALUES
 (1,'S001','李学生','男','2003-09-01',1,NULL,'13900000001','s001@example.com','2022-09-01'),
 (2,'S002','王同学','女','2003-08-21',2,NULL,'13900000002','s002@example.com','2022-09-01'),
 (3,'S003','张同学','男','2003-07-15',3,NULL,'13900000003','s003@example.com','2022-09-01'),
 (4,'S004','刘同学','女','2003-06-13',4,NULL,'13900000004','s004@example.com','2022-09-01'),
 (5,'S005','赵同学','男','2003-05-12',5,NULL,'13900000005','s005@example.com','2022-09-01'),
 (6,'S006','钱同学','女','2003-04-11',6,NULL,'13900000006','s006@example.com','2022-09-01'),
 (7,'S007','孙同学','男','2003-03-10',7,NULL,'13900000007','s007@example.com','2022-09-01'),
 (8,'S008','周同学','女','2003-02-09',8,NULL,'13900000008','s008@example.com','2022-09-01'),
 (9,'S009','吴同学','男','2003-01-08',9,NULL,'13900000009','s009@example.com','2022-09-01'),
 (10,'S010','郑同学','女','2003-02-07',10,NULL,'13900000010','s010@example.com','2022-09-01'),
 (11,'S011','冯同学','男','2003-03-06',11,NULL,'13900000011','s011@example.com','2022-09-01'),
 (12,'S012','陈同学','女','2003-04-05',12,NULL,'13900000012','s012@example.com','2022-09-01'),
 (13,'S013','褚同学','男','2003-05-04',13,NULL,'13900000013','s013@example.com','2022-09-01'),
 (14,'S014','卫同学','女','2003-06-03',14,NULL,'13900000014','s014@example.com','2022-09-01'),
 (15,'S015','蒋同学','男','2003-07-02',15,NULL,'13900000015','s015@example.com','2022-09-01'),
 (16,'S016','沈同学','女','2003-08-01',16,NULL,'13900000016','s016@example.com','2022-09-01'),
 (17,'S017','韩同学','男','2003-09-01',17,NULL,'13900000017','s017@example.com','2022-09-01'),
 (18,'S018','杨同学','女','2003-10-01',18,NULL,'13900000018','s018@example.com','2022-09-01'),
 (19,'S019','朱同学','男','2003-11-01',19,NULL,'13900000019','s019@example.com','2022-09-01'),
 (20,'S020','秦同学','女','2003-12-01',20,NULL,'13900000020','s020@example.com','2022-09-01'),
 (21,'S021','尤同学','男','2003-11-11',21,NULL,'13900000021','s021@example.com','2022-09-01'),
 (22,'S022','许同学','女','2003-10-10',22,NULL,'13900000022','s022@example.com','2022-09-01'),
 (23,'S023','何同学','男','2003-09-09',23,NULL,'13900000023','s023@example.com','2022-09-01'),
 (24,'S024','吕同学','女','2003-08-08',24,NULL,'13900000024','s024@example.com','2022-09-01'),
 (25,'S025','施同学','男','2003-07-07',25,NULL,'13900000025','s025@example.com','2022-09-01'),
 (26,'S026','张晓','女','2003-06-06',26,NULL,'13900000026','s026@example.com','2022-09-01'),
 (27,'S027','李华','男','2003-05-05',27,NULL,'13900000027','s027@example.com','2022-09-01'),
 (28,'S028','王芳','女','2003-04-04',28,NULL,'13900000028','s028@example.com','2022-09-01'),
 (29,'S029','赵强','男','2003-03-03',29,NULL,'13900000029','s029@example.com','2022-09-01'),
 (30,'S030','钱丽','女','2003-02-02',30,NULL,'13900000030','s030@example.com','2022-09-01');

INSERT INTO term_plan (id, term, major_id, course_id) VALUES
 (1,'2024-2025-1',1,1),(2,'2024-2025-1',2,2),(3,'2024-2025-1',3,3),(4,'2024-2025-1',4,4),
 (5,'2024-2025-1',5,5),(6,'2024-2025-1',6,6),(7,'2024-2025-1',7,7),(8,'2024-2025-1',8,8),
 (9,'2024-2025-1',9,9),(10,'2024-2025-1',10,10),(11,'2024-2025-1',11,11),(12,'2024-2025-1',12,12),
 (13,'2024-2025-1',13,13),(14,'2024-2025-1',14,14),(15,'2024-2025-1',15,15),(16,'2024-2025-1',16,16),
 (17,'2024-2025-1',17,17),(18,'2024-2025-1',18,18),(19,'2024-2025-1',19,19),(20,'2024-2025-1',20,20),
 (21,'2024-2025-1',21,21),(22,'2024-2025-1',22,22),(23,'2024-2025-1',23,23),(24,'2024-2025-1',24,24),
 (25,'2024-2025-1',25,25),(26,'2024-2025-1',26,26),(27,'2024-2025-1',27,27),(28,'2024-2025-1',28,28),
 (29,'2024-2025-1',29,29),(30,'2024-2025-1',30,30);

INSERT INTO teaching_assignment (id, term_plan_id, teacher_id, course_type, remarks) VALUES
 (1,1,1,'基础课','无'),(2,2,2,'基础课','无'),(3,3,3,'专业课','无'),(4,4,4,'专业课','无'),
 (5,5,5,'基础课','无'),(6,6,6,'专业课','无'),(7,7,7,'专业课','无'),(8,8,8,'专业课','无'),
 (9,9,9,'基础课','无'),(10,10,10,'专业课','无'),(11,11,11,'基础课','无'),(12,12,12,'专业课','无'),
 (13,13,13,'基础课','无'),(14,14,14,'基础课','无'),(15,15,15,'基础课','无'),(16,16,16,'专业课','无'),
 (17,17,17,'基础课','无'),(18,18,18,'基础课','无'),(19,19,19,'基础课','无'),(20,20,20,'基础课','无'),
 (21,21,21,'基础课','无'),(22,22,22,'基础课','无'),(23,23,23,'基础课','无'),(24,24,24,'基础课','无'),
 (25,25,25,'基础课','无'),(26,26,26,'基础课','无'),(27,27,27,'基础课','无'),(28,28,28,'基础课','无'),
 (29,29,29,'基础课','无'),(30,30,30,'基础课','无');

INSERT INTO grade_record (id, student_id, course_id, term, score) VALUES
 (1,1,1,'2024-2025-1',88),(2,2,2,'2024-2025-1',90),(3,3,3,'2024-2025-1',86),(4,4,4,'2024-2025-1',92),
 (5,5,5,'2024-2025-1',81),(6,6,6,'2024-2025-1',77),(7,7,7,'2024-2025-1',89),(8,8,8,'2024-2025-1',93),
 (9,9,9,'2024-2025-1',85),(10,10,10,'2024-2025-1',79),(11,11,11,'2024-2025-1',88),(12,12,12,'2024-2025-1',90),
 (13,13,13,'2024-2025-1',92),(14,14,14,'2024-2025-1',95),(15,15,15,'2024-2025-1',80),(16,16,16,'2024-2025-1',83),
 (17,17,17,'2024-2025-1',91),(18,18,18,'2024-2025-1',84),(19,19,19,'2024-2025-1',87),(20,20,20,'2024-2025-1',82),
 (21,21,21,'2024-2025-1',89),(22,22,22,'2024-2025-1',85),(23,23,23,'2024-2025-1',90),(24,24,24,'2024-2025-1',88),
 (25,25,25,'2024-2025-1',91),(26,26,26,'2024-2025-1',86),(27,27,27,'2024-2025-1',84),(28,28,28,'2024-2025-1',92),
 (29,29,29,'2024-2025-1',90),(30,30,30,'2024-2025-1',87);

INSERT INTO timetable (id, owner_type, owner_id, term, file_name, file_url) VALUES
 (1,'MAJOR',1,'2024-2025-1','major1.xlsx','/uploads/major1.xlsx'),
 (2,'MAJOR',2,'2024-2025-1','major2.xlsx','/uploads/major2.xlsx'),
 (3,'MAJOR',3,'2024-2025-1','major3.xlsx','/uploads/major3.xlsx'),
 (4,'MAJOR',4,'2024-2025-1','major4.xlsx','/uploads/major4.xlsx'),
 (5,'MAJOR',5,'2024-2025-1','major5.xlsx','/uploads/major5.xlsx'),
 (6,'TEACHER',1,'2024-2025-1','teacher1.xlsx','/uploads/teacher1.xlsx'),
 (7,'TEACHER',2,'2024-2025-1','teacher2.xlsx','/uploads/teacher2.xlsx'),
 (8,'TEACHER',3,'2024-2025-1','teacher3.xlsx','/uploads/teacher3.xlsx'),
 (9,'TEACHER',4,'2024-2025-1','teacher4.xlsx','/uploads/teacher4.xlsx'),
 (10,'TEACHER',5,'2024-2025-1','teacher5.xlsx','/uploads/teacher5.xlsx'),
 (11,'STUDENT',1,'2024-2025-1','student1.xlsx','/uploads/student1.xlsx'),
 (12,'STUDENT',2,'2024-2025-1','student2.xlsx','/uploads/student2.xlsx'),
 (13,'STUDENT',3,'2024-2025-1','student3.xlsx','/uploads/student3.xlsx'),
 (14,'STUDENT',4,'2024-2025-1','student4.xlsx','/uploads/student4.xlsx'),
 (15,'STUDENT',5,'2024-2025-1','student5.xlsx','/uploads/student5.xlsx'),
 (16,'MAJOR',6,'2024-2025-1','major6.xlsx','/uploads/major6.xlsx'),
 (17,'MAJOR',7,'2024-2025-1','major7.xlsx','/uploads/major7.xlsx'),
 (18,'MAJOR',8,'2024-2025-1','major8.xlsx','/uploads/major8.xlsx'),
 (19,'MAJOR',9,'2024-2025-1','major9.xlsx','/uploads/major9.xlsx'),
 (20,'MAJOR',10,'2024-2025-1','major10.xlsx','/uploads/major10.xlsx'),
 (21,'TEACHER',6,'2024-2025-1','teacher6.xlsx','/uploads/teacher6.xlsx'),
 (22,'TEACHER',7,'2024-2025-1','teacher7.xlsx','/uploads/teacher7.xlsx'),
 (23,'TEACHER',8,'2024-2025-1','teacher8.xlsx','/uploads/teacher8.xlsx'),
 (24,'TEACHER',9,'2024-2025-1','teacher9.xlsx','/uploads/teacher9.xlsx'),
 (25,'TEACHER',10,'2024-2025-1','teacher10.xlsx','/uploads/teacher10.xlsx'),
 (26,'STUDENT',6,'2024-2025-1','student6.xlsx','/uploads/student6.xlsx'),
 (27,'STUDENT',7,'2024-2025-1','student7.xlsx','/uploads/student7.xlsx'),
 (28,'STUDENT',8,'2024-2025-1','student8.xlsx','/uploads/student8.xlsx'),
 (29,'STUDENT',9,'2024-2025-1','student9.xlsx','/uploads/student9.xlsx'),
 (30,'STUDENT',10,'2024-2025-1','student10.xlsx','/uploads/student10.xlsx');

INSERT INTO student_course (id, student_id, course_id, term) VALUES
 (1,1,1,'2024-2025-1'),(2,2,2,'2024-2025-1'),(3,3,3,'2024-2025-1'),(4,4,4,'2024-2025-1'),(5,5,5,'2024-2025-1'),
 (6,6,6,'2024-2025-1'),(7,7,7,'2024-2025-1'),(8,8,8,'2024-2025-1'),(9,9,9,'2024-2025-1'),(10,10,10,'2024-2025-1'),
 (11,11,11,'2024-2025-1'),(12,12,12,'2024-2025-1'),(13,13,13,'2024-2025-1'),(14,14,14,'2024-2025-1'),(15,15,15,'2024-2025-1'),
 (16,16,16,'2024-2025-1'),(17,17,17,'2024-2025-1'),(18,18,18,'2024-2025-1'),(19,19,19,'2024-2025-1'),(20,20,20,'2024-2025-1'),
 (21,21,21,'2024-2025-1'),(22,22,22,'2024-2025-1'),(23,23,23,'2024-2025-1'),(24,24,24,'2024-2025-1'),(25,25,25,'2024-2025-1'),
 (26,26,26,'2024-2025-1'),(27,27,27,'2024-2025-1'),(28,28,28,'2024-2025-1'),(29,29,29,'2024-2025-1'),(30,30,30,'2024-2025-1');

INSERT INTO sys_user (id, username, password, role, name, phone, active, student_id, teacher_id) VALUES
 (1,'admin','admin123','ADMIN','管理员1','13000000001',1,NULL,NULL),(2,'admin2','admin123','ADMIN','管理员2','13000000002',1,NULL,NULL),
 (3,'admin3','admin123','ADMIN','管理员3','13000000003',1),(4,'admin4','admin123','ADMIN','管理员4','13000000004',1),
 (5,'admin5','admin123','ADMIN','管理员5','13000000005',1),(6,'admin6','admin123','ADMIN','管理员6','13000000006',1),
 (7,'admin7','admin123','ADMIN','管理员7','13000000007',1),(8,'admin8','admin123','ADMIN','管理员8','13000000008',1),
 (9,'admin9','admin123','ADMIN','管理员9','13000000009',1),(10,'admin10','admin123','ADMIN','管理员10','13000000010',1),
 (11,'teacher1','123456','TEACHER','王老师','13800000001',1,NULL,1),(12,'teacher2','123456','TEACHER','李老师','13800000002',1,NULL,2),
 (13,'teacher3','123456','TEACHER','张老师','13800000003',1,NULL,3),(14,'teacher4','123456','TEACHER','刘老师','13800000004',1,NULL,4),
 (15,'teacher5','123456','TEACHER','赵老师','13800000005',1,NULL,5),(16,'teacher6','123456','TEACHER','钱老师','13800000006',1,NULL,6),
 (17,'teacher7','123456','TEACHER','孙老师','13800000007',1,NULL,7),(18,'teacher8','123456','TEACHER','周老师','13800000008',1,NULL,8),
 (19,'teacher9','123456','TEACHER','吴老师','13800000009',1,NULL,9),(20,'teacher10','123456','TEACHER','郑老师','13800000010',1,NULL,10),
 (21,'student1','123456','STUDENT','李学生','13900000001',1,1,NULL),(22,'student2','123456','STUDENT','王同学','13900000002',1,2,NULL),
 (23,'student3','123456','STUDENT','张同学','13900000003',1,3,NULL),(24,'student4','123456','STUDENT','刘同学','13900000004',1,4,NULL),
 (25,'student5','123456','STUDENT','赵同学','13900000005',1,5,NULL),(26,'student6','123456','STUDENT','钱同学','13900000006',1,6,NULL),
 (27,'student7','123456','STUDENT','孙同学','13900000007',1,7,NULL),(28,'student8','123456','STUDENT','周同学','13900000008',1,8,NULL),
 (29,'student9','123456','STUDENT','吴同学','13900000009',1,9,NULL),(30,'student10','123456','STUDENT','郑同学','13900000010',1,10,NULL);
