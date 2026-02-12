import { useState, useRef, useCallback } from 'react';
import JSONBig from 'json-bigint';
import { getToken } from '../api';

const JSONBigString = JSONBig({ storeAsString: true });

// ==================== Types ====================

export type PptPhase =
  | 'idle'
  | 'detecting'
  | 'generating_outline'
  | 'outline_ready'
  | 'awaiting_template'
  | 'parsing_template'
  | 'template_ready'
  | 'generating_slides'
  | 'assembling'
  | 'completed'
  | 'error';

export interface SlideImage {
  index: number;
  imageUrl: string;
}

export interface TemplateSlide {
  index: number;
  role: string;
  text_slots: { shape_id: number; role: string }[];
  image_slots: { shape_id: number }[];
}

export interface GeneratedSlide {
  previewImageUrl: string;
  isNew: boolean;
}

export interface PptGenerationState {
  phase: PptPhase;
  sessionId: string | null;
  statusMessage: string;
  aiMessage: string;
  intentDetected: boolean | null;
  intentTopic: string;
  outlineMarkdown: string;
  templateUrl: string;
  slideImages: SlideImage[];
  templateSlides: TemplateSlide[];
  generatedSlides: GeneratedSlide[];
  currentSlide: number;
  totalSlides: number;
  selectedSlideIndex: number;
  resultUrl: string;
  resultFileName: string;
  errorMessage: string;
}

const initialState: PptGenerationState = {
  phase: 'idle',
  sessionId: null,
  statusMessage: '',
  aiMessage: '',
  intentDetected: null,
  intentTopic: '',
  outlineMarkdown: '',
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
};

const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';

// ==================== Hook ====================

