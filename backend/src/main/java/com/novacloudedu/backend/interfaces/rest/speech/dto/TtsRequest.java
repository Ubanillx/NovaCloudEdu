package com.novacloudedu.backend.interfaces.rest.speech.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 语音合成请求
 */
@Data
@Schema(description = "语音合成请求")
public class TtsRequest {

    @NotBlank(message = "合成文本不能为空")
    @Size(max = 5000, message = "文本长度不能超过5000字符")
    @Schema(description = "要合成的文本", requiredMode = Schema.RequiredMode.REQUIRED, example = "你好，欢迎使用智云星课")
    private String text;

    @Schema(description = "发音人，可选值: xiaoyun, xiaogang, ruoxi 等", example = "xiaoyun")
    private String voice;

    @Schema(description = "音量 (0-100)", minimum = "0", maximum = "100", example = "50")
    private Integer volume;

    @Schema(description = "语速 (-500 到 500)", minimum = "-500", maximum = "500", example = "0")
    private Integer speechRate;

    @Schema(description = "语调 (-500 到 500)", minimum = "-500", maximum = "500", example = "0")
    private Integer pitchRate;

    @Schema(description = "音频格式: pcm, wav, mp3", example = "mp3", defaultValue = "mp3")
    private String format = "mp3";
}
