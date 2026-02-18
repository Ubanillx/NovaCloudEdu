package com.novacloudedu.backend.interfaces.rest.grading.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "提交作业请求")
public class SubmitHomeworkRequest {

    @Schema(description = "批改模式: EXAM_PAPER(试卷批改) / GENERAL(通用作业助手)，默认 GENERAL")
    private String gradingMode;

    @Schema(description = "作业标题（通用模式可自定义，如'人教版三年级数学第五章练习'）")
    private String title;

    @Schema(description = "学科: MATH/CHINESE/ENGLISH/...（可选，通用模式AI自动推断）")
    private String subject;

    @Schema(description = "年级")
    private String grade;

    @NotEmpty(message = "作业图片不能为空")
    @Schema(description = "作业图片 OSS URL 列表")
    private List<String> imageUrls;

    @Schema(description = "班级ID（可选）")
    private Long classId;

    @Schema(description = "关联试卷ID（试卷批改模式时传入）")
    private Long examPaperId;
}
