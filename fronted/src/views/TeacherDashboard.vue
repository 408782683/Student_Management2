<template>
  <div class="app-shell">
    <h1 style="margin-bottom:8px;">教师工作台</h1>
    <p style="margin-top:0;color:#475569;">选择要进行的教学任务入口。</p>
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
import { DocumentChecked, Notebook, Collection, Lock } from '@element-plus/icons-vue';

const router = useRouter();
const cards = [
  { title: '教学任务', desc: '查看本学期的授课与带班任务。', route: '/teacher/assignments', icon: Notebook },
  { title: '成绩录入', desc: '录入与查询所授课程成绩。', route: '/teacher/grades', icon: DocumentChecked },
  { title: '课表与点名册', desc: '下载个人课表，导出行政班点名册。', route: '/teacher/timetable', icon: Collection },
  { title: '账号与密码', desc: '修改登录密码，保障账户安全。', route: '/teacher/account', icon: Lock }
];

const go = (route) => router.push(route);
</script>
