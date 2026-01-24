package com.csms.entity;
import java.sql.Timestamp;
public class Approval {
    private int id;
    private String title;
    private String type;
    private String content;
    private String status;
    private Timestamp createTime;
    // Getters and Setters (请自行在 Eclipse 中 Generate)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }
}