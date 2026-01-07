<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>成绩查询 / 打印</strong></template>
    <el-form :inline="true" label-width="90px">
      <el-form-item><el-button type="primary" @click="loadGrades">查询</el-button></el-form-item>
      <el-form-item><el-button :disabled="!grades.length" @click="printGrades">打印成绩单</el-button></el-form-item>
    </el-form>
    <el-table :data="grades" height="380">
      <el-table-column prop="courseId" label="课程ID" />
      <el-table-column label="课程名称">
        <template #default="scope">{{ courseName(scope.row.courseId) }}</template>
      </el-table-column>
      <el-table-column prop="term" label="学期" />
      <el-table-column prop="score" label="成绩" />
    </el-table>
  </el-card>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import http from '../../api/http';
import { getUser } from '../../utils/auth';

const user = getUser();
const studentId = ref(user?.studentId || '');
const grades = ref([]);
const courses = ref([]);
const courseMap = ref({});

const loadGrades = async () => {
  const { data } = await http.get('/student/grades', { params: { studentId: studentId.value } });
  grades.value = data.data;
};

const printGrades = () => window.print();

const loadCourses = async () => {
  const { data } = await http.get('/admin/courses');
  courses.value = data.data;
  courseMap.value = Object.fromEntries(courses.value.map(c => [c.id, c.name]));
};

const courseName = (id) => courseMap.value[id] || '-';

onMounted(async () => {
  await loadCourses();
  await loadGrades();
});
</script>
