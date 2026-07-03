package com.csms.service;

import com.csms.dto.LoginRequest;
import com.csms.dto.RegisterRequest;
import com.csms.entity.EmployeeWhitelist;
import com.csms.entity.User;
import com.csms.repository.UserRepository;
import com.csms.repository.WhitelistRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private WhitelistRepository whitelistRepository;

    public User login(LoginRequest request) {
        Optional<User> userOpt = userRepository.findByUsernameAndPassword(
                request.getUsername(), request.getPassword());
        return userOpt.orElse(null);
    }

    @Transactional
    public Map<String, String> register(RegisterRequest request) {
        Map<String, String> result = new LinkedHashMap<>();

        // 基础校验
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            result.put("success", "false");
            result.put("message", "两次输入的密码不一致");
            return result;
        }

        // 校验白名单和验证码
        Optional<EmployeeWhitelist> whitelistOpt = whitelistRepository
                .findByUidAndVerifyCode(request.getUid(), request.getVerifyCode());

        if (whitelistOpt.isEmpty()) {
            result.put("success", "false");
            result.put("message", "员工工号或验证码错误");
            return result;
        }

        EmployeeWhitelist wl = whitelistOpt.get();
        if (wl.getIsRegistered() == 1) {
            result.put("success", "false");
            result.put("message", "该工号已注册过");
            return result;
        }

        // 检查用户名是否重复
        if (userRepository.findByUsername(request.getUsername()).isPresent()) {
            result.put("success", "false");
            result.put("message", "该用户名已被使用");
            return result;
        }

        // 插入用户
        User user = new User();
        user.setUid(request.getUid());
        user.setUsername(request.getUsername());
        user.setPassword(request.getPassword());
        user.setName(wl.getName());
        user.setDepartment(wl.getDepartment());
        user.setPosition(wl.getPosition());
        user.setPhone(wl.getPhone());
        userRepository.save(user);

        // 更新白名单
        wl.setIsRegistered(1);
        whitelistRepository.save(wl);

        result.put("success", "true");
        result.put("message", "注册成功");
        return result;
    }
}
