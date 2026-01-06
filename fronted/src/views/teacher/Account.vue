<template>
  <el-card class="card-block" shadow="hover">
    <template #header><strong>账号与密码</strong></template>
    <el-form :model="pwd" label-width="90px" :inline="true">
      <el-form-item label="新密码"><el-input v-model="pwd.newPassword" type="password" show-password /></el-form-item>
      <el-form-item><el-button type="primary" @click="changePwd">修改</el-button></el-form-item>
    </el-form>
  </el-card>
</template>

<script setup>
import { reactive } from 'vue';
import { ElMessage } from 'element-plus';
import http from '../../api/http';
import { getUser, getPasswordCache } from '../../utils/auth';

const user = getUser();
const cache = getPasswordCache();
const pwd = reactive({ newPassword: '' });

const changePwd = async () => {
  await http.post('/teacher/password', { username: user?.username, oldPassword: cache?.password || '', newPassword: pwd.newPassword });
  ElMessage.success('密码已修改');
};
</script>
