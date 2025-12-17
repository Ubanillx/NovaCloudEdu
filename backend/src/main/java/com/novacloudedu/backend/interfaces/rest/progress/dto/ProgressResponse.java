package com.novacloudedu.backend.interfaces.rest.progress.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "学习进度响应")
public class ProgressResponse {

    @Schema(description = "进度ID")
    private Long id;

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "课程ID")
    private Long courseId;

    @Schema(description = "小节ID")
    private Long sectionId;

    @Schema(description = "学习进度(百分比)")
    private Integer progress;

    @Schema(description = "观看时长(秒)")
    private Integer watchDuration;

    @Schema(description = "上次观看位置(秒)")
    private Integer lastPosition;

    @Schema(description = "是否完成")
    private Boolean isCompleted;

    @Schema(description = "完成时间")
    private LocalDateTime completedTime;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
