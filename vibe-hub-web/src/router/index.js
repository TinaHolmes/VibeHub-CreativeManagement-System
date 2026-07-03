import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
    meta: { guest: true }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/Register.vue'),
    meta: { guest: true }
  },
  {
    path: '/',
    component: () => import('../views/Layout.vue'),
    meta: { requiresAuth: true },
    redirect: '/staff',
    children: [
      {
        path: 'staff',
        name: 'Staff',
        component: () => import('../views/StaffList.vue')
      },
      {
        path: 'spaces',
        name: 'Spaces',
        component: () => import('../views/SpaceList.vue')
      },
      {
        path: 'equipments',
        name: 'Equipments',
        component: () => import('../views/EquipmentList.vue')
      },
      {
        path: 'approvals',
        name: 'Approvals',
        component: () => import('../views/ApprovalList.vue')
      },
      {
        path: 'community',
        name: 'Community',
        component: () => import('../views/CommunityList.vue')
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach(async (to, from, next) => {
  const authStore = useAuthStore()

  if (!authStore.checked) {
    await authStore.fetchCurrentUser()
  }

  if (to.meta.requiresAuth && !authStore.isLoggedIn) {
    next('/login')
  } else if (to.meta.guest && authStore.isLoggedIn) {
    next('/staff')
  } else {
    next()
  }
})

export default router
