package com.novacloudedu.backend.infrastructure.email;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * 管理员邮件通知配置属性
 */
@Data
@Component
@ConfigurationProperties(prefix = "admin-email")
public class EmailProperties {

    /**
     * 是否启用管理员邮件通知
     */
    private boolean enabled = true;

    /**
     * 管理员收件人列表（逗号分隔）
     */
    private String recipients = "";

    /**
     * 平台名称（用于邮件标题前缀）
     */
    private String platformName = "智云星课";

    /**
     * 获取收件人列表
     */
    public List<String> getRecipientList() {
        if (recipients == null || recipients.isBlank()) {
            return Collections.emptyList();
        }
        return Arrays.stream(recipients.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .toList();
    }
}
