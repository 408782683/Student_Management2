<template>
  <table class="table" v-if="rows.length">
    <thead>
      <tr>
        <th v-for="h in headers" :key="h.key">{{ h.label }}</th>
        <th v-if="onEdit || onDelete">操作</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="row in rows" :key="row[idField]">
        <td v-for="h in headers" :key="h.key">{{ row[h.key] }}</td>
        <td v-if="onEdit || onDelete">
          <button v-if="onEdit" @click="() => onEdit(row)">编辑</button>
          <button v-if="onDelete" @click="() => onDelete(row)" style="margin-left:6px; background:#dc2626;">删除</button>
        </td>
      </tr>
    </tbody>
  </table>
  <p v-else>暂无数据</p>
</template>

<script setup>
defineProps({
  headers: { type: Array, default: () => [] },
  rows: { type: Array, default: () => [] },
  idField: { type: String, default: 'id' },
  onEdit: Function,
  onDelete: Function
});
</script>
