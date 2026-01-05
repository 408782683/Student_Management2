<template>
  <el-container style="height:100vh;">
    <el-aside width="220px">
      <el-menu :default-active="active" router>
        <el-menu-item index="/student/dashboard">工作台</el-menu-item>
        <el-menu-item index="/student/courses">选课</el-menu-item>
        <el-menu-item index="/student/grades">成绩查询</el-menu-item>
        <el-menu-item index="/student/timetable">课表</el-menu-item>
        <el-menu-item index="/student/account">账号安全</el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header style="display:flex;justify-content:space-between;align-items:center;">
        <div style="display:flex;align-items:center;gap:12px;">
          <el-icon><i-ep-reading /></el-icon>
          <div>
            <div style="font-size:16px;font-weight:700;">淮安大学教务系统 · 学生中心</div>
            <div style="font-size:12px;opacity:0.9;">Huai'an University Student Portal</div>
          </div>
        </div>
        <div style="display:flex;align-items:center;gap:8px;">
          <el-tag type="success">{{ user?.role }}</el-tag>
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
