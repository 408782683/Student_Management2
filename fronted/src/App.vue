<template>
  <div class="app-shell">
    <h1>高校实习教务管理系统</h1>
    <p>后端已提供 REST 接口，前端示例基于 Vue 3 + Vite，可直接调试或扩展。</p>
    <nav class="card" style="display:flex; gap:12px; align-items:center;">
      <RouterLink to="/">登录</RouterLink>
      <RouterLink to="/admin">管理员</RouterLink>
      <RouterLink to="/teacher">教师</RouterLink>
      <RouterLink to="/student">学生</RouterLink>
    </nav>
    <RouterView />
  </div>
</template>

<script setup>
</script>

<style scoped>
nav a {
  color: #2563eb;
  text-decoration: none;
  font-weight: 600;
}
nav a.router-link-active {
  text-decoration: underline;
}
</style>
