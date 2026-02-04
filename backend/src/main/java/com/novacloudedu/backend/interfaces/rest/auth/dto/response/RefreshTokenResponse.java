package com.novacloudedu.backend.interfaces.rest.auth.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 刷新Token响应DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "刷新Token响应")
public class RefreshTokenResponse {

    @Schema(description = "新的Access Token")
    private String token;

    @Schema(description = "新的Refresh Token")
    private String refreshToken;
}
