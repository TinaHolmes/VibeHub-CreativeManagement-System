<template>
  <div>
    <nav class="vibe-nav">
      <div class="nav-content">
        <router-link to="/staff" class="nav-logo">Holmes VIBE HUB</router-link>
        <div class="nav-menu">
          <router-link to="/staff">创意人才</router-link>
          <router-link to="/spaces">创意空间</router-link>
          <router-link to="/equipments">器材调度</router-link>
          <router-link to="/approvals">流程审批</router-link>
          <router-link to="/community">内部社群</router-link>
          <a href="#" class="logout-link" @click.prevent="handleLogout">退出 HUB</a>
        </div>
      </div>
    </nav>

    <router-view />
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const router = useRouter()
const authStore = useAuthStore()

async function handleLogout() {
  await authStore.logout()
  router.push('/login')
}
</script>

<style scoped>
.vibe-nav {
  position: fixed; top: 0; left: 0; width: 100%; height: 50px;
  background: rgba(0, 0, 0, 0.85); backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px); z-index: 1000;
  display: flex; justify-content: center;
  border-bottom: 1px solid rgba(255,255,255,0.1);
}
.nav-content {
  width: 90%; max-width: 1100px;
  display: flex; justify-content: space-between; align-items: center;
}
.nav-logo { color: #fff; font-weight: 700; font-size: 18px; text-decoration: none; letter-spacing: 1px; }
.nav-menu { display: flex; gap: 30px; }
.nav-menu a { color: #ccc; text-decoration: none; font-size: 14px; transition: 0.3s; }
.nav-menu a:hover, .nav-menu a.router-link-active { color: #fff; }
.logout-link { color: #ff3b30 !important; font-weight: 600; }
</style>
