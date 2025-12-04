package com.novacloudedu.backend.infrastructure.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * JWT 访问拒绝处理器 - 处理无权限请求
 */
@Component
@RequiredArgsConstructor
public class JwtAccessDeniedHandler implements AccessDeniedHandler {

    private final ObjectMapper objectMapper;

    @Override
    public void handle(HttpServletRequest request,
                       HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException {
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());

        String json = objectMapper.writeValueAsString(ResultUtils.error(ErrorCode.NO_AUTH_ERROR));
        response.getWriter().write(json);
    }
}
