<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>教学任务</strong></template>
    <el-form :model="query" label-width="90px" :inline="true">
      <el-form-item label="教师ID"><el-input v-model.number="query.teacherId" type="number" /></el-form-item>
      <el-form-item label="学期"><el-input v-model="query.term" placeholder="2024-2025-1" /></el-form-item>
      <el-form-item><el-button type="primary" @click="loadAssignments">查询</el-button></el-form-item>
    </el-form>
    <el-table :data="assignments" height="400" style="margin-top:8px;">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="courseType" label="课程类型" />
      <el-table-column prop="remarks" label="备注" />
    </el-table>
  </el-card>
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../../api/http';
import { getUser } from '../../utils/auth';

const user = getUser();
const query = reactive({ teacherId: user?.teacherId || '', term: '' });
const assignments = ref([]);

const loadAssignments = async () => {
  const { data } = await http.get('/teacher/assignments', { params: query });
  assignments.value = data.data;
};
</script>
