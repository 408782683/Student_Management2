<template>
  <el-space wrap fill>
    <el-card class="card-block" shadow="hover">
      <template #header><strong>学院 / 专业 / 班级</strong></template>
      <el-form :model="college" label-width="90px" :inline="true">
        <el-form-item label="学院名"><el-input v-model="college.name" /></el-form-item>
        <el-form-item label="代码"><el-input v-model="college.code" /></el-form-item>
        <el-form-item label="描述"><el-input v-model="college.description" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveCollege">新增学院</el-button></el-form-item>
      </el-form>
      <el-table :data="colleges" style="margin-bottom:12px;" height="200">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="学院" />
        <el-table-column prop="code" label="代码" />
      </el-table>

      <el-divider content-position="left">专业</el-divider>
      <el-form :model="major" label-width="90px" :inline="true">
        <el-form-item label="学院">
          <el-select v-model="major.collegeId" placeholder="选择学院" style="width:180px;">
            <el-option v-for="c in colleges" :key="c.id" :label="c.name" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="专业名"><el-input v-model="major.name" /></el-form-item>
        <el-form-item label="代码"><el-input v-model="major.code" /></el-form-item>
        <el-form-item label="描述"><el-input v-model="major.description" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveMajor">新增专业</el-button></el-form-item>
      </el-form>
      <el-table :data="majors" style="margin-bottom:12px;" height="200">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="专业" />
        <el-table-column prop="code" label="代码" />
        <el-table-column prop="collegeId" label="学院ID" />
      </el-table>

      <el-divider content-position="left">班级</el-divider>
      <el-form :model="clazz" label-width="90px" :inline="true">
        <el-form-item label="专业">
          <el-select v-model="clazz.majorId" placeholder="选择专业" style="width:180px;">
            <el-option v-for="m in majors" :key="m.id" :label="m.name" :value="m.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="班级名"><el-input v-model="clazz.name" /></el-form-item>
        <el-form-item label="年级"><el-input v-model.number="clazz.grade" type="number" /></el-form-item>
        <el-form-item label="辅导员"><el-input v-model="clazz.counselor" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveClazz">新增班级</el-button></el-form-item>
      </el-form>
      <el-table :data="clazzes" height="200">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="班级" />
        <el-table-column prop="majorId" label="专业ID" />
        <el-table-column prop="grade" label="年级" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>学院 / 专业 / 班级</strong></template>
      <el-form :model="college" label-width="90px" :inline="true">
        <el-form-item label="学院名"><el-input v-model="college.name" /></el-form-item>
        <el-form-item label="代码"><el-input v-model="college.code" /></el-form-item>
        <el-form-item label="描述"><el-input v-model="college.description" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveCollege">新增学院</el-button></el-form-item>
      </el-form>
      <el-table :data="colleges" style="margin-bottom:12px;" height="200">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="学院" />
        <el-table-column prop="code" label="代码" />
      </el-table>

      <el-divider content-position="left">专业</el-divider>
      <el-form :model="major" label-width="90px" :inline="true">
        <el-form-item label="学院">
          <el-select v-model="major.collegeId" placeholder="选择学院" style="width:180px;">
            <el-option v-for="c in colleges" :key="c.id" :label="c.name" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="专业名"><el-input v-model="major.name" /></el-form-item>
        <el-form-item label="代码"><el-input v-model="major.code" /></el-form-item>
        <el-form-item label="描述"><el-input v-model="major.description" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveMajor">新增专业</el-button></el-form-item>
      </el-form>
      <el-table :data="majors" style="margin-bottom:12px;" height="200">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="专业" />
        <el-table-column prop="code" label="代码" />
        <el-table-column prop="collegeId" label="学院ID" />
      </el-table>

      <el-divider content-position="left">班级</el-divider>
      <el-form :model="clazz" label-width="90px" :inline="true">
        <el-form-item label="专业">
          <el-select v-model="clazz.majorId" placeholder="选择专业" style="width:180px;">
            <el-option v-for="m in majors" :key="m.id" :label="m.name" :value="m.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="班级名"><el-input v-model="clazz.name" /></el-form-item>
        <el-form-item label="年级"><el-input v-model.number="clazz.grade" type="number" /></el-form-item>
        <el-form-item label="辅导员"><el-input v-model="clazz.counselor" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveClazz">新增班级</el-button></el-form-item>
      </el-form>
      <el-table :data="clazzes" height="200">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="name" label="班级" />
        <el-table-column prop="majorId" label="专业ID" />
        <el-table-column prop="grade" label="年级" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>课程与培养计划</strong></template>
      <el-form :model="course" label-width="90px" :inline="true">
        <el-form-item label="课程名"><el-input v-model="course.name" /></el-form-item>
        <el-form-item label="学分"><el-input v-model.number="course.credit" type="number" style="width:120px;" /></el-form-item>
        <el-form-item label="分类"><el-input v-model="course.category" /></el-form-item>
        <el-form-item label="性质"><el-input v-model="course.nature" /></el-form-item>
        <el-form-item label="考核"><el-input v-model="course.assessmentMethod" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveCourse">保存课程</el-button></el-form-item>
      </el-form>
      <el-table :data="courses" style="margin-bottom:12px;" height="200">
        <el-table-column prop="id" label="ID" width="50" />
        <el-table-column prop="name" label="课程" />
        <el-table-column prop="credit" label="学分" width="80" />
        <el-table-column prop="category" label="分类" />
        <el-table-column prop="nature" label="性质" />
      </el-table>

      <el-divider content-position="left">培养计划</el-divider>
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
      <el-table :data="plans" height="200">
        <el-table-column prop="id" label="ID" width="50" />
        <el-table-column prop="term" label="学期" />
        <el-table-column prop="majorId" label="专业ID" />
        <el-table-column prop="courseId" label="课程ID" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>教学任务分配</strong></template>
      <el-form :model="assignment" label-width="110px" :inline="true">
        <el-form-item label="培养计划">
          <el-select v-model="assignment.termPlanId" placeholder="选择计划" style="width:180px;">
            <el-option v-for="p in plans" :key="p.id" :label="`${p.id} - ${p.term}`" :value="p.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="教师ID"><el-input v-model.number="assignment.teacherId" type="number" /></el-form-item>
        <el-form-item label="课程类别"><el-input v-model="assignment.courseType" placeholder="基础/专业" /></el-form-item>
        <el-form-item label="备注"><el-input v-model="assignment.remarks" /></el-form-item>
        <el-form-item><el-button type="primary" @click="saveAssignment">保存分配</el-button></el-form-item>
      </el-form>
      <el-form :inline="true" label-width="80px" style="margin-top:6px;">
        <el-form-item label="学期">
          <el-input v-model="assignmentTerm" placeholder="查询学期" />
        </el-form-item>
        <el-form-item><el-button @click="loadAssignments">查询</el-button></el-form-item>
      </el-form>
      <el-table :data="assignments" height="200">
        <el-table-column prop="id" label="ID" width="50" />
        <el-table-column prop="termPlanId" label="计划ID" />
        <el-table-column prop="teacherId" label="教师ID" />
        <el-table-column prop="courseType" label="类型" />
        <el-table-column prop="remarks" label="备注" />
      </el-table>
    </el-card>

    <el-card class="card-block" shadow="hover">
      <template #header><strong>课表上传</strong></template>
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
      <el-table :data="timetables" style="margin-top:8px;" height="200">
        <el-table-column prop="id" label="ID" width="50" />
        <el-table-column prop="term" label="学期" />
        <el-table-column prop="fileName" label="文件名" />
        <el-table-column prop="fileUrl" label="存储路径" />
      </el-table>
    </el-card>
  </el-space>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import http from '../api/http';
