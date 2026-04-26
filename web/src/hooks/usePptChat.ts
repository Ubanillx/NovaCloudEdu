import { useState, useRef, useCallback } from 'react';
import JSONBig from 'json-bigint';
import { apiClient, Configuration, PPTApi, getToken } from '../api';
import type {
  PptPhase, PptGenerationState, GeneratedSlide, SlideImage,
  TemplateSlide, AgentTask, AgentTaskSummary,
} from './usePptGeneration';

const JSONBigString = JSONBig({ storeAsString: true });

// ==================== Chat Message Types ====================

export type PptChatMessageType =
  | 'user'
  | 'ai-text'
  | 'outline-card'
  | 'progress-card'
  | 'download-card'
  | 'status'
  | 'action-card'
  | 'error';

export interface PptChatMessage {
  id: string;
  type: PptChatMessageType;
  content: string;
  timestamp: string;
  isStreaming?: boolean;
  outlineMarkdown?: string;
  progress?: { current: number; total: number };
  downloadUrl?: string;
  downloadFileName?: string;
  actionType?: 'confirm-outline';
  actionDone?: boolean;
}

// ==================== Session Types ====================

export interface PptSessionSummary {
  id: string;
  topic: string;
  state: string;
  resultUrl?: string;
  createTime: string;
  updateTime: string;
}

export interface PptSessionDetail {
  id: string;
  topic: string;
  state: string;
  outlineMarkdown?: string;
  outlineJson?: string;
  projectId?: string;
  templateId?: string;
  templateUrl?: string;
  templateJson?: string;
  slidesJson?: string;
  resultUrl?: string;
  createTime: string;
  updateTime: string;
}

// ==================== Constants ====================

const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
const pptApi = new PPTApi(new Configuration(), '', apiClient);

let msgIdCounter = 0;
function nextMsgId(): string {
  return `msg-${Date.now()}-${++msgIdCounter}`;
}

function nowTimestamp(): string {
  return new Date().toISOString();
}

// ==================== Hook ====================

