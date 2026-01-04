<template>
  <el-card shadow="hover">
    <template #header>
      <div style="display:flex;justify-content:space-between;align-items:center;">
        <strong>学生管理</strong>
        <el-button type="primary" @click="loadStudents">刷新</el-button>
      </div>
    </template>
    <el-form :model="student" label-width="90px" :inline="true">
      <el-form-item label="ID"><el-input v-model="student.id" type="number" placeholder="留空新增" style="width:150px;" /></el-form-item>
      <el-form-item label="学号"><el-input v-model="student.studentNo" /></el-form-item>
      <el-form-item label="姓名"><el-input v-model="student.name" /></el-form-item>
      <el-form-item label="性别"><el-input v-model="student.gender" /></el-form-item>
      <el-form-item label="班级ID"><el-input v-model="student.classId" type="number" /></el-form-item>
      <el-form-item label="电话"><el-input v-model="student.phone" /></el-form-item>
      <el-form-item label="邮箱"><el-input v-model="student.email" /></el-form-item>
      <el-form-item label="入学日期"><el-date-picker v-model="student.enrollmentDate" type="date" value-format="YYYY-MM-DD" /></el-form-item>
      <el-form-item><el-button type="primary" @click="saveStudent">保存学生</el-button></el-form-item>
    </el-form>
    <el-table :data="students" style="width:100%;margin-top:12px;" height="520">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="studentNo" label="学号" />
      <el-table-column prop="name" label="姓名" />
      <el-table-column prop="gender" label="性别" />
      <el-table-column prop="classId" label="班级ID" />
      <el-table-column prop="phone" label="电话" />
      <el-table-column prop="email" label="邮箱" />
      <el-table-column label="操作" width="160">
        <template #default="scope">
          <el-button size="small" @click="fillStudent(scope.row)">编辑</el-button>
          <el-button size="small" type="danger" @click="removeStudent(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import http from '../../api/http';
import { ElMessage, ElMessageBox } from 'element-plus';

const student = reactive({ id: '', studentNo: '', name: '', gender: '', classId: '', phone: '', email: '', enrollmentDate: '' });
const students = ref([]);

const loadStudents = async () => {
  const { data } = await http.get('/admin/students');
  students.value = data.data;
};

const saveStudent = async () => {
  await http.post('/admin/student', student);
  ElMessage.success('保存成功');
  await loadStudents();
};

const fillStudent = (row) => Object.assign(student, row);

const removeStudent = async (row) => {
  await ElMessageBox.confirm('确认删除该学生?', '提示');
  await http.delete(`/admin/student/${row.id}`);
  ElMessage.success('删除成功');
  await loadStudents();
};

onMounted(loadStudents);
</script>
