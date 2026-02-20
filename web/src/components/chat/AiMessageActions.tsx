import React, { useState } from 'react';
import { Copy, Check, RotateCcw, Volume2, VolumeX, Loader2 } from 'lucide-react';
import type { useTextToSpeech } from '../../hooks/useTextToSpeech';

interface AiMessageActionsProps {
  text: string;
  messageIndex: number;
  onRetry?: () => void;
  tts: ReturnType<typeof useTextToSpeech>;
}

const AiMessageActions: React.FC<AiMessageActionsProps> = ({
  text,
  messageIndex,
  onRetry,
  tts,
}) => {
  const [copied, setCopied] = useState(false);

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(text);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch { /* ignore */ }
  };

  const isThisSpeaking = tts.speakingIndex === messageIndex && tts.isSpeaking;
  const isThisLoading = tts.speakingIndex === messageIndex && tts.isLoading;

  const handleSpeak = () => {
    if (isThisSpeaking || isThisLoading) {
      tts.stop();
    } else {
      tts.speak(text, messageIndex);
    }
  };

  return (
    <div className="flex items-center gap-1 mt-1 ml-1">
      {/* 复制 */}
      <button
        onClick={handleCopy}
        className="p-1 rounded hover:bg-gray-200 dark:hover:bg-gray-700 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
        title="复制"
      >
        {copied ? <Check size={14} className="text-emerald-500" /> : <Copy size={14} />}
      </button>

      {/* 重试 */}
      {onRetry && (
        <button
          onClick={onRetry}
          className="p-1 rounded hover:bg-gray-200 dark:hover:bg-gray-700 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
          title="重试"
        >
          <RotateCcw size={14} />
        </button>
      )}

      {/* 语音朗读 */}
      <button
        onClick={handleSpeak}
        className={`p-1 rounded transition-colors ${
          isThisSpeaking
            ? 'text-brand-500 hover:text-brand-600 bg-brand-50 dark:bg-brand-900/20'
            : 'text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700'
        }`}
        title={isThisSpeaking ? '停止朗读' : '语音朗读'}
      >
        {isThisLoading ? (
          <Loader2 size={14} className="animate-spin" />
        ) : isThisSpeaking ? (
          <VolumeX size={14} />
        ) : (
          <Volume2 size={14} />
        )}
      </button>
    </div>
  );
};

export default AiMessageActions;
