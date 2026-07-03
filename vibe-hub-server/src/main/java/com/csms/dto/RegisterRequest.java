package com.csms.dto;

public class RegisterRequest {
    private String uid;
    private String verifyCode;
    private String username;
    private String password;
    private String confirmPassword;

    public RegisterRequest() {}

    public String getUid() { return uid; }
    public void setUid(String uid) { this.uid = uid; }
    public String getVerifyCode() { return verifyCode; }
    public void setVerifyCode(String verifyCode) { this.verifyCode = verifyCode; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }
}
