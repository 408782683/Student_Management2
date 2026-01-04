<template>
  <div class="card">
    <h2>学生登录</h2>
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
    <div class="form-row" style="justify-content: space-between; margin-top:8px;">
      <RouterLink to="/login/admin">我是管理员</RouterLink>
      <RouterLink to="/login/teacher">我是老师</RouterLink>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import http from '../api/http';
import { useRouter } from 'vue-router';

const router = useRouter();
const form = reactive({ username: '', password: '', captcha: '', role: 'STUDENT' });
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
    router.push('/student');
  } catch (e) {
    // handled globally
  } finally {
    loading.value = false;
  }
};
</script>
