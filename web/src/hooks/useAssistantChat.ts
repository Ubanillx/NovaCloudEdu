import { useState, useCallback, useRef, useEffect } from 'react';
import { apiClient, getToken } from '../api';

// ============ 类型定义 ============

export interface AssistantChatMessage {
  id?: number;
  role: 'user' | 'assistant';
  content: string;
  timestamp?: string;
  isStreaming?: boolean;
}

export interface AssistantChatSession {
  sessionId: number;
  title?: string;
  messageCount: number;
  createTime?: string;
  updateTime?: string;
}

// ============ localStorage 会话映射 ============

const STORAGE_KEY = 'ai_assistant_sessions';

function getStoredSessionIds(assistantId: string): string[] {
  try {
    const data = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
    return data[assistantId] || [];
  } catch {
    return [];
  }
}

function storeSessionId(assistantId: string, sessionId: string) {
  try {
    const data = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
    const list: string[] = data[assistantId] || [];
    if (!list.includes(sessionId)) {
      list.unshift(sessionId);
      data[assistantId] = list;
      localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
    }
  } catch { /* ignore */ }
}

function removeStoredSessionId(assistantId: string, sessionId: string) {
  try {
    const data = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
    const list: string[] = data[assistantId] || [];
    data[assistantId] = list.filter(id => id !== sessionId);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
  } catch { /* ignore */ }
}

// ============ Hook ============

