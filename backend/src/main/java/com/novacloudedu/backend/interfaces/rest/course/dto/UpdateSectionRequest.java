package com.novacloudedu.backend.interfaces.rest.course.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "更新小节请求")
public class UpdateSectionRequest {

    @NotBlank(message = "小节标题不能为空")
    @Schema(description = "小节标题")
    private String title;

    @Schema(description = "小节描述")
    private String description;

    @Schema(description = "视频URL")
    private String videoUrl;

    @NotNull(message = "时长不能为空")
    @Schema(description = "时长(秒)")
    private Integer duration;

    @NotNull(message = "排序不能为空")
    @Schema(description = "排序，数字越小排序越靠前")
    private Integer sort;

    @NotNull(message = "是否免费不能为空")
    @Schema(description = "是否免费：false-否，true-是")
    private Boolean isFree;

    @Schema(description = "资源URL")
    private String resourceUrl;
}
