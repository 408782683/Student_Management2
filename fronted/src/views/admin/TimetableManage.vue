<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>课表管理</strong></template>
    <el-form :model="upload" label-width="90px" :inline="true">
      <el-form-item label="归属">
        <el-select v-model="upload.ownerType" style="width:160px;">
          <el-option label="专业" value="MAJOR" />
          <el-option label="教师" value="TEACHER" />
          <el-option label="学生" value="STUDENT" />
        </el-select>
      </el-form-item>
      <el-form-item label="关联ID"><el-input v-model.number="upload.ownerId" type="number" style="width:140px;" /></el-form-item>
      <el-form-item label="学期"><el-input v-model="upload.term" placeholder="2024-2025-1" /></el-form-item>
      <el-form-item label="文件"><input type="file" @change="onFileChange" /></el-form-item>
      <el-form-item><el-button type="primary" :disabled="!upload.file" @click="doUpload">上传</el-button></el-form-item>
    </el-form>
    <el-table :data="timetables" style="margin-top:12px;" height="380">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="ownerType" label="归属" />
      <el-table-column prop="ownerId" label="关联ID" />
      <el-table-column prop="term" label="学期" />
      <el-table-column prop="fileName" label="文件名" />
      <el-table-column prop="fileUrl" label="存储路径" />
    </el-table>
  </el-card>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import http from '../../api/http';

const upload = reactive({ ownerType: 'MAJOR', ownerId: '', term: '', file: null });
const timetables = ref([]);

const onFileChange = (e) => upload.file = e.target.files?.[0];

const doUpload = async () => {
  const formData = new FormData();
  formData.append('ownerType', upload.ownerType);
  formData.append('ownerId', upload.ownerId);
  formData.append('term', upload.term);
  formData.append('file', upload.file);
  const { data } = await http.post('/admin/timetable', formData, { headers: { 'Content-Type': 'multipart/form-data' } });
  timetables.value.unshift(data.data);
  ElMessage.success('课表上传成功');
};

const loadTimetables = async () => {
  const { data } = await http.get('/admin/timetables');
  timetables.value = data.data || [];
};

onMounted(loadTimetables);
</script>
