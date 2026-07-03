import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { loginAPI, registerAPI, logoutAPI, getCurrentUserAPI } from '../api/auth'

export const useAuthStore = defineStore('auth', () => {
  const currentUser = ref(null)
  const checked = ref(false)
  const error = ref(null)

  const isLoggedIn = computed(() => currentUser.value !== null)
  const username = computed(() => currentUser.value?.username || '')

  async function login(username, password) {
    error.value = null
    try {
      const res = await loginAPI(username, password)
      currentUser.value = res.data
      return true
    } catch (e) {
      error.value = e.response?.data?.message || '登录失败'
      return false
    }
  }

  async function register(data) {
    error.value = null
    try {
      await registerAPI(data)
      return true
    } catch (e) {
      error.value = e.response?.data?.message || '注册失败'
      return false
    }
  }

  async function logout() {
    try {
      await logoutAPI()
    } finally {
      currentUser.value = null
    }
  }

  async function fetchCurrentUser() {
    try {
      const res = await getCurrentUserAPI()
      currentUser.value = res.data
    } catch {
      currentUser.value = null
    } finally {
      checked.value = true
    }
  }

  return { currentUser, checked, error, isLoggedIn, username, login, register, logout, fetchCurrentUser }
})
