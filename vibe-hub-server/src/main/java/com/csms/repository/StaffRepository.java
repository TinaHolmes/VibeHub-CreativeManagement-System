package com.csms.repository;

import com.csms.entity.Staff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface StaffRepository extends JpaRepository<Staff, Integer> {
    @Query("SELECT s FROM Staff s WHERE s.name LIKE %:keyword% OR s.department LIKE %:keyword%")
    List<Staff> searchByKeyword(@Param("keyword") String keyword);
}
