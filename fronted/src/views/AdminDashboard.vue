<template>
  <div class="card">
    <h2>管理员 - 学生/教师信息</h2>
    <div class="form-row">
      <input v-model="student.id" type="number" placeholder="学生ID(留空新增)" />
      <input v-model="student.studentNo" placeholder="学号" />
      <input v-model="student.name" placeholder="姓名" />
      <input v-model="student.gender" placeholder="性别" />
      <input v-model="student.classId" type="number" placeholder="班级ID" />
      <input v-model="student.photoUrl" placeholder="照片URL" />
      <input v-model="student.phone" placeholder="电话" />
      <input v-model="student.email" placeholder="邮箱" />
      <input v-model="student.enrollmentDate" type="date" />
      <button @click="saveStudent">保存学生</button>
    </div>
    <crud-table :headers="studentHeaders" :rows="students" :on-edit="fillStudent" :on-delete="removeStudent" />
  </div>

  <div class="card">
    <h2>教师信息</h2>
    <div class="form-row">
      <input v-model="teacher.id" type="number" placeholder="教师ID(留空新增)" />
      <input v-model="teacher.teacherNo" placeholder="工号" />
      <input v-model="teacher.name" placeholder="姓名" />
      <input v-model="teacher.title" placeholder="职称" />
      <input v-model="teacher.collegeId" type="number" placeholder="学院ID" />
      <input v-model="teacher.photoUrl" placeholder="照片URL" />
      <input v-model="teacher.phone" placeholder="电话" />
      <input v-model="teacher.email" placeholder="邮箱" />
      <input v-model="teacher.hiredDate" type="date" />
      <button @click="saveTeacher">保存教师</button>
    </div>
    <crud-table :headers="teacherHeaders" :rows="teachers" :on-edit="fillTeacher" :on-delete="removeTeacher" />
  </div>

  <div class="card">
    <h2>学院 / 专业 / 班级</h2>
    <div class="form-row">
      <input v-model="college.name" placeholder="学院名称" />
      <input v-model="college.code" placeholder="学院代码" />
      <input v-model="college.description" placeholder="描述" />
      <button @click="saveCollege">新增学院</button>
    </div>
    <crud-table :headers="collegeHeaders" :rows="colleges" />

    <div class="form-row">
      <select v-model="major.collegeId">
        <option value="">选择学院</option>
        <option v-for=\"c in colleges\" :key=\"c.id\" :value=\"c.id\">{{ c.name }}</option>
      </select>
      <input v-model="major.name" placeholder="专业名称" />
      <input v-model="major.code" placeholder="专业代码" />
      <input v-model="major.description" placeholder="描述" />
      <button @click="saveMajor">新增专业</button>
    </div>
    <crud-table :headers="majorHeaders" :rows="majors" />

    <div class="form-row">
      <select v-model="clazz.majorId">
        <option value="">选择专业</option>
        <option v-for=\"m in majors\" :key=\"m.id\" :value=\"m.id\">{{ m.name }}</option>
      </select>
      <input v-model="clazz.name" placeholder="班级名称" />
      <input v-model.number="clazz.grade" type="number" placeholder="年级" />
      <input v-model="clazz.counselor" placeholder="辅导员" />
      <button @click="saveClazz">新增班级</button>
    </div>
    <crud-table :headers="clazzHeaders" :rows="clazzes" />
  </div>

  <div class="card">
    <h2>课程与培养计划</h2>
    <div class="form-row">
      <input v-model="course.name" placeholder="课程名称" />
      <input v-model.number="course.credit" placeholder="学分" type="number" />
      <input v-model="course.category" placeholder="课程分类" />
      <input v-model="course.nature" placeholder="课程性质" />
      <input v-model="course.assessmentMethod" placeholder="考核方式" />
      <button @click="saveCourse">保存课程</button>
    </div>
    <crud-table :headers="courseHeaders" :rows="courses" />

    <div class="form-row">
      <input v-model="plan.term" placeholder="学期 2024-2025-1" />
      <select v-model="plan.majorId">
        <option value="">选择专业</option>
        <option v-for=\"m in majors\" :key=\"m.id\" :value=\"m.id\">{{ m.name }}</option>
      </select>
      <select v-model="plan.courseId">
        <option value="">选择课程</option>
        <option v-for=\"c in courses\" :key=\"c.id\" :value=\"c.id\">{{ c.name }}</option>
      </select>
      <button @click="savePlan">新增培养计划</button>
    </div>
    <div class=\"form-row\">
      <input v-model=\"planQuery.term\" placeholder=\"查询学期\" />
      <select v-model=\"planQuery.majorId\">
        <option value="">选择专业</option>
        <option v-for=\"m in majors\" :key=\"m.id\" :value=\"m.id\">{{ m.name }}</option>
      </select>
      <button @click=\"loadPlans\">查询计划</button>
    </div>
    <crud-table :headers=\"planHeaders\" :rows=\"plans\" />
  </div>

  <div class=\"card\">
    <h2>教学任务分配</h2>
    <div class=\"form-row\">
      <select v-model=\"assignment.termPlanId\">
        <option value="">选择培养计划ID</option>
        <option v-for=\"p in plans\" :key=\"p.id\" :value=\"p.id\">{{ p.id }} - {{ p.term }}</option>
      </select>
      <input v-model.number=\"assignment.teacherId\" type=\"number\" placeholder=\"教师ID\" />
      <input v-model=\"assignment.courseType\" placeholder=\"课程类别 (基础/专业)\" />
      <input v-model=\"assignment.remarks\" placeholder=\"备注\" />
      <button @click=\"saveAssignment\">保存分配</button>
    </div>
    <div class=\"form-row\">
      <input v-model=\"assignmentTerm\" placeholder=\"查询学期\" />
      <button @click=\"loadAssignments\">查询</button>
    </div>
    <crud-table :headers=\"assignmentHeaders\" :rows=\"assignments\" />
  </div>

  <div class=\"card\">
    <h2>上传课表</h2>
    <div class=\"form-row\">
      <select v-model=\"upload.ownerType\">
        <option value=\"MAJOR\">专业课表</option>
        <option value=\"TEACHER\">教师课表</option>
        <option value=\"STUDENT\">学生课表</option>
      </select>
      <input v-model.number=\"upload.ownerId\" placeholder=\"关联ID\" type=\"number\" />
      <input v-model=\"upload.term\" placeholder=\"学期 2024-2025-1\" />
      <input type=\"file\" @change=\"onFileChange\" />
      <button :disabled=\"!upload.file\" @click=\"doUpload\">上传</button>
    </div>
    <div v-if=\"timetables.length\">
      <h3>已上传</h3>
      <ul>
        <li v-for=\"t in timetables\" :key=\"t.id\">{{ t.term }} - {{ t.fileName }} ({{ t.fileUrl }})</li>
      </ul>
    </div>
  </div>
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
