package com.csms.repository;

import com.csms.entity.CommunityPost;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CommunityPostRepository extends JpaRepository<CommunityPost, Integer> {
    List<CommunityPost> findAllByOrderByPublishTimeDesc();
}
