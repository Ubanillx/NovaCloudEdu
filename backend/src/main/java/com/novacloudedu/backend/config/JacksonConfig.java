package com.novacloudedu.backend.config;

import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Jackson 配置类
 * 1. 解决 Web JSON 中 Long 类型 ID 精度丢失问题
 * 2. 支持 Java 8 日期时间类型（LocalDateTime 等）序列化
 * 
 * 问题原因：JavaScript 的 Number 类型只能精确表示 53 位整数（Number.MAX_SAFE_INTEGER = 2^53 - 1）
 * 而 Java 的 Long 是 64 位的，超过 53 位的整数在 JavaScript 中会丢失精度
 * 
 * 解决方案：将 Long 类型序列化为 String，前端以字符串形式处理 ID
 */
@Configuration
public class JacksonConfig {

    /**
     * 自定义 Jackson ObjectMapper 配置
     * 1. 将 Long 和 long 类型序列化为 String
     * 2. 注册 JavaTimeModule 支持 Java 8 日期时间类型
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
        return builder -> {
            // 创建自定义模块处理 Long 类型
            SimpleModule simpleModule = new SimpleModule();
            
            // Long 类型（包装类）序列化为 String
            simpleModule.addSerializer(Long.class, ToStringSerializer.instance);
            // long 类型（基本类型）序列化为 String
            simpleModule.addSerializer(Long.TYPE, ToStringSerializer.instance);
            
            // 注册模块：Long 转 String + Java 8 日期时间支持
            builder.modules(simpleModule, new JavaTimeModule());
            
            // 禁用将日期写为时间戳，改为 ISO-8601 格式字符串
            builder.featuresToDisable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        };
    }
}