import CrudTable from '../components/CrudTable.vue';

const student = reactive({ id: '', studentNo: '', name: '', gender: '', classId: '', photoUrl: '', phone: '', email: '', enrollmentDate: '' });
const students = ref([]);
const studentHeaders = [
  { key: 'id', label: 'ID' }, { key: 'studentNo', label: '学号' }, { key: 'name', label: '姓名' }, { key: 'gender', label: '性别' }, { key: 'classId', label: '班级' }
];

const teacher = reactive({ id: '', teacherNo: '', name: '', title: '', collegeId: '', photoUrl: '', phone: '', email: '', hiredDate: '' });
const teachers = ref([]);
const teacherHeaders = [
  { key: 'id', label: 'ID' }, { key: 'teacherNo', label: '工号' }, { key: 'name', label: '姓名' }, { key: 'title', label: '职称' }, { key: 'collegeId', label: '学院' }
];

const college = reactive({ name: '', code: '', description: '' });
const colleges = ref([]);
const collegeHeaders = [
  { key: 'id', label: 'ID' }, { key: 'name', label: '学院名称' }, { key: 'code', label: '代码' }
];
const major = reactive({ collegeId: '', name: '', code: '', description: '' });
const majors = ref([]);
const majorHeaders = [
  { key: 'id', label: 'ID' }, { key: 'name', label: '专业' }, { key: 'code', label: '代码' }, { key: 'collegeId', label: '学院ID' }
];
const clazz = reactive({ majorId: '', name: '', grade: '', counselor: '' });
const clazzes = ref([]);
const clazzHeaders = [
  { key: 'id', label: 'ID' }, { key: 'name', label: '班级' }, { key: 'majorId', label: '专业ID' }, { key: 'grade', label: '年级' }
];

