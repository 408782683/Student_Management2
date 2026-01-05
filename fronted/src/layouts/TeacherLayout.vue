<template>
  <el-container style="height:100vh;">
    <el-aside width="220px">
      <el-menu :default-active="active" router>
        <el-menu-item index="/teacher/dashboard">工作台</el-menu-item>
        <el-menu-item index="/teacher/assignments">教学任务</el-menu-item>
        <el-menu-item index="/teacher/grades">成绩录入</el-menu-item>
        <el-menu-item index="/teacher/timetable">课表与点名册</el-menu-item>
        <el-menu-item index="/teacher/account">账号安全</el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header style="display:flex;justify-content:space-between;align-items:center;">
        <div style="display:flex;align-items:center;gap:12px;">
          <el-icon><i-ep-notebook /></el-icon>
          <div>
            <div style="font-size:16px;font-weight:700;">淮安大学教务系统 · 教师中心</div>
            <div style="font-size:12px;opacity:0.9;">Huai'an University Teaching Portal</div>
          </div>
        </div>
        <div style="display:flex;align-items:center;gap:8px;">
          <el-tag type="warning">{{ user?.role }}</el-tag>
          <span style="margin-left:8px;">{{ user?.name || user?.username }}</span>
          <el-button size="small" type="text" @click="logout">退出</el-button>
        </div>
      </el-header>
      <el-main style="background:#f5f5f5;">
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup>
import { computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { getUser, clearUser } from '../utils/auth';

const route = useRoute();
const router = useRouter();
const user = computed(() => getUser());
const active = computed(() => route.path);

const logout = () => {
  clearUser();
  router.push('/');
};
</script>
