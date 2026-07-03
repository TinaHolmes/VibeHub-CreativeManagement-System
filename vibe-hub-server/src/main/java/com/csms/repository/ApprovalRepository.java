package com.csms.repository;

import com.csms.entity.Approval;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ApprovalRepository extends JpaRepository<Approval, Integer> {
    List<Approval> findAllByOrderByCreateTimeDesc();
    List<Approval> findByStatusOrderByCreateTimeDesc(String status);
}
