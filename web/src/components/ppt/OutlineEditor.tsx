import React, { useState } from 'react';
import { Edit3, Check } from 'lucide-react';

interface OutlineEditorProps {
  markdown: string;
  onConfirm: () => void;
  onRevise: (feedback: string) => void;
  isLoading: boolean;
  aiMessage: string;
}

export const OutlineEditor: React.FC<OutlineEditorProps> = ({
  markdown,
  onConfirm,
  onRevise,
  isLoading,
  aiMessage,
}) => {
  const [showRevise, setShowRevise] = useState(false);
  const [feedback, setFeedback] = useState('');

  const handleRevise = () => {
    if (!feedback.trim()) return;
    onRevise(feedback.trim());
    setFeedback('');
    setShowRevise(false);
  };

  if (isLoading) {
    return (
      <div className="animate-in fade-in duration-500">
        {/* AI 流式文字 */}
        {aiMessage && (
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-6 mb-4 transition-all duration-300">
            <div className="prose dark:prose-invert max-w-none text-sm whitespace-pre-wrap">
              {aiMessage}
              <span className="inline-block w-0.5 h-4 bg-brand-500 ml-0.5 animate-cursorBlink" />
            </div>
          </div>
        )}
        {/* 骨架屏 */}
        {!aiMessage && (
          <div className="space-y-3">
            {[1, 2, 3, 4, 5].map(i => (
              <div key={i} className="h-4 animate-shimmer rounded" style={{ width: `${90 - i * 10}%` }} />
            ))}
          </div>
        )}
      </div>
    );
  }

  return (
    <div className="animate-in fade-in duration-500 space-y-4">
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-6 transition-all duration-300">
        <h3 className="text-sm font-bold text-gray-400 uppercase tracking-wider mb-3">AI 生成的大纲</h3>
        <div className="prose dark:prose-invert max-w-none text-sm whitespace-pre-wrap leading-relaxed">
          {markdown}
        </div>
      </div>

      {showRevise ? (
        <div className="space-y-3">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">修改意见</label>
            <textarea
              value={feedback}
              onChange={e => setFeedback(e.target.value)}
              placeholder="请描述您希望修改的内容..."
              className="w-full h-24 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 resize-none focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              autoFocus
            />
          </div>
          <div className="flex gap-3">
            <button
              onClick={handleRevise}
              disabled={!feedback.trim()}
              className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95"
            >
              提交修改
            </button>
            <button
              onClick={() => setShowRevise(false)}
              className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
            >
              取消
            </button>
          </div>
        </div>
      ) : (
        <div className="flex gap-3">
          <button
            onClick={onConfirm}
            className="flex items-center gap-2 px-6 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Check size={18} />
            确认大纲
          </button>
          <button
            onClick={() => setShowRevise(true)}
            className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors"
          >
            <Edit3 size={18} />
            修改大纲
          </button>
        </div>
      )}
    </div>
  );
};
