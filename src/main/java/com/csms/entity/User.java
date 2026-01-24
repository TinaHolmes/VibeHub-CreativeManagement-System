package com.csms.entity;




public class User {
    // 1. 私有属性
    private int id;
    private String uid;          // 员工工号 (如: ID-1)
    private String username;     // 登录账号
    private String password;     // 登录密码 (
    private String name;         // 员工真实姓名
    private String department;   // 所属部门
    private String position;     // 职位
    private String phone;        // 联系电话

    // 2. 无参构造器 (JavaBean 规范必须有)
    public User() {}

    // 3. 全参构造器 (方便开发时快速创建对象)
    public User(int id, String uid, String username, String password, String name, 
                String department, String position, String phone) {
        this.id = id;
        this.uid = uid;
        this.username = username;
        this.password = password;
        this.name = name;
        this.department = department;
        this.position = position;
        this.phone = phone;
    }

    // 4. Getter 和 Setter 方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    // 5. toString 方法 (方便调试，在控制台打印用户信息)
    @Override
    public String toString() {
        return "User [uid=" + uid + ", username=" + username + ", name=" + name + 
               ", dept=" + department + ", pos=" + position + "]";
    }
}