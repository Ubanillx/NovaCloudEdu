package com.novacloudedu.backend.interfaces.rest.course.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "课程信息响应")
public class CourseResponse {

    @Schema(description = "课程ID")
    private Long id;

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

    @Schema(description = "课程类型：0-公开课，1-付费课，2-会员课")
    private Integer courseType;

    @Schema(description = "课程类型描述")
    private String courseTypeDesc;

    @Schema(description = "难度等级：1-入门，2-初级，3-中级，4-高级，5-专家")
    private Integer difficulty;

    @Schema(description = "难度等级描述")
    private String difficultyDesc;

    @Schema(description = "状态：0-未发布，1-已发布，2-已下架")
    private Integer status;

    @Schema(description = "状态描述")
    private String statusDesc;

    @Schema(description = "讲师ID")
    private Long teacherId;

    @Schema(description = "总时长(分钟)")
    private Integer totalDuration;

    @Schema(description = "总章节数")
    private Integer totalChapters;

    @Schema(description = "总小节数")
    private Integer totalSections;

    @Schema(description = "学习人数")
    private Integer studentCount;

    @Schema(description = "评分")
    private BigDecimal ratingScore;

    @Schema(description = "标签列表")
    private List<String> tags;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
