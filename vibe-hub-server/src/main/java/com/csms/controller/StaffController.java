package com.csms.controller;

import com.csms.entity.Staff;
import com.csms.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/staff")
public class StaffController {

    @Autowired
    private StaffService staffService;

    @GetMapping
    public ResponseEntity<List<Staff>> searchStaff(@RequestParam(defaultValue = "") String keyword) {
        return ResponseEntity.ok(staffService.searchStaff(keyword));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Staff> getStaff(@PathVariable int id) {
        Staff staff = staffService.getStaffById(id);
        if (staff != null) {
            return ResponseEntity.ok(staff);
        }
        return ResponseEntity.notFound().build();
    }
}
