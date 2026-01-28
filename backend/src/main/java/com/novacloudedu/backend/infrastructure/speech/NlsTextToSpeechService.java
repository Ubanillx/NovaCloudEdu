package com.novacloudedu.backend.infrastructure.speech;

import com.alibaba.nls.client.AccessToken;
import com.alibaba.nls.client.protocol.NlsClient;
import com.alibaba.nls.client.protocol.OutputFormatEnum;
import com.alibaba.nls.client.protocol.SampleRateEnum;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizer;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizerListener;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizerResponse;
import com.novacloudedu.backend.config.NlsSpeechConfig;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;

/**
 * 阿里云 NLS 语音合成 (TTS) 服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class NlsTextToSpeechService {

    private final NlsSpeechConfig nlsSpeechConfig;

    private NlsClient nlsClient;
    private String accessToken;
    private long tokenExpireTime;

    @PostConstruct
    public void init() {
        try {
            refreshToken();
            nlsClient = new NlsClient(nlsSpeechConfig.getUrl(), accessToken);
            log.info("NLS 语音合成服务初始化成功");
        } catch (Exception e) {
            log.error("NLS 语音合成服务初始化失败", e);
        }
    }

    @PreDestroy
    public void destroy() {
        if (nlsClient != null) {
            nlsClient.shutdown();
        }
    }

    /**
     * 刷新 AccessToken
     */
    private void refreshToken() throws IOException {
        AccessToken token = new AccessToken(
                nlsSpeechConfig.getAccessKeyId(),
                nlsSpeechConfig.getAccessKeySecret()
        );
        token.apply();
        this.accessToken = token.getToken();
        this.tokenExpireTime = token.getExpireTime();
        log.info("NLS TTS AccessToken 刷新成功，过期时间: {}", tokenExpireTime);
    }

    /**
     * 检查并刷新 Token
     */
    private void checkAndRefreshToken() {
        long currentTime = System.currentTimeMillis() / 1000;
        if (currentTime >= tokenExpireTime - 60) {
            try {
                refreshToken();
                if (nlsClient != null) {
                    nlsClient.shutdown();
                }
                nlsClient = new NlsClient(nlsSpeechConfig.getUrl(), accessToken);
            } catch (IOException e) {
                log.error("刷新 TTS Token 失败", e);
            }
        }
    }

    /**
     * 文本转语音（同步方式）
     *
     * @param text 要合成的文本
     * @return 音频数据（字节数组）
     */
    public byte[] synthesize(String text) {
        return synthesize(text, null, null, null, null, null);
    }

    /**
     * 文本转语音（同步方式，可自定义参数）
     *
     * @param text       要合成的文本
     * @param voice      发音人（可选）
     * @param volume     音量 0-100（可选）
     * @param speechRate 语速 -500 到 500（可选）
     * @param pitchRate  语调 -500 到 500（可选）
     * @param format     音频格式（可选）
     * @return 音频数据（字节数组）
     */
    public byte[] synthesize(String text, String voice, Integer volume, 
                             Integer speechRate, Integer pitchRate, String format) {
        checkAndRefreshToken();

        NlsSpeechConfig.TtsConfig config = nlsSpeechConfig.getTts();
        
        // 使用传入参数或默认配置
        String finalVoice = voice != null ? voice : config.getVoice();
        int finalVolume = volume != null ? volume : config.getVolume();
        int finalSpeechRate = speechRate != null ? speechRate : config.getSpeechRate();
        int finalPitchRate = pitchRate != null ? pitchRate : config.getPitchRate();
        String finalFormat = format != null ? format : config.getFormat();

        ByteArrayOutputStream audioBuffer = new ByteArrayOutputStream();
        CompletableFuture<Boolean> future = new CompletableFuture<>();

        try {
            SpeechSynthesizerListener listener = new SpeechSynthesizerListener() {
                @Override
                public void onComplete(SpeechSynthesizerResponse response) {
                    log.debug("TTS 合成完成: taskId={}", response.getTaskId());
                    future.complete(true);
                }

                @Override
                public void onMessage(ByteBuffer buffer) {
                    byte[] data = new byte[buffer.remaining()];
                    buffer.get(data);
                    try {
                        audioBuffer.write(data);
                    } catch (IOException e) {
                        log.error("写入音频数据失败", e);
                    }
                }

                @Override
                public void onFail(SpeechSynthesizerResponse response) {
                    log.error("TTS 合成失败: status={}, message={}", 
                            response.getStatus(), response.getStatusText());
                    future.completeExceptionally(
                            new RuntimeException("TTS 合成失败: " + response.getStatusText()));
                }
            };

            SpeechSynthesizer synthesizer = new SpeechSynthesizer(nlsClient, listener);
            synthesizer.setAppKey(nlsSpeechConfig.getAppKey());
            synthesizer.setVoice(finalVoice);
            synthesizer.setVolume(finalVolume);
            synthesizer.setSpeechRate(finalSpeechRate);
            synthesizer.setPitchRate(finalPitchRate);
            synthesizer.setFormat(OutputFormatEnum.valueOf(finalFormat.toUpperCase()));
            synthesizer.setSampleRate(SampleRateEnum.SAMPLE_RATE_16K);
            synthesizer.setText(text);

            synthesizer.start();
            synthesizer.waitForComplete();
            
            // 等待完成，最多30秒
            future.get(30, TimeUnit.SECONDS);
            
            synthesizer.close();
            
            return audioBuffer.toByteArray();

        } catch (Exception e) {
            log.error("TTS 合成异常: text={}", text, e);
            throw new RuntimeException("语音合成失败", e);
        }
    }

    /**
     * 文本转语音（异步方式）
     *
     * @param text 要合成的文本
     * @return CompletableFuture 包含音频数据
     */
    public CompletableFuture<byte[]> synthesizeAsync(String text) {
        return synthesizeAsync(text, null, null, null, null, null);
    }

    /**
     * 文本转语音（异步方式，可自定义参数）
     */
    public CompletableFuture<byte[]> synthesizeAsync(String text, String voice, Integer volume,
                                                      Integer speechRate, Integer pitchRate, String format) {
        return CompletableFuture.supplyAsync(() -> 
                synthesize(text, voice, volume, speechRate, pitchRate, format));
    }

    /**
     * 获取支持的发音人列表
     */
    public String[] getSupportedVoices() {
        return new String[]{
                "xiaoyun",      // 小云 - 标准女声
                "xiaogang",     // 小刚 - 标准男声
                "ruoxi",        // 若兮 - 温柔女声
                "siqi",         // 思琪 - 温柔女声
                "sijia",        // 思佳 - 标准女声
                "sicheng",      // 思诚 - 标准男声
                "aiqi",         // 艾琪 - 温柔女声
                "aijia",        // 艾佳 - 标准女声
                "aicheng",      // 艾诚 - 标准男声
                "aida",         // 艾达 - 标准男声
                "ninger",       // 宁儿 - 标准女声
                "ruilin",       // 瑞琳 - 标准女声
                "siyue",        // 思悦 - 温柔女声
                "aiya",         // 艾雅 - 严厉女声
                "aixia",        // 艾夏 - 亲和女声
                "aimei",        // 艾美 - 甜美女声
                "aiyu",         // 艾雨 - 自然女声
                "aiyue",        // 艾悦 - 温柔女声
                "aijing",       // 艾婧 - 严厉女声
                "xiaomei",      // 小美 - 甜美女声
                "aina",         // 艾娜 - 浙普女声
                "yina",         // 伊娜 - 浙普女声
                "sijing",       // 思婧 - 严厉女声
                "sitong",       // 思彤 - 儿童音
                "xiaobei",      // 小北 - 萝莉女声
                "aitong",       // 艾彤 - 儿童音
                "aiwei",        // 艾薇 - 萝莉女声
                "aibao"         // 艾宝 - 萝莉女声
        };
    }
}
