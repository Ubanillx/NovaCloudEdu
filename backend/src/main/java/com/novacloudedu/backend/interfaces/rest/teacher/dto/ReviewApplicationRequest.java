package com.novacloudedu.backend.interfaces.rest.teacher.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "审核讲师申请请求")
public class ReviewApplicationRequest {

    @NotNull(message = "申请ID不能为空")
    @Schema(description = "申请ID")
    private Long applicationId;

    @NotNull(message = "审核结果不能为空")
    @Schema(description = "是否通过：true-通过，false-拒绝")
    private Boolean approved;

    @Schema(description = "拒绝原因（拒绝时必填）")
    private String rejectReason;
}
