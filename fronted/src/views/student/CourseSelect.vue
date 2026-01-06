<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>自主选课</strong></template>
    <el-form :inline="true" label-width="90px">
      <el-form-item label="学期"><el-input v-model="selectTerm" /></el-form-item>
      <el-form-item label="课程">
        <el-select v-model.number="selectedCourseId" placeholder="选择课程" style="width:200px;">
          <el-option v-for="c in courses" :key="c.id" :label="`${c.name} (${c.credit}学分)`" :value="c.id" />
        </el-select>
      </el-form-item>
      <el-form-item><el-button type="primary" @click="selectCourse">选课</el-button></el-form-item>
    </el-form>
    <el-button style="margin:8px 0;" @click="loadSelectedCourses">刷新已选课程</el-button>
    <el-table :data="selectedCourses" height="360">
      <el-table-column prop="id" label="记录ID" width="80" />
      <el-table-column prop="courseId" label="课程ID" />
      <el-table-column prop="term" label="学期" />
    </el-table>
  </el-card>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import http from '../../api/http';
import { getUser } from '../../utils/auth';

const user = getUser();
const studentId = ref(user?.studentId || '');
const selectTerm = ref('');
const courses = ref([]);
const selectedCourseId = ref('');
const selectedCourses = ref([]);

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

onMounted(async () => {
  await loadCourses();
  await loadSelectedCourses();
});
</script>
