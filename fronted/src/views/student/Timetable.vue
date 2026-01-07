<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>课表下载</strong></template>
    <el-form :inline="true" label-width="90px">
      <el-form-item label="学期"><el-input v-model="term" /></el-form-item>
      <el-form-item><el-button type="primary" @click="loadTimetable">获取课表</el-button></el-form-item>
    </el-form>
    <el-alert v-if="timetable" type="success" :closable="false" show-icon>
      <template #title>文件：{{ timetable.fileName }} &nbsp; 路径：{{ timetable.fileUrl }}</template>
    </el-alert>
  </el-card>
</template>

<script setup>
import { ref } from 'vue';
import http from '../../api/http';
import { getUser } from '../../utils/auth';

const user = getUser();
const studentId = ref(user?.studentId || '');
const term = ref('');
const timetable = ref(null);

const loadTimetable = async () => {
  const { data } = await http.get('/student/timetable', { params: { studentId: studentId.value, term: term.value } });
  timetable.value = data.data;
};
</script>
