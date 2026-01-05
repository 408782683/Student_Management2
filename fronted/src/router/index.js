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
import OrgStructureManage from '../views/admin/OrgStructureManage.vue';
import CoursePlanManage from '../views/admin/CoursePlanManage.vue';
import TeachingAssignment from '../views/admin/TeachingAssignment.vue';
import TimetableManage from '../views/admin/TimetableManage.vue';
import TeacherDashboard from '../views/TeacherDashboard.vue';
import TeacherGrades from '../views/teacher/GradeManage.vue';
import TeacherAssignments from '../views/teacher/Assignments.vue';
import TeacherTimetable from '../views/teacher/Timetable.vue';
import TeacherAccount from '../views/teacher/Account.vue';
import StudentDashboard from '../views/StudentDashboard.vue';
import CourseSelect from '../views/student/CourseSelect.vue';
import StudentGrades from '../views/student/Grades.vue';
import StudentTimetable from '../views/student/Timetable.vue';
import StudentAccount from '../views/student/Account.vue';
import { getUser } from '../utils/auth';

const routes = [
  { path: '/', component: Login },
  { path: '/login/admin', component: AdminLogin },
  { path: '/login/teacher', component: TeacherLogin },
  { path: '/admin', component: AdminLayout, meta: { role: 'ADMIN' }, children: [
    { path: '', redirect: '/admin/base' },
    { path: 'base', component: AdminDashboard, meta: { role: 'ADMIN' } },
    { path: 'teachers', component: TeacherManage, meta: { role: 'ADMIN' } },
    { path: 'students', component: StudentManage, meta: { role: 'ADMIN' } },
    { path: 'org', component: OrgStructureManage, meta: { role: 'ADMIN' } },
    { path: 'course-plan', component: CoursePlanManage, meta: { role: 'ADMIN' } },
    { path: 'assignments', component: TeachingAssignment, meta: { role: 'ADMIN' } },
    { path: 'timetable', component: TimetableManage, meta: { role: 'ADMIN' } }
  ]},
  { path: '/teacher', component: TeacherLayout, meta: { role: 'TEACHER' }, children: [
    { path: '', redirect: '/teacher/dashboard' },
    { path: 'dashboard', component: TeacherDashboard, meta: { role: 'TEACHER' } },
    { path: 'assignments', component: TeacherAssignments, meta: { role: 'TEACHER' } },
    { path: 'grades', component: TeacherGrades, meta: { role: 'TEACHER' } },
    { path: 'timetable', component: TeacherTimetable, meta: { role: 'TEACHER' } },
    { path: 'account', component: TeacherAccount, meta: { role: 'TEACHER' } }
  ]},
  { path: '/student', component: StudentLayout, meta: { role: 'STUDENT' }, children: [
    { path: '', redirect: '/student/dashboard' },
    { path: 'dashboard', component: StudentDashboard, meta: { role: 'STUDENT' } },
    { path: 'courses', component: CourseSelect, meta: { role: 'STUDENT' } },
    { path: 'grades', component: StudentGrades, meta: { role: 'STUDENT' } },
    { path: 'timetable', component: StudentTimetable, meta: { role: 'STUDENT' } },
    { path: 'account', component: StudentAccount, meta: { role: 'STUDENT' } }
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
