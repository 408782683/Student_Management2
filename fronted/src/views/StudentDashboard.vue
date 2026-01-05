<template>
  <div class="app-shell">
    <h1 style="margin-bottom:8px;">学生工作台</h1>
    <p style="margin-top:0;color:#475569;">请选择你要进行的学习与查询入口。</p>
    <el-row :gutter="16">
      <el-col v-for="card in cards" :key="card.route" :xs="24" :sm="12" :md="8">
        <el-card shadow="hover" class="module-card" @click="go(card.route)" :body-style="{minHeight:'120px',cursor:'pointer'}">
          <div style="display:flex;align-items:flex-start;gap:10px;">
            <el-icon :size="24"><component :is="card.icon" /></el-icon>
            <div>
              <div style="font-weight:700;font-size:16px;">{{ card.title }}</div>
              <div style="color:#6b7280;margin-top:6px;">{{ card.desc }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router';
import { Notebook, DataAnalysis, Collection, Lock } from '@element-plus/icons-vue';

const router = useRouter();
const cards = [
  { title: '选课中心', desc: '查看可选课程并提交选课申请。', route: '/student/courses', icon: Notebook },
  { title: '成绩查询', desc: '查看并打印个人成绩单。', route: '/student/grades', icon: DataAnalysis },
  { title: '课表下载', desc: '按学期获取个人课表文件。', route: '/student/timetable', icon: Collection },
  { title: '账号与密码', desc: '修改登录密码，保障账户安全。', route: '/student/account', icon: Lock }
];

const go = (route) => router.push(route);
</script>
