<template>
  <el-space wrap fill>
    <el-card class="card-block" shadow="hover">
      <template #header><strong>学院管理</strong></template>
      <el-form :model="college" label-width="90px" :inline="true">
        <el-form-item label="学院名"><el-input v-model="college.name" /></el-form-item>
        <el-form-item label="代码"><el-input v-model="college.code" /></el-form-item>
        <el-form-item label="描述"><el-input v-model="college.description" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveCollege">保存学院</el-button></el-form-item>
      </el-form>
      <el-table :data="colleges" height="260" style="margin-top:8px;">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="学院" />
        <el-table-column prop="code" label="代码" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>专业管理</strong></template>
      <el-form :model="major" label-width="90px" :inline="true">
        <el-form-item label="学院">
          <el-select v-model="major.collegeId" placeholder="选择学院" style="width:180px;">
            <el-option v-for="c in colleges" :key="c.id" :label="c.name" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="专业名"><el-input v-model="major.name" /></el-form-item>
        <el-form-item label="代码"><el-input v-model="major.code" /></el-form-item>
        <el-form-item label="描述"><el-input v-model="major.description" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveMajor">保存专业</el-button></el-form-item>
      </el-form>
      <el-table :data="majors" height="260" style="margin-top:8px;">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="专业" />
        <el-table-column prop="code" label="代码" />
        <el-table-column prop="collegeId" label="学院ID" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>班级管理</strong></template>
      <el-form :model="clazz" label-width="90px" :inline="true">
        <el-form-item label="专业">
          <el-select v-model="clazz.majorId" placeholder="选择专业" style="width:180px;">
            <el-option v-for="m in majors" :key="m.id" :label="m.name" :value="m.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="班级名"><el-input v-model="clazz.name" /></el-form-item>
        <el-form-item label="年级"><el-input v-model.number="clazz.grade" type="number" /></el-form-item>
        <el-form-item label="辅导员"><el-input v-model="clazz.counselor" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveClazz">保存班级</el-button></el-form-item>
      </el-form>
      <el-table :data="clazzes" height="260" style="margin-top:8px;">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="班级" />
        <el-table-column prop="majorId" label="专业ID" />
        <el-table-column prop="grade" label="年级" />
      </el-table>
    </el-card>
  </el-space>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import http from '../../api/http';

const college = reactive({ name: '', code: '', description: '' });
const colleges = ref([]);
const major = reactive({ collegeId: '', name: '', code: '', description: '' });
const majors = ref([]);
const clazz = reactive({ majorId: '', name: '', grade: '', counselor: '' });
const clazzes = ref([]);

const saveCollege = async () => {
  await http.post('/admin/college', college);
  ElMessage.success('学院已保存');
  await loadColleges();
};

const saveMajor = async () => {
  await http.post('/admin/major', major);
  ElMessage.success('专业已保存');
  await loadMajors();
};

const saveClazz = async () => {
  await http.post('/admin/clazz', clazz);
  ElMessage.success('班级已保存');
  await loadClazzes();
};

const loadColleges = async () => {
  const { data } = await http.get('/admin/colleges');
  colleges.value = data.data;
  if (!major.collegeId && colleges.value.length) {
    major.collegeId = colleges.value[0].id;
  }
};

const loadMajors = async () => {
  const collegeId = major.collegeId || colleges.value[0]?.id;
  if (!collegeId) return;
  const { data } = await http.get('/admin/majors', { params: { collegeId } });
  majors.value = data.data;
  if (!clazz.majorId && majors.value.length) clazz.majorId = majors.value[0].id;
};

const loadClazzes = async () => {
  if (!clazz.majorId) return;
  const { data } = await http.get('/admin/clazzes', { params: { majorId: clazz.majorId } });
  clazzes.value = data.data;
};

onMounted(async () => {
  await loadColleges();
  await loadMajors();
  await loadClazzes();
});
</script>
