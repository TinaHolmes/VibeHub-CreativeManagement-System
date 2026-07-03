import request from './request'

export function getStaffList(keyword = '') {
  return request.get('/staff', { params: { keyword } })
}
