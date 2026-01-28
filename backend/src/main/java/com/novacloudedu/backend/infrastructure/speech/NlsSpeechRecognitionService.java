package com.novacloudedu.backend.infrastructure.speech;

import com.alibaba.nls.client.AccessToken;
import com.alibaba.nls.client.protocol.InputFormatEnum;
import com.alibaba.nls.client.protocol.NlsClient;
import com.alibaba.nls.client.protocol.SampleRateEnum;
import com.alibaba.nls.client.protocol.asr.SpeechTranscriber;
import com.alibaba.nls.client.protocol.asr.SpeechTranscriberListener;
import com.alibaba.nls.client.protocol.asr.SpeechTranscriberResponse;
import com.novacloudedu.backend.config.NlsSpeechConfig;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Consumer;

/**
 * 阿里云 NLS 实时语音识别服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class NlsSpeechRecognitionService {

    private final NlsSpeechConfig nlsSpeechConfig;
    
    private NlsClient nlsClient;
    private String accessToken;
    private long tokenExpireTime;
    
    private final ConcurrentHashMap<String, SpeechTranscriber> transcriberMap = new ConcurrentHashMap<>();

    @PostConstruct
    public void init() {
        try {
            refreshToken();
            nlsClient = new NlsClient(nlsSpeechConfig.getUrl(), accessToken);
            log.info("NLS 语音识别服务初始化成功");
        } catch (Exception e) {
            log.error("NLS 语音识别服务初始化失败", e);
        }
    }

    @PreDestroy
    public void destroy() {
        transcriberMap.values().forEach(transcriber -> {
            try {
                transcriber.close();
            } catch (Exception e) {
                log.error("关闭 transcriber 失败", e);
            }
        });
        transcriberMap.clear();
        
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
        log.info("NLS AccessToken 刷新成功，过期时间: {}", tokenExpireTime);
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
                log.error("刷新 Token 失败", e);
            }
        }
    }

    /**
     * 创建实时语音转写会话
     *
     * @param sessionId 会话ID
     * @param onSentenceBegin 句子开始回调
     * @param onSentenceEnd 句子结束回调（返回最终识别结果）
     * @param onTranscriptionResultChange 中间结果回调
     * @param onError 错误回调
     * @return 是否创建成功
     */
    public boolean startTranscription(String sessionId,
                                       Consumer<String> onSentenceBegin,
                                       Consumer<TranscriptionResult> onSentenceEnd,
                                       Consumer<TranscriptionResult> onTranscriptionResultChange,
                                       Consumer<String> onError) {
        checkAndRefreshToken();
        
        try {
            SpeechTranscriberListener listener = new SpeechTranscriberListener() {
                private int currentSentenceIndex = 0;
                
                @Override
                public void onTranscriberStart(SpeechTranscriberResponse response) {
                    log.debug("语音转写开始: sessionId={}, taskId={}", sessionId, response.getTaskId());
                }

                @Override
                public void onSentenceBegin(SpeechTranscriberResponse response) {
                    currentSentenceIndex++;
                    log.debug("句子开始: sessionId={}, index={}", sessionId, currentSentenceIndex);
                    if (onSentenceBegin != null) {
                        onSentenceBegin.accept(String.valueOf(currentSentenceIndex));
                    }
                }

                @Override
                public void onSentenceEnd(SpeechTranscriberResponse response) {
                    log.debug("句子结束: sessionId={}, text={}", sessionId, response.getTransSentenceText());
                    if (onSentenceEnd != null) {
                        TranscriptionResult result = new TranscriptionResult(
                                currentSentenceIndex,
                                response.getTransSentenceText(),
                                response.getSentenceBeginTime(),
                                System.currentTimeMillis(),
                                true
                        );
                        onSentenceEnd.accept(result);
                    }
                }

                @Override
                public void onTranscriptionResultChange(SpeechTranscriberResponse response) {
                    log.debug("中间结果: sessionId={}, text={}", sessionId, response.getTransSentenceText());
                    if (onTranscriptionResultChange != null) {
                        TranscriptionResult result = new TranscriptionResult(
                                currentSentenceIndex,
                                response.getTransSentenceText(),
                                response.getSentenceBeginTime(),
                                System.currentTimeMillis(),
                                false
                        );
                        onTranscriptionResultChange.accept(result);
                    }
                }

                @Override
                public void onTranscriptionComplete(SpeechTranscriberResponse response) {
                    log.debug("语音转写完成: sessionId={}", sessionId);
                }

                @Override
                public void onFail(SpeechTranscriberResponse response) {
                    log.error("语音转写失败: sessionId={}, status={}, message={}",
                            sessionId, response.getStatus(), response.getStatusText());
                    if (onError != null) {
                        onError.accept(response.getStatusText());
                    }
                }
            };

            SpeechTranscriber transcriber = new SpeechTranscriber(nlsClient, listener);
            transcriber.setAppKey(nlsSpeechConfig.getAppKey());
            
            NlsSpeechConfig.TranscriberConfig config = nlsSpeechConfig.getTranscriber();
            transcriber.setFormat(InputFormatEnum.valueOf(config.getFormat().toUpperCase()));
            transcriber.setSampleRate(SampleRateEnum.SAMPLE_RATE_16K);
            transcriber.setEnableIntermediateResult(config.isEnableIntermediateResult());
            transcriber.setEnablePunctuation(config.isEnablePunctuation());
            transcriber.setEnableITN(config.isEnableItn());

            transcriber.start();
            transcriberMap.put(sessionId, transcriber);
            
            log.info("语音转写会话创建成功: sessionId={}", sessionId);
            return true;
            
        } catch (Exception e) {
            log.error("创建语音转写会话失败: sessionId={}", sessionId, e);
            if (onError != null) {
                onError.accept("创建语音转写会话失败: " + e.getMessage());
            }
            return false;
        }
    }

    /**
     * 发送音频数据
     *
     * @param sessionId 会话ID
     * @param audioData 音频数据（PCM格式）
     */
    public void sendAudio(String sessionId, byte[] audioData) {
        SpeechTranscriber transcriber = transcriberMap.get(sessionId);
        if (transcriber != null) {
            try {
                transcriber.send(audioData);
            } catch (Exception e) {
                log.error("发送音频数据失败: sessionId={}", sessionId, e);
            }
        } else {
            log.warn("未找到语音转写会话: sessionId={}", sessionId);
        }
    }

    /**
     * 停止语音转写
     *
     * @param sessionId 会话ID
     */
    public void stopTranscription(String sessionId) {
        SpeechTranscriber transcriber = transcriberMap.remove(sessionId);
        if (transcriber != null) {
            try {
                transcriber.stop();
                transcriber.close();
                log.info("语音转写会话已停止: sessionId={}", sessionId);
            } catch (Exception e) {
                log.error("停止语音转写会话失败: sessionId={}", sessionId, e);
            }
        }
    }

    /**
     * 语音识别结果
     */
    public record TranscriptionResult(
            int sentenceIndex,
            String text,
            long beginTime,
            long endTime,
            boolean isFinal
    ) {}
}
