<template>
  <div class="auth-page">
    <el-card class="auth-card" shadow="hover" role="form" aria-label="学生登录表单">
      <div class="auth-brand" aria-label="淮安大学教务系统标识">
        <img :src="logo" alt="淮安大学教务系统 logo" />
        <div class="brand-text">
          <span class="brand-title">淮安大学教务系统</span>
          <span class="brand-sub">Huai'an University Academic Portal</span>
        </div>
      </div>
      <div class="auth-header">
        <div>
          <h1 class="auth-title">学生登录</h1>
          <p class="auth-subtitle">使用学号和验证码安全进入学习空间</p>
        </div>
        <el-tag type="success" effect="light">Student</el-tag>
      </div>
      <el-form
        class="auth-form"
        :model="form"
        label-position="top"
        @keyup.enter="submit"
      >
        <div v-if="errorMsg" class="auth-error" role="alert">{{ errorMsg }}</div>
        <el-form-item label="用户名" label-for="student-username">
          <el-input
            id="student-username"
            v-model="form.username"
            autocomplete="username"
            :prefix-icon="User"
            aria-required="true"
          />
        </el-form-item>
        <el-form-item label="密码" label-for="student-password">
          <el-input
            id="student-password"
            v-model="form.password"
            type="password"
            show-password
            autocomplete="current-password"
            :prefix-icon="Lock"
            aria-required="true"
          />
        </el-form-item>
        <el-form-item label="验证码" label-for="student-captcha">
          <div class="auth-captcha">
            <el-input
              id="student-captcha"
              v-model="form.captcha"
              autocomplete="one-time-code"
              aria-required="true"
            />
            <el-button :icon="Refresh" @click="fetchCaptcha">获取验证码</el-button>
            <el-tag v-if="captchaText" type="info">{{ captchaText }}</el-tag>
          </div>
        </el-form-item>
        <el-form-item class="auth-actions">
          <el-button
            type="primary"
            :loading="loading"
            @click="submit"
            style="width:100%;"
            aria-live="polite"
          >
            登录
          </el-button>
        </el-form-item>
      </el-form>
      <div class="auth-links" aria-label="其他角色登录入口">
        <RouterLink to="/login/admin">我是管理员</RouterLink>
        <RouterLink to="/login/teacher">我是老师</RouterLink>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../api/http';
import { useRouter } from 'vue-router';
import { ElMessage } from 'element-plus';
import { User, Lock, Refresh } from '@element-plus/icons-vue';
import logo from '../logo.png';
import { setUser, setPasswordCache } from '../utils/auth';

const router = useRouter();
const form = reactive({ username: '', password: '', captcha: '', role: 'STUDENT' });
const captchaText = ref('');
const loading = ref(false);
const errorMsg = ref('');

const fetchCaptcha = async () => {
  if (!form.username) {
    ElMessage.warning('请输入用户名以生成验证码');
    return;
  }
  const { data } = await http.get('/auth/captcha', { params: { key: form.username } });
  captchaText.value = data.data;
  errorMsg.value = '';
};

const submit = async () => {
  loading.value = true;
  errorMsg.value = '';
  try {
    const { data } = await http.post('/auth/login', form);
    const user = data.data;
    if (!user || user.role !== 'STUDENT') {
      errorMsg.value = '角色不匹配，禁止登录';
      return;
    }
    setUser(user);
    setPasswordCache(user.username, form.password);
    ElMessage.success('登录成功');
    router.push('/student');
  } catch (e) {
    errorMsg.value = '登录失败，请检查账号、密码或验证码';
  } finally {
    loading.value = false;
  }
};
</script>
