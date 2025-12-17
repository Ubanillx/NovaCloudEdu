package com.novacloudedu.backend.interfaces.rest.course.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
@Schema(description = "创建课程请求")
public class CreateCourseRequest {

    @NotBlank(message = "课程标题不能为空")
    @Schema(description = "课程标题")
    private String title;

    @Schema(description = "课程副标题")
    private String subtitle;

    @Schema(description = "课程描述")
    private String description;

    @Schema(description = "封面图片URL")
    private String coverImage;

    @Schema(description = "课程价格")
    private BigDecimal price;

    @NotNull(message = "课程类型不能为空")
    @Schema(description = "课程类型：0-公开课，1-付费课，2-会员课")
    private Integer courseType;

    @NotNull(message = "难度等级不能为空")
    @Schema(description = "难度等级：1-入门，2-初级，3-中级，4-高级，5-专家")
    private Integer difficulty;

    @NotNull(message = "讲师ID不能为空")
    @Schema(description = "讲师ID")
    private Long teacherId;

    @Schema(description = "标签列表")
    private List<String> tags;
}
