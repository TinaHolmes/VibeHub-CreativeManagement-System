package com.csms.controller;

import com.csms.dto.StatusUpdateRequest;
import com.csms.entity.Approval;
import com.csms.service.ApprovalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/approvals")
public class ApprovalController {

    @Autowired
    private ApprovalService approvalService;

    @GetMapping
    public ResponseEntity<List<Approval>> getApprovals(@RequestParam(required = false) String status) {
        return ResponseEntity.ok(approvalService.getApprovals(status));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateStatus(@PathVariable int id, @RequestBody StatusUpdateRequest request) {
        Approval approval = approvalService.updateStatus(id, request.getStatus());
        if (approval != null) {
            return ResponseEntity.ok(Map.of("message", "状态更新成功", "status", approval.getStatus()));
        }
        return ResponseEntity.notFound().build();
    }
}
