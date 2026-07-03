package com.csms.service;

import com.csms.entity.Staff;
import com.csms.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StaffService {

    @Autowired
    private StaffRepository staffRepository;

    public List<Staff> searchStaff(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return staffRepository.findAll();
        }
        return staffRepository.searchByKeyword(keyword);
    }

    public Staff getStaffById(int id) {
        return staffRepository.findById(id).orElse(null);
    }
}
