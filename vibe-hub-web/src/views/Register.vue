<template>
  <div class="register-page">
    <div class="register-container">
      <div class="register-header">
        <h1><i class="fa-solid fa-user-plus" style="color: var(--apple-blue); margin-right: 10px;"></i>员工注册</h1>
        <p>请使用公司分配的员工工号完成注册</p>
      </div>

      <div class="info-box">
        <p><strong><i class="fa-solid fa-circle-info"></i> 注意事项</strong></p>
        <p>• 仅限公司内部员工注册<br>
           • 请输入 IT 部门分配的员工工号（UID）<br>
           • 首次注册请联系管理员获取验证码</p>
      </div>

      <div v-if="errorMsg" class="error-message" style="display: block;">
        <i class="fa-solid fa-triangle-exclamation"></i> {{ errorMsg }}
      </div>

      <form @submit.prevent="handleRegister">
        <div class="form-group">
          <label>员工工号 (UID) <span class="required">*</span></label>
          <input type="text" v-model="form.uid" placeholder="例如: ID-001" required>
        </div>
        <div class="form-group">
          <label>验证码 <span class="required">*</span></label>
          <input type="text" v-model="form.verifyCode" placeholder="请联系 IT 部门获取" required>
        </div>
        <div class="form-group">
          <label>用户名 <span class="required">*</span></label>
          <input type="text" v-model="form.username" placeholder="设置登录用户名" required>
        </div>
        <div class="form-group">
          <label>密码 <span class="required">*</span></label>
          <input type="password" v-model="form.password" placeholder="至少 6 位字符" required minlength="6" @input="checkStrength">
          <div class="password-strength" v-show="form.password.length > 0">
            <div class="password-strength-bar" :style="{ width: strength + '%', background: strengthColor }"></div>
          </div>
          <div class="password-hint">密码强度建议：包含大小写字母、数字</div>
        </div>
        <div class="form-group">
          <label>确认密码 <span class="required">*</span></label>
          <input type="password" v-model="form.confirmPassword" placeholder="再次输入密码" required>
        </div>
        <button type="submit" class="register-btn" :disabled="loading">
          <i class="fa-solid fa-check"></i> {{ loading ? '注册中...' : '完成注册' }}
        </button>
      </form>

      <div class="back-link">
        <router-link to="/login"><i class="fa-solid fa-arrow-left"></i> 返回登录</router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const form = reactive({
  uid: '', verifyCode: '', username: '', password: '', confirmPassword: ''
})
const loading = ref(false)
const errorMsg = ref('')
const strength = ref(0)

const strengthColor = computed(() => {
  if (strength.value <= 25) return '#ff3b30'
  if (strength.value <= 50) return '#ff9500'
  if (strength.value <= 75) return '#ffcc00'
  return '#34c759'
})

function checkStrength() {
  const pwd = form.password
  let s = 0
  if (pwd.length >= 6) s += 25
  if (pwd.length >= 10) s += 25
  if (/[a-z]/.test(pwd) && /[A-Z]/.test(pwd)) s += 25
  if (/\d/.test(pwd)) s += 25
  strength.value = s
}

async function handleRegister() {
  errorMsg.value = ''
  if (form.password !== form.confirmPassword) {
    errorMsg.value = '两次输入的密码不一致！'
    return
  }
  if (form.password.length < 6) {
    errorMsg.value = '密码长度至少为 6 位！'
    return
  }
  loading.value = true
  const ok = await authStore.register({ ...form })
  loading.value = false
  if (ok) {
    router.push('/login?register=success')
  } else {
    errorMsg.value = authStore.error || '注册失败'
  }
}
</script>

<style scoped>
:root { --apple-blue: #0071e3; --vibe-black: #1d1d1f; }

.register-page {
  min-height: 100vh; display: flex; justify-content: center; align-items: center;
  background: linear-gradient(135deg, #667eea 0%, #ffff99 120%);
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
}
.register-container {
  background: white; border-radius: 30px; padding: 60px;
  max-width: 500px; width: 90%;
  box-shadow: 0 30px 60px rgba(0,0,0,0.2); animation: slideUp 0.6s ease;
}
.register-header { text-align: center; margin-bottom: 40px; }
.register-header h1 { font-size: 36px; font-weight: 700; margin: 0 0 10px 0; color: var(--vibe-black); }
.register-header p { color: #86868b; font-size: 15px; margin: 0; }

.info-box {
  background: #f5f5f7; border-radius: 12px; padding: 16px;
  margin-bottom: 30px; border-left: 4px solid var(--apple-blue);
}
.info-box p { margin: 0; color: #86868b; font-size: 14px; line-height: 1.5; }
.info-box strong { color: #1d1d1f; }

.form-group { margin-bottom: 20px; }
.form-group label { display: block; margin-bottom: 8px; font-size: 14px; font-weight: 500; color: #1d1d1f; }
.required { color: #ff3b30; }
.form-group input {
  width: 100%; padding: 16px; border: 1px solid #d2d2d7; border-radius: 12px;
  font-size: 16px; background: #f5f5f7; outline: none; transition: 0.3s;
}
.form-group input:focus {
  border-color: var(--apple-blue); background: #fff;
  box-shadow: 0 0 0 4px rgba(0,113,227,0.1);
}

.password-strength { margin-top: 8px; height: 4px; background: #e5e5e7; border-radius: 2px; overflow: hidden; }
.password-strength-bar { height: 100%; width: 0%; transition: 0.3s; border-radius: 2px; }
.password-hint { font-size: 12px; color: #86868b; margin-top: 6px; }

.register-btn {
  width: 100%; padding: 18px; background: var(--vibe-black);
  color: white; border: none; border-radius: 12px; font-size: 17px;
  font-weight: 500; cursor: pointer; transition: 0.3s; margin-top: 10px;
}
.register-btn:hover { background: #333; transform: scale(1.01); box-shadow: 0 10px 20px rgba(0,0,0,0.15); }
.register-btn:disabled { opacity: 0.6; cursor: not-allowed; }

.back-link {
  text-align: center; margin-top: 25px; padding-top: 20px; border-top: 1px solid #eee;
}
.back-link a { color: var(--apple-blue); text-decoration: none; font-size: 15px; font-weight: 500; }

.error-message {
  background: #ffe5e5; color: #ff3b30; padding: 12px 16px;
  border-radius: 8px; margin-bottom: 20px; font-size: 14px;
}

@keyframes slideUp {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
