# fronted - Vue 3 前端示例

使用 Vite + Vue 3 搭建的简单前端，便于对接后端接口（端口 8080）。

## 开发
```bash
cd fronted
npm install
npm run dev
```

Vite 代理已配置 `/api` -> `http://localhost:8080`，无需额外跨域配置。

## 页面
- `/` 登录（获取验证码并调用登录接口）
- `/admin` 管理员演示：课程维护、课表上传
- `/teacher` 教师演示：教学任务查询、成绩录入、课表查看
- `/student` 学生成绩与课表查询

可按课程作业需求自行扩展样式、表单和数据校验。
