<template>
  <div class="card">
    <h2>学生 - 修改密码</h2>
    <div class="form-row">
      <input v-model="pwd.username" placeholder="用户名" />
      <input v-model="pwd.oldPassword" type="password" placeholder="旧密码" />
      <input v-model="pwd.newPassword" type="password" placeholder="新密码" />
      <button @click="changePwd">修改</button>
    </div>
  </div>

  <div class="card">
    <h2>成绩查询 / 打印</h2>
    <div class="form-row">
      <input v-model.number="studentId" type="number" placeholder="学生ID" />
      <button @click="loadGrades">查询</button>
      <button :disabled="!grades.length" @click="printGrades">打印成绩单</button>
    </div>
    <table class="table" v-if="grades.length">
      <thead><tr><th>课程ID</th><th>学期</th><th>成绩</th></tr></thead>
      <tbody>
        <tr v-for="g in grades" :key="g.id">
          <td>{{ g.courseId }}</td><td>{{ g.term }}</td><td>{{ g.score }}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="card">
    <h2>课表下载</h2>
    <div class="form-row">
      <input v-model.number="studentId" type="number" placeholder="学生ID" />
      <input v-model="term" placeholder="学期" />
      <button @click="loadTimetable">获取课表</button>
    </div>
    <p v-if="timetable">文件：{{ timetable.fileName }} 路径：{{ timetable.fileUrl }}</p>
  </div>

  <div class="card">
    <h2>自主选课</h2>
    <div class="form-row">
      <input v-model.number="studentId" type="number" placeholder="学生ID" />
      <input v-model="selectTerm" placeholder="学期" />
      <select v-model.number="selectedCourseId">
        <option value="">选择课程</option>
        <option v-for=\"c in courses\" :key=\"c.id\" :value=\"c.id\">{{ c.name }} ({{ c.credit }}学分)</option>
      </select>
      <button @click="selectCourse">选课</button>
    </div>
    <button @click="loadSelectedCourses">刷新已选课程</button>
    <table class="table" v-if="selectedCourses.length">
      <thead><tr><th>ID</th><th>课程ID</th><th>学期</th></tr></thead>
      <tbody>
        <tr v-for="c in selectedCourses" :key="c.id">
          <td>{{ c.id }}</td><td>{{ c.courseId }}</td><td>{{ c.term }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import http from '../api/http';

const pwd = ref({ username: '', oldPassword: '', newPassword: '' });
const studentId = ref('');
const term = ref('');
const grades = ref([]);
const timetable = ref(null);
const courses = ref([]);
const selectedCourseId = ref('');
const selectTerm = ref('');
const selectedCourses = ref([]);

const changePwd = async () => {
  await http.post('/student/password', pwd.value);
  alert('密码已修改');
};

const loadGrades = async () => {
  const { data } = await http.get('/student/grades', { params: { studentId: studentId.value } });
  grades.value = data.data;
};

const printGrades = () => window.print();

const loadTimetable = async () => {
  const { data } = await http.get('/student/timetable', { params: { studentId: studentId.value, term: term.value } });
  timetable.value = data.data;
};

const loadCourses = async () => {
  const { data } = await http.get('/admin/courses');
  courses.value = data.data;
};

const selectCourse = async () => {
  await http.post('/student/course/select', null, { params: { studentId: studentId.value, courseId: selectedCourseId.value, term: selectTerm.value } });
  alert('选课成功');
  await loadSelectedCourses();
};

const loadSelectedCourses = async () => {
  const { data } = await http.get('/student/courses', { params: { studentId: studentId.value } });
  selectedCourses.value = data.data;
};

onMounted(() => {
  loadCourses();
});
</script>
