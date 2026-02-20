package com.novacloudedu.backend.config;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 阿里云智能语音交互 (NLS) 配置类
 * 支持语音识别 (ASR)、语音合成 (TTS)、实时语音转写等功能
 */
@Slf4j
@Data
@Configuration
@ConfigurationProperties(prefix = "aliyun.nls")
public class NlsSpeechConfig {

    /**
     * 阿里云 AccessKey ID
     */
    private String accessKeyId;

    /**
     * 阿里云 AccessKey Secret
     */
    private String accessKeySecret;

    /**
     * NLS 应用 AppKey
     */
    private String appKey;

    /**
     * NLS 服务地址 (默认为公网地址)
     */
    private String url = "wss://nls-gateway-cn-shanghai.aliyuncs.com/ws/v1";

    /**
     * 语音识别 (ASR) 配置
     */
    private AsrConfig asr = new AsrConfig();

    /**
     * 语音合成 (TTS) 配置
     */
    private TtsConfig tts = new TtsConfig();

    /**
     * 实时语音转写配置
     */
    private TranscriberConfig transcriber = new TranscriberConfig();

    @Data
    public static class AsrConfig {
        /**
         * 是否启用中间结果
         */
        private boolean enableIntermediateResult = true;

        /**
         * 是否启用标点符号
         */
        private boolean enablePunctuation = true;

        /**
         * 是否启用逆文本规整 (ITN)
         */
        private boolean enableItn = true;

        /**
         * 采样率 (默认 16000)
         */
        private int sampleRate = 16000;

        /**
         * 音频格式 (默认 pcm)
         */
        private String format = "pcm";
    }

    @Data
    public static class TtsConfig {
        /**
         * 发音人 (默认 xiaoyun)
         */
        private String voice = "xiaoyun";

        /**
         * 音量 (0-100，默认 50)
         */
        private int volume = 50;

        /**
         * 语速 (-500 到 500，默认 0)
         */
        private int speechRate = 0;

        /**
         * 语调 (-500 到 500，默认 0)
         */
        private int pitchRate = 0;

        /**
         * 音频格式 (默认 pcm)
         */
        private String format = "pcm";

        /**
         * 采样率 (默认 16000)
         */
        private int sampleRate = 16000;
    }

    @Data
    public static class TranscriberConfig {
        /**
         * 是否启用中间结果
         */
        private boolean enableIntermediateResult = true;

        /**
         * 是否启用标点符号
         */
        private boolean enablePunctuation = true;

        /**
         * 是否启用逆文本规整 (ITN)
         */
        private boolean enableItn = true;

        /**
         * 最大静默时间 (毫秒)
         */
        private int maxSentenceSilence = 800;

        /**
         * 采样率 (默认 16000)
         */
        private int sampleRate = 16000;

        /**
         * 音频格式 (默认 pcm)
         */
        private String format = "pcm";
    }
}
