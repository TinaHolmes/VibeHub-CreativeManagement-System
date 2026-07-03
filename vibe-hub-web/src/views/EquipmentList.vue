<template>
  <div class="container">
    <div class="header-section">
      <div>
        <h2>器材调度中心</h2>
        <p>VIBE 全球影像资产实时清单</p>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th>资产编号</th>
          <th>器材名称</th>
          <th>型号/类别</th>
          <th>当前状态</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="e in equipList" :key="e.id">
          <td><span class="id-badge">EQ-{{ e.id }}</span></td>
          <td class="name-cell">{{ e.name }}</td>
          <td>{{ e.model }}</td>
          <td>
            <span :class="['status-dot', statusClass(e.status)]">
              <i class="fa-solid fa-circle" style="font-size: 8px;"></i> {{ e.status }}
            </span>
          </td>
          <td>
            <a v-if="e.status === '在库'" href="#" class="btn-action" @click.prevent>申请领用</a>
            <span v-else class="unavailable">暂不可用</span>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getEquipmentList } from '../api/equipment'

const equipList = ref([])

function statusClass(status) {
  if (status === '在库') return 'in-stock'
  if (status === '出借中') return 'out-stock'
  return 'fixing'
}

onMounted(async () => {
  try {
    const res = await getEquipmentList()
    equipList.value = res.data
  } catch (e) {
    console.error('Failed to fetch equipments', e)
  }
})
</script>

<style scoped>
:root { --apple-blue: #0071e3; --apple-bg: #f5f5f7; }
body { background-color: var(--apple-bg); }
.container {
  width: 90%; max-width: 1000px; margin: 80px auto 40px;
  background: #fff; padding: 50px; border-radius: 24px;
  box-shadow: 0 10px 40px rgba(0,0,0,0.05);
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
}
.header-section {
  display: flex; justify-content: space-between; align-items: flex-end;
  margin-bottom: 40px; border-bottom: 1px solid #f2f2f7; padding-bottom: 20px;
}
h2 { font-size: 42px; font-weight: 700; margin: 0; letter-spacing: -2px; }
.header-section p { color: #86868b; margin-top: 5px; }

table { width: 100%; border-collapse: collapse; }
th { text-align: left; font-size: 11px; text-transform: uppercase; color: #86868b; padding: 20px 15px; border-bottom: 1px solid #d2d2d7; }
td { padding: 25px 15px; font-size: 15px; border-bottom: 1px solid #f2f2f7; }

.id-badge { background: #000; color: #fff; padding: 4px 10px; border-radius: 6px; font-family: monospace; }
.name-cell { font-weight: 700; }

.status-dot { display: inline-flex; align-items: center; gap: 8px; padding: 5px 12px; border-radius: 20px; font-size: 13px; font-weight: 500; }
.in-stock { background: rgba(40, 167, 69, 0.1); color: #28a745; }
.out-stock { background: rgba(255, 159, 10, 0.1); color: #ff9f0a; }
.fixing { background: rgba(255, 59, 48, 0.1); color: #ff3b30; }

.btn-action { background: var(--apple-blue); color: #fff; padding: 8px 18px; border-radius: 10px; text-decoration: none; font-size: 13px; font-weight: 500; transition: 0.2s; }
.btn-action:hover { background: #0077ed; transform: scale(1.05); }
.unavailable { color: #ccc; font-size: 13px; }
</style>
