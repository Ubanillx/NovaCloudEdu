package com.novacloudedu.backend.interfaces.rest.course.dto;

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
@Schema(description = "章节信息响应")
public class ChapterResponse {

    @Schema(description = "章节ID")
    private Long id;

    @Schema(description = "课程ID")
    private Long courseId;

    @Schema(description = "章节标题")
    private String title;

    @Schema(description = "章节描述")
    private String description;

    @Schema(description = "排序")
    private Integer sort;

    @Schema(description = "小节列表")
    private List<SectionResponse> sections;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
