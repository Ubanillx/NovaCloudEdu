package com.novacloudedu.backend.interfaces.rest.scraper.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 执行抓取任务请求
 */
@Data
public class ExecuteTaskRequest {

    @NotNull(message = "配置ID不能为空")
    private Long configId;

    private Integer maxArticles;
}
