import { useState, useCallback, useRef } from 'react';
import { apiClient, getToken } from '../../api';

// ============ 类型定义 ============

export interface AiChatMessage {
  id?: number;
  role: 'user' | 'assistant';
  content: string;
  timestamp?: string;
  isStreaming?: boolean;
  attachments?: string[];
}

/** 文生图任务状态 */
export interface ImageGeneration {
  index: number;
  prompt: string;
  status: 'generating' | 'done' | 'error';
  url?: string;
  error?: string;
}

/** 文生视频任务状态 */
export interface VideoGeneration {
  index: number;
  prompt: string;
  status: 'generating' | 'done' | 'error';
  url?: string;
  error?: string;
}

export interface AiChatSession {
  sessionId: number;
  title?: string;
  messageCount: number;
  createTime?: string;
  updateTime?: string;
}

// ============ AI 聊天 Hook ============

export function useAiChat() {
  const [sessions, setSessions] = useState<AiChatSession[]>([]);
  const [messages, setMessages] = useState<AiChatMessage[]>([]);
  const [currentSessionId, setCurrentSessionId] = useState<number | null>(null);
  const [sessionTitle, setSessionTitle] = useState('AI 助手');
  const [isLoading, setIsLoading] = useState(false);
  const [isLoadingSessions, setIsLoadingSessions] = useState(false);
  const [isInitializing, setIsInitializing] = useState(false);
  const [streamingContent, setStreamingContent] = useState('');
  const [imageGenerations, setImageGenerations] = useState<ImageGeneration[]>([]);
  const [videoGenerations, setVideoGenerations] = useState<VideoGeneration[]>([]);

  const abortControllerRef = useRef<AbortController | null>(null);
  const isStreamingRef = useRef(false);

  // ==================== 会话管理 ====================

  /** 获取会话列表 */
  const loadSessions = useCallback(async () => {
    setIsLoadingSessions(true);
    try {
      const res = await apiClient.get('/api/ai/chat/sessions', {
        params: { page: 0, size: 50 },
      });
      const data = res.data;
      if (data?.code === 0 && Array.isArray(data?.data)) {
        setSessions(data.data.map((s: Record<string, unknown>) => ({
          sessionId: s.sessionId,
          title: s.title,
          messageCount: s.messageCount ?? 0,
          createTime: s.createTime,
          updateTime: s.updateTime,
        })));
      }
    } catch (e) {
      console.error('获取会话列表失败:', e);
    } finally {
      setIsLoadingSessions(false);
    }
  }, []);

  /** 创建新会话 */
  const createSession = useCallback(async (): Promise<number | null> => {
    try {
      const res = await apiClient.post('/api/ai/chat/sessions');
      const data = res.data;
      if (data?.code === 0 && data?.data?.sessionId) {
        const sessionId = data.data.sessionId;
        setCurrentSessionId(sessionId);
        setMessages([]);
        setSessionTitle('AI 助手');
        setStreamingContent('');
        return sessionId;
      }
    } catch (e) {
      console.error('创建会话失败:', e);
    }
    return null;
  }, []);

  /** 加载会话详情 */
  const loadSessionDetail = useCallback(async (sessionId: number) => {
    // 切换会话时立即停止当前流式响应
    abortControllerRef.current?.abort();
    abortControllerRef.current = null;
    isStreamingRef.current = false;
    setIsLoading(false);
    setStreamingContent('');

    setIsInitializing(true);
    try {
      const res = await apiClient.get(`/api/ai/chat/sessions/${sessionId}`);
      const data = res.data;
      if (data?.code === 0 && data?.data) {
        const detail = data.data;
        const session = detail.session;
        const msgs: AiChatMessage[] = (detail.messages || []).map((m: Record<string, unknown>) => ({
          id: m.id,
          role: m.role as 'user' | 'assistant',
          content: m.content as string,
          timestamp: m.createTime as string | undefined,
          attachments: m.attachments as string[] | undefined,
        }));
        setCurrentSessionId(sessionId);
        setMessages(msgs);
        setSessionTitle(session?.title || 'AI 助手');
        setStreamingContent('');
      }
    } catch (e) {
      console.error('获取会话详情失败:', e);
    } finally {
      setIsInitializing(false);
    }
  }, []);

  /** 删除会话 */
  const deleteSession = useCallback(async (sessionId: number): Promise<boolean> => {
    try {
      const res = await apiClient.delete(`/api/ai/chat/sessions/${sessionId}`);
      if (res.data?.code === 0) {
        setSessions(prev => prev.filter(s => String(s.sessionId) !== String(sessionId)));
        if (String(currentSessionId) === String(sessionId)) {
          setCurrentSessionId(null);
          setMessages([]);
          setSessionTitle('AI 助手');
        }
        return true;
      }
    } catch (e) {
      console.error('删除会话失败:', e);
    }
    return false;
  }, [currentSessionId]);

  // ==================== SSE 流式对话 ====================

  /** 发送消息（SSE 流式） */
  const sendMessage = useCallback(async (
    content: string,
    options?: {
      imageUrls?: string[];
      documentUrls?: string[];
      modelId?: string;
    }
  ) => {
    if (!content.trim() || isStreamingRef.current) return;
    if (currentSessionId == null) return;

    isStreamingRef.current = true;
    setIsLoading(true);
    setStreamingContent('');
    setImageGenerations([]);
    setVideoGenerations([]);

    // 添加用户消息
    const userMsg: AiChatMessage = {
      role: 'user',
      content,
      timestamp: new Date().toISOString(),
      attachments: [
        ...(options?.imageUrls || []),
        ...(options?.documentUrls || []).map(u => `doc:${u}`),
      ].filter(Boolean).length > 0
        ? [
            ...(options?.imageUrls || []),
            ...(options?.documentUrls || []).map(u => `doc:${u}`),
          ]
        : undefined,
    };
    setMessages(prev => [...prev, userMsg]);

    // SSE 请求
    const baseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
    const url = `${baseUrl}/api/ai/chat/sessions/${currentSessionId}/stream`;
    const token = getToken();

    const body: Record<string, unknown> = { message: content };
    if (options?.imageUrls?.length) body.imageUrls = options.imageUrls;
    if (options?.documentUrls?.length) body.documentUrls = options.documentUrls;
    if (options?.modelId) body.modelId = options.modelId;

    const controller = new AbortController();
    abortControllerRef.current = controller;

    let accumulated = '';
    // 本地追踪生成结果（避免闭包读不到最新 React state）
    const imageResultsMap = new Map<number, { url?: string; error?: string }>();
    const videoResultsMap = new Map<number, { url?: string; error?: string }>();

    try {
      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
          ...(token ? { Authorization: `Bearer ${token}` } : {}),
        },
        body: JSON.stringify(body),
        signal: controller.signal,
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }

      const reader = response.body?.getReader();
      if (!reader) throw new Error('No response body');

      const decoder = new TextDecoder();
      let buffer = '';
      let currentEventType = 'message';

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const lines = buffer.split('\n');
        buffer = lines.pop() || '';

        for (const line of lines) {
          if (line.startsWith('event:')) {
            currentEventType = line.slice(6).trim();
            if (currentEventType === 'done') {
              break;
            }
            continue;
          }

          if (line.startsWith('data:')) {
            const data = line.slice(5).trim();
            if (data === '[DONE]') break;
            if (!data) continue;

            // 根据事件类型分发处理
            if (currentEventType === 'image_generating') {
              try {
                const payload = JSON.parse(data);
                setImageGenerations(prev => [
                  ...prev,
                  { index: payload.index, prompt: payload.prompt, status: 'generating' },
                ]);
              } catch { /* ignore */ }
              currentEventType = 'message';
              continue;
            }

            if (currentEventType === 'image_generated') {
              try {
                const payload = JSON.parse(data);
                imageResultsMap.set(payload.index, { url: payload.url });
                setImageGenerations(prev =>
                  prev.map(ig =>
                    ig.index === payload.index
                      ? { ...ig, status: 'done' as const, url: payload.url }
                      : ig
                  )
                );
              } catch { /* ignore */ }
              currentEventType = 'message';
              continue;
            }

            if (currentEventType === 'image_error') {
              try {
                const payload = JSON.parse(data);
                imageResultsMap.set(payload.index, { error: payload.error });
                setImageGenerations(prev =>
                  prev.map(ig =>
                    ig.index === payload.index
                      ? { ...ig, status: 'error' as const, error: payload.error }
                      : ig
                  )
                );
              } catch { /* ignore */ }
              currentEventType = 'message';
              continue;
            }

            if (currentEventType === 'video_generating') {
              try {
                const payload = JSON.parse(data);
                setVideoGenerations(prev => [
                  ...prev,
                  { index: payload.index, prompt: payload.prompt, status: 'generating' },
                ]);
              } catch { /* ignore */ }
              currentEventType = 'message';
              continue;
            }

            if (currentEventType === 'video_generated') {
              try {
                const payload = JSON.parse(data);
                videoResultsMap.set(payload.index, { url: payload.url });
                setVideoGenerations(prev =>
                  prev.map(vg =>
                    vg.index === payload.index
                      ? { ...vg, status: 'done' as const, url: payload.url }
                      : vg
                  )
                );
              } catch { /* ignore */ }
              currentEventType = 'message';
              continue;
            }

            if (currentEventType === 'video_error') {
              try {
                const payload = JSON.parse(data);
                videoResultsMap.set(payload.index, { error: payload.error });
                setVideoGenerations(prev =>
                  prev.map(vg =>
                    vg.index === payload.index
                      ? { ...vg, status: 'error' as const, error: payload.error }
                      : vg
                  )
                );
              } catch { /* ignore */ }
              currentEventType = 'message';
              continue;
            }

            if (currentEventType === 'error') {
              currentEventType = 'message';
              continue;
            }

            // 普通 message 事件
            try {
              const jsonData = JSON.parse(data);
              if (typeof jsonData === 'object' && jsonData !== null) {
                const token = jsonData.content ?? jsonData.text ?? data;
                accumulated += String(token);
              } else {
                accumulated += String(jsonData);
              }
            } catch {
              // 纯文本 token
              accumulated += data;
            }

            setStreamingContent(accumulated);
            currentEventType = 'message';
          }
        }
      }

      // 流结束，替换标记并保存为 assistant 消息
      if (accumulated) {
        let finalContent = accumulated;
        // 用实际图片URL替换 <<IMAGE_GEN:...>> 和 <<IMAGE_REF:...>> 标记
        if (imageResultsMap.size > 0) {
          let idx = 0;
          finalContent = finalContent.replace(/<<IMAGE_(?:GEN|REF):(.+?)>>/g, (_match, prompt: string) => {
            idx++;
            const result = imageResultsMap.get(idx);
            if (result?.url) {
              return `\n![AI生成图片](${result.url})\n`;
            } else if (result?.error) {
              return `\n[图片生成失败: ${result.error}]\n`;
            }
            return `\n[图片生成中: ${prompt.trim()}]\n`;
          });
        }
        // 用实际视频URL替换 <<VIDEO_GEN:...>> 标记
        if (videoResultsMap.size > 0) {
          let idx = 0;
          finalContent = finalContent.replace(/<<VIDEO_GEN:(.+?)>>/g, (_match, prompt: string) => {
            idx++;
            const result = videoResultsMap.get(idx);
            if (result?.url) {
              return `\n<video controls src="${result.url}" style="max-width:100%;border-radius:12px"></video>\n`;
            } else if (result?.error) {
              return `\n[视频生成失败: ${result.error}]\n`;
            }
            return `\n[视频生成中: ${prompt.trim()}]\n`;
          });
        }
        setMessages(prev => [...prev, {
          role: 'assistant',
          content: finalContent,
          timestamp: new Date().toISOString(),
        }]);
      }
      setStreamingContent('');
      setImageGenerations([]);
      setVideoGenerations([]);

    } catch (e) {
      if ((e as Error).name !== 'AbortError') {
        console.error('SSE 请求失败:', e);
        // 如果有部分内容，仍然保存
        if (accumulated) {
          setMessages(prev => [...prev, {
            role: 'assistant',
            content: accumulated,
            timestamp: new Date().toISOString(),
          }]);
          setStreamingContent('');
        }
      }
    } finally {
      isStreamingRef.current = false;
      setIsLoading(false);
      abortControllerRef.current = null;
    }
  }, [currentSessionId]);

  /** 取消流式响应 */
  const cancelStream = useCallback(() => {
    abortControllerRef.current?.abort();
    abortControllerRef.current = null;

    if (isStreamingRef.current) {
      setStreamingContent(prev => {
        if (prev) {
          setMessages(msgs => [...msgs, {
            role: 'assistant',
            content: prev + '\n\n*[已停止]*',
            timestamp: new Date().toISOString(),
          }]);
        }
        return '';
      });
      isStreamingRef.current = false;
      setIsLoading(false);
    }
  }, []);

  /** 刷新会话标题 */
  const refreshTitle = useCallback(async () => {
    if (currentSessionId == null) return;
    try {
      const res = await apiClient.get(`/api/ai/chat/sessions/${currentSessionId}`);
      const data = res.data;
      if (data?.code === 0 && data?.data?.session?.title) {
        setSessionTitle(data.data.session.title);
      }
    } catch {
      // ignore
    }
  }, [currentSessionId]);

  /** 开始新对话（重置当前会话） */
  const startNewSession = useCallback(async (): Promise<boolean> => {
    if (isStreamingRef.current) return false;
    const sessionId = await createSession();
    if (sessionId != null) {
      loadSessions();
      return true;
    }
    return false;
  }, [createSession, loadSessions]);

  /** 打开已有会话 */
  const openSession = useCallback(async (session: AiChatSession) => {
    await loadSessionDetail(session.sessionId);
  }, [loadSessionDetail]);

  return {
    // 状态
    sessions,
    messages,
    currentSessionId,
    sessionTitle,
    isLoading,
    isLoadingSessions,
    isInitializing,
    streamingContent,
    imageGenerations,
    videoGenerations,
    isStreaming: isStreamingRef.current,

    // 会话管理
    loadSessions,
    createSession,
    loadSessionDetail,
    deleteSession,
    startNewSession,
    openSession,

    // 对话
    sendMessage,
    cancelStream,
    refreshTitle,
  };
}
