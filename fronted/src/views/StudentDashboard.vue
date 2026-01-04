<template>
  <div class="card">
    <h2>学生 - 成绩查询</h2>
    <div class="form-row">
      <input v-model.number="studentId" type="number" placeholder="学生ID" />
      <button @click="loadGrades">查询</button>
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
</template>

<script setup>
import { ref } from 'vue';
import http from '../api/http';

const studentId = ref('');
const term = ref('');
const grades = ref([]);
const timetable = ref(null);

const loadGrades = async () => {
  const { data } = await http.get('/student/grades', { params: { studentId: studentId.value } });
  grades.value = data.data;
};

const loadTimetable = async () => {
  const { data } = await http.get('/student/timetable', { params: { studentId: studentId.value, term: term.value } });
  timetable.value = data.data;
};
</script>
