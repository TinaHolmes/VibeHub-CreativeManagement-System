package com.csms.service;

import com.csms.entity.CommunityPost;
import com.csms.repository.CommunityPostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommunityService {

    @Autowired
    private CommunityPostRepository communityPostRepository;

    public List<CommunityPost> getAllPosts() {
        return communityPostRepository.findAllByOrderByPublishTimeDesc();
    }

    public CommunityPost likePost(int id) {
        CommunityPost post = communityPostRepository.findById(id).orElse(null);
        if (post != null) {
            post.setLikes(post.getLikes() + 1);
            communityPostRepository.save(post);
        }
        return post;
    }
}
