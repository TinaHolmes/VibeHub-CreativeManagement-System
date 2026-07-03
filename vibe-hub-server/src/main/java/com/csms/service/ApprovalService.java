package com.csms.service;

import com.csms.entity.Approval;
import com.csms.repository.ApprovalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApprovalService {

    @Autowired
    private ApprovalRepository approvalRepository;

    public List<Approval> getApprovals(String status) {
        if (status == null || status.isBlank()) {
            return approvalRepository.findAllByOrderByCreateTimeDesc();
        }
        return approvalRepository.findByStatusOrderByCreateTimeDesc(status);
    }

    public Approval updateStatus(int id, String status) {
        Approval approval = approvalRepository.findById(id).orElse(null);
        if (approval != null) {
            approval.setStatus(status);
            approvalRepository.save(approval);
        }
        return approval;
    }
}