export function usePptGeneration() {
  const [state, setState] = useState<PptGenerationState>(initialState);
  const abortControllerRef = useRef<AbortController | null>(null);

  const update = useCallback((patch: Partial<PptGenerationState>) => {
    setState(prev => ({ ...prev, ...patch }));
  }, []);

  // ---- SSE 通用方法 ----
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

      // 读取最新的 sessionId
      setState(prev => {
        if (prev.sessionId) body.sessionId = prev.sessionId;
        return prev;
      });

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

        while (true) {
          const { done, value } = await reader.read();
          if (done) break;

          buffer += decoder.decode(value, { stream: true });
          const lines = buffer.split('\n');
          buffer = lines.pop() || '';

          for (const line of lines) {
            if (line.startsWith('event:')) {
              currentEventType = line.slice(6).trim();
              continue;
            }
            if (line.startsWith('data:')) {
              const data = line.slice(5).trim();
              if (currentEventType === 'done') {
                if (onEvent) onEvent('done', data);
                currentEventType = 'message';
                continue;
              }
              if (data === '[DONE]' || !data) continue;
              if (onEvent) onEvent(currentEventType, data);
            }
          }
        }
      } catch (err: unknown) {
        if (err instanceof DOMException && err.name === 'AbortError') return;
        const msg = err instanceof Error ? err.message : '未知错误';
        update({ phase: 'error', errorMessage: msg });
      }
    },
    [update]
  );

  // ---- 步骤方法 ----

  const detectIntent = useCallback(
    (message: string) => {
      update({ phase: 'detecting', aiMessage: '', intentDetected: null, errorMessage: '' });
      sendAction('detect_intent', { message }, (evt, data) => {
        if (evt === 'message') {
          setState(prev => ({ ...prev, aiMessage: prev.aiMessage + data }));
        } else if (evt === 'intent') {
          try {
            const payload = JSONBigString.parse(data);
            update({
              intentDetected: payload.detected,
              intentTopic: payload.topic || '',
              ...(payload.sessionId ? { sessionId: String(payload.sessionId) } : {}),
            });
            if (payload.detected) {
              update({ phase: 'awaiting_template' });
            } else {
              update({ phase: 'idle' });
            }
          } catch { /* ignore */ }
        } else if (evt === 'error') {
          update({ phase: 'error', errorMessage: data });
        }
      });
    },
    [sendAction, update]
  );

  const generateOutline = useCallback(
    (topic: string, requirements?: string) => {
      update({ phase: 'generating_outline', outlineMarkdown: '', aiMessage: '', errorMessage: '' });
      const extra: Record<string, unknown> = { topic };
      if (requirements) extra.requirements = requirements;
      sendAction('generate_outline', extra, (evt, data) => {
        if (evt === 'message') {
          setState(prev => ({ ...prev, aiMessage: prev.aiMessage + data }));
        } else if (evt === 'outline') {
          try {
            const payload = JSONBigString.parse(data);
            update({
              outlineMarkdown: payload.outline || payload.markdown || data,
              phase: 'outline_ready',
              ...(payload.sessionId ? { sessionId: String(payload.sessionId) } : {}),
            });
          } catch {
            update({ outlineMarkdown: data, phase: 'outline_ready' });
          }
        } else if (evt === 'error') {
          update({ phase: 'error', errorMessage: data });
        }
      });
    },
    [sendAction, update]
  );

  const reviseOutline = useCallback(
    (feedback: string) => {
      update({ phase: 'generating_outline', aiMessage: '', errorMessage: '' });
      sendAction('revise_outline', { feedback }, (evt, data) => {
        if (evt === 'message') {
          setState(prev => ({ ...prev, aiMessage: prev.aiMessage + data }));
        } else if (evt === 'outline') {
          try {
            const payload = JSONBigString.parse(data);
            update({
              outlineMarkdown: payload.outline || payload.markdown || data,
              phase: 'outline_ready',
            });
          } catch {
            update({ outlineMarkdown: data, phase: 'outline_ready' });
          }
        } else if (evt === 'error') {
          update({ phase: 'error', errorMessage: data });
        }
      });
    },
    [sendAction, update]
  );

  const confirmOutline = useCallback(() => {
    update({ errorMessage: '' });
    sendAction('confirm_outline', {}, (evt, data) => {
      if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          update({ statusMessage: payload.message || '' });
        } catch { /* ignore */ }
      } else if (evt === 'error') {
        update({ phase: 'error', errorMessage: data });
      }
    });
  }, [sendAction, update]);

  const selectTemplate = useCallback(
    (templateId?: string, templateUrl?: string) => {
      update({ phase: 'parsing_template', statusMessage: '正在解析模板...', errorMessage: '' });
      const extra: Record<string, unknown> = {};
      if (templateId) extra.templateId = templateId;
      if (templateUrl) extra.templateUrl = templateUrl;

      sendAction('select_template', extra, (evt, data) => {
        if (evt === 'status') {
          try {
            const payload = JSONBigString.parse(data);
            update({ statusMessage: payload.message || '', phase: payload.phase || 'parsing_template' });
          } catch { /* ignore */ }
        } else if (evt === 'template_parsed') {
          try {
            const payload = JSONBigString.parse(data);
            const tplUrl = payload.templateUrl || '';
            update({
              phase: 'template_ready',
              templateUrl: tplUrl,
              templateSlides: payload.slides || [],
              slideImages: (payload.slideImages || []).map((img: { index: number; imageUrl: string }) => ({
                index: img.index,
                imageUrl: img.imageUrl,
              })),
              statusMessage: '模板就绪',
            });

          } catch { /* ignore */ }
        } else if (evt === 'error') {
          update({ phase: 'error', errorMessage: data });
        }
      });
    },
    [sendAction, update]
  );

  const generatePpt = useCallback(() => {
    update({
      phase: 'generating_slides',
      generatedSlides: [],
      currentSlide: 0,
      totalSlides: 0,
      errorMessage: '',
      statusMessage: '正在生成幻灯片内容...',
    });

    sendAction('generate_ppt', {}, (evt, data) => {
      if (evt === 'status') {
        try {
          const payload = JSONBigString.parse(data);
          update({ statusMessage: payload.message || '' });
          if (payload.phase === 'assembling') {
            update({ phase: 'assembling' });
          }
        } catch { /* ignore */ }
      } else if (evt === 'slide_progress') {
        try {
          const payload = JSONBigString.parse(data);
          const newSlide: GeneratedSlide = {
            previewImageUrl: payload.previewImageUrl || '',
            isNew: true,
          };

          setState(prev => {
            const slides = [...prev.generatedSlides, newSlide];
            return {
              ...prev,
              generatedSlides: slides,
              currentSlide: payload.current || slides.length,
              totalSlides: payload.total || prev.totalSlides,
              selectedSlideIndex: slides.length - 1,
            };
          });

          // 清除 isNew 标记（动画后）
          setTimeout(() => {
            setState(prev => ({
              ...prev,
              generatedSlides: prev.generatedSlides.map((s, i) =>
                i === prev.generatedSlides.length - 1 ? { ...s, isNew: false } : s
              ),
            }));
          }, 600);
        } catch { /* ignore */ }
      } else if (evt === 'result') {
        try {
          const payload = JSONBigString.parse(data);
          update({
            phase: 'completed',
            resultUrl: payload.fileUrl || payload.file_url || '',
            resultFileName: payload.fileName || payload.file_name || '',
            statusMessage: 'PPT 生成完毕！',
          });
        } catch { /* ignore */ }
      } else if (evt === 'done') {
        setState(prev => {
          if (prev.resultUrl) {
            return { ...prev, phase: 'completed', statusMessage: 'PPT 生成完毕！' };
          }
          return prev;
        });
      } else if (evt === 'error') {
        update({ phase: 'error', errorMessage: data });
      }
    });
  }, [sendAction, update]);

  const setSelectedSlide = useCallback((index: number) => {
    update({ selectedSlideIndex: index });
  }, [update]);

  const abort = useCallback(() => {
    abortControllerRef.current?.abort();
    update({ phase: 'idle', statusMessage: '' });
  }, [update]);

  const reset = useCallback(() => {
    abortControllerRef.current?.abort();
    setState(initialState);
  }, []);

  return {
    ...state,
    detectIntent,
    generateOutline,
    reviseOutline,
    confirmOutline,
    selectTemplate,
    generatePpt,
    setSelectedSlide,
    abort,
    reset,
  };
}
