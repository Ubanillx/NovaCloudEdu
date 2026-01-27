package com.novacloudedu.backend.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.context.SecurityContextHolder;

import jakarta.annotation.PostConstruct;

@Configuration
public class AsyncSecurityConfig {

    @PostConstruct
    public void enableAuthenticationContextOnSpawnedThreads() {
        SecurityContextHolder.setStrategyName(SecurityContextHolder.MODE_INHERITABLETHREADLOCAL);
    }
}
