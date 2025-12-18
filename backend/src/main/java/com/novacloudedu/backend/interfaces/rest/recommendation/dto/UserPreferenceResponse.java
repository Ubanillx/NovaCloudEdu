package com.novacloudedu.backend.interfaces.rest.recommendation.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@Schema(description = "用户喜好响应")
public class UserPreferenceResponse {

    @Schema(description = "ID")
    private Long id;

    @Schema(description = "喜好类型")
    private String preferenceType;

    @Schema(description = "喜好类型描述")
    private String preferenceTypeDesc;

    @Schema(description = "喜好键")
    private String preferenceKey;

    @Schema(description = "喜好权重值")
    private BigDecimal preferenceValue;

    @Schema(description = "交互次数")
    private Integer interactionCount;

    @Schema(description = "最后交互时间")
    private LocalDateTime lastInteractionTime;
}
