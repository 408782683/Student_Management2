# 高校实习教务管理系统（后端示例）

基于 Spring Boot 2.7 + MyBatis + MySQL + Lombok + Swagger/OpenAPI 的后端示例，满足课程作业中对登录、管理员、教师、学生模块的基本要求，前后端分离，前端可自行开发对接。

## 项目结构
```
src/main/java/com/example/academicsystem
├── AcademicSystemApplication.java    # Spring Boot 启动类
├── config                            # Swagger、异常处理等基础配置
├── controller                        # 管理员/教师/学生/登录接口
├── dto                               # 登录、改密、成绩提交请求对象
├── entity                            # 业务实体（用户、学生、教师、学院、课程等）
├── mapper                            # MyBatis Mapper 接口
├── service                           # 业务接口
├── service/impl                      # 业务实现
└── util                              # 响应包装、文件存储、点名册导出工具

src/main/resources
├── application.yml                   # 数据源、MyBatis、Freemarker 配置
├── mapper                            # Mapper XML
├── templates/roster.ftl              # Freemarker 点名册模板
└── schema.sql                        # 简易建表脚本（含外键约束）
```

## 主要特性
- **登录模块**：按角色登录、验证码校验（内存缓存）。
- **管理员模块**：师生信息、学院/专业/班级、课程、培养计划、教学任务、课表上传/查询等基础 CRUD。
- **教师模块**：改密、教学任务查询、成绩录入与校验、课表获取、点名册（Freemarker 模板）导出。
- **学生模块**：改密、成绩查询、课表获取、自主选课。
- **文件上传**：使用本地 `uploads/` 目录存储（可换为对象存储），课表上传返回文件路径。
- **API 文档**：集成 springdoc-openapi，启动后访问 `/swagger-ui.html`。

## 启动与数据库
1. 创建数据库并执行 `src/main/resources/schema.sql`（已包含 `CREATE DATABASE IF NOT EXISTS academic_system; USE academic_system;`），以初始化表结构和示例数据。
2. 根据实际 MySQL 账号修改 `application.yml` 中的数据源配置。
3. 运行 `mvn spring-boot:run`（或在 IDE 中直接启动 `AcademicSystemApplication`）。

> 说明：示例中密码校验与业务逻辑采用简化实现，适合课程作业和原型演示，可按实际需求扩展完善。

## 前端（fronted）
- 目录：`/fronted`，使用 Vue 3 + Vite + axios + vue-router。
- 运行：`cd fronted && npm install && npm run dev`，默认代理 `/api` 到 `http://localhost:8080`，可直接对接后端。
- 页面：登录、管理员（课程维护/课表上传）、教师（教学任务查询/成绩录入/课表查看）、学生（成绩与课表查询）。
