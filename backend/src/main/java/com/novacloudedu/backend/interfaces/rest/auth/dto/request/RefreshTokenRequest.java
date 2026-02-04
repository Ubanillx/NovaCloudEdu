package com.novacloudedu.backend.interfaces.rest.auth.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

/**
 * 刷新Token请求DTO
 */
@Schema(description = "刷新Token请求")
public record RefreshTokenRequest(
        @Schema(description = "Refresh Token", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotBlank(message = "Refresh Token不能为空")
        String refreshToken
) {
}
