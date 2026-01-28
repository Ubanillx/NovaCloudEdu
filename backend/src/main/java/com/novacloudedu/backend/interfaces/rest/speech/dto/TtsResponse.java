package com.novacloudedu.backend.interfaces.rest.speech.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 语音合成响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "语音合成响应")
public class TtsResponse {

    @Schema(description = "Base64 编码的音频数据")
    private String audioBase64;

    @Schema(description = "音频格式", example = "mp3")
    private String format;

    @Schema(description = "音频数据大小（字节）", example = "12345")
    private Integer size;

    @Schema(description = "音频时长（毫秒），如果可用", example = "3500")
    private Long durationMs;
}
