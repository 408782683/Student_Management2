<template>
  <el-container style="height:100vh;">
    <el-aside width="220px">
      <el-menu :default-active="active" router>
        <el-menu-item index="/admin/base">工作台</el-menu-item>
        <el-menu-item index="/admin/students">学生管理</el-menu-item>
        <el-menu-item index="/admin/teachers">教师管理</el-menu-item>
        <el-menu-item index="/admin/org">学院/专业/班级</el-menu-item>
        <el-menu-item index="/admin/course-plan">课程与培养计划</el-menu-item>
        <el-menu-item index="/admin/assignments">教学任务分配</el-menu-item>
        <el-menu-item index="/admin/timetable">课表管理</el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header style="display:flex;justify-content:space-between;align-items:center;">
        <div style="display:flex;align-items:center;gap:12px;">
          <el-icon><i-ep-suitcase /></el-icon>
          <div>
            <div style="font-size:16px;font-weight:700;">淮安大学教务系统 · 管理员中心</div>
            <div style="font-size:12px;opacity:0.9;">Huai'an University Academic Admin Portal</div>
          </div>
        </div>
        <div style="display:flex;align-items:center;gap:8px;">
          <el-tag type="danger">{{ user?.role }}</el-tag>
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
import { Suitcase as IepSuitcase } from '@element-plus/icons-vue';

const route = useRoute();
const router = useRouter();
const user = computed(() => getUser());
const active = computed(() => route.path);

const logout = () => {
  clearUser();
  router.push('/');
};
</script>
