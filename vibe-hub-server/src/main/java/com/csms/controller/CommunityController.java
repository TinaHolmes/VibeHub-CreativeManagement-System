package com.csms.controller;

import com.csms.entity.CommunityPost;
import com.csms.service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    @GetMapping
    public ResponseEntity<List<CommunityPost>> getAllPosts() {
        return ResponseEntity.ok(communityService.getAllPosts());
    }

    @PutMapping("/{id}/like")
    public ResponseEntity<?> likePost(@PathVariable int id) {
        CommunityPost post = communityService.likePost(id);
        if (post != null) {
            return ResponseEntity.ok(Map.of("message", "点赞成功", "likes", post.getLikes()));
        }
        return ResponseEntity.notFound().build();
    }
}
