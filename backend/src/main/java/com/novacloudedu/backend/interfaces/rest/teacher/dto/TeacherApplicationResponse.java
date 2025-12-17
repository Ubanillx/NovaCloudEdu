package com.novacloudedu.backend.interfaces.rest.teacher.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "讲师申请响应")
public class TeacherApplicationResponse {

    @Schema(description = "申请ID")
    private Long id;

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "讲师姓名")
    private String name;

    @Schema(description = "讲师简介")
    private String introduction;

    @Schema(description = "专业领域")
    private List<String> expertise;

    @Schema(description = "资质证书URL")
    private String certificateUrl;

    @Schema(description = "状态：0-待审核，1-已通过，2-已拒绝")
    private Integer status;

    @Schema(description = "状态描述")
    private String statusDesc;

    @Schema(description = "拒绝原因")
    private String rejectReason;

    @Schema(description = "审核人ID")
    private Long reviewerId;

    @Schema(description = "审核时间")
    private LocalDateTime reviewTime;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
