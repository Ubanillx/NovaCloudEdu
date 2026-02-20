import React, { useState, useRef, useEffect } from 'react';
import { Send, Square } from 'lucide-react';
import VoiceInputButton from '../chat/VoiceInputButton';

const QUICK_PROMPTS = [
  '帮我做一个关于人工智能的PPT',
  '生成一份项目汇报演示文稿',
  '制作一个教学课件',
  '做一份产品介绍PPT',
];

interface PptChatInputProps {
  onSend: (content: string) => void;
  isGenerating: boolean;
  onAbort?: () => void;
  disabled?: boolean;
  showQuickPrompts?: boolean;
}

const PptChatInput: React.FC<PptChatInputProps> = ({
  onSend,
  isGenerating,
  onAbort,
  disabled,
  showQuickPrompts,
}) => {
  const [input, setInput] = useState('');
  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const voiceBaseInputRef = useRef('');

  useEffect(() => {
    const el = textareaRef.current;
    if (el) {
      el.style.height = 'auto';
      el.style.height = Math.min(el.scrollHeight, 160) + 'px';
    }
  }, [input]);

  const handleSend = () => {
    const content = input.trim();
    if (!content || isGenerating || disabled) return;
    setInput('');
    if (textareaRef.current) textareaRef.current.style.height = 'auto';
    onSend(content);
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === 'Enter' && !e.shiftKey && !e.nativeEvent.isComposing) {
      e.preventDefault();
      handleSend();
    }
  };

  const handleQuickPrompt = (text: string) => {
    setInput('');
    onSend(text);
  };

  return (
    <div className="border-t border-gray-200/60 dark:border-gray-700/40 bg-white/80 dark:bg-gray-900/80 backdrop-blur-sm">
      {/* 快捷提示 */}
      {showQuickPrompts && (
        <div className="px-4 pt-3 flex flex-wrap gap-2">
          {QUICK_PROMPTS.map(text => (
            <button
              key={text}
              onClick={() => handleQuickPrompt(text)}
              className="px-3 py-1.5 text-xs text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/40 rounded-lg border border-brand-100 dark:border-brand-800 transition-colors"
            >
              {text}
            </button>
          ))}
        </div>
      )}

      <div className="p-3 flex items-end gap-2">
        <VoiceInputButton
          onTextChange={(text) => setInput(voiceBaseInputRef.current + text)}
          onRecordingStart={() => { voiceBaseInputRef.current = input; }}
          disabled={isGenerating || disabled}
        />
        <div className="flex-1 relative">
          <textarea
            ref={textareaRef}
            value={input}
            onChange={e => setInput(e.target.value)}
            onKeyDown={handleKeyDown}
            placeholder="输入 PPT 主题或需求，Shift+Enter 换行..."
            rows={1}
            disabled={isGenerating || disabled}
            className="w-full px-4 py-2.5 text-sm bg-gray-50 dark:bg-gray-800/80 border border-gray-200 dark:border-gray-700 rounded-xl outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 resize-none transition-all disabled:opacity-50 text-gray-800 dark:text-gray-200 placeholder-gray-400"
            style={{ maxHeight: 160, minHeight: 40 }}
          />
        </div>

        <div className="pb-0.5">
          {isGenerating ? (
            <button
              onClick={onAbort}
              className="p-2.5 rounded-xl bg-red-500 hover:bg-red-600 text-white transition-colors shadow-sm"
              title="停止生成"
            >
              <Square size={16} fill="currentColor" />
            </button>
          ) : (
            <button
              onClick={handleSend}
              disabled={!input.trim() || disabled}
              className="p-2.5 rounded-xl bg-brand-500 hover:bg-brand-600 disabled:opacity-40 disabled:cursor-not-allowed text-white transition-colors shadow-sm"
              title="发送"
            >
              <Send size={16} />
            </button>
          )}
        </div>
      </div>

      <p className="px-4 pb-2 text-[11px] text-gray-400 text-center">
        AI 生成内容仅供参考，请核实重要信息
      </p>
    </div>
  );
};

export default PptChatInput;
