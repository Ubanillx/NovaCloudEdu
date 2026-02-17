package com.novacloudedu.backend.interfaces.rest.membership.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "更新会员计划请求")
public class UpdatePlanRequest {

    @NotNull(message = "计划ID不能为空")
    @Schema(description = "计划ID")
    private Long id;

    @Schema(description = "计划名称")
    private String name;

    @Schema(description = "计划描述")
    private String description;

    @Schema(description = "价格")
    private BigDecimal price;

    @Schema(description = "有效期天数")
    private Integer durationDays;
}
