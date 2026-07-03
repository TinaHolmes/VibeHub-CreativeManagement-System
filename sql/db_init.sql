-- =============================================
-- VibeHub 创意工作室管理系统 - 数据库初始化脚本
-- 数据库: company_db
-- =============================================

SET SESSION sql_mode = '';
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS company_db
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE company_db;

-- 先删除有外键依赖的表
DROP TABLE IF EXISTS reservations;

-- =============================================
-- 员工白名单表 (注册用)
-- =============================================
DROP TABLE IF EXISTS employee_whitelist;
CREATE TABLE employee_whitelist (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    uid           VARCHAR(20)  NOT NULL UNIQUE COMMENT '员工工号',
    name          VARCHAR(50)  NOT NULL COMMENT '真实姓名',
    department    VARCHAR(100)  DEFAULT '' COMMENT '所属部门',
    position      VARCHAR(100)  DEFAULT '' COMMENT '职位',
    phone         VARCHAR(20)  DEFAULT '' COMMENT '联系电话',
    verify_code   VARCHAR(20)  NOT NULL COMMENT '验证码',
    is_registered TINYINT(1)   DEFAULT 0 COMMENT '是否已注册: 0未注册/1已注册'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工注册白名单';

INSERT INTO employee_whitelist (uid, name, department, position, phone, verify_code, is_registered) VALUES
('ID-001', 'Holmes',   '创意管理部', '创意总监',   '13800000001', 'VIBE001', 1),
('ID-002', '张三',     '摄影部',     '高级摄影师', '13800000002', 'VIBE002', 1),
('ID-003', '李四',     '后期部',     '调色师',     '13800000003', 'VIBE003', 1),
('ID-004', '王五',     '市场部',     '品牌策划',   '13800000004', 'VIBE004', 1),
('ID-005', '赵六',     '技术部',     '前端开发',   '13800000005', 'VIBE005', 1),
('ID-006', 'Alex Chen', '摄影部',    '首席摄影师', '13900000001', 'VIBE006', 0),
('ID-007', 'Sarah Wang','摄影部',    '人像摄影师', '13900000002', 'VIBE007', 0),
('ID-008', 'Mike Liu',  '后期部',    '后期主管',   '13900000003', 'VIBE008', 0);

-- =============================================
-- 1. 用户表 (登录认证)
-- =============================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    uid         VARCHAR(20)  NOT NULL UNIQUE COMMENT '员工工号',
    username    VARCHAR(50)  NOT NULL UNIQUE COMMENT '登录账号',
    password    VARCHAR(100) NOT NULL COMMENT '登录密码',
    name        VARCHAR(50)  NOT NULL COMMENT '真实姓名',
    department  VARCHAR(50)  DEFAULT '' COMMENT '所属部门',
    position    VARCHAR(50)  DEFAULT '' COMMENT '职位',
    phone       VARCHAR(20)  DEFAULT '' COMMENT '联系电话'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户';

INSERT INTO users (uid, username, password, name, department, position, phone) VALUES
('ID-001', 'admin',    'admin123',  'Holmes',   '创意管理部', '创意总监',   '13800000001'),
('ID-002', 'zhangsan', 'pass123',   '张三',     '摄影部',     '高级摄影师', '13800000002'),
('ID-003', 'lisi',     'pass123',   '李四',     '后期部',     '调色师',     '13800000003'),
('ID-004', 'wangwu',   'pass123',   '王五',     '市场部',     '品牌策划',   '13800000004'),
('ID-005', 'zhaoliu',  'pass123',   '赵六',     '技术部',     '前端开发',   '13800000005');

-- =============================================
-- 2. 员工表 (创意人才库)
-- =============================================
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50)  NOT NULL COMMENT '姓名',
    department  VARCHAR(50)  DEFAULT '' COMMENT '部门',
    position    VARCHAR(50)  DEFAULT '' COMMENT '职位',
    phone       VARCHAR(20)  DEFAULT '' COMMENT '电话'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工信息';

INSERT INTO staff (name, department, position, phone) VALUES
('Alex Chen',   '摄影部', '首席摄影师',   '13900000001'),
('Sarah Wang',  '摄影部', '人像摄影师',   '13900000002'),
('Mike Liu',    '后期部', '后期主管',     '13900000003'),
('Emily Zhang', '后期部', '特效师',       '13900000004'),
('David Li',    '创意管理部', '创意总监', '13900000005'),
('Lisa Zhao',   '市场部', '品牌总监',     '13900000006'),
('Tom Huang',   '市场部', '社交媒体运营', '13900000007'),
('Jenny Wu',    '技术部', '全栈工程师',   '13900000008'),
('Kevin Sun',   '技术部', 'UI/UX 设计师', '13900000009'),
('Amy Zhou',    '器材部', '器材管理员',   '13900000010'),
('Chris Xu',    '摄影部', '风光摄影师',   '13900000011'),
('Diana Yang',  '创意管理部', '美术指导', '13900000012');

