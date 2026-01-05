<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>成绩录入与查询</strong></template>
    <el-form :model="grade" label-width="100px" :inline="true">
      <el-form-item label="学生ID"><el-input v-model.number="grade.studentId" type="number" /></el-form-item>
      <el-form-item label="课程ID"><el-input v-model.number="grade.courseId" type="number" /></el-form-item>
      <el-form-item label="学期"><el-input v-model="grade.term" /></el-form-item>
      <el-form-item label="成绩"><el-input v-model.number="grade.score" type="number" /></el-form-item>
      <el-form-item><el-button type="primary" @click="submitGrade">提交</el-button></el-form-item>
    </el-form>
    <el-divider content-position="left">我的成绩录入记录</el-divider>
    <el-form :model="query" label-width="90px" :inline="true">
      <el-form-item label="教师ID"><el-input v-model.number="query.teacherId" type="number" /></el-form-item>
      <el-form-item label="学期"><el-input v-model="query.term" /></el-form-item>
      <el-form-item><el-button @click="loadGrades">查询</el-button></el-form-item>
    </el-form>
    <el-table :data="grades" height="320">
      <el-table-column prop="studentId" label="学生" />
      <el-table-column prop="courseId" label="课程" />
      <el-table-column prop="term" label="学期" />
      <el-table-column prop="score" label="成绩" />
    </el-table>
  </el-card>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import http from '../../api/http';
import { getUser } from '../../utils/auth';

const user = getUser();
const grade = reactive({ studentId: '', courseId: '', term: '', score: '' });
const query = reactive({ teacherId: user?.teacherId || '', term: '' });
const grades = ref([]);

const submitGrade = async () => {
  await http.post('/teacher/grade', grade);
  ElMessage.success('成绩已提交');
  await loadGrades();
};

const loadGrades = async () => {
  const { data } = await http.get('/teacher/grades', { params: query });
  grades.value = data.data;
};

onMounted(loadGrades);
</script>
