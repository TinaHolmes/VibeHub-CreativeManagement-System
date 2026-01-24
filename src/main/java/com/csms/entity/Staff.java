package com.csms.entity;

/**
 * 员工/摄影师实体类
 * 对应 vibe_hub 数据库中的 staff 表
 */
public class Staff {
    private int id;
    private String name;
    private String department;
    private String position;
    private String phone;

    // 1. 无参构造器（JavaBean 必须有）
    public Staff() {}
    
    // 2. 全参构造器（方便在 DAO 中快速创建对象）
    public Staff(int id, String name, String department, String position, String phone) {
        this.id = id;
        this.name = name;
        this.department = department;
        this.position = position;
        this.phone = phone;
    }

    // 3. 所有的 Getter 和 Setter 方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    // 4. toString 方法（调试利器：帮你检查数据有没有成功查到内存里）
    @Override
    public String toString() {
        return "Staff [id=" + id + ", name=" + name + ", department=" + department + 
               ", position=" + position + ", phone=" + phone + "]";
    }
}