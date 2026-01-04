<template>
  <div class="card">
    <h2>管理员登录</h2>
    <div class="form-row">
      <label>用户名 <input v-model="form.username" /></label>
      <label>密码 <input type="password" v-model="form.password" /></label>
    </div>
    <div class="form-row">
      <label>验证码 <input v-model="form.captcha" /></label>
      <button @click="fetchCaptcha">获取验证码</button>
      <span v-if="captchaText">当前验证码：<strong>{{ captchaText }}</strong></span>
    </div>
    <button :disabled="loading" @click="submit">登录</button>
    <p style="margin-top:12px;">我是学生？<RouterLink to="/">去学生登录</RouterLink> | 我是老师？<RouterLink to="/login/teacher">去教师登录</RouterLink></p>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../api/http';
import { useRouter } from 'vue-router';

const router = useRouter();
const form = reactive({ username: '', password: '', captcha: '', role: 'ADMIN' });
const captchaText = ref('');
const loading = ref(false);

const fetchCaptcha = async () => {
  if (!form.username) {
    alert('请输入用户名以生成验证码');
    return;
  }
  const { data } = await http.get('/auth/captcha', { params: { key: form.username } });
  captchaText.value = data.data;
};

const submit = async () => {
  loading.value = true;
  try {
    await http.post('/auth/login', form);
    alert('登录成功');
    router.push('/admin');
  } finally {
    loading.value = false;
  }
};
</script>
