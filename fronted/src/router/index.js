import { createRouter, createWebHistory } from 'vue-router';
import Login from '../views/Login.vue';
import AdminLogin from '../views/AdminLogin.vue';
import TeacherLogin from '../views/TeacherLogin.vue';
import AdminLayout from '../layouts/AdminLayout.vue';
import TeacherLayout from '../layouts/TeacherLayout.vue';
import StudentLayout from '../layouts/StudentLayout.vue';
import AdminDashboard from '../views/AdminDashboard.vue';
import TeacherManage from '../views/admin/TeacherManage.vue';
import StudentManage from '../views/admin/StudentManage.vue';
import GradeManage from '../views/teacher/GradeManage.vue';
import CourseSelect from '../views/student/CourseSelect.vue';
import { getUser } from '../utils/auth';

const routes = [
  { path: '/', component: Login },
  { path: '/login/admin', component: AdminLogin },
  { path: '/login/teacher', component: TeacherLogin },
  { path: '/admin', component: AdminLayout, meta: { role: 'ADMIN' }, children: [
    { path: '', redirect: '/admin/base' },
    { path: 'base', component: AdminDashboard, meta: { role: 'ADMIN' } },
    { path: 'teachers', component: TeacherManage, meta: { role: 'ADMIN' } },
    { path: 'students', component: StudentManage, meta: { role: 'ADMIN' } }
  ]},
  { path: '/teacher', component: TeacherLayout, meta: { role: 'TEACHER' }, children: [
    { path: '', redirect: '/teacher/grades' },
    { path: 'grades', component: GradeManage, meta: { role: 'TEACHER' } }
  ]},
  { path: '/student', component: StudentLayout, meta: { role: 'STUDENT' }, children: [
    { path: '', redirect: '/student/courses' },
    { path: 'courses', component: CourseSelect, meta: { role: 'STUDENT' } }
  ]}
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

router.beforeEach((to, from, next) => {
  const user = getUser();
  if (to.meta?.role) {
    if (!user || user.role !== to.meta.role) {
      return next('/');
    }
  }
  next();
});

export default router;
const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
