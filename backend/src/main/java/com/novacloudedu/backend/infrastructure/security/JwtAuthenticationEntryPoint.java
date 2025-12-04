package com.novacloudedu.backend.infrastructure.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * JWT 认证入口点 - 处理未认证请求
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final ObjectMapper objectMapper;

    @Override
    public void commence(HttpServletRequest request,
                         HttpServletResponse response,
                         AuthenticationException authException) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());

        String json = objectMapper.writeValueAsString(ResultUtils.error(ErrorCode.NOT_LOGIN_ERROR));
        response.getWriter().write(json);
    }
}
