<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>课表与点名册</strong></template>
    <el-form :model="query" label-width="90px" :inline="true">
      <el-form-item label="教师ID"><el-input v-model.number="query.teacherId" type="number" /></el-form-item>
      <el-form-item label="学期"><el-input v-model="query.term" /></el-form-item>
      <el-form-item><el-button type="primary" @click="loadTimetable">获取课表</el-button></el-form-item>
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
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../../api/http';
import { getUser } from '../../utils/auth';

const user = getUser();
const query = reactive({ teacherId: user?.teacherId || '', term: '' });
const roster = reactive({ classId: '', term: '' });
const timetable = ref(null);

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
