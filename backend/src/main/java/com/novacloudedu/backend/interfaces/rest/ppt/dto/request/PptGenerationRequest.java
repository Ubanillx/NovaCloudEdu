package com.novacloudedu.backend.interfaces.rest.ppt.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
@Schema(description = "PPT生成助手请求")
public class PptGenerationRequest {

    @NotBlank(message = "操作类型不能为空")
    @Schema(description = "操作类型: detect_intent / generate_outline / revise_outline / confirm_outline / select_template / generate_ppt")
    private String action;

    @Schema(description = "会话ID（首次操作时为空，后续步骤必填）")
    private Long sessionId;

    @Schema(description = "用户消息（detect_intent 时使用，AI判断是否要生成PPT）")
    private String message;

    @Schema(description = "PPT主题（generate_outline 时使用）")
    private String topic;

    @Schema(description = "额外要求（generate_outline 时可选）")
    private String requirements;

    @Schema(description = "修改反馈（revise_outline 时使用）")
    private String feedback;

    @Schema(description = "系统模板ID（select_template 时使用）")
    private Long templateId;

    @Schema(description = "自定义模板URL（select_template 时使用，与 templateId 二选一）")
    private String templateUrl;

    @Schema(description = "结构化大纲JSON（update_outline 时使用）")
    private String outlineJson;

    @Schema(description = "关联的PPT项目ID（detect_intent 时可选）")
    private Long projectId;
}
