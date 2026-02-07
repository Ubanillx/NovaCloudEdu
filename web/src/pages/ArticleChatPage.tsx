import React, { useState, useRef, useEffect, useCallback } from 'react';
import Markdown from 'react-markdown';
import { Send, Square, Trash2, Bot, User, Info } from 'lucide-react';
import { getToken } from '../api';

interface ChatMessage {
  role: 'user' | 'assistant';
  content: string;
  isStreaming?: boolean;
}

interface ArticleChatPanelProps {
  articleId: string;
  articleTitle: string;
  open: boolean;
}

export const ArticleChatPanel: React.FC<ArticleChatPanelProps> = ({
  articleId,
  articleTitle,
  open,
}) => {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [streamingContent, setStreamingContent] = useState('');

  const messagesEndRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLTextAreaElement>(null);
  const abortControllerRef = useRef<AbortController | null>(null);
  const initializedRef = useRef(false);

  // 初始欢迎消息（仅首次打开时设置）
  useEffect(() => {
    if (open && !initializedRef.current) {
      initializedRef.current = true;
      setMessages([
        {
          role: 'assistant',
          content: `你好！我是AI助手，很高兴与你讨论《${articleTitle}》这篇文章。\n\n你可以问我关于文章内容的任何问题，比如：\n- 这篇文章的主要观点是什么？\n- 作者想表达什么思想？\n- 文章中有哪些值得深思的地方？`,
        },
      ]);
    }
  }, [open, articleTitle]);

  // 打开面板时聚焦输入框
  useEffect(() => {
    if (open) {
      setTimeout(() => inputRef.current?.focus(), 300);
    }
  }, [open]);

  const scrollToBottom = useCallback(() => {
    setTimeout(() => {
      messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
    }, 50);
  }, []);

  useEffect(() => {
    scrollToBottom();
  }, [messages, streamingContent, scrollToBottom]);

  // 关闭面板时取消流
  useEffect(() => {
    if (!open) {
      abortControllerRef.current?.abort();
    }
  }, [open]);

  const sendMessage = async () => {
    const content = input.trim();
    if (!content || isLoading || !articleId) return;

    setInput('');
    inputRef.current?.focus();

    const userMsg: ChatMessage = { role: 'user', content };
    setMessages((prev) => [...prev, userMsg]);
    setIsLoading(true);
    setStreamingContent('');

    // 构建历史（排除欢迎消息）
    const history = messages.length > 1
      ? messages.slice(1).map((m) => ({ role: m.role, content: m.content }))
      : [];

    const historyJson = history.length > 0 ? JSON.stringify(history) : undefined;

    const baseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
    const params = new URLSearchParams();
    params.set('message', content);
    if (historyJson) params.set('historyJson', historyJson);
    const sseUrl = `${baseUrl}/api/articles/${articleId}/chat/stream?${params.toString()}`;

    const controller = new AbortController();
    abortControllerRef.current = controller;

    let accumulated = '';

    try {
      const token = getToken();
      const response = await fetch(sseUrl, {
        method: 'GET',
        headers: {
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
          ...(token ? { 'Authorization': `Bearer ${token}` } : {}),
        },
        signal: controller.signal,
      });

      if (!response.ok || !response.body) {
        throw new Error(`HTTP ${response.status}`);
      }

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let buffer = '';

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const lines = buffer.split('\n');
        buffer = lines.pop() || '';

        for (const line of lines) {
          if (line.startsWith('data:')) {
            const data = line.slice(5).trim();
            if (data === '[DONE]' || !data) continue;

            try {
              const json = JSON.parse(data);
              const chunk = json.content || json.text || data;
              accumulated += chunk;
            } catch {
              accumulated += data;
            }
            setStreamingContent(accumulated);
          }
        }
      }
    } catch (err: unknown) {
      if (err instanceof DOMException && err.name === 'AbortError') {
        if (accumulated) accumulated += '\n\n[已取消]';
      } else {
        if (!accumulated) accumulated = '抱歉，请求失败，请稍后重试。';
      }
    } finally {
      if (accumulated) {
        setMessages((prev) => [...prev, { role: 'assistant', content: accumulated }]);
      }
      setStreamingContent('');
      setIsLoading(false);
      abortControllerRef.current = null;
    }
  };

  const cancelStream = () => {
    abortControllerRef.current?.abort();
  };

  const clearMessages = () => {
    setMessages([
      {
        role: 'assistant',
        content: `对话已清空。你可以继续提问关于《${articleTitle}》的问题。`,
      },
    ]);
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  };

  if (!open) return null;

  return (
    <div className="flex flex-col h-full bg-white dark:bg-gray-950 rounded-2xl border border-gray-200 dark:border-gray-800 shadow-sm overflow-hidden">
      {/* Header */}
      <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-200 dark:border-gray-800 flex-shrink-0">
        <div className="w-8 h-8 bg-gradient-to-br from-brand-500 to-accent-500 rounded-full flex items-center justify-center flex-shrink-0">
          <Bot size={16} className="text-white" />
        </div>
        <div className="flex-1 min-w-0">
          <h2 className="text-sm font-bold text-gray-900 dark:text-white">AI 深度讨论</h2>
        </div>
        <button
          onClick={clearMessages}
          className="p-1.5 text-gray-400 hover:text-error transition-colors"
          title="清空对话"
        >
          <Trash2 size={14} />
        </button>
      </div>

      {/* Tip */}
      <div className="flex items-center gap-2 px-4 py-1.5 bg-brand-50 dark:bg-brand-900/10 border-b border-brand-100 dark:border-brand-800/30 flex-shrink-0">
        <Info size={12} className="text-brand-500 flex-shrink-0" />
        <span className="text-[11px] text-gray-500 dark:text-gray-400">AI 已阅读全文，可针对细节提问</span>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto px-4 py-4 space-y-4 min-h-0">
        {messages.map((msg, index) => (
          <MessageBubble key={index} message={msg} />
        ))}
        {streamingContent && (
          <MessageBubble message={{ role: 'assistant', content: streamingContent, isStreaming: true }} />
        )}
        <div ref={messagesEndRef} />
      </div>

      {/* Input */}
      <div className="flex-shrink-0 px-4 py-3 border-t border-gray-200 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-900/50">
        <div className="flex items-end gap-2">
          <div className="flex-1">
            <textarea
              ref={inputRef}
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder="想对文章说点什么..."
              rows={1}
              className="w-full px-3 py-2 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 focus:border-brand-500 dark:focus:border-brand-500 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 outline-none resize-none transition-colors max-h-24"
              style={{ minHeight: '38px' }}
            />
          </div>
          {isLoading ? (
            <button
              onClick={cancelStream}
              className="w-9 h-9 flex items-center justify-center bg-red-50 dark:bg-red-900/20 text-red-500 border border-red-200 dark:border-red-800 rounded-xl hover:bg-red-100 dark:hover:bg-red-900/30 transition-colors flex-shrink-0"
              title="停止生成"
            >
              <Square size={14} />
            </button>
          ) : (
            <button
              onClick={sendMessage}
              disabled={!input.trim()}
              className="w-9 h-9 flex items-center justify-center bg-brand-600 hover:bg-brand-700 text-white rounded-xl shadow-md shadow-brand-600/20 disabled:opacity-50 disabled:cursor-not-allowed transition-all flex-shrink-0 active:scale-95"
            >
              <Send size={14} />
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

const MessageBubble: React.FC<{ message: ChatMessage }> = ({ message }) => {
  const isUser = message.role === 'user';

  return (
    <div className={`flex gap-2.5 ${isUser ? 'flex-row-reverse' : ''}`}>
      <div
        className={`w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 ${
          isUser
            ? 'bg-brand-100 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400'
            : 'bg-gradient-to-br from-brand-500 to-accent-500 text-white shadow-sm shadow-brand-500/20'
        }`}
      >
        {isUser ? <User size={16} /> : <Bot size={16} />}
      </div>

      <div
        className={`max-w-[85%] px-3.5 py-2.5 rounded-2xl shadow-sm ${
          isUser
            ? 'bg-brand-600 text-white rounded-tr-sm'
            : 'bg-white dark:bg-gray-900 text-gray-800 dark:text-gray-200 border border-gray-200 dark:border-gray-800 rounded-tl-sm'
        }`}
      >
        {isUser ? (
          <p className="text-sm leading-relaxed whitespace-pre-wrap">{message.content}</p>
        ) : (
          <div className="prose prose-sm prose-gray dark:prose-invert max-w-none [&_p]:my-1 [&_ul]:my-1 [&_ol]:my-1 [&_li]:my-0.5">
            <Markdown>{message.content}</Markdown>
            {message.isStreaming && (
              <div className="flex items-center gap-2 mt-2 pt-2 border-t border-gray-100 dark:border-gray-800">
                <div className="w-3 h-3 border-2 border-brand-500 border-t-transparent rounded-full animate-spin" />
                <span className="text-xs text-gray-400">AI 正在思考...</span>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default ArticleChatPanel;
