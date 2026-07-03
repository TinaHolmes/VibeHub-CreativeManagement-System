import request from './request'

export function getSpaceList() {
  return request.get('/spaces')
}
