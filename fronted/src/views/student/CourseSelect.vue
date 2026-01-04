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
      <template #header><strong>成绩查询 / 打印</strong></template>
      <el-form :inline="true" label-width="90px">
        <el-form-item label="学生ID"><el-input v-model.number="studentId" type="number" /></el-form-item>
        <el-form-item><el-button type="primary" @click="loadGrades">查询</el-button></el-form-item>
        <el-form-item><el-button :disabled="!grades.length" @click="printGrades">打印成绩单</el-button></el-form-item>
      </el-form>
      <el-table :data="grades" height="240">
        <el-table-column prop="courseId" label="课程ID" />
        <el-table-column prop="term" label="学期" />
        <el-table-column prop="score" label="成绩" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>课表下载</strong></template>
      <el-form :inline="true" label-width="90px">
        <el-form-item label="学生ID"><el-input v-model.number="studentId" type="number" /></el-form-item>
        <el-form-item label="学期"><el-input v-model="term" /></el-form-item>
        <el-form-item><el-button type="primary" @click="loadTimetable">获取课表</el-button></el-form-item>
      </el-form>
      <el-alert v-if="timetable" type="success" :closable="false" show-icon>
        <template #title>文件：{{ timetable.fileName }} &nbsp; 路径：{{ timetable.fileUrl }}</template>
      </el-alert>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>自主选课</strong></template>
      <el-form :inline="true" label-width="90px">
        <el-form-item label="学生ID"><el-input v-model.number="studentId" type="number" /></el-form-item>
        <el-form-item label="学期"><el-input v-model="selectTerm" /></el-form-item>
        <el-form-item label="课程">
          <el-select v-model.number="selectedCourseId" placeholder="选择课程" style="width:200px;">
            <el-option v-for="c in courses" :key="c.id" :label="`${c.name} (${c.credit}学分)`" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item><el-button type="primary" @click="selectCourse">选课</el-button></el-form-item>
      </el-form>
      <el-button style="margin:8px 0;" @click="loadSelectedCourses">刷新已选课程</el-button>
      <el-table :data="selectedCourses" height="240">
        <el-table-column prop="id" label="记录ID" width="80" />
        <el-table-column prop="courseId" label="课程ID" />
        <el-table-column prop="term" label="学期" />
      </el-table>
    </el-card>
  </el-space>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import http from '../../api/http';
import { ElMessage } from 'element-plus';
import { getUser } from '../../utils/auth';

const user = getUser();
const pwd = ref({ newPassword: '' });
const studentId = ref(user?.studentId || '');
const term = ref('');
const grades = ref([]);
const timetable = ref(null);
const courses = ref([]);
const selectedCourseId = ref('');
const selectTerm = ref('');
const selectedCourses = ref([]);

const changePwd = async () => {
  await http.post('/student/password', { username: user?.username, oldPassword: '', newPassword: pwd.value.newPassword });
  ElMessage.success('密码已修改');
};

const loadGrades = async () => {
  const { data } = await http.get('/student/grades', { params: { studentId: studentId.value } });
  grades.value = data.data;
};

const printGrades = () => window.print();

const loadTimetable = async () => {
  const { data } = await http.get('/student/timetable', { params: { studentId: studentId.value, term: term.value } });
  timetable.value = data.data;
};

const loadCourses = async () => {
  const { data } = await http.get('/admin/courses');
  courses.value = data.data;
};

const selectCourse = async () => {
  await http.post('/student/course/select', null, { params: { studentId: studentId.value, courseId: selectedCourseId.value, term: selectTerm.value } });
  ElMessage.success('选课成功');
  await loadSelectedCourses();
};

const loadSelectedCourses = async () => {
  const { data } = await http.get('/student/courses', { params: { studentId: studentId.value } });
  selectedCourses.value = data.data;
};

onMounted(() => {
  loadCourses();
});
</script>
