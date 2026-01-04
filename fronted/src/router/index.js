import { createRouter, createWebHistory } from 'vue-router';
import Login from '../views/Login.vue';
import AdminDashboard from '../views/AdminDashboard.vue';
import TeacherDashboard from '../views/TeacherDashboard.vue';
import StudentDashboard from '../views/StudentDashboard.vue';

const routes = [
  { path: '/', component: Login },
  { path: '/admin', component: AdminDashboard },
  { path: '/teacher', component: TeacherDashboard },
  { path: '/student', component: StudentDashboard }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
