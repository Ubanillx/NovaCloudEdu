package com.novacloudedu.backend.interfaces.rest.course.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "课程结构响应")
public class CourseStructureResponse {

    @Schema(description = "课程信息")
    private CourseResponse course;

    @Schema(description = "章节列表（包含小节）")
    private List<ChapterResponse> chapters;

    @Schema(description = "当前用户是否有权访问付费内容")
    private Boolean hasAccess;

    @Schema(description = "当前用户是否已购买此课程（有有效订单）")
    private Boolean purchased;
}
