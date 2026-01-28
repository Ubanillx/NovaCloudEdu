package com.novacloudedu.backend.interfaces.rest.speech;

import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.infrastructure.speech.NlsTextToSpeechService;
import com.novacloudedu.backend.interfaces.rest.speech.dto.TtsRequest;
import com.novacloudedu.backend.interfaces.rest.speech.dto.TtsResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Base64;

/**
 * 语音服务控制器
 * 提供语音合成 (TTS) 接口
 */
@Slf4j
@RestController
@RequestMapping("/api/speech")
@RequiredArgsConstructor
@Tag(name = "语音服务", description = "语音合成 (TTS) 接口")
public class SpeechController {

    private final NlsTextToSpeechService textToSpeechService;

    @PostMapping("/tts")
    @Operation(summary = "文本转语音", description = "将文本转换为语音，返回音频文件")
    public ResponseEntity<byte[]> textToSpeech(@Valid @RequestBody TtsRequest request) {
        try {
            String text = request.getText();
            String format = request.getFormat() != null ? request.getFormat() : "mp3";
            
            log.info("TTS 请求: text={}, voice={}, format={}", 
                    text.length() > 50 ? text.substring(0, 50) + "..." : text, 
                    request.getVoice(), format);
            
            byte[] audioData = textToSpeechService.synthesize(
                    text,
                    request.getVoice(),
                    request.getVolume(),
                    request.getSpeechRate(),
                    request.getPitchRate(),
                    format
            );
            
            // 根据格式设置 Content-Type
            String contentType = switch (format.toLowerCase()) {
                case "mp3" -> "audio/mpeg";
                case "wav" -> "audio/wav";
                default -> "audio/pcm";
            };
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.parseMediaType(contentType));
            headers.setContentLength(audioData.length);
            headers.set("Content-Disposition", "inline; filename=\"speech." + format + "\"");
            
            return ResponseEntity.ok()
                    .headers(headers)
                    .body(audioData);
                    
        } catch (Exception e) {
            log.error("TTS 合成失败: text={}", request.getText(), e);
            return ResponseEntity.internalServerError().build();
        }
    }

    @PostMapping("/tts/base64")
    @Operation(summary = "文本转语音 (Base64)", description = "将文本转换为语音，返回 Base64 编码的音频数据")
    public BaseResponse<TtsResponse> textToSpeechBase64(@Valid @RequestBody TtsRequest request) {
        try {
            String text = request.getText();
            String format = request.getFormat() != null ? request.getFormat() : "mp3";
            
            log.info("TTS Base64 请求: text={}, voice={}", 
                    text.length() > 50 ? text.substring(0, 50) + "..." : text, 
                    request.getVoice());
            
            byte[] audioData = textToSpeechService.synthesize(
                    text,
                    request.getVoice(),
                    request.getVolume(),
                    request.getSpeechRate(),
                    request.getPitchRate(),
                    format
            );
            
            String base64Audio = Base64.getEncoder().encodeToString(audioData);
            
            TtsResponse response = TtsResponse.builder()
                    .audioBase64(base64Audio)
                    .format(format)
                    .size(audioData.length)
                    .build();
            
            return ResultUtils.success(response);
            
        } catch (Exception e) {
            log.error("TTS Base64 合成失败", e);
            return new BaseResponse<>(50000, null, "语音合成失败: " + e.getMessage());
        }
    }

    @GetMapping("/tts/voices")
    @Operation(summary = "获取支持的发音人列表")
    public BaseResponse<String[]> getSupportedVoices() {
        return ResultUtils.success(textToSpeechService.getSupportedVoices());
    }
}
