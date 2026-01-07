# 淮安大学教务系统

高校实习教务管理系统课程作业示例，采用 **Spring Boot 2.7 + MyBatis + MySQL + Lombok + Swagger/OpenAPI + Freemarker** 的后端，前端为 **Vue 3 + Vite + Element Plus**，前后端分离。

## 项目目标与范围
系统用于实现对高校学生、教师与教务的管理，核心能力包括：

### 1. 登录模块
- 角色登录验证：管理员、教师、学生
- 验证码校验
- 从数据库读取账号密码并验证，成功后进入对应角色页面

### 2. 管理员模块
a) 新生与新入职教师信息录入、查询、修改、删除（包含 int / 字符串 / 日期 / 图片等字段）

b) 学院 / 专业 / 班级信息统筹（增删改查，外键约束：班级 → 专业 → 学院）

c) 课程录入 + 不同学期专业培养计划管理（课程字段：学分、考核方式、课程分类、课程性质）

d) 教学任务分配：为教学计划分配课程教师（基础课 / 专业课分类），可查询历史分配

e) 上传专业及教师课表（学生与教师下载查看），主要考察文件上传/下载

### 3. 教师模块
a) 修改登录密码

b) 按学期查看教务分配（所授课程 / 班级）

c) 录入并查询成绩（分数合法性校验）

d) 下载某学期课表（与教师 ID 绑定）

e) 导出行政班点名册（Freemarker 模板生成，下载）

### 4. 学生模块
a) 修改登录密码

b) 查看成绩并打印成绩单

c) 下载新学期课表，学生自主选课（选做）

## 架构与技术栈

### 后端（Spring Boot）
- Spring Boot 2.7
- MyBatis + XML Mapper
- MySQL 8
- Lombok
- Springdoc OpenAPI
- Freemarker（点名册导出）

### 前端（Vue 3）
- Vue 3 + Vite
- vue-router
- axios
- Element Plus UI

## 项目结构
```
src/main/java/com/example/academicsystem
├── AcademicSystemApplication.java    # Spring Boot 启动类
├── config                            # Swagger、异常处理、CORS
├── controller                        # 管理员/教师/学生/登录接口
├── dto                               # 登录、改密、成绩提交请求
├── entity                            # 用户、学生、教师、课程、班级等实体
├── mapper                            # MyBatis Mapper 接口
├── service                           # 业务接口
├── service/impl                      # 业务实现
├── util                              # 响应包装、文件存储、点名册导出工具
└── uml                               # PlantUML 图（流程/时序/用例）

src/main/resources
├── application.yml                   # 数据源、MyBatis、Freemarker 配置
├── mapper                            # Mapper XML
├── templates/roster.ftl              # Freemarker 点名册模板
└── schema.sql                        # 建表 + 测试数据

fronted
├── src
│   ├── layouts                        # 管理员/教师/学生布局
│   ├── views                          # 登录页 + 业务页面
│   ├── api/http.js                    # axios 封装
│   ├── utils/auth.js                  # 登录态缓存
│   └── styles.css                     # 全局样式
└── vite.config.js
```

## 数据库初始化
1. 创建数据库并执行 `src/main/resources/schema.sql`。
2. 脚本已包含 `CREATE DATABASE IF NOT EXISTS academic_system; USE academic_system;`。
3. 该脚本包含大量真实测试数据（师生、课程、教学计划、选课与成绩）。

## 后端启动
```bash
mvn spring-boot:run
```
默认端口：`8080`

## 前端启动
```bash
cd fronted
npm install
npm run dev
```
默认访问：`http://localhost:5173/`

## API 文档
- `http://localhost:8080/swagger-ui.html`

> 说明：本项目为课程作业示例，业务逻辑已做简化，适合原型展示与扩展开发。
