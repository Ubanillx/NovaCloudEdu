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
}
