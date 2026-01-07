<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>教学任务分配</strong></template>
    <el-form :model="assignment" label-width="110px" :inline="true">
      <el-form-item label="学期">
        <el-input v-model="assignment.term" placeholder="2024-2025-1" />
      </el-form-item>
      <el-form-item label="计划ID">
        <el-select v-model="assignment.termPlanId" placeholder="选择计划" style="width:200px;">
          <el-option v-for="p in plans" :key="p.id" :label="`${p.id} - ${p.term}`" :value="p.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="教师ID"><el-input v-model.number="assignment.teacherId" type="number" /></el-form-item>
      <el-form-item label="课程类别"><el-input v-model="assignment.courseType" placeholder="基础/专业" /></el-form-item>
      <el-form-item label="备注"><el-input v-model="assignment.remarks" /></el-form-item>
      <el-form-item><el-button type="primary" @click="saveAssignment">保存分配</el-button></el-form-item>
    </el-form>
    <el-divider content-position="left">查询</el-divider>
    <el-form :inline="true" label-width="80px" style="margin-top:6px;">
      <el-form-item label="学期">
        <el-input v-model="assignmentTerm" placeholder="查询学期" />
      </el-form-item>
      <el-form-item><el-button @click="loadAssignments">查询</el-button></el-form-item>
    </el-form>
    <el-table :data="assignments" height="320" style="margin-top:8px;">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="termPlanId" label="计划ID" />
      <el-table-column prop="teacherId" label="教师ID" />
      <el-table-column prop="courseType" label="类型" />
      <el-table-column prop="remarks" label="备注" />
    </el-table>
  </el-card>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import http from '../../api/http';

const assignment = reactive({ term: '', termPlanId: '', teacherId: '', courseType: '', remarks: '' });
const assignments = ref([]);
const assignmentTerm = ref('');
const plans = ref([]);

const loadPlans = async () => {
  if (!assignment.term) return;
  const { data } = await http.get('/admin/plans', { params: { term: assignment.term, majorId: null } });
  plans.value = data.data || [];
};

const saveAssignment = async () => {
  await http.post('/admin/assignment', assignment);
  ElMessage.success('分配已保存');
  await loadAssignments();
};

const loadAssignments = async () => {
  if (!assignmentTerm.value) {
    assignments.value = [];
    return;
  }
  const { data } = await http.get('/admin/assignments', { params: { term: assignmentTerm.value } });
  assignments.value = data.data;
};

onMounted(loadAssignments);
</script>
