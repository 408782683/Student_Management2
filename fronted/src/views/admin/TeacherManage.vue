<template>
  <el-card shadow="hover">
    <template #header>
      <div style="display:flex;justify-content:space-between;align-items:center;">
        <strong>教师管理</strong>
        <el-button type="primary" @click="loadTeachers">刷新</el-button>
      </div>
    </template>
    <el-form :model="teacher" label-width="100px" :inline="true">
      <el-form-item label="ID"><el-input v-model="teacher.id" type="number" placeholder="留空新增" style="width:150px;" /></el-form-item>
      <el-form-item label="工号"><el-input v-model="teacher.teacherNo" /></el-form-item>
      <el-form-item label="姓名"><el-input v-model="teacher.name" /></el-form-item>
      <el-form-item label="职称"><el-input v-model="teacher.title" /></el-form-item>
      <el-form-item label="学院ID"><el-input v-model="teacher.collegeId" type="number" /></el-form-item>
      <el-form-item label="电话"><el-input v-model="teacher.phone" /></el-form-item>
      <el-form-item label="邮箱"><el-input v-model="teacher.email" /></el-form-item>
      <el-form-item label="入职日期"><el-date-picker v-model="teacher.hiredDate" type="date" value-format="YYYY-MM-DD" /></el-form-item>
      <el-form-item><el-button type="primary" @click="saveTeacher">保存教师</el-button></el-form-item>
    </el-form>
    <el-table :data="teachers" style="width:100%;margin-top:12px;" height="520">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="teacherNo" label="工号" />
      <el-table-column prop="name" label="姓名" />
      <el-table-column prop="title" label="职称" />
      <el-table-column prop="collegeId" label="学院ID" />
      <el-table-column prop="phone" label="电话" />
      <el-table-column prop="email" label="邮箱" />
      <el-table-column label="操作" width="160">
        <template #default="scope">
          <el-button size="small" @click="fillTeacher(scope.row)">编辑</el-button>
          <el-button size="small" type="danger" @click="removeTeacher(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import http from '../../api/http';
import { ElMessage, ElMessageBox } from 'element-plus';

const teacher = reactive({ id: '', teacherNo: '', name: '', title: '', collegeId: '', phone: '', email: '', hiredDate: '' });
const teachers = ref([]);

const loadTeachers = async () => {
  const { data } = await http.get('/admin/teachers');
  teachers.value = data.data;
};

const saveTeacher = async () => {
  await http.post('/admin/teacher', teacher);
  ElMessage.success('保存成功');
  await loadTeachers();
};

const fillTeacher = (row) => Object.assign(teacher, row);

const removeTeacher = async (row) => {
  await ElMessageBox.confirm('确认删除该教师?', '提示');
  await http.delete(`/admin/teacher/${row.id}`);
  ElMessage.success('删除成功');
  await loadTeachers();
};

onMounted(loadTeachers);
</script>
