<template>
  <div class="card">
    <h2>登录</h2>
    <div class="form-row">
      <label>用户名 <input v-model="form.username" /></label>
      <label>密码 <input type="password" v-model="form.password" /></label>
      <label>角色
        <select v-model="form.role">
          <option value="ADMIN">管理员</option>
          <option value="TEACHER">教师</option>
          <option value="STUDENT">学生</option>
        </select>
      </label>
    </div>
    <div class="form-row">
      <label>验证码 <input v-model="form.captcha" /></label>
      <button @click="fetchCaptcha">获取验证码</button>
      <span v-if="captchaText">当前验证码：<strong>{{ captchaText }}</strong></span>
    </div>
    <button :disabled="loading" @click="submit">登录</button>
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
    if (form.role === 'ADMIN') router.push('/admin');
    if (form.role === 'TEACHER') router.push('/teacher');
    if (form.role === 'STUDENT') router.push('/student');
  } catch (e) {
    // handled globally
  } finally {
    loading.value = false;
  }
};
</script>
