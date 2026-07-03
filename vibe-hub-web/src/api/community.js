import request from './request'

export function getPostList() {
  return request.get('/community')
}

export function likePost(id) {
  return request.put(`/community/${id}/like`)
}
