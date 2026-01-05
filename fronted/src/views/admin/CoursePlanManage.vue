<template>
  <el-space wrap fill>
    <el-card class="card-block" shadow="hover">
      <template #header><strong>课程管理</strong></template>
      <el-form :model="course" label-width="90px" :inline="true">
        <el-form-item label="课程名"><el-input v-model="course.name" /></el-form-item>
        <el-form-item label="学分"><el-input v-model.number="course.credit" type="number" style="width:120px;" /></el-form-item>
        <el-form-item label="分类"><el-input v-model="course.category" /></el-form-item>
        <el-form-item label="性质"><el-input v-model="course.nature" /></el-form-item>
        <el-form-item label="考核"><el-input v-model="course.assessmentMethod" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveCourse">保存课程</el-button></el-form-item>
      </el-form>
      <el-table :data="courses" height="260" style="margin-top:8px;">
        <el-table-column prop="id" label="ID" width="50" />
        <el-table-column prop="name" label="课程" />
        <el-table-column prop="credit" label="学分" width="80" />
        <el-table-column prop="category" label="分类" />
        <el-table-column prop="nature" label="性质" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>培养计划</strong></template>
      <el-form :model="plan" label-width="90px" :inline="true">
        <el-form-item label="学期"><el-input v-model="plan.term" placeholder="2024-2025-1" /></el-form-item>
        <el-form-item label="专业">
          <el-select v-model="plan.majorId" placeholder="选择专业" style="width:180px;">
            <el-option v-for="m in majors" :key="m.id" :label="m.name" :value="m.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="课程">
          <el-select v-model="plan.courseId" placeholder="选择课程" style="width:180px;">
            <el-option v-for="c in courses" :key="c.id" :label="c.name" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item><el-button type="primary" @click="savePlan">新增计划</el-button></el-form-item>
      </el-form>
      <el-form :model="planQuery" label-width="90px" :inline="true" style="margin-top:6px;">
        <el-form-item label="学期"><el-input v-model="planQuery.term" /></el-form-item>
        <el-form-item label="专业">
          <el-select v-model="planQuery.majorId" placeholder="选择专业" style="width:180px;">
            <el-option v-for="m in majors" :key="m.id" :label="m.name" :value="m.id" />
          </el-select>
        </el-form-item>
        <el-form-item><el-button @click="loadPlans">查询计划</el-button></el-form-item>
      </el-form>
      <el-table :data="plans" height="260" style="margin-top:8px;">
        <el-table-column prop="id" label="ID" width="50" />
        <el-table-column prop="term" label="学期" />
        <el-table-column prop="majorId" label="专业ID" />
        <el-table-column prop="courseId" label="课程ID" />
      </el-table>
    </el-card>
  </el-space>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import http from '../../api/http';

const course = reactive({ name: '', credit: '', category: '', nature: '', assessmentMethod: '' });
const courses = ref([]);
const plan = reactive({ term: '', majorId: '', courseId: '' });
const planQuery = reactive({ term: '', majorId: '' });
const plans = ref([]);
const majors = ref([]);

const loadMajors = async () => {
  const { data } = await http.get('/admin/majors');
  majors.value = data.data;
  if (!plan.majorId && majors.value.length) {
    plan.majorId = majors.value[0].id;
    planQuery.majorId = plan.majorId;
  }
};

const loadCourses = async () => {
  const { data } = await http.get('/admin/courses');
  courses.value = data.data;
};

const saveCourse = async () => {
  await http.post('/admin/course', course);
  ElMessage.success('课程已保存');
  await loadCourses();
};

const savePlan = async () => {
  await http.post('/admin/plan', plan);
  ElMessage.success('培养计划已保存');
  await loadPlans();
};

const loadPlans = async () => {
  if (!planQuery.term || !planQuery.majorId) {
    plans.value = [];
    return;
  }
  const { data } = await http.get('/admin/plans', { params: planQuery });
  plans.value = data.data;
};

onMounted(async () => {
  await Promise.all([loadMajors(), loadCourses()]);
});
</script>
