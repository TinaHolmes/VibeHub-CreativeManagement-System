package com.csms.entity;
import java.sql.Timestamp;
public class Post {
	private String avatarUrl;
	public String getAvatarUrl() { return avatarUrl; }
	public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }
    private int id;
    private String author;
    private String title;
    private String content;
    private int likes;
    private Timestamp publishTime;
    // Getters and Setters (请自行在 Eclipse 中 Generate)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }
    public Timestamp getPublishTime() { return publishTime; }
    public void setPublishTime(Timestamp publishTime) { this.publishTime = publishTime; }
}