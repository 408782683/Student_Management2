<template>
  <div class="card">
    <h2>教师 - 教学任务</h2>
    <div class="form-row">
      <input v-model.number="query.teacherId" type="number" placeholder="教师ID" />
      <input v-model="query.term" placeholder="学期" />
      <button @click="loadAssignments">查询</button>
    </div>
    <table class="table" v-if="assignments.length">
      <thead><tr><th>ID</th><th>课程类型</th><th>备注</th></tr></thead>
      <tbody>
        <tr v-for="a in assignments" :key="a.id">
          <td>{{ a.id }}</td><td>{{ a.courseType }}</td><td>{{ a.remarks }}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="card">
    <h2>录入成绩</h2>
    <div class="form-row">
      <input v-model.number="grade.studentId" type="number" placeholder="学生ID" />
      <input v-model.number="grade.courseId" type="number" placeholder="课程ID" />
      <input v-model="grade.term" placeholder="学期" />
      <input v-model.number="grade.score" type="number" placeholder="成绩" />
      <button @click="submitGrade">提交</button>
    </div>
  </div>

  <div class="card">
    <h2>课表下载</h2>
    <div class="form-row">
      <input v-model.number="query.teacherId" type="number" placeholder="教师ID" />
      <input v-model="query.term" placeholder="学期" />
      <button @click="loadTimetable">获取课表</button>
    </div>
    <p v-if="timetable">文件：{{ timetable.fileName }} 路径：{{ timetable.fileUrl }}</p>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../api/http';

const query = reactive({ teacherId: '', term: '' });
const assignments = ref([]);
const grade = reactive({ studentId: '', courseId: '', term: '', score: '' });
const timetable = ref(null);

const loadAssignments = async () => {
  const { data } = await http.get('/teacher/assignments', { params: query });
  assignments.value = data.data;
};

const submitGrade = async () => {
  await http.post('/teacher/grade', grade);
  alert('提交成功');
};

const loadTimetable = async () => {
  const { data } = await http.get('/teacher/timetable', { params: query });
  timetable.value = data.data;
};
</script>
