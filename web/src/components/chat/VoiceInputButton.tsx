import React, { useEffect, useRef, useState } from 'react';
import { Mic, MicOff } from 'lucide-react';
import { useSpeechRecognition } from '../../hooks/useSpeechRecognition';
import toast from '../ui/Toast';

interface VoiceInputButtonProps {
  /** 实时回调：录音期间每次识别结果变化时调用，文本直接填入输入框 */
  onTextChange: (text: string) => void;
  /** 录音开始时回调：父组件应在此保存当前输入框内容 */
  onRecordingStart?: () => void;
  /** 录音结束时回调 */
  onRecordingEnd?: () => void;
  disabled?: boolean;
}

// 声波动画组件
const AudioWaveform: React.FC = () => {
  const [bars, setBars] = useState<number[]>([0.3, 0.5, 0.4, 0.6, 0.3, 0.5, 0.4]);
  
  useEffect(() => {
    const interval = setInterval(() => {
      setBars(prev => prev.map(() => 0.2 + Math.random() * 0.6));
    }, 100);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="flex items-center gap-0.5 h-6">
      {bars.map((h, i) => (
        <div
          key={i}
          className="w-1 bg-red-500 rounded-full transition-all duration-100"
          style={{ height: `${h * 100}%` }}
        />
      ))}
    </div>
  );
};

const VoiceInputButton: React.FC<VoiceInputButtonProps> = ({
  onTextChange,
  onRecordingStart,
  onRecordingEnd,
  disabled,
}) => {
  const {
    isRecording,
    interimText,
    finalText,
    error,
    startRecording,
    stopRecording,
  } = useSpeechRecognition();

  const wasRecordingRef = useRef(false);

  // 实时推送识别结果：已确认文本 + 中间文本
  useEffect(() => {
    if (isRecording) {
      const currentText = finalText + (interimText || '');
      onTextChange(currentText);
    }
  }, [isRecording, finalText, interimText, onTextChange]);

  // 录音状态变化
  useEffect(() => {
    if (isRecording && !wasRecordingRef.current) {
      wasRecordingRef.current = true;
      onRecordingStart?.();
    }
    if (!isRecording && wasRecordingRef.current) {
      wasRecordingRef.current = false;
      // 最后推送一次最终文本
      if (finalText) {
        onTextChange(finalText);
      }
      onRecordingEnd?.();
    }
  }, [isRecording, finalText, onTextChange, onRecordingStart, onRecordingEnd]);

  // 错误提示
  useEffect(() => {
    if (error) {
      toast.error(error);
    }
  }, [error]);

  const handleClick = () => {
    if (disabled) return;
    if (isRecording) {
      stopRecording();
    } else {
      startRecording();
    }
  };

  return (
    <div className="relative">
      <button
        onClick={handleClick}
        disabled={disabled}
        className={`p-2 rounded-lg transition-colors ${
          isRecording
            ? 'text-red-500 bg-red-50 dark:bg-red-900/20 hover:bg-red-100 dark:hover:bg-red-900/30 animate-pulse'
            : 'text-gray-400 hover:text-brand-500 hover:bg-gray-100 dark:hover:bg-gray-800'
        } disabled:opacity-50 disabled:cursor-not-allowed`}
        title={isRecording ? '停止录音' : '语音输入'}
      >
        {isRecording ? <MicOff size={18} /> : <Mic size={18} />}
      </button>

      {/* 录音中浮层：声波动画 */}
      {isRecording && (
        <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg shadow-lg z-50">
          <AudioWaveform />
          <div className="flex justify-center">
            <div className="w-2 h-2 bg-white dark:bg-gray-800 border-r border-b border-gray-200 dark:border-gray-700 transform rotate-45 -mt-1" />
          </div>
        </div>
      )}
    </div>
  );
};

export default VoiceInputButton;
