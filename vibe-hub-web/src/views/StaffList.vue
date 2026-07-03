<template>
  <div class="container">
    <div class="header-section">
      <div>
        <h2>创意人才库</h2>
        <p>VIBE 摄影平台内部人才管理系统</p>
      </div>
      <div class="user-tag" v-if="authStore.isLoggedIn">
        Authenticated: <span>{{ authStore.username }}</span>
      </div>
    </div>

    <div class="search-area">
      <input type="text" v-model="keyword" placeholder="搜索摄影师姓名、创意部门..." @keyup.enter="search" />
      <button class="btn-vibe" @click="search">检索</button>
    </div>

    <table>
      <thead>
        <tr>
          <th>UID</th>
          <th>姓名</th>
          <th>所属部门</th>
          <th>职能岗位</th>
          <th>联络方式</th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="staffList.length === 0">
          <td colspan="5" class="empty-state">🔍 库中暂无匹配项，尝试检索其他关键词</td>
        </tr>
        <tr v-for="s in staffList" :key="s.id">
          <td><span class="id-badge">ID-{{ s.id }}</span></td>
          <td class="name-cell">{{ s.name }}</td>
          <td><span class="dept-tag">{{ s.department }}</span></td>
          <td>{{ s.position }}</td>
          <td class="phone-cell">{{ s.phone }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../stores/auth'
import { getStaffList } from '../api/staff'

const authStore = useAuthStore()
const staffList = ref([])
const keyword = ref('')

async function search() {
  try {
    const res = await getStaffList(keyword.value)
    staffList.value = res.data
  } catch (e) {
    console.error('Failed to fetch staff list', e)
  }
}

onMounted(() => search())
</script>

<style scoped>
:root { --vibe-black: #1b2621; --apple-blue: #0071e3; --text-sec: #86868b; }

body { padding-top: 80px; background-color: #354f52; }
.container {
  width: 92%; max-width: 1050px; margin: 80px auto 40px;
  background: #fff; padding: 50px; border-radius: 24px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.05); animation: slideUp 0.8s ease;
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
}
.header-section {
  display: flex; justify-content: space-between; align-items: flex-end;
  margin-bottom: 40px; border-bottom: 1px solid #eee; padding-bottom: 20px;
}
h2 { font-size: 42px; font-weight: 700; margin: 0; letter-spacing: -2px; }
.header-section p { color: var(--text-sec); margin-top: 5px; }
.user-tag { font-size: 14px; color: var(--text-sec); }
.user-tag span { color: var(--vibe-black); font-weight: 600; }

.search-area {
  background: #f5f5f7; padding: 25px; border-radius: 18px;
  display: flex; gap: 15px; margin-bottom: 40px;
}
input[type="text"] {
  flex: 1; padding: 15px 20px; border: 1px solid #d2d2d7; border-radius: 12px;
  font-size: 16px; outline: none; transition: 0.3s;
}
input[type="text"]:focus { border-color: var(--vibe-black); box-shadow: 0 0 0 4px rgba(0,0,0,0.05); }
.btn-vibe {
  background: var(--vibe-black); color: #fff; border: none; padding: 0 35px;
  border-radius: 12px; font-weight: 600; cursor: pointer; transition: 0.3s;
}
.btn-vibe:hover { background: #333; transform: scale(1.02); }

table { width: 100%; border-collapse: collapse; }
th {
  text-align: left; font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px;
  color: var(--text-sec); padding: 20px 10px; border-bottom: 1px solid var(--text-sec);
}
td { padding: 25px 10px; font-size: 15px; border-bottom: 1px solid #f2f2f7; color: #333; }
tr:hover td { background-color: #ffe9f4; }

.id-badge { background: #000; color: #fff; padding: 4px 10px; border-radius: 6px; font-family: "SF Mono", monospace; font-size: 12px; }
.name-cell { font-weight: 700; }
.dept-tag { background: rgba(0,113,227,0.08); color: var(--apple-blue); padding: 4px 12px; border-radius: 20px; font-size: 13px; font-weight: 500; }
.phone-cell { color: var(--text-sec); }
.empty-state { text-align: center; padding: 100px; color: var(--text-sec); }

@keyframes slideUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
