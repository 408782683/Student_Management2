<template>
  <el-container style="height:100vh;">
    <el-aside width="200px">
      <el-menu :default-active="active" router>
        <el-menu-item index="/teacher/grades">成绩与课表</el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header style="display:flex;justify-content:space-between;align-items:center;">
        <div>教师中心</div>
        <div>
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
