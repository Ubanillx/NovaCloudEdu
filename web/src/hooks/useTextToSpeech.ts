import { useState, useRef, useCallback } from 'react';
import { apiClient } from '../api';

/**
 * 去除 Markdown 标记，提取纯文本用于 TTS
 */
function stripMarkdown(text: string): string {
  return text
    // 代码块
    .replace(/```[\s\S]*?```/g, '')
    // 行内代码
    .replace(/`([^`]+)`/g, '$1')
    // 图片
    .replace(/!\[([^\]]*)\]\([^)]+\)/g, '$1')
    // 链接
    .replace(/\[([^\]]+)\]\([^)]+\)/g, '$1')
    // 加粗/斜体
    .replace(/\*{1,3}([^*]+)\*{1,3}/g, '$1')
    .replace(/_{1,3}([^_]+)_{1,3}/g, '$1')
    // 标题
    .replace(/^#{1,6}\s+/gm, '')
    // 删除线
    .replace(/~~([^~]+)~~/g, '$1')
    // 引用
    .replace(/^>\s+/gm, '')
    // 无序列表标记
    .replace(/^[\s]*[-*+]\s+/gm, '')
    // 有序列表标记
    .replace(/^[\s]*\d+\.\s+/gm, '')
    // 分割线
    .replace(/^[-*_]{3,}$/gm, '')
    // HTML 标签
    .replace(/<[^>]+>/g, '')
    // 多余空行
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

export function useTextToSpeech() {
  const [isSpeaking, setIsSpeaking] = useState(false);
  const [speakingIndex, setSpeakingIndex] = useState<number | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const audioRef = useRef<HTMLAudioElement | null>(null);
  const objectUrlRef = useRef<string | null>(null);

  /** 清理音频资源 */
  const cleanup = useCallback(() => {
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current.removeAttribute('src');
      audioRef.current = null;
    }
    if (objectUrlRef.current) {
      URL.revokeObjectURL(objectUrlRef.current);
      objectUrlRef.current = null;
    }
    setIsSpeaking(false);
    setSpeakingIndex(null);
    setIsLoading(false);
  }, []);

  /** 停止播放 */
  const stop = useCallback(() => {
    cleanup();
  }, [cleanup]);

  /** 播放指定文本 */
  const speak = useCallback(async (text: string, index: number) => {
    // 如果正在播放同一条，则停止
    if (speakingIndex === index && isSpeaking) {
      stop();
      return;
    }

    // 停止之前的播放
    cleanup();

    const plainText = stripMarkdown(text);
    if (!plainText) return;

    // 限制长度（阿里云 TTS 单次最大约 5000 字符）
    const truncated = plainText.length > 4500 ? plainText.slice(0, 4500) + '...' : plainText;

    setIsLoading(true);
    setSpeakingIndex(index);

    try {
      const response = await apiClient.post('/api/speech/tts', {
        text: truncated,
        voice: 'zhixiaobai',
        format: 'mp3',
      }, {
        responseType: 'arraybuffer',
      });

      const blob = new Blob([response.data], { type: 'audio/mpeg' });
      const url = URL.createObjectURL(blob);
      objectUrlRef.current = url;

      const audio = new Audio(url);
      audioRef.current = audio;

      audio.onplay = () => {
        setIsLoading(false);
        setIsSpeaking(true);
      };

      audio.onended = () => {
        cleanup();
      };

      audio.onerror = () => {
        cleanup();
      };

      await audio.play();
    } catch (e) {
      console.error('TTS 播放失败:', e);
      cleanup();
    }
  }, [speakingIndex, isSpeaking, stop, cleanup]);

  return {
    isSpeaking,
    isLoading,
    speakingIndex,
    speak,
    stop,
  };
}
