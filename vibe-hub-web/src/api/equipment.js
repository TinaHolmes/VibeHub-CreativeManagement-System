import request from './request'

export function getEquipmentList() {
  return request.get('/equipments')
}
