package com.csms.controller;

import com.csms.dto.LoginRequest;
import com.csms.dto.RegisterRequest;
import com.csms.entity.User;
import com.csms.service.AuthService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request, HttpSession session) {
        User user = authService.login(request);
        if (user != null) {
            session.setAttribute("currentUser", user);
            return ResponseEntity.ok(Map.of(
                "id", user.getId(),
                "uid", user.getUid(),
                "username", user.getUsername(),
                "name", user.getName(),
                "department", user.getDepartment(),
                "position", user.getPosition(),
                "phone", user.getPhone()
            ));
        }
        return ResponseEntity.status(401).body(Map.of("message", "用户名或密码错误"));
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        Map<String, String> result = authService.register(request);
        if ("true".equals(result.get("success"))) {
            return ResponseEntity.ok(result);
        }
        return ResponseEntity.badRequest().body(result);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        session.invalidate();
        return ResponseEntity.ok(Map.of("message", "已退出登录"));
    }

    @GetMapping("/me")
    public ResponseEntity<?> getCurrentUser(HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        if (user != null) {
            return ResponseEntity.ok(Map.of(
                "id", user.getId(),
                "uid", user.getUid(),
                "username", user.getUsername(),
                "name", user.getName(),
                "department", user.getDepartment(),
                "position", user.getPosition(),
                "phone", user.getPhone()
            ));
        }
        return ResponseEntity.status(401).body(Map.of("message", "未登录"));
    }
}