export function usePptChat() {
  // ---- Session list state ----
  const [sessions, setSessions] = useState<PptSessionSummary[]>([]);
  const [isLoadingSessions, setIsLoadingSessions] = useState(false);
  const [currentSessionId, setCurrentSessionId] = useState<string | null>(null);

  // ---- Chat messages ----
  const [messages, setMessages] = useState<PptChatMessage[]>([]);
  const streamingMsgIdRef = useRef<string | null>(null);

  // ---- PPT generation state (mirrors usePptGeneration) ----
  const [pptState, setPptState] = useState<PptGenerationState>({
    phase: 'idle',
    sessionId: null,
    statusMessage: '',
    aiMessage: '',
    intentDetected: null,
    intentTopic: '',
    outlineMarkdown: '',
    outlineJson: '',
    projectId: null,
    templateUrl: '',
    slideImages: [],
    templateSlides: [],
    generatedSlides: [],
    currentSlide: 0,
    totalSlides: 0,
    selectedSlideIndex: 0,
    resultUrl: '',
    resultFileName: '',
    errorMessage: '',
    agentTasks: [],
    agentTaskSummary: null,
    evaluationResult: null,
    repairProgress: null,
  });

  const abortControllerRef = useRef<AbortController | null>(null);
  const sessionIdRef = useRef<string | null>(null);

  const updatePpt = useCallback((patch: Partial<PptGenerationState>) => {
    if (patch.sessionId !== undefined) {
      sessionIdRef.current = patch.sessionId;
    }
    setPptState(prev => ({ ...prev, ...patch }));
  }, []);

  // ---- Helper: append chat message ----
  const appendMessage = useCallback((msg: Omit<PptChatMessage, 'id' | 'timestamp'>) => {
    const full: PptChatMessage = { ...msg, id: nextMsgId(), timestamp: nowTimestamp() };
    setMessages(prev => [...prev, full]);
    return full.id;
  }, []);

  const updateMessage = useCallback((id: string, patch: Partial<PptChatMessage>) => {
    setMessages(prev => prev.map(m => m.id === id ? { ...m, ...patch } : m));
  }, []);

  // ---- Session API ----

  const loadSessions = useCallback(async () => {
    setIsLoadingSessions(true);
    try {
      const res = await pptApi.listSessions1();
      if (res.data?.code === 0 && Array.isArray(res.data.data)) {
        setSessions(res.data.data.map((s: Record<string, unknown>) => ({
          id: String(s.id),
          topic: s.topic as string || '',
          state: s.state as string || '',
          resultUrl: s.resultUrl as string || undefined,
          createTime: s.createTime as string || '',
          updateTime: s.updateTime as string || '',
        })));
      }
    } catch (e) {
      console.error('加载PPT会话列表失败:', e);
    } finally {
      setIsLoadingSessions(false);
    }
  }, []);

  const loadSessionDetail = useCallback(async (sessionId: string) => {
    try {
      const res = await pptApi.getSessionDetail({ sessionId: sessionId as unknown as number });
      if (res.data?.code === 0 && res.data.data) {
        return res.data.data as unknown as PptSessionDetail;
      }
    } catch (e) {
      console.error('加载PPT会话详情失败:', e);
    }
    return null;
  }, []);

  const deleteSession = useCallback(async (sessionId: string) => {
    try {
      await pptApi.deleteSession({ sessionId: sessionId as unknown as number });
      setSessions(prev => prev.filter(s => s.id !== sessionId));
      if (currentSessionId === sessionId) {
        setCurrentSessionId(null);
        setMessages([]);
        setPptState(prev => ({ ...prev, phase: 'idle', sessionId: null }));
      }
      return true;
    } catch (e) {
      console.error('删除PPT会话失败:', e);
      return false;
    }
  }, [currentSessionId]);

  // ---- Reconstruct messages from session detail ----
  const reconstructMessages = useCallback((detail: PptSessionDetail) => {
    const msgs: PptChatMessage[] = [];

    // 1. User message (topic)
    msgs.push({
      id: nextMsgId(),
      type: 'user',
      content: detail.topic,
      timestamp: detail.createTime,
    });

    // 2. Outline
    if (detail.outlineMarkdown) {
      msgs.push({
        id: nextMsgId(),
        type: 'ai-text',
        content: '好的，我来为你生成一份大纲。',
        timestamp: detail.createTime,
      });
      msgs.push({
        id: nextMsgId(),
        type: 'outline-card',
        content: '',
        outlineMarkdown: detail.outlineMarkdown,
        timestamp: detail.createTime,
        actionDone: true,
      });
    }

    // 3. Result
    if (detail.resultUrl) {
      msgs.push({
        id: nextMsgId(),
        type: 'ai-text',
        content: 'PPT 生成完毕！',
        timestamp: detail.updateTime,
      });
      msgs.push({
        id: nextMsgId(),
        type: 'download-card',
        content: '',
        downloadUrl: detail.resultUrl,
        downloadFileName: `${detail.topic}.pptx`,
        timestamp: detail.updateTime,
      });
    }

    return msgs;
  }, []);

  // ---- Open existing session ----
  const openSession = useCallback(async (sessionId: string) => {
    abortControllerRef.current?.abort();
    setCurrentSessionId(sessionId);

    const detail = await loadSessionDetail(sessionId);
    if (!detail) return;

    const msgs = reconstructMessages(detail);
    setMessages(msgs);

    // Reconstruct PPT state from detail
    let phase: PptPhase = 'idle';
    const stateStr = detail.state?.toLowerCase();
    if (stateStr === 'completed') phase = 'completed';
    else if (stateStr === 'generating_outline') phase = 'generating_outline';
    else if (stateStr === 'outline_ready') phase = 'outline_ready';
    else if (stateStr === 'awaiting_template') phase = 'awaiting_template';
    else if (stateStr === 'template_ready') phase = 'template_ready';
    else if (stateStr === 'generating_slides') phase = 'generating_slides';
    else if (stateStr === 'assembling') phase = 'assembling';
    else if (stateStr === 'failed') phase = 'error';

    // Parse slidesJson & templateJson if available
    let generatedSlides: GeneratedSlide[] = [];
    let templateSlides: TemplateSlide[] = [];
    let slideImages: SlideImage[] = [];

    if (detail.slidesJson) {
      try {
        const parsed = JSONBigString.parse(detail.slidesJson);
        if (Array.isArray(parsed)) {
          generatedSlides = parsed.map((item: Record<string, unknown>) => ({
            previewImageUrl: (item.previewImageUrl as string) || '',
            isNew: false,
          }));
        }
      } catch { /* ignore */ }
    }

    if (detail.templateJson) {
      try {
        const parsed = JSONBigString.parse(detail.templateJson);
        if (parsed.slides) templateSlides = parsed.slides;
        if (parsed.slideImages) slideImages = parsed.slideImages;
      } catch { /* ignore */ }
    }

    sessionIdRef.current = detail.id;
    setPptState({
      phase,
      sessionId: detail.id,
      statusMessage: '',
      aiMessage: '',
      intentDetected: null,
      intentTopic: detail.topic,
      outlineMarkdown: detail.outlineMarkdown || '',
      outlineJson: detail.outlineJson || '',
      projectId: detail.projectId || null,
      templateUrl: detail.templateUrl || '',
      slideImages,
      templateSlides,
      generatedSlides,
      currentSlide: generatedSlides.length,
      totalSlides: generatedSlides.length,
      selectedSlideIndex: 0,
      resultUrl: detail.resultUrl || '',
      resultFileName: detail.resultUrl ? `${detail.topic}.pptx` : '',
      errorMessage: '',
      agentTasks: [],
      agentTaskSummary: null,
      evaluationResult: null,
      repairProgress: null,
    });

  }, [loadSessionDetail, reconstructMessages]);

  // ---- SSE helper ----
  const sendAction = useCallback(
    async (
      action: string,
      extra: Record<string, unknown> = {},
      onEvent?: (eventName: string, data: string) => void
    ) => {
      abortControllerRef.current?.abort();
      const controller = new AbortController();
      abortControllerRef.current = controller;

      const token = getToken();
      const body: Record<string, unknown> = { action, ...extra };

      // Read sessionId from ref (synchronous, avoids React batching issues)
      if (sessionIdRef.current) {
        body.sessionId = sessionIdRef.current;
      }

      try {
        const response = await fetch(`${API_BASE}/api/ppt/generation/stream`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Accept: 'text/event-stream',
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
        let currentEventType = 'message';
        let dataLines: string[] = [];

        const dispatchEvent = () => {
          if (dataLines.length === 0) return;
          const data = dataLines.join('\n');
          dataLines = [];
          const evtType = currentEventType;
          currentEventType = 'message';
          if (evtType === 'done') {
            if (onEvent) onEvent('done', data);
            return;
          }
          if (data === '[DONE]') return;
          if (onEvent) onEvent(evtType, data);
        };

        while (true) {
          const { done, value } = await reader.read();
          if (done) break;

          buffer += decoder.decode(value, { stream: true });
          const lines = buffer.split('\n');
          buffer = lines.pop() || '';

          for (const line of lines) {
            const stripped = line.endsWith('\r') ? line.slice(0, -1) : line;

            // 空行 = SSE 事件分隔符，派发已缓冲的事件
            if (stripped === '') {
              dispatchEvent();
              continue;
            }

            const colonIdx = stripped.indexOf(':');
            if (colonIdx === 0) continue; // SSE 注释行

            let field: string;
            let val: string;
            if (colonIdx > 0) {
              field = stripped.substring(0, colonIdx);
              val = stripped.substring(colonIdx + 1);
              if (val.startsWith(' ')) val = val.substring(1);
            } else {
              field = stripped;
              val = '';
            }

            if (field === 'event') {
              currentEventType = val.trim();
            } else if (field === 'data') {
              dataLines.push(val);
            }
          }
        }
        // 流结束时派发剩余缓冲
        dispatchEvent();
      } catch (err: unknown) {
        if (err instanceof DOMException && err.name === 'AbortError') return;
        const msg = err instanceof Error ? err.message : '未知错误';
        updatePpt({ phase: 'error', errorMessage: msg });
        appendMessage({ type: 'error', content: msg });
      }
    },
    [updatePpt, appendMessage]
  );

  // ==================== Chat Actions ====================

  /** 发送用户消息（自动意图识别 → 生成大纲） */
  const sendMessage = useCallback((content: string, projectId?: string | null) => {
    // Append user message
    appendMessage({ type: 'user', content });

    // Start intent detection + outline generation
    updatePpt({ phase: 'detecting', aiMessage: '', intentDetected: null, errorMessage: '', ...(projectId ? { projectId } : {}) });

    const streamMsgId = appendMessage({ type: 'ai-text', content: '', isStreaming: true });
    streamingMsgIdRef.current = streamMsgId;

    const extra: Record<string, unknown> = { message: content };
    if (projectId) extra.projectId = projectId;

    sendAction('detect_intent', extra, (evt, data) => {
      if (evt === 'message') {
        setMessages(prev => prev.map(m =>
          m.id === streamMsgId ? { ...m, content: m.content + data } : m
        ));
      } else if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({ statusMessage: payload.message || '' });
        } catch { /* ignore */ }
      } else if (evt === 'intent') {
        try {
          const payload = JSONBigString.parse(data);

          // Finish streaming message & strip <<PPT_INTENT:...>> tag from displayed text
          setMessages(prev => prev.map(m =>
            m.id === streamMsgId
              ? { ...m, isStreaming: false, content: m.content.replace(/<<PPT_INTENT:.*?>>\s*/g, '').trim() }
              : m
          ));

          if (payload.detected) {
            const sessionId = payload.sessionId ? String(payload.sessionId) : null;
            const topic = payload.topic || content;

            updatePpt({
              phase: 'awaiting_template',
              intentDetected: true,
              intentTopic: topic,
              ...(sessionId ? { sessionId } : {}),
            });
            if (sessionId) {
              sessionIdRef.current = sessionId;
              setCurrentSessionId(sessionId);
            }

            // 新流程：意图识别后先选模板
            appendMessage({ type: 'status', content: '已识别 PPT 主题，请选择模板。' });
          } else {
            updatePpt({ phase: 'idle', intentDetected: false });
          }
        } catch { /* ignore */ }
      } else if (evt === 'error') {
        updatePpt({ phase: 'error', errorMessage: data });
        setMessages(prev => prev.map(m =>
          m.id === streamMsgId ? { ...m, isStreaming: false } : m
        ));
        appendMessage({ type: 'error', content: data });
      }
    });
  }, [appendMessage, sendAction, updatePpt]);

  /** Internal: generate outline (called after intent detected) */
  const generateOutlineInternal = useCallback((topic: string, requirements?: string) => {
    updatePpt({ phase: 'generating_outline', outlineMarkdown: '', aiMessage: '', errorMessage: '' });

    const streamMsgId = appendMessage({ type: 'ai-text', content: '', isStreaming: true });
    streamingMsgIdRef.current = streamMsgId;

    const extra: Record<string, unknown> = { topic };
    if (requirements) extra.requirements = requirements;

    sendAction('agent_generate_outline', extra, (evt, data) => {
      if (evt === 'message') {
        setMessages(prev => prev.map(m =>
          m.id === streamMsgId ? { ...m, content: m.content + data } : m
        ));
        setPptState(prev => ({ ...prev, aiMessage: prev.aiMessage + data }));
      } else if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({ statusMessage: payload.message || '', phase: payload.phase || 'generating_outline' });
        } catch { /* ignore */ }
      } else if (evt === 'agent_todo') {
        try {
          const payload = JSONBigString.parse(data);
          const eventType = payload.type as string;
          if (eventType === 'full_list' && Array.isArray(payload.tasks)) {
            updatePpt({
              agentTasks: payload.tasks as AgentTask[],
              agentTaskSummary: payload.summary as AgentTaskSummary || null,
            });
          } else if (eventType === 'task_added' || eventType === 'task_status_changed' || eventType === 'task_updated') {
            const updatedTask = payload.task as AgentTask;
            if (updatedTask) {
              setPptState(prev => {
                const tasks = [...prev.agentTasks];
                const idx = tasks.findIndex(t => t.id === updatedTask.id);
                if (idx >= 0) tasks[idx] = updatedTask;
                else tasks.push(updatedTask);
                return { ...prev, agentTasks: tasks, agentTaskSummary: payload.summary as AgentTaskSummary || prev.agentTaskSummary };
              });
            }
          }
        } catch { /* ignore */ }
      } else if (evt === 'outline') {
        try {
          const payload = JSONBigString.parse(data);
          const markdown = payload.outline || payload.markdown || data;
          const outlineJson = payload.outlineJson || '';
          const sessionId = payload.sessionId ? String(payload.sessionId) : undefined;

          updatePpt({
            outlineMarkdown: markdown,
            outlineJson: outlineJson,
            phase: 'outline_ready',
            ...(sessionId ? { sessionId } : {}),
          });
          if (sessionId) setCurrentSessionId(sessionId);

          // Finish streaming: replace streamed text with short summary, then add outline card
          setMessages(prev => prev.map(m =>
            m.id === streamMsgId ? { ...m, isStreaming: false, content: '大纲已生成，请查看下方内容。' } : m
          ));
          appendMessage({
            type: 'outline-card',
            content: '',
            outlineMarkdown: markdown,
          });
        } catch {
          updatePpt({ outlineMarkdown: data, phase: 'outline_ready' });
        }
      } else if (evt === 'error') {
        updatePpt({ phase: 'error', errorMessage: data });
        setMessages(prev => prev.map(m =>
          m.id === streamMsgId ? { ...m, isStreaming: false } : m
        ));
        appendMessage({ type: 'error', content: data });
      }
    });
  }, [appendMessage, sendAction, updatePpt]);

  /** Revise outline with user feedback */
  const reviseOutline = useCallback((feedback: string) => {
    appendMessage({ type: 'user', content: feedback });
    updatePpt({ phase: 'generating_outline', aiMessage: '', errorMessage: '' });

    const streamMsgId = appendMessage({ type: 'ai-text', content: '', isStreaming: true });

    sendAction('revise_outline', { feedback }, (evt, data) => {
      if (evt === 'message') {
        setMessages(prev => prev.map(m =>
          m.id === streamMsgId ? { ...m, content: m.content + data } : m
        ));
      } else if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({ statusMessage: payload.message || '', phase: payload.phase || 'generating_outline' });
        } catch { /* ignore */ }
      } else if (evt === 'outline') {
        try {
          const payload = JSONBigString.parse(data);
          const markdown = payload.outline || payload.markdown || data;
          updatePpt({ outlineMarkdown: markdown, phase: 'outline_ready' });

          setMessages(prev => prev.map(m =>
            m.id === streamMsgId ? { ...m, isStreaming: false, content: '大纲已修改，请查看下方内容。' } : m
          ));
          appendMessage({
            type: 'outline-card',
            content: '',
            outlineMarkdown: markdown,
          });
        } catch {
          updatePpt({ outlineMarkdown: data, phase: 'outline_ready' });
        }
      } else if (evt === 'error') {
        updatePpt({ phase: 'error', errorMessage: data });
        setMessages(prev => prev.map(m =>
          m.id === streamMsgId ? { ...m, isStreaming: false } : m
        ));
        appendMessage({ type: 'error', content: data });
      }
    });
  }, [appendMessage, sendAction, updatePpt]);

  /** Save edited outline JSON to backend */
  const updateOutline = useCallback((outlineJson: string) => {
    updatePpt({ outlineJson });
    sendAction('update_outline', { outlineJson }, (evt, data) => {
      if (evt === 'outline_updated') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({ outlineJson: payload.outlineJson || outlineJson });
        } catch { /* ignore */ }
      } else if (evt === 'error') {
        appendMessage({ type: 'error', content: data });
      }
    });
  }, [sendAction, updatePpt, appendMessage]);

  /** Confirm outline → trigger slides generation (template already selected) */
  const confirmOutline = useCallback(() => {
    // Mark outline card as done
    setMessages(prev => prev.map(m =>
      m.type === 'outline-card' && !m.actionDone ? { ...m, actionDone: true } : m
    ));
    updatePpt({ errorMessage: '' });
    appendMessage({ type: 'status', content: '大纲已确认，开始生成幻灯片...' });

    sendAction('confirm_outline', {}, (evt, data) => {
      if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({ statusMessage: payload.message || '' });
        } catch { /* ignore */ }
      } else if (evt === 'outline_confirmed') {
        try {
          const payload = JSONBigString.parse(data);
          const sessionId = payload.sessionId ? String(payload.sessionId) : undefined;
          if (sessionId) {
            sessionIdRef.current = sessionId;
            setCurrentSessionId(sessionId);
          }
        } catch { /* ignore */ }
      } else if (evt === 'done') {
        // 新流程：确认大纲后自动开始生成 slides
        setTimeout(() => {
          generatePptInternal();
        }, 300);
      } else if (evt === 'error') {
        updatePpt({ phase: 'error', errorMessage: data });
        appendMessage({ type: 'error', content: data });
      }
    });
  }, [appendMessage, sendAction, updatePpt]);

  /** Select template */
  const selectTemplate = useCallback((templateId?: string, templateUrl?: string) => {
    updatePpt({ phase: 'parsing_template', statusMessage: '正在解析模板...', errorMessage: '' });
    appendMessage({ type: 'status', content: '正在解析模板...' });

    const extra: Record<string, unknown> = {};
    if (templateId) extra.templateId = templateId;
    if (templateUrl) extra.templateUrl = templateUrl;

    sendAction('select_template', extra, (evt, data) => {
      if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({ statusMessage: payload.message || '', phase: payload.phase || 'parsing_template' });
        } catch { /* ignore */ }
      } else if (evt === 'template_parsed') {
        try {
          const payload = JSONBigString.parse(data);
          const tplUrl = payload.templateUrl || '';
          updatePpt({
            phase: 'template_ready',
            templateUrl: tplUrl,
            templateSlides: payload.slides || [],
            slideImages: (payload.slideImages || []).map((img: { index: number; imageUrl: string }) => ({
              index: img.index,
              imageUrl: img.imageUrl,
            })),
            statusMessage: '模板就绪',
          });

          appendMessage({ type: 'status', content: '模板就绪，开始生成大纲...' });

          // 新流程：模板就绪后自动生成大纲（大纲 AI 会感知模板结构）
          setTimeout(() => {
            setPptState(prev => {
              generateOutlineInternal(prev.intentTopic || '');
              return prev;
            });
          }, 500);
        } catch { /* ignore */ }
      } else if (evt === 'error') {
        updatePpt({ phase: 'error', errorMessage: data });
        appendMessage({ type: 'error', content: data });
      }
    });
  }, [appendMessage, sendAction, updatePpt]);

  /** Skip template selection — use HTML mode */
  const skipTemplate = useCallback((styleHint?: string) => {
    updatePpt({ phase: 'parsing_template', statusMessage: '跳过模板，使用 HTML 模式...', errorMessage: '' });
    appendMessage({ type: 'status', content: styleHint
      ? `跳过模板选择，风格：${styleHint}`
      : '跳过模板选择，将使用 HTML 模式生成 PPT...' });

    const extra: Record<string, unknown> = {};
    if (styleHint) extra.styleHint = styleHint;

    sendAction('skip_template', extra, (evt, data) => {
      if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({ statusMessage: payload.message || '' });
        } catch { /* ignore */ }
      } else if (evt === 'template_skipped') {
        try {
          const payload = JSONBigString.parse(data);
          const sessionId = payload.sessionId ? String(payload.sessionId) : undefined;
          if (sessionId) {
            sessionIdRef.current = sessionId;
            setCurrentSessionId(sessionId);
          }
        } catch { /* ignore */ }
        updatePpt({
          phase: 'template_ready',
          templateUrl: '',
          templateSlides: [],
          slideImages: [],
          statusMessage: 'HTML 模式就绪',
        });
        appendMessage({ type: 'status', content: 'HTML 模式就绪，开始生成大纲...' });

        // 自动生成大纲
        setTimeout(() => {
          setPptState(prev => {
            generateOutlineInternal(prev.intentTopic || '');
            return prev;
          });
        }, 500);
      } else if (evt === 'done') {
        // done handled above in template_skipped
      } else if (evt === 'error') {
        updatePpt({ phase: 'error', errorMessage: data });
        appendMessage({ type: 'error', content: data });
      }
    });
  }, [appendMessage, sendAction, updatePpt]);

  /** Internal: generate PPT slides */
  const generatePptInternal = useCallback(() => {
    updatePpt({
      phase: 'generating_slides',
      generatedSlides: [],
      currentSlide: 0,
      totalSlides: 0,
      errorMessage: '',
      statusMessage: '正在生成幻灯片内容...',
    });

    const progressMsgId = appendMessage({
      type: 'progress-card',
      content: '',
      progress: { current: 0, total: 0 },
    });

    sendAction('agent_generate_ppt', {}, (evt, data) => {
      if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({ statusMessage: payload.message || '' });
          if (payload.phase === 'assembling') {
            updatePpt({ phase: 'assembling' });
          }
        } catch { /* ignore */ }
      } else if (evt === 'slide_placeholders') {
        // 后端推送所有幻灯片占位符（并行生成开始前）
        try {
          const payload = JSONBigString.parse(data);
          const total = payload.total as number || 0;
          const slidesData = payload.slides as { index: number; status: string; statusLabel: string }[];
          const placeholders: GeneratedSlide[] = (slidesData || []).map(() => ({
            previewImageUrl: '',
            isNew: false,
            status: 'pending' as const,
            statusLabel: '等待生成',
          }));
          setPptState(prev => ({
            ...prev,
            generatedSlides: placeholders,
            totalSlides: total,
            currentSlide: 0,
          }));
          updateMessage(progressMsgId, { progress: { current: 0, total } });
        } catch { /* ignore */ }
      } else if (evt === 'slide_status') {
        // 后端推送单页状态变化（generating/designing/rendering/done/evaluating/repairing/failed）
        try {
          const payload = JSONBigString.parse(data);
          const idx = payload.index as number;
          const status = payload.status as string;
          const statusLabel = payload.statusLabel as string;
          setPptState(prev => {
            const slides = [...prev.generatedSlides];
            if (idx >= 0 && idx < slides.length) {
              slides[idx] = { ...slides[idx], status: status as GeneratedSlide['status'], statusLabel };
            }
            return { ...prev, generatedSlides: slides };
          });
        } catch { /* ignore */ }
      } else if (evt === 'slide_progress') {
        // 后端推送单页预览图就绪（更新已有占位符而非追加）
        try {
          const payload = JSONBigString.parse(data);
          const slideIndex = (payload.current as number || 1) - 1; // current is 1-based
          const previewUrl = payload.previewImageUrl as string || '';

          setPptState(prev => {
            const slides = [...prev.generatedSlides];
            if (slideIndex >= 0 && slideIndex < slides.length) {
              // 更新已有占位符
              slides[slideIndex] = {
                ...slides[slideIndex],
                previewImageUrl: previewUrl,
                isNew: true,
                status: 'done',
                statusLabel: '完成',
              };
            } else {
              // 兜底：追加新幻灯片（无占位符时）
              slides.push({
                previewImageUrl: previewUrl,
                isNew: true,
                status: 'done',
                statusLabel: '完成',
              });
            }
            const doneCount = slides.filter(s => s.previewImageUrl).length;
            return {
              ...prev,
              generatedSlides: slides,
              currentSlide: doneCount,
              totalSlides: payload.total || prev.totalSlides,
            };
          });

          // Update progress message
          updateMessage(progressMsgId, {
            progress: {
              current: payload.current || 0,
              total: payload.total || 0,
            },
          });

          // Clear isNew animation flag
          setTimeout(() => {
            setPptState(prev => ({
              ...prev,
              generatedSlides: prev.generatedSlides.map((s, i) =>
                i === slideIndex ? { ...s, isNew: false } : s
              ),
            }));
          }, 600);
        } catch { /* ignore */ }
      } else if (evt === 'agent_todo') {
        try {
          const payload = JSONBigString.parse(data);
          const eventType = payload.type as string;

          if (eventType === 'full_list' && Array.isArray(payload.tasks)) {
            updatePpt({
              agentTasks: payload.tasks as AgentTask[],
              agentTaskSummary: payload.summary as AgentTaskSummary || null,
            });
          } else if (eventType === 'task_added' || eventType === 'task_status_changed' || eventType === 'task_updated') {
            const updatedTask = payload.task as AgentTask;
            if (updatedTask) {
              setPptState(prev => {
                const tasks = [...prev.agentTasks];
                const idx = tasks.findIndex(t => t.id === updatedTask.id);
                if (idx >= 0) {
                  tasks[idx] = updatedTask;
                } else {
                  tasks.push(updatedTask);
                }
                return {
                  ...prev,
                  agentTasks: tasks,
                  agentTaskSummary: payload.summary as AgentTaskSummary || prev.agentTaskSummary,
                };
              });
            }
          }
        } catch { /* ignore */ }
      } else if (evt === 'evaluation_result') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({
            evaluationResult: {
              overallScore: payload.overallScore || 0,
              contentScore: payload.contentScore || 0,
              designScore: payload.designScore || 0,
              coherenceScore: payload.coherenceScore || 0,
              strengths: payload.strengths || [],
              weaknesses: payload.weaknesses || [],
              suggestions: payload.suggestions || [],
              slideFeedbacks: payload.slideFeedbacks || [],
              repairRounds: payload.repairRounds || 0,
            },
          });
        } catch { /* ignore */ }
      } else if (evt === 'repair_progress') {
        try {
          const payload = JSONBigString.parse(data);
          updatePpt({
            repairProgress: {
              phase: payload.phase || 'evaluating',
              round: payload.round || 0,
              slideIndex: payload.slideIndex,
              message: payload.message || '',
            },
          });
        } catch { /* ignore */ }
      } else if (evt === 'result') {
        try {
          const payload = JSONBigString.parse(data);
          const url = payload.fileUrl || payload.file_url || '';
          const name = payload.fileName || payload.file_name || '';

          // Finalize all slides to 'done' and update progress to 100%
          setPptState(prev => {
            const finalSlides = prev.generatedSlides.map(s => ({
              ...s,
              status: 'done' as const,
              statusLabel: '完成',
              isNew: false,
            }));
            const total = prev.totalSlides || finalSlides.length;
            return {
              ...prev,
              phase: 'completed',
              resultUrl: url,
              resultFileName: name,
              statusMessage: 'PPT 生成完毕！',
              generatedSlides: finalSlides,
              currentSlide: total,
              totalSlides: total,
            };
          });

          // Update progress card to 100%
          updateMessage(progressMsgId, {
            progress: { current: payload.slideCount || 0, total: payload.slideCount || 0 },
          });

          appendMessage({
            type: 'download-card',
            content: '',
            downloadUrl: url,
            downloadFileName: name,
          });
          loadSessions();
        } catch { /* ignore */ }
      } else if (evt === 'done') {
        setPptState(prev => {
          if (prev.resultUrl) {
            // Also finalize any remaining slides
            const finalSlides = prev.generatedSlides.map(s =>
              s.status !== 'done' ? { ...s, status: 'done' as const, statusLabel: '完成' } : s
            );
            return {
              ...prev,
              phase: 'completed',
              statusMessage: 'PPT 生成完毕！',
              generatedSlides: finalSlides,
              currentSlide: prev.totalSlides,
            };
          }
          return prev;
        });
      } else if (evt === 'error') {
        updatePpt({ phase: 'error', errorMessage: data });
        appendMessage({ type: 'error', content: data });
      }
    });
  }, [appendMessage, updateMessage, sendAction, updatePpt, loadSessions]);

  const setSelectedSlide = useCallback((index: number) => {
    updatePpt({ selectedSlideIndex: index });
  }, [updatePpt]);

  /** Start a new session (clear state) */
  const startNewSession = useCallback(() => {
    abortControllerRef.current?.abort();
    sessionIdRef.current = null;
    setCurrentSessionId(null);
    setMessages([]);
    setPptState({
      phase: 'idle',
      sessionId: null,
      statusMessage: '',
      aiMessage: '',
      intentDetected: null,
      intentTopic: '',
      outlineMarkdown: '',
      outlineJson: '',
      projectId: null,
      templateUrl: '',
      slideImages: [],
      templateSlides: [],
      generatedSlides: [],
      currentSlide: 0,
      totalSlides: 0,
      selectedSlideIndex: 0,
      resultUrl: '',
      resultFileName: '',
      errorMessage: '',
      agentTasks: [],
      agentTaskSummary: null,
      evaluationResult: null,
      repairProgress: null,
    });
  }, []);

  const abort = useCallback(() => {
    abortControllerRef.current?.abort();
    updatePpt({ phase: 'idle', statusMessage: '' });
  }, [updatePpt]);

  // ---- Derived state ----
  const showPreview = ['generating_slides', 'assembling', 'completed'].includes(pptState.phase);
  const showTemplateSelector = pptState.phase === 'awaiting_template';
  const isGenerating = ['detecting', 'generating_outline', 'parsing_template', 'generating_slides', 'assembling'].includes(pptState.phase);

  return {
    // Session management
    sessions,
    isLoadingSessions,
    currentSessionId,
    loadSessions,
    openSession,
    deleteSession,
    startNewSession,

    // Chat messages
    messages,

    // PPT state
    pptState,
    showPreview,
    showTemplateSelector,
    isGenerating,

    // Actions
    sendMessage,
    reviseOutline,
    confirmOutline,
    updateOutline,
    selectTemplate,
    skipTemplate,
    setSelectedSlide,
    abort,
  };
}
