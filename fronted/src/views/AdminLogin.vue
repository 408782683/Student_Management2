<template>
  <el-row justify="center" style="margin-top: 60px;">
    <el-col :xs="24" :sm="14" :md="10" :lg="8">
      <el-card shadow="hover">
        <div style="display:flex;justify-content:space-between;align-items:center;">
          <h2 style="margin:0;">管理员登录</h2>
          <el-tag type="danger">Admin</el-tag>
        </div>
        <el-form :model="form" label-width="80px" style="margin-top:16px;">
          <el-form-item label="用户名">
            <el-input v-model="form.username" autocomplete="username" />
          </el-form-item>
          <el-form-item label="密码">
            <el-input v-model="form.password" type="password" show-password autocomplete="current-password" />
          </el-form-item>
          <el-form-item label="验证码">
            <el-input v-model="form.captcha" style="width:180px;" />
            <el-button style="margin-left:8px;" @click="fetchCaptcha">获取验证码</el-button>
            <el-tag v-if="captchaText" type="info" style="margin-left:8px;">{{ captchaText }}</el-tag>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" :loading="loading" @click="submit" block>登录</el-button>
          </el-form-item>
        </el-form>
        <div style="display:flex;justify-content:space-between;">
          <RouterLink to="/">我是学生</RouterLink>
          <RouterLink to="/login/teacher">我是老师</RouterLink>
        </div>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../api/http';
import { useRouter } from 'vue-router';
import { ElMessage } from 'element-plus';

const router = useRouter();
const form = reactive({ username: '', password: '', captcha: '', role: 'ADMIN' });
const captchaText = ref('');
const loading = ref(false);

const fetchCaptcha = async () => {
  if (!form.username) {
    ElMessage.warning('请输入用户名以生成验证码');
    return;
  }
  const { data } = await http.get('/auth/captcha', { params: { key: form.username } });
  captchaText.value = data.data;
};

const submit = async () => {
  loading.value = true;
  try {
    await http.post('/auth/login', form);
    ElMessage.success('登录成功');
    router.push('/admin');
  } finally {
    loading.value = false;
  }
};
</script>
