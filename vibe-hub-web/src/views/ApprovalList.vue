<template>
  <div class="container">
    <div class="header-section">
      <h2>流程审批中心</h2>
      <div class="stats-group">
        <div class="stat-card pending">
          <div class="stat-number">{{ pendingCount }}</div>
          <div class="stat-label">待审批</div>
        </div>
        <div class="stat-card approved">
          <div class="stat-number">{{ approvedCount }}</div>
          <div class="stat-label">已通过</div>
        </div>
      </div>
    </div>

    <div class="filter-tabs">
      <button v-for="f in filters" :key="f.value" :class="['filter-tab', { active: activeFilter === f.value }]" @click="activeFilter = f.value; filterApprovals()">
        {{ f.label }}
      </button>
    </div>

    <table>
      <thead>
        <tr>
          <th>类型</th>
          <th>标题</th>
          <th>提交时间</th>
          <th>状态</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="filteredList.length === 0">
          <td colspan="5" class="empty-state">
            <i class="fa-solid fa-inbox empty-icon"></i>
            <div>暂无审批流程</div>
          </td>
        </tr>
        <tr v-for="a in filteredList" :key="a.id" class="approval-row">
          <td>
            <span class="type-icon">
              <i :class="typeIcon(a.type)"></i> {{ a.type }}
            </span>
            <span v-if="isUrgent(a)" class="urgent-tag">紧急</span>
          </td>
          <td>
            <strong>{{ a.title }}</strong>
            <div class="detail-popup">
              <div class="detail-row"><span class="detail-label">申请编号：</span><span class="detail-value">#{{ a.id }}</span></div>
              <div class="detail-row"><span class="detail-label">申请类型：</span><span class="detail-value">{{ a.type }}</span></div>
              <div class="detail-row"><span class="detail-label">申请标题：</span><span class="detail-value">{{ a.title }}</span></div>
              <div class="detail-row"><span class="detail-label">当前状态：</span><span class="detail-value"><span :class="statusBadge(a.status)">{{ a.status }}</span></span></div>
              <div class="detail-row"><span class="detail-label">提交时间：</span><span class="detail-value">{{ a.createTime }}</span></div>
            </div>
          </td>
          <td>{{ formatTime(a.createTime) }}</td>
          <td>
            <span :class="['status-badge', statusBadge(a.status)]">{{ a.status }}</span>
          </td>
          <td>
            <div class="action-buttons">
              <template v-if="a.status === '待审批'">
                <button class="action-btn approve-btn" @click="handleAction(a.id, '已通过')"><i class="fa-solid fa-check"></i> 通过</button>
                <button class="action-btn reject-btn" @click="handleAction(a.id, '已驳回')"><i class="fa-solid fa-xmark"></i> 驳回</button>
              </template>
              <button class="action-btn detail-btn" @click="alert(`详情 #${a.id}`)"><i class="fa-solid fa-eye"></i> 详情</button>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { getApprovalList, updateApprovalStatus } from '../api/approval'

const approvalList = ref([])
const activeFilter = ref('all')

const filters = [
  { label: '全部', value: 'all' },
  { label: '待审批', value: '待审批' },
  { label: '已通过', value: '已通过' },
  { label: '已驳回', value: '已驳回' }
]

const pendingCount = computed(() => approvalList.value.filter(a => a.status === '待审批').length)
const approvedCount = computed(() => approvalList.value.filter(a => a.status === '已通过').length)
const filteredList = computed(() => activeFilter.value === 'all' ? approvalList.value : approvalList.value.filter(a => a.status === activeFilter.value))

function typeIcon(type) {
  if (type.includes('请假')) return 'fa-solid fa-calendar-days'
  if (type.includes('报销')) return 'fa-solid fa-receipt'
  if (type.includes('采购')) return 'fa-solid fa-cart-shopping'
  return 'fa-solid fa-file-lines'
}

function statusBadge(status) {
  if (status === '已通过') return 'approved'
  if (status === '已驳回') return 'rejected'
  return 'pending'
}

function isUrgent(a) {
  return a.status === '待审批' && a.id % 2 === 1
}

function formatTime(t) {
  if (!t) return ''
  return t.toString().substring(0, 16)
}

async function fetchApprovals() {
  try {
    const res = await getApprovalList(activeFilter.value)
    approvalList.value = res.data
  } catch (e) {
    console.error('Failed to fetch approvals', e)
  }
}

function filterApprovals() {
  fetchApprovals()
}

async function handleAction(id, status) {
  if (confirm(`确定要${status === '已通过' ? '通过' : '驳回'}这个申请吗？`)) {
    try {
      await updateApprovalStatus(id, status)
      fetchApprovals()
    } catch (e) {
      alert('操作失败')
    }
  }
}

onMounted(() => fetchApprovals())
</script>

