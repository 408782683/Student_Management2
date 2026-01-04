<template>
  <div class="card">
    <h2>管理员 - 课程与培养计划</h2>
    <div class="form-row">
      <input v-model="course.name" placeholder="课程名称" />
      <input v-model.number="course.credit" placeholder="学分" type="number" />
      <input v-model="course.category" placeholder="课程分类" />
      <input v-model="course.nature" placeholder="课程性质" />
      <input v-model="course.assessmentMethod" placeholder="考核方式" />
      <button @click="saveCourse">保存课程</button>
    </div>
    <button @click="loadCourses">刷新课程列表</button>
    <table class="table" v-if="courses.length">
      <thead>
        <tr>
          <th>名称</th><th>学分</th><th>分类</th><th>性质</th><th>考核</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="c in courses" :key="c.id">
          <td>{{ c.name }}</td><td>{{ c.credit }}</td><td>{{ c.category }}</td><td>{{ c.nature }}</td><td>{{ c.assessmentMethod }}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="card">
    <h2>上传课表</h2>
    <div class="form-row">
      <select v-model="upload.ownerType">
        <option value="MAJOR">专业课表</option>
        <option value="TEACHER">教师课表</option>
        <option value="STUDENT">学生课表</option>
      </select>
      <input v-model.number="upload.ownerId" placeholder="关联ID" type="number" />
      <input v-model="upload.term" placeholder="学期 2024-2025-1" />
      <input type="file" @change="onFileChange" />
      <button :disabled="!upload.file" @click="doUpload">上传</button>
    </div>
    <div v-if="timetables.length">
      <h3>已上传</h3>
      <ul>
        <li v-for="t in timetables" :key="t.id">{{ t.term }} - {{ t.fileName }} ({{ t.fileUrl }})</li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../api/http';

const course = reactive({ name: '', credit: '', category: '', nature: '', assessmentMethod: '' });
const courses = ref([]);
const upload = reactive({ ownerType: 'MAJOR', ownerId: '', term: '', file: null });
const timetables = ref([]);

const saveCourse = async () => {
  await http.post('/admin/course', course);
  alert('保存成功');
  await loadCourses();
};

const loadCourses = async () => {
  const { data } = await http.get('/admin/courses');
  courses.value = data.data;
};

const onFileChange = (e) => {
  upload.file = e.target.files?.[0];
};

const doUpload = async () => {
  const formData = new FormData();
  formData.append('ownerType', upload.ownerType);
  formData.append('ownerId', upload.ownerId);
  formData.append('term', upload.term);
  formData.append('file', upload.file);
  const { data } = await http.post('/admin/timetable', formData, { headers: { 'Content-Type': 'multipart/form-data' } });
  timetables.value.push(data.data);
};

loadCourses();
</script>
