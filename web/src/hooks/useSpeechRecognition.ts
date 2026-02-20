import { useState, useRef, useCallback } from 'react';
import { getToken } from '../api';

/** 静音自动停止阈值（毫秒） */
const SILENCE_TIMEOUT_MS = 2000;
/** 静音判断音量阈值（RMS，0~1） */
const SILENCE_THRESHOLD = 0.01;

/**
 * 实时语音识别 Hook
 * 通过 WebSocket 连接后端 ASR 服务，麦克风采集音频后下采样为 16kHz PCM 发送
 */
export function useSpeechRecognition() {
  const [isRecording, setIsRecording] = useState(false);
  const [interimText, setInterimText] = useState('');
  const [finalText, setFinalText] = useState('');
  const [error, setError] = useState<string | null>(null);

  const wsRef = useRef<WebSocket | null>(null);
  const streamRef = useRef<MediaStream | null>(null);
  const audioContextRef = useRef<AudioContext | null>(null);
  const processorRef = useRef<ScriptProcessorNode | null>(null);
  const sourceRef = useRef<MediaStreamAudioSourceNode | null>(null);
  const accumulatedTextRef = useRef('');
  const silenceTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const stopRecordingRef = useRef<(() => void) | null>(null);
  const isRecordingRef = useRef(false);

  /** 清理所有资源 */
  const cleanup = useCallback(() => {
    isRecordingRef.current = false;

    if (processorRef.current) {
      processorRef.current.disconnect();
      processorRef.current.onaudioprocess = null;
      processorRef.current = null;
    }
    if (sourceRef.current) {
      sourceRef.current.disconnect();
      sourceRef.current = null;
    }
    if (audioContextRef.current && audioContextRef.current.state !== 'closed') {
      audioContextRef.current.close().catch(() => {});
      audioContextRef.current = null;
    }
    if (streamRef.current) {
      streamRef.current.getTracks().forEach(t => t.stop());
      streamRef.current = null;
    }
    if (silenceTimerRef.current) {
      clearTimeout(silenceTimerRef.current);
      silenceTimerRef.current = null;
    }
    if (wsRef.current) {
      if (wsRef.current.readyState === WebSocket.OPEN) {
        try {
          wsRef.current.send(JSON.stringify({ type: 'stop' }));
        } catch { /* ignore */ }
      }
      wsRef.current.close();
      wsRef.current = null;
    }
    setIsRecording(false);
  }, []);

  /**
   * 将 Float32 音频数据从原始采样率下采样到 16kHz，并转为 Int16 PCM
   */
  const downsampleToInt16 = (buffer: Float32Array, fromSampleRate: number): ArrayBuffer => {
    const targetRate = 16000;
    const ratio = fromSampleRate / targetRate;
    const newLength = Math.round(buffer.length / ratio);
    const result = new Int16Array(newLength);

    for (let i = 0; i < newLength; i++) {
      const srcIndex = i * ratio;
      const srcIndexFloor = Math.floor(srcIndex);
      const srcIndexCeil = Math.min(srcIndexFloor + 1, buffer.length - 1);
      const frac = srcIndex - srcIndexFloor;

      // 线性插值
      const sample = buffer[srcIndexFloor] * (1 - frac) + buffer[srcIndexCeil] * frac;
      // 转 Int16
      const s = Math.max(-1, Math.min(1, sample));
      result[i] = s < 0 ? s * 0x8000 : s * 0x7FFF;
    }

    return result.buffer;
  };

  /** 开始录音 */
  const startRecording = useCallback(async () => {
    if (isRecordingRef.current) return;

    setError(null);
    setInterimText('');
    setFinalText('');
    accumulatedTextRef.current = '';

    console.log('[ASR] 开始录音流程...');

    // 1. 获取麦克风权限
    let stream: MediaStream;
    try {
      stream = await navigator.mediaDevices.getUserMedia({
        audio: {
          channelCount: 1,
          echoCancellation: true,
          noiseSuppression: true,
        },
      });
      console.log('[ASR] 麦克风权限获取成功');
    } catch (e) {
      const err = e as DOMException;
      console.error('[ASR] 麦克风权限获取失败:', err.name, err.message);
      if (err.name === 'NotAllowedError') {
        setError('麦克风权限被拒绝，请在浏览器设置中允许访问麦克风');
      } else {
        setError('无法访问麦克风: ' + err.message);
      }
      return;
    }
    streamRef.current = stream;

    // 2. 建立 WebSocket 连接
    const token = getToken();
    const baseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
    const wsUrl = baseUrl.replace(/^http/, 'ws') + '/ws/speech?token=' + (token || '');
    console.log('[ASR] WebSocket 连接:', wsUrl);

    const ws = new WebSocket(wsUrl);
    wsRef.current = ws;

    ws.binaryType = 'arraybuffer';

    // NLS 就绪标志，ready 消息到达后置为 true
    let nlsReady = false;

    ws.onmessage = (event) => {
      try {
        const data = JSON.parse(event.data);
        console.log('[ASR] 收到消息:', data.type, data.text || '');
        switch (data.type) {
          case 'ready':
            nlsReady = true;
            break;
          case 'transcription':
            setInterimText(data.text || '');
            break;
          case 'sentence_begin':
            break;
          case 'sentence_end':
            if (data.text) {
              accumulatedTextRef.current += data.text;
              setFinalText(accumulatedTextRef.current);
              setInterimText('');
            }
            break;
          case 'error':
            setError(data.message || '语音识别错误');
            cleanup();
            break;
          case 'stopped':
            break;
        }
      } catch (e) {
        console.error('[ASR] 解析消息失败:', e, event.data);
      }
    };

    ws.onerror = () => {
      setError('语音识别连接失败');
      cleanup();
    };

    ws.onclose = () => {
      if (isRecordingRef.current) {
        cleanup();
      }
    };

    ws.onopen = () => {
      console.log('[ASR] 启动音频采集');

      const audioContext = new AudioContext();
      audioContextRef.current = audioContext;

      const source = audioContext.createMediaStreamSource(stream);
      sourceRef.current = source;

      const processor = audioContext.createScriptProcessor(4096, 1, 1);
      processorRef.current = processor;

      processor.onaudioprocess = (e) => {
        if (!nlsReady || ws.readyState !== WebSocket.OPEN) return;
        const inputData = e.inputBuffer.getChannelData(0);
        const pcmData = downsampleToInt16(inputData, audioContext.sampleRate);
        ws.send(pcmData);

        // 静音检测
        let sum = 0;
        for (let i = 0; i < inputData.length; i++) sum += inputData[i] * inputData[i];
        const rms = Math.sqrt(sum / inputData.length);

        if (rms > SILENCE_THRESHOLD) {
          if (silenceTimerRef.current) {
            clearTimeout(silenceTimerRef.current);
            silenceTimerRef.current = null;
          }
        } else if (accumulatedTextRef.current && !silenceTimerRef.current) {
          silenceTimerRef.current = setTimeout(() => {
            silenceTimerRef.current = null;
            stopRecordingRef.current?.();
          }, SILENCE_TIMEOUT_MS);
        }
      };

      source.connect(processor);
      processor.connect(audioContext.destination);

      isRecordingRef.current = true;
      setIsRecording(true);
      console.log('[ASR] 音频采集已启动，等待 NLS ready...');
    };
  }, [cleanup]);

  /** 停止录音 */
  const stopRecording = useCallback(() => {
    cleanup();
  }, [cleanup]);

  // 保持 ref 始终指向最新的 stopRecording，供静音定时器调用
  stopRecordingRef.current = stopRecording;

  return {
    isRecording,
    interimText,
    finalText,
    error,
    startRecording,
    stopRecording,
  };
}
