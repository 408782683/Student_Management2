<template>
  <div class="app-shell">
    <h1 style="margin-bottom:8px;">管理员工作台</h1>
    <p style="margin-top:0;color:#475569;">请选择要进入的业务模块，完成对应的教务管理任务。</p>
    <el-row :gutter="16">
      <el-col v-for="card in cards" :key="card.route" :xs="24" :sm="12" :md="8" :lg="6">
        <el-card shadow="hover" class="module-card" @click="go(card.route)" :body-style="{minHeight:'140px',cursor:'pointer'}">
          <div style="display:flex;align-items:flex-start;gap:10px;">
            <el-icon :size="26"><component :is="card.icon" /></el-icon>
            <div>
              <div style="font-weight:700;font-size:16px;">{{ card.title }}</div>
              <div style="color:#6b7280;margin:6px 0 10px;">{{ card.desc }}</div>
              <el-tag size="small" type="info">{{ card.badge }}</el-tag>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router';
import { School, Collection, Notebook, SetUp, List, Upload } from '@element-plus/icons-vue';

const router = useRouter();
const cards = [
  { title: '学生管理', desc: '录入、查询、更新和删除学生信息。', route: '/admin/students', badge: 'Student', icon: School },
  { title: '教师管理', desc: '维护教师档案、联系方式与任教信息。', route: '/admin/teachers', badge: 'Teacher', icon: Collection },
  { title: '学院 / 专业 / 班级', desc: '维护院系层级、专业与班级关联。', route: '/admin/org', badge: 'Org', icon: Notebook },
  { title: '课程与培养计划', desc: '配置课程与学期培养计划。', route: '/admin/course-plan', badge: 'Course', icon: SetUp },
  { title: '教学任务分配', desc: '为计划分配授课教师并查看历史记录。', route: '/admin/assignments', badge: 'Task', icon: List },
  { title: '课表管理', desc: '上传并管理专业 / 教师 / 学生课表文件。', route: '/admin/timetable', badge: 'Timetable', icon: Upload }
];

const go = (route) => router.push(route);
</script>
