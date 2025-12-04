package com.novacloudedu.backend.interfaces.rest.common;

import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 健康检查控制器
 */
@Tag(name = "系统监控", description = "系统健康检查接口")
@RestController
@RequestMapping("/api")
public class HealthController {

    @Operation(summary = "健康检查", description = "检查服务是否正常运行")
    @GetMapping("/health")
    public BaseResponse<String> health() {
        return ResultUtils.success("ok");
    }
}
