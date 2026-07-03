import request from './request'

export function getApprovalList(status = '') {
  const params = {}
  if (status && status !== 'all') params.status = status
  return request.get('/approvals', { params })
}

export function updateApprovalStatus(id, status) {
  return request.put(`/approvals/${id}`, { status })
}