export function useAssistantChat(assistantId: string | undefined) {
  const [sessions, setSessions] = useState<AssistantChatSession[]>([]);
  const [messages, setMessages] = useState<AssistantChatMessage[]>([]);
  const [currentSessionId, setCurrentSessionId] = useState<string | null>(null);
  const [sessionTitle, setSessionTitle] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [isLoadingSessions, setIsLoadingSessions] = useState(false);
  const [isInitializing, setIsInitializing] = useState(false);
  const [streamingContent, setStreamingContent] = useState('');
  const [ragStatus, setRagStatus] = useState<'idle' | 'searching' | 'found' | 'not_found'>('idle');
  const [workflowStatus, setWorkflowStatus] = useState<'idle' | 'calling' | 'completed' | 'error'>('idle');

  const abortControllerRef = useRef<AbortController | null>(null);
  const isStreamingRef = useRef(false);
  const currentSessionIdRef = useRef<string | null>(null);

  // 同步 ref
  useEffect(() => {
    currentSessionIdRef.current = currentSessionId;
  }, [currentSessionId]);

  // ==================== 会话管理 ====================

  /** 获取此助手的会话列表 */
  const loadSessions = useCallback(async () => {
    if (!assistantId) return;
    setIsLoadingSessions(true);
    try {
      const storedIds = getStoredSessionIds(String(assistantId));
      if (storedIds.length === 0) {
        setSessions([]);
        return;
      }
      // 获取全部会话，再根据 localStorage 映射过滤
      const res = await apiClient.get('/api/ai/chat/sessions', {
        params: { page: 0, size: 100 },
      });
      const data = res.data;
      if (data?.code === 0 && Array.isArray(data?.data)) {
        const storedSet = new Set(storedIds);
        const filtered = data.data
          .filter((s: Record<string, unknown>) => storedSet.has(String(s.sessionId)))
          .map((s: Record<string, unknown>) => ({
            sessionId: s.sessionId,
            title: s.title,
            messageCount: s.messageCount ?? 0,
            createTime: s.createTime,
            updateTime: s.updateTime,
          }));
        setSessions(filtered);

        // 清理已不存在的 sessionId
        const existingIds = new Set(filtered.map((s: AssistantChatSession) => String(s.sessionId)));
        const validIds = storedIds.filter(id => existingIds.has(id));
        if (validIds.length !== storedIds.length) {
          const storageData = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
          storageData[String(assistantId)] = validIds;
          localStorage.setItem(STORAGE_KEY, JSON.stringify(storageData));
        }
      }
    } catch (e) {
      console.error('获取会话列表失败:', e);
    } finally {
      setIsLoadingSessions(false);
    }
  }, [assistantId]);

  /** 加载会话详情 */
  const loadSessionDetail = useCallback(async (sessionId: string) => {
    abortControllerRef.current?.abort();
    abortControllerRef.current = null;
    isStreamingRef.current = false;
    setIsLoading(false);
    setStreamingContent('');
    setRagStatus('idle');

    setIsInitializing(true);
    try {
      const res = await apiClient.get(`/api/ai/chat/sessions/${sessionId}`);
      const data = res.data;
      if (data?.code === 0 && data?.data) {
        const detail = data.data;
        const session = detail.session;
        const msgs: AssistantChatMessage[] = (detail.messages || []).map((m: Record<string, unknown>) => ({
          id: m.id,
          role: m.role as 'user' | 'assistant',
          content: m.content as string,
          timestamp: m.createTime as string | undefined,
        }));
        setCurrentSessionId(sessionId);
        setMessages(msgs);
        setSessionTitle(session?.title || '');
        setStreamingContent('');
      }
    } catch (e) {
      console.error('获取会话详情失败:', e);
    } finally {
      setIsInitializing(false);
    }
  }, []);

  /** 删除会话 */
  const deleteSession = useCallback(async (sessionId: string): Promise<boolean> => {
    try {
      const res = await apiClient.delete(`/api/ai/chat/sessions/${sessionId}`);
      if (res.data?.code === 0) {
        setSessions(prev => prev.filter(s => String(s.sessionId) !== sessionId));
        if (assistantId) removeStoredSessionId(String(assistantId), sessionId);
        if (currentSessionIdRef.current === sessionId) {
          setCurrentSessionId(null);
          setMessages([]);
          setSessionTitle('');
        }
        return true;
      }
    } catch (e) {
      console.error('删除会话失败:', e);
    }
    return false;
  }, [assistantId]);

  // ==================== SSE 流式对话 ====================

  /** 发送消息 */
  const sendMessage = useCallback(async (content: string) => {
    if (!content.trim() || isStreamingRef.current || !assistantId) return;

    isStreamingRef.current = true;
    setIsLoading(true);
    setStreamingContent('');
    setRagStatus('idle');
    setWorkflowStatus('idle');

    // 添加用户消息
    setMessages(prev => [...prev, {
      role: 'user',
      content,
      timestamp: new Date().toISOString(),
    }]);

    const baseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
    const url = `${baseUrl}/api/ai/assistants/${assistantId}/chat/stream`;
    const token = getToken();

    const body: Record<string, unknown> = { message: content };
    if (currentSessionIdRef.current) {
      // 雪花ID，不做 Number() 转换
      body.sessionId = currentSessionIdRef.current as unknown as number;
    }

    const controller = new AbortController();
    abortControllerRef.current = controller;
    let accumulated = '';
    let currentEvent = '';
    // 时间节流（~80ms）：避免每个 token 都触发 React 重渲染 + ReactMarkdown 全量解析
    let throttleTimer: ReturnType<typeof setTimeout> | null = null;
    const THROTTLE_MS = 80;
    const flushStreaming = () => {
      if (throttleTimer !== null) {
        clearTimeout(throttleTimer);
        throttleTimer = null;
      }
      setStreamingContent(accumulated);
    };
    const scheduleStreamingUpdate = () => {
      if (throttleTimer === null) {
        throttleTimer = setTimeout(() => {
          setStreamingContent(accumulated);
          throttleTimer = null;
        }, THROTTLE_MS);
      }
    };

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

      if (!response.ok) throw new Error(`HTTP ${response.status}`);

      const reader = response.body?.getReader();
      if (!reader) throw new Error('No response body');

      const decoder = new TextDecoder();
      let buffer = '';
      // SSE 事件缓冲：按 SSE 规范，同一事件内的多个 data: 行用 \n 拼接
      let pendingDataLines: string[] = [];

      // 处理一个完整的 SSE 事件
      const dispatchEvent = (eventType: string, data: string) => {
        if (data === '[DONE]') return;

        // session 事件：接收后端自动创建的会话 ID
        if (eventType === 'session') {
          try {
            const sessionData = JSON.parse(data);
            if (sessionData.sessionId) {
              const sid = String(sessionData.sessionId);
              setCurrentSessionId(sid);
              currentSessionIdRef.current = sid;
              storeSessionId(String(assistantId), sid);
            }
          } catch { /* ignore */ }
          return;
        }

        if (eventType === 'rag_searching') {
          setRagStatus('searching');
          return;
        }

        if (eventType === 'rag_completed') {
          try {
            const ragData = JSON.parse(data);
            setRagStatus(ragData.found ? 'found' : 'not_found');
          } catch {
            setRagStatus('not_found');
          }
          return;
        }

        if (eventType === 'error') {
          accumulated += `\n\n⚠️ ${data}`;
          flushStreaming();
          return;
        }

        if (eventType === 'done') return;

        // 工作流事件处理
        if (eventType === 'workflow_calling') {
          accumulated = accumulated.replace(/\[CALL_WORKFLOW:\s*\{[\s\S]*?\}\s*\]/, '');
          flushStreaming();
          setWorkflowStatus('calling');
          return;
        }

        if (eventType === 'workflow_completed') {
          setWorkflowStatus('completed');
          return;
        }

        if (eventType === 'workflow_error') {
          try {
            const wfData = JSON.parse(data);
            accumulated += `\n\n> 工作流执行失败: ${wfData.error}`;
            flushStreaming();
          } catch { /* ignore */ }
          setWorkflowStatus('error');
          return;
        }

        if (eventType === 'image_generating' || eventType === 'video_generating') {
          try {
            const genData = JSON.parse(data);
            accumulated += `\n\n🎨 *正在生成${eventType === 'video_generating' ? '视频' : '图片'}：${genData.prompt}...*`;
            flushStreaming();
          } catch { /* ignore */ }
          return;
        }

        if (eventType === 'image_generated' || eventType === 'video_generated') {
          try {
            const genData = JSON.parse(data);
            const mediaUrl = genData.url || genData.imageUrl;
            if (mediaUrl) {
              accumulated += eventType === 'video_generated'
                ? `\n\n<video controls src="${mediaUrl}" style="max-width:100%;border-radius:12px"></video>`
                : `\n\n![生成图片](${mediaUrl})`;
              flushStreaming();
            }
          } catch { /* ignore */ }
          return;
        }

        // 普通 message token：data 是 LLM token（可能含换行）
        try {
          const json = JSON.parse(data);
          const chunk = json.content ?? json.text ?? data;
          accumulated += String(chunk);
        } catch {
          accumulated += data;
        }
        scheduleStreamingUpdate();
      };

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const lines = buffer.split('\n');
        buffer = lines.pop() || '';

        for (const line of lines) {
          // 空行 = SSE 事件分隔符 → 派发已缓冲的事件
          if (line.trim() === '') {
            if (pendingDataLines.length > 0) {
              const eventData = pendingDataLines.join('\n');
              dispatchEvent(currentEvent, eventData);
              pendingDataLines = [];
            }
            currentEvent = '';
            continue;
          }

          if (line.startsWith('event:')) {
            currentEvent = line.slice(6).trim();
            continue;
          }

          if (line.startsWith('data:')) {
            // SSE 规范：data: 后面如果有一个空格则去掉该空格
            const dataContent = line.charAt(5) === ' ' ? line.slice(6) : line.slice(5);
            pendingDataLines.push(dataContent);
            continue;
          }
        }
      }

      // 流结束后处理剩余的未派发事件
      if (pendingDataLines.length > 0) {
        const eventData = pendingDataLines.join('\n');
        dispatchEvent(currentEvent, eventData);
      }
    } catch (err: unknown) {
      flushStreaming();
      if (err instanceof DOMException && err.name === 'AbortError') {
        if (accumulated) accumulated += '\n\n*[已停止]*';
      } else {
        console.error('SSE 请求失败:', err);
        if (!accumulated) accumulated = '抱歉，请求失败，请稍后重试。';
      }
    } finally {
      flushStreaming();
      if (accumulated) {
        setMessages(prev => [...prev, {
          role: 'assistant',
          content: accumulated,
          timestamp: new Date().toISOString(),
        }]);
      }
      setStreamingContent('');
      isStreamingRef.current = false;
      setIsLoading(false);
      abortControllerRef.current = null;
      // 延迟重置工作流状态，让用户短暂看到完成/错误提示
      setTimeout(() => setWorkflowStatus('idle'), 1500);
    }
  }, [assistantId]);

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

  /** 重试：删除最后一对用户+AI消息，重新发送用户消息 */
  const retryMessage = useCallback((messageIndex: number) => {
    if (isStreamingRef.current) return;

    setMessages(prev => {
      const aiMsg = prev[messageIndex];
      if (!aiMsg || aiMsg.role !== 'assistant') return prev;

      let userMsgIndex = messageIndex - 1;
      while (userMsgIndex >= 0 && prev[userMsgIndex].role !== 'user') {
        userMsgIndex--;
      }
      if (userMsgIndex < 0) return prev;

      const userMsg = prev[userMsgIndex];
      const newMessages = prev.filter((_, i) => i !== userMsgIndex && i !== messageIndex);

      setTimeout(() => {
        sendMessage(userMsg.content);
      }, 50);

      return newMessages;
    });
  }, [sendMessage]);

  /** 新建对话（重置状态，首条消息发送时自动创建会话） */
  const startNewSession = useCallback(() => {
    if (isStreamingRef.current) return;
    abortControllerRef.current?.abort();
    setCurrentSessionId(null);
    currentSessionIdRef.current = null;
    setMessages([]);
    setSessionTitle('');
    setStreamingContent('');
    setRagStatus('idle');
  }, []);

  /** 刷新会话标题 */
  const refreshSessionTitle = useCallback(async () => {
    const sid = currentSessionIdRef.current;
    if (!sid) return;
    try {
      const res = await apiClient.get(`/api/ai/chat/sessions/${sid}`);
      const data = res.data;
      if (data?.code === 0 && data?.data?.session?.title) {
        setSessionTitle(data.data.session.title);
        // 同步更新 sessions 列表中的标题
        setSessions(prev => prev.map(s =>
          String(s.sessionId) === sid
            ? { ...s, title: data.data.session.title }
            : s
        ));
      }
    } catch { /* ignore */ }
  }, []);

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
    ragStatus,
    workflowStatus,

    // 会话管理
    loadSessions,
    loadSessionDetail,
    deleteSession,
    startNewSession,
    refreshSessionTitle,

    // 对话
    sendMessage,
    cancelStream,
    retryMessage,
  };
}
