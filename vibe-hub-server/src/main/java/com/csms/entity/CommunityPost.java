package com.csms.entity;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "community_posts")
public class CommunityPost {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, length = 50)
    private String author;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String content;

    private int likes;

    @Column(name = "publish_time")
    private Timestamp publishTime;

    public CommunityPost() {}

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
