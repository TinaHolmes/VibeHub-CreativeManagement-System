<template>
  <div class="container">
    <div class="header-section">
      <div>
        <h2>创意空间管理</h2>
        <p>VIBE 摄影棚与协作室实时状态监控</p>
      </div>
      <div class="user-tag" v-if="authStore.isLoggedIn">
        Operator: <span>{{ authStore.username }}</span>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th>编号</th>
          <th>空间名称</th>
          <th>功能类型</th>
          <th>容纳人数</th>
          <th>当前状态</th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="spaceList.length === 0">
          <td colspan="5" class="empty-state">🔍 暂无空间数据，请检查数据库配置</td>
        </tr>
        <tr v-for="s in spaceList" :key="s.id">
          <td><span class="id-badge">ID-{{ s.id }}</span></td>
          <td class="name-cell">{{ s.name }}</td>
          <td>{{ s.type }}</td>
          <td>{{ s.capacity }} 人</td>
          <td><span class="status-tag">{{ s.status }}</span></td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../stores/auth'
import { getSpaceList } from '../api/space'

const authStore = useAuthStore()
const spaceList = ref([])

onMounted(async () => {
  try {
    const res = await getSpaceList()
    spaceList.value = res.data
  } catch (e) {
    console.error('Failed to fetch spaces', e)
  }
})
</script>

<style scoped>
:root { --apple-blue: #0071e3; }

body { background-color: #f5f5f7; }
.container {
  width: 90%; max-width: 1000px; margin: 80px auto 40px;
  background: #fff; padding: 50px; border-radius: 24px;
  box-shadow: 0 10px 40px rgba(0,0,0,0.05); animation: slideUp 0.8s ease;
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
}
.header-section {
  display: flex; justify-content: space-between; align-items: flex-end;
  margin-bottom: 40px; border-bottom: 1px solid #f2f2f7; padding-bottom: 20px;
}
h2 { font-size: 42px; font-weight: 700; margin: 0; letter-spacing: -2px; }
.header-section p { color: #86868b; margin-top: 5px; }
.user-tag { font-size: 14px; color: #86868b; }
.user-tag span { font-weight: 600; }

table { width: 100%; border-collapse: collapse; margin-top: 20px; }
th { text-align: left; font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; color: #86868b; padding: 20px 15px; border-bottom: 1px solid #d2d2d7; }
td { padding: 25px 15px; font-size: 15px; border-bottom: 1px solid #f2f2f7; color: #333; }
tr:hover td { background-color: #fafafa; }

.id-badge { background: #000; color: #fff; padding: 4px 10px; border-radius: 6px; font-family: monospace; font-size: 12px; }
.name-cell { font-weight: 700; }
.status-tag { background: rgba(0,113,227,0.08); color: var(--apple-blue); padding: 5px 14px; border-radius: 20px; font-size: 13px; font-weight: 500; }
.empty-state { text-align: center; padding: 100px; color: #86868b; font-style: italic; }

@keyframes slideUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
