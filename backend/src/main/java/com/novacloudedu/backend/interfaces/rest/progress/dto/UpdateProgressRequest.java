package com.novacloudedu.backend.interfaces.rest.progress.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "更新学习进度请求")
public class UpdateProgressRequest {

    @NotNull(message = "课程ID不能为空")
    @Schema(description = "课程ID")
    private Long courseId;

    @NotNull(message = "小节ID不能为空")
    @Schema(description = "小节ID")
    private Long sectionId;

    @NotNull(message = "上次观看位置不能为空")
    @Min(value = 0, message = "观看位置不能为负数")
    @Schema(description = "上次观看位置(秒)")
    private Integer lastPosition;

    @NotNull(message = "观看时长不能为空")
    @Min(value = 0, message = "观看时长不能为负数")
    @Schema(description = "观看时长(秒)")
    private Integer watchDuration;

    @NotNull(message = "进度不能为空")
    @Min(value = 0, message = "进度不能为负数")
    @Max(value = 100, message = "进度不能超过100")
    @Schema(description = "学习进度(百分比)")
    private Integer progress;
}
