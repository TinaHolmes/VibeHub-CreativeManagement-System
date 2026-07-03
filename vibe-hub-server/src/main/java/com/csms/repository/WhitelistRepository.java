package com.csms.repository;

import com.csms.entity.EmployeeWhitelist;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface WhitelistRepository extends JpaRepository<EmployeeWhitelist, Integer> {
    Optional<EmployeeWhitelist> findByUidAndVerifyCode(String uid, String verifyCode);
}
