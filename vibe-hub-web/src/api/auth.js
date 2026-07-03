import request from './request'

export function loginAPI(username, password) {
  return request.post('/auth/login', { username, password })
}

export function registerAPI(data) {
  return request.post('/auth/register', data)
}

export function logoutAPI() {
  return request.post('/auth/logout')
}

export function getCurrentUserAPI() {
  return request.get('/auth/me')
}