const course = reactive({ name: '', credit: '', category: '', nature: '', assessmentMethod: '' });
const courses = ref([]);
const courseHeaders = [
  { key: 'id', label: 'ID' }, { key: 'name', label: '名称' }, { key: 'credit', label: '学分' }, { key: 'category', label: '分类' }, { key: 'nature', label: '性质' }, { key: 'assessmentMethod', label: '考核' }
];

const plan = reactive({ term: '', majorId: '', courseId: '' });
const plans = ref([]);
const planQuery = reactive({ term: '', majorId: '' });
const planHeaders = [
  { key: 'id', label: 'ID' }, { key: 'term', label: '学期' }, { key: 'majorId', label: '专业ID' }, { key: 'courseId', label: '课程ID' }
];

const assignment = reactive({ termPlanId: '', teacherId: '', courseType: '', remarks: '' });
const assignments = ref([]);
const assignmentTerm = ref('');
const assignmentHeaders = [
  { key: 'id', label: 'ID' }, { key: 'termPlanId', label: '计划ID' }, { key: 'teacherId', label: '教师ID' }, { key: 'courseType', label: '类型' }, { key: 'remarks', label: '备注' }
];

const upload = reactive({ ownerType: 'MAJOR', ownerId: '', term: '', file: null });
const timetables = ref([]);

const saveStudent = async () => {
  await http.post('/admin/student', student);
  alert('学生保存成功');
  await loadStudents();
};
const fillStudent = (row) => Object.assign(student, row);
const removeStudent = async (row) => {
  await http.delete(`/admin/student/${row.id}`);
  await loadStudents();
};

const saveTeacher = async () => {
  await http.post('/admin/teacher', teacher);
  alert('教师保存成功');
  await loadTeachers();
};
const fillTeacher = (row) => Object.assign(teacher, row);
const removeTeacher = async (row) => {
  await http.delete(`/admin/teacher/${row.id}`);
  await loadTeachers();
};

const saveCollege = async () => {
  await http.post('/admin/college', college);
  alert('学院已保存');
  await loadColleges();
};
const saveMajor = async () => {
  await http.post('/admin/major', major);
  alert('专业已保存');
  await loadMajors();
};
const saveClazz = async () => {
  await http.post('/admin/clazz', clazz);
  alert('班级已保存');
  await loadClazzes();
};

const saveCourse = async () => {
  await http.post('/admin/course', course);
  alert('课程已保存');
  await loadCourses();
};

const savePlan = async () => {
  await http.post('/admin/plan', plan);
  alert('培养计划已保存');
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

const saveAssignment = async () => {
  await http.post('/admin/assignment', assignment);
  alert('分配已保存');
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

const onFileChange = (e) => upload.file = e.target.files?.[0];
const doUpload = async () => {
  const formData = new FormData();
  formData.append('ownerType', upload.ownerType);
  formData.append('ownerId', upload.ownerId);
  formData.append('term', upload.term);
  formData.append('file', upload.file);
  const { data } = await http.post('/admin/timetable', formData, { headers: { 'Content-Type': 'multipart/form-data' } });
  timetables.value.push(data.data);
};

const loadStudents = async () => {
  const { data } = await http.get('/admin/students');
  students.value = data.data;
};
const loadTeachers = async () => {
  const { data } = await http.get('/admin/teachers');
  teachers.value = data.data;
};
const loadColleges = async () => {
  const { data } = await http.get('/admin/colleges');
  colleges.value = data.data;
};
const loadMajors = async () => {
  if (!major.collegeId && colleges.value.length) {
    major.collegeId = colleges.value[0].id;
  }
  const collegeId = major.collegeId || colleges.value[0]?.id;
  if (!collegeId) return;
  const { data } = await http.get('/admin/majors', { params: { collegeId } });
  majors.value = data.data;
};
const loadClazzes = async () => {
  if (!clazz.majorId && majors.value.length) clazz.majorId = majors.value[0].id;
  if (!clazz.majorId) return;
  const { data } = await http.get('/admin/clazzes', { params: { majorId: clazz.majorId } });
  clazzes.value = data.data;
};
const loadCourses = async () => {
  const { data } = await http.get('/admin/courses');
  courses.value = data.data;
};

onMounted(async () => {
  await loadStudents();
  await loadTeachers();
  await loadColleges();
  await loadMajors();
  await loadClazzes();
  await loadCourses();
});
</script>
