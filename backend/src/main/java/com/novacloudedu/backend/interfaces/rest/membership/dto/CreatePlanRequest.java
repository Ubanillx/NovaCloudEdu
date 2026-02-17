package com.novacloudedu.backend.interfaces.rest.membership.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "创建会员计划请求")
public class CreatePlanRequest {

    @NotBlank(message = "计划名称不能为空")
    @Schema(description = "计划名称")
    private String name;

    @NotBlank(message = "计划编码不能为空")
    @Schema(description = "计划编码：FREE/BASIC/PRO/TEACHER")
    private String code;

    @Schema(description = "计划描述")
    private String description;

    @NotNull(message = "价格不能为空")
    @Schema(description = "价格")
    private BigDecimal price;

    @Schema(description = "有效期天数，0表示永久")
    private Integer durationDays;
}