<style scoped>
:root { --vibe-black: #000; --apple-bg: #f5f5f7; --apple-blue: #0071e3; --apple-green: #34c759; --apple-red: #ff3b30; }

body { background: var(--apple-bg); padding-top: 80px; display: flex; justify-content: center; }
.container {
  width: 90%; max-width: 1200px; margin: 80px auto 40px;
  background: #fff; padding: 50px; border-radius: 24px;
  box-shadow: 0 10px 40px rgba(0,0,0,0.05);
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
}
.header-section { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
.header-section h2 { font-size: 42px; font-weight: 700; letter-spacing: -2px; margin: 0; }

.stats-group { display: flex; gap: 20px; }
.stat-card { padding: 15px 25px; border-radius: 16px; color: #fff; text-align: center; min-width: 100px; }
.stat-card.pending { background: linear-gradient(135deg, #FF9F0A 0%, #FFB340 100%); }
.stat-card.approved { background: linear-gradient(135deg, #30D158 0%, #63E6BE 100%); }
.stat-number { font-size: 28px; font-weight: 700; }
.stat-label { font-size: 12px; opacity: 0.95; margin-top: 5px; font-weight: 500; }

.filter-tabs { display: flex; gap: 10px; margin-bottom: 30px; border-bottom: 1px solid #e5e5e5; padding-bottom: 15px; }
.filter-tab { padding: 8px 20px; border-radius: 20px; background: transparent; border: 1px solid #d2d2d7; color: #86868b; cursor: pointer; font-size: 14px; transition: 0.3s; }
.filter-tab:hover { background: #f5f5f7; }
.filter-tab.active { background: var(--vibe-black); color: #fff; border-color: var(--vibe-black); }

table { width: 100%; border-collapse: separate; border-spacing: 0; }
th { text-align: left; color: #86868b; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; padding: 15px; border-bottom: 2px solid #d2d2d7; }
td { padding: 25px 15px; border-bottom: 1px solid #f2f2f7; font-size: 14px; }

tbody tr { transition: all 0.2s ease; cursor: pointer; position: relative; z-index: 1; background: #fff; }
tbody tr:hover { background: #f9f9f9; transform: scale(1.01); box-shadow: 0 4px 20px rgba(0,0,0,0.08); z-index: 100; border-radius: 12px; }

.status-badge { padding: 6px 16px; border-radius: 20px; font-size: 13px; font-weight: 600; display: inline-block; }
.status-badge.pending { background: #fff7e6; color: #fa8c16; }
.status-badge.approved { background: #f6ffed; color: #52c41a; }
.status-badge.rejected { background: #fff1f0; color: #ff4d4f; }

.type-icon { display: inline-flex; align-items: center; gap: 8px; color: var(--apple-blue); font-weight: 600; }

.urgent-tag { background: linear-gradient(135deg, #ff6b6b, #ee5a6f); color: #fff; padding: 3px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; margin-left: 10px; animation: pulse 2s infinite; }

.action-buttons { display: flex; gap: 8px; opacity: 0; transition: 0.3s; }
tr:hover .action-buttons { opacity: 1; }
.action-btn { padding: 8px 16px; border: none; border-radius: 12px; font-size: 13px; font-weight: 500; cursor: pointer; transition: 0.3s; display: inline-flex; align-items: center; gap: 6px; color: #fff; }
.approve-btn { background: var(--apple-green); }
.approve-btn:hover { background: #28a745; transform: translateY(-2px); }
.reject-btn { background: var(--apple-red); }
.reject-btn:hover { background: #dc3545; transform: translateY(-2px); }
.detail-btn { background: var(--apple-blue); }
.detail-btn:hover { background: #005bb5; transform: translateY(-2px); }

.detail-popup {
  display: none; position: absolute; left: 50%; top: 80%;
  transform: translateX(-50%); width: 400px; background: #fff;
  border-radius: 16px; padding: 25px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.2); z-index: 999;
  margin-top: 10px; border: 1px solid rgba(0,0,0,0.05);
}
tr:hover .detail-popup { display: block; }
.detail-popup::before {
  content: ''; position: absolute; top: -8px; left: 50%;
  transform: translateX(-50%); width: 0; height: 0;
  border-left: 8px solid transparent; border-right: 8px solid transparent; border-bottom: 8px solid #fff;
}
.detail-row { display: flex; margin-bottom: 15px; padding-bottom: 15px; border-bottom: 1px solid #f0f0f0; }
.detail-row:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
.detail-label { font-size: 13px; color: #86868b; width: 100px; font-weight: 500; }
.detail-value { font-size: 14px; color: #1d1d1f; flex: 1; }

.empty-state { text-align: center; padding: 60px; color: #86868b; }
.empty-icon { font-size: 48px; margin-bottom: 15px; opacity: 0.3; }

@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.7; } }
</style>
