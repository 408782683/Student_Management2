import { createRouter, createWebHistory } from 'vue-router';
import Login from '../views/Login.vue';
import AdminLogin from '../views/AdminLogin.vue';
import TeacherLogin from '../views/TeacherLogin.vue';
import AdminDashboard from '../views/AdminDashboard.vue';
import TeacherDashboard from '../views/TeacherDashboard.vue';
import StudentDashboard from '../views/StudentDashboard.vue';
import TeacherManage from '../views/admin/TeacherManage.vue';
import StudentManage from '../views/admin/StudentManage.vue';
import GradeManage from '../views/teacher/GradeManage.vue';
import CourseSelect from '../views/student/CourseSelect.vue';

const routes = [
  { path: '/', component: Login },
  { path: '/login/admin', component: AdminLogin },
  { path: '/login/teacher', component: TeacherLogin },
  { path: '/admin', component: AdminDashboard, children: [
    { path: 'teachers', component: TeacherManage },
    { path: 'students', component: StudentManage }
  ]},
  { path: '/teacher', component: TeacherDashboard, children: [
    { path: 'grades', component: GradeManage }
  ]},
  { path: '/student', component: StudentDashboard, children: [
    { path: 'courses', component: CourseSelect }
  ]}
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
