package com.novacloudedu.backend.interfaces.rest.ai.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
@Schema(description = "AI生成头像请求")
public class GenerateAvatarRequest {

    @NotBlank(message = "图片描述不能为空")
    @Schema(description = "图片描述（英文效果更好）", example = "A friendly cartoon robot teacher with blue theme")
    private String prompt;
}
