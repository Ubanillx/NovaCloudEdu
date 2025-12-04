package com.novacloudedu.backend.aop;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.valueobject.UserRole;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

/**
 * 权限校验 AOP
 */
@Aspect
@Component
@RequiredArgsConstructor
public class AuthInterceptor {

    private final UserApplicationService userApplicationService;

    /**
     * 执行拦截
     */
    @Around("@annotation(authCheck)")
    public Object doInterceptor(ProceedingJoinPoint joinPoint, AuthCheck authCheck) throws Throwable {
        String mustRole = authCheck.mustRole();
        
        // 获取当前登录用户
        User loginUser = userApplicationService.getCurrentUser();
        
        // 必须有指定角色才通过
        if (StringUtils.isNotBlank(mustRole)) {
            UserRole mustRoleEnum;
            try {
                mustRoleEnum = UserRole.fromValue(mustRole);
            } catch (IllegalArgumentException e) {
                throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
            }
            
            UserRole userRole = loginUser.getRole();
            
            // 如果需要管理员权限，检查当前用户是否为管理员
            if (UserRole.ADMIN.equals(mustRoleEnum)) {
                if (!UserRole.ADMIN.equals(userRole)) {
                    throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
                }
            }
            
            // 如果需要教师权限，管理员也可以通过
            if (UserRole.TEACHER.equals(mustRoleEnum)) {
                if (!UserRole.TEACHER.equals(userRole) 
                        && !UserRole.ADMIN.equals(userRole)) {
                    throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
                }
            }
        }
        
        // 通过权限校验，放行
        return joinPoint.proceed();
    }
}
