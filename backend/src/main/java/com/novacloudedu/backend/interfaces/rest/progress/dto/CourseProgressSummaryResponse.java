package com.novacloudedu.backend.interfaces.rest.progress.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "课程进度汇总响应")
public class CourseProgressSummaryResponse {

    @Schema(description = "课程ID")
    private Long courseId;

    @Schema(description = "总小节数")
    private Long totalSections;

    @Schema(description = "已完成小节数")
    private Long completedSections;

    @Schema(description = "课程整体进度(百分比)")
    private Integer overallProgress;

    @Schema(description = "完成率(百分比)")
    private Integer completionRate;
}
