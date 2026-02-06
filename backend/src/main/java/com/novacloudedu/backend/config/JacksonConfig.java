package com.novacloudedu.backend.config;

import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Jackson 配置类
 * 支持 Java 8 日期时间类型（LocalDateTime 等）序列化
 */
@Configuration
public class JacksonConfig {

    /**
     * 自定义 Jackson ObjectMapper 配置
     * 注册 JavaTimeModule 支持 Java 8 日期时间类型
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
        return builder -> {
            // 注册 Java 8 日期时间支持
            builder.modules(new JavaTimeModule());
            
            // 禁用将日期写为时间戳，改为 ISO-8601 格式字符串
            builder.featuresToDisable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        };
    }
}
