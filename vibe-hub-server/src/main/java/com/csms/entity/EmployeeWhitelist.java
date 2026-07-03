package com.csms.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "employee_whitelist")
public class EmployeeWhitelist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, unique = true, length = 20)
    private String uid;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(length = 50)
    private String department;

    @Column(length = 50)
    private String position;

    @Column(length = 20)
    private String phone;

    @Column(name = "verify_code", nullable = false, length = 20)
    private String verifyCode;

    @Column(name = "is_registered")
    private int isRegistered;

    public EmployeeWhitelist() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUid() { return uid; }
    public void setUid(String uid) { this.uid = uid; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getVerifyCode() { return verifyCode; }
    public void setVerifyCode(String verifyCode) { this.verifyCode = verifyCode; }
    public int getIsRegistered() { return isRegistered; }
    public void setIsRegistered(int isRegistered) { this.isRegistered = isRegistered; }
}
