package com.novacloudedu.backend.interfaces.rest.course.dto;

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
@Schema(description = "小节信息响应")
public class SectionResponse {

    @Schema(description = "小节ID")
    private Long id;

    @Schema(description = "课程ID")
    private Long courseId;

    @Schema(description = "章节ID")
    private Long chapterId;

    @Schema(description = "小节标题")
    private String title;

    @Schema(description = "小节描述")
    private String description;

    @Schema(description = "视频URL")
    private String videoUrl;

    @Schema(description = "时长(秒)")
    private Integer duration;

    @Schema(description = "排序")
    private Integer sort;

    @Schema(description = "是否免费")
    private Boolean isFree;

    @Schema(description = "资源URL")
    private String resourceUrl;

    @Schema(description = "HLS播放地址(m3u8)")
    private String hlsUrl;

    @Schema(description = "转码状态: 0-未转码, 1-转码中, 2-已完成, 3-失败")
    private Integer transcodeStatus;

    @Schema(description = "缩略图雪碧图URL")
    private String thumbnailUrl;

    @Schema(description = "缩略图数量")
    private Integer thumbnailCount;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