-- =============================================
-- 3. 器材表 (摄影器材资产管理)
-- =============================================
DROP TABLE IF EXISTS equipments;
CREATE TABLE equipments (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(100) NOT NULL COMMENT '器材名称',
    model   VARCHAR(100) DEFAULT '' COMMENT '型号',
    status  VARCHAR(20)  DEFAULT '在库' COMMENT '状态: 在库/出借中/维修中'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='器材设备';

INSERT INTO equipments (name, model, status) VALUES
('Sony A7M4 全画幅相机',         'Sony α7 IV',       '在库'),
('Canon EOS R5 相机',            'Canon EOS R5',     '出借中'),
('DJI RS 3 Pro 稳定器',          'DJI RS 3 Pro',     '在库'),
('Godox AD600Pro 闪光灯',        'Godox AD600Pro',   '维修中'),
('Apple Mac Studio (M2 Ultra)',  'Mac Studio 2023',  '在库'),
('EIZO ColorEdge CG319X 显示器', 'EIZO CG319X',      '在库'),
('Profoto B10 外拍灯',           'Profoto B10 Plus', '出借中'),
('DJI Mavic 3 Pro 无人机',       'DJI Mavic 3 Pro',  '在库');

-- =============================================
-- 4. 空间表 (摄影棚/会议室调度)
-- =============================================
DROP TABLE IF EXISTS spaces;
CREATE TABLE spaces (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100) NOT NULL COMMENT '空间名称',
    type     VARCHAR(50)  DEFAULT '' COMMENT '类型: 摄影棚/会议室/后期室',
    capacity INT          DEFAULT 0 COMMENT '容纳人数',
    status   VARCHAR(20)  DEFAULT '空闲' COMMENT '状态: 空闲/使用中/维护中'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='创意空间';

INSERT INTO spaces (name, type, capacity, status) VALUES
('Studio A - 人像摄影棚',   '摄影棚', 8,  '空闲'),
('Studio B - 产品摄影棚',   '摄影棚', 6,  '使用中'),
('Studio C - 无影墙影棚',   '摄影棚', 10, '空闲'),
('会议室 101 - 创意讨论室', '会议室', 12, '空闲'),
('会议室 201 - 客户洽谈室', '会议室', 6,  '使用中'),
('后期剪辑室 A',            '后期室', 4,  '使用中'),
('后期调色室 B',            '后期室', 3,  '空闲'),
('绿幕特效棚',              '摄影棚', 15, '维护中');

-- =============================================
-- 5. 审批表 (请假/报销/器材调用)
-- =============================================
DROP TABLE IF EXISTS approvals;
CREATE TABLE approvals (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(200) NOT NULL COMMENT '审批标题',
    type        VARCHAR(50)  NOT NULL COMMENT '类型: 请假/报销/器材调用/其他',
    content     TEXT         COMMENT '审批内容',
    status      VARCHAR(20)  DEFAULT '待审批' COMMENT '状态: 待审批/已通过/已驳回',
    create_time TIMESTAMP    DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='审批流程';

INSERT INTO approvals (title, type, content, status, create_time) VALUES
('请假申请 - 外拍期间调休',       '请假',   '申请调休 3 天，已完成外拍任务', '已通过', '2025-06-15 09:00:00'),
('报销申请 - 外景差旅费',         '报销',   '三亚外景拍摄差旅费用合计 ¥4850', '待审批', '2025-06-20 14:30:00'),
('器材调用 - DJI Mavic 3 Pro',   '器材调用', '航拍项目需调用无人机 5 天',     '已通过', '2025-06-18 11:00:00'),
('请假申请 - 年假',               '请假',   '年假 5 天，暑期出行',            '已驳回', '2025-06-22 08:00:00'),
('报销申请 - 客户招待费',         '报销',   '客户来访招待费用 ¥1200',         '待审批', '2025-06-25 16:00:00');

-- =============================================
-- 6. 社群帖子表 (内部社区)
-- =============================================
DROP TABLE IF EXISTS community_posts;
CREATE TABLE community_posts (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    author       VARCHAR(50)  NOT NULL COMMENT '作者',
    title        VARCHAR(200) NOT NULL COMMENT '帖子标题',
    content      TEXT         COMMENT '帖子内容',
    likes        INT          DEFAULT 0 COMMENT '点赞数',
    publish_time TIMESTAMP    DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='内部社群';

INSERT INTO community_posts (author, title, content, likes, publish_time) VALUES
('Alex Chen',   '分享一组最新的人像作品',     '这组作品使用了自然光+反光板的组合，效果非常棒！', 28, '2025-06-10 10:30:00'),
('Sarah Wang',  '外拍心得：雨天拍摄技巧',     '下雨天不是问题，关键在于用好防水装备和光线...',    45, '2025-06-12 14:00:00'),
('Mike Liu',    'DaVinci Resolve 调色预设分享', '自己调了 3 个适合商业片风格的 LUT，欢迎大家试用', 67, '2025-06-15 09:20:00'),
('Diana Yang',  'VIBE 品牌视觉规范更新',       '请各团队注意新版本品牌色和字体规范...',           32, '2025-06-18 16:00:00'),
('Kevin Sun',   '内部工具：照片批量重命名脚本', '写了一个 Python 脚本，能按 EXIF 日期批量重命名',  89, '2025-06-20 11:45:00');

SET FOREIGN_KEY_CHECKS = 1;
