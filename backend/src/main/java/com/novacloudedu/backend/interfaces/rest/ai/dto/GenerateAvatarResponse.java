package com.novacloudedu.backend.interfaces.rest.ai.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "AI生成头像响应")
public class GenerateAvatarResponse {

    @Schema(description = "生成的图片URL")
    private String imageUrl;

    @Schema(description = "是否成功")
    private boolean success;

    @Schema(description = "错误信息（失败时）")
    private String errorMessage;

    public static GenerateAvatarResponse success(String imageUrl) {
        return new GenerateAvatarResponse(imageUrl, true, null);
    }

    public static GenerateAvatarResponse failure(String errorMessage) {
        return new GenerateAvatarResponse(null, false, errorMessage);
    }
}
