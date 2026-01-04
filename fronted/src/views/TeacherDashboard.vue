<template>
  <el-space wrap fill>
    <el-card class="card-block" shadow="hover">
      <template #header><strong>修改密码</strong></template>
      <el-form :model="pwd" label-width="90px" :inline="true">
        <el-form-item label="新密码"><el-input v-model="pwd.newPassword" type="password" show-password /></el-form-item>
        <el-form-item><el-button type="primary" @click="changePwd">修改</el-button></el-form-item>
      </el-form>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>教学任务</strong></template>
      <el-form :model="query" label-width="90px" :inline="true">
        <el-form-item label="教师ID"><el-input v-model.number="query.teacherId" type="number" /></el-form-item>
        <el-form-item label="学期"><el-input v-model="query.term" placeholder="2024-2025-1" /></el-form-item>
        <el-form-item><el-button type="primary" @click="loadAssignments">查询</el-button></el-form-item>
      </el-form>
      <el-table :data="assignments" height="220">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="courseType" label="课程类型" />
        <el-table-column prop="remarks" label="备注" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>录入/查询成绩</strong></template>
      <el-form :model="grade" label-width="100px" :inline="true">
        <el-form-item label="学生ID"><el-input v-model.number="grade.studentId" type="number" /></el-form-item>
        <el-form-item label="课程ID"><el-input v-model.number="grade.courseId" type="number" /></el-form-item>
        <el-form-item label="学期"><el-input v-model="grade.term" /></el-form-item>
        <el-form-item label="成绩"><el-input v-model.number="grade.score" type="number" /></el-form-item>
        <el-form-item><el-button type="primary" @click="submitGrade">提交</el-button></el-form-item>
      </el-form>
      <el-divider content-position="left">成绩查询</el-divider>
      <el-form :model="query" label-width="90px" :inline="true">
        <el-form-item label="教师ID"><el-input v-model.number="query.teacherId" type="number" /></el-form-item>
        <el-form-item label="学期"><el-input v-model="query.term" /></el-form-item>
        <el-form-item><el-button @click="loadGrades">查询</el-button></el-form-item>
      </el-form>
      <el-table :data="grades" height="240">
        <el-table-column prop="studentId" label="学生" />
        <el-table-column prop="courseId" label="课程" />
        <el-table-column prop="term" label="学期" />
        <el-table-column prop="score" label="成绩" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>课表与点名册</strong></template>
      <el-form :model="query" label-width="90px" :inline="true">
        <el-form-item label="教师ID"><el-input v-model.number="query.teacherId" type="number" /></el-form-item>
        <el-form-item label="学期"><el-input v-model="query.term" /></el-form-item>
        <el-form-item><el-button @click="loadTimetable">获取课表</el-button></el-form-item>
      </el-form>
      <el-alert v-if="timetable" type="success" :closable="false" show-icon>
        <template #title>文件：{{ timetable.fileName }} &nbsp; 路径：{{ timetable.fileUrl }}</template>
      </el-alert>
      <el-divider />
      <el-form :model="roster" label-width="90px" :inline="true">
        <el-form-item label="行政班ID"><el-input v-model.number="roster.classId" type="number" /></el-form-item>
        <el-form-item label="学期"><el-input v-model="roster.term" /></el-form-item>
        <el-form-item><el-button type="primary" @click="exportRoster">导出点名册</el-button></el-form-item>
      </el-form>
    </el-card>
  </el-space>
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../api/http';
import { getUser } from '../utils/auth';

const user = getUser();
const pwd = reactive({ newPassword: '' });
const query = reactive({ teacherId: '', term: '' });
const assignments = ref([]);
const grade = reactive({ studentId: '', courseId: '', term: '', score: '' });
const grades = ref([]);
const timetable = ref(null);
const roster = reactive({ classId: '', term: '' });

const changePwd = async () => {
  await http.post('/teacher/password', { username: user?.username, oldPassword: '', newPassword: pwd.newPassword });
  alert('密码已修改');
};

const loadAssignments = async () => {
  const { data } = await http.get('/teacher/assignments', { params: query });
  assignments.value = data.data;
};

const submitGrade = async () => {
  await http.post('/teacher/grade', grade);
  alert('提交成功');
};

const loadGrades = async () => {
  const { data } = await http.get('/teacher/grades', { params: query });
  grades.value = data.data;
};

const loadTimetable = async () => {
  const { data } = await http.get('/teacher/timetable', { params: query });
  timetable.value = data.data;
};

const exportRoster = async () => {
  const resp = await http.get('/teacher/roster/export', { params: roster, responseType: 'blob' });
  const blob = new Blob([resp.data], { type: 'application/msword' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `roster_${roster.term || ''}.doc`;
  a.click();
  URL.revokeObjectURL(url);
};
</script>
