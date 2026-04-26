import React, { useEffect, useState } from 'react';
import { Phone, PhoneOff, Video, User } from 'lucide-react';
import { useRtc } from '../../context/RtcContext';

const IncomingCallModal: React.FC = () => {
  const { callState, currentCall, answerCall, rejectCall } = useRtc();
  const [timeLeft, setTimeLeft] = useState(30);

  // 30 秒超时自动拒绝
  useEffect(() => {
    if (callState !== 'ringing_in') {
      setTimeLeft(30);
      return;
    }
    const timer = setInterval(() => {
      setTimeLeft((prev) => {
        if (prev <= 1) {
          rejectCall();
          return 30;
        }
        return prev - 1;
      });
    }, 1000);
    return () => clearInterval(timer);
  }, [callState, rejectCall]);

  if (callState !== 'ringing_in' || !currentCall) return null;

  const isVideo = currentCall.mediaType === 'video';

  return (
    <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/40 backdrop-blur-sm animate-in fade-in duration-200">
      <div className="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl border border-gray-200 dark:border-gray-700 p-8 w-[340px] flex flex-col items-center gap-5">
        {/* 来电动画 */}
        <div className="relative">
          <div className="absolute inset-0 rounded-full bg-brand-400/20 animate-ping" />
          <div className="absolute -inset-2 rounded-full bg-brand-400/10 animate-pulse" />
          <div className="relative w-20 h-20 rounded-full bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 flex items-center justify-center ring-4 ring-brand-200 dark:ring-brand-800 shadow-sm">
            {currentCall.peerAvatar ? (
              <img src={currentCall.peerAvatar} alt="" className="w-20 h-20 rounded-full object-cover" />
            ) : (
              <User size={36} className="text-brand-600 dark:text-brand-400" />
            )}
          </div>
        </div>

        {/* 来电信息 */}
        <div className="text-center">
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
            {currentCall.peerName}
          </h3>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1 flex items-center justify-center gap-1.5">
            {isVideo ? <Video size={14} /> : <Phone size={14} />}
            {isVideo ? '视频通话' : '语音通话'}邀请
          </p>
          <p className="text-xs text-gray-400 dark:text-gray-500 mt-1">{timeLeft}s</p>
        </div>

        {/* 操作按钮 */}
        <div className="flex items-center gap-8">
          {/* 拒绝 */}
          <button
            onClick={rejectCall}
            className="w-14 h-14 rounded-full bg-red-500 hover:bg-red-600 text-white flex items-center justify-center shadow-lg shadow-red-500/30 transition-all hover:scale-105 active:scale-95"
          >
            <PhoneOff size={22} />
          </button>

          {/* 接听 */}
          <button
            onClick={answerCall}
            className="w-14 h-14 rounded-full bg-emerald-500 hover:bg-emerald-600 text-white flex items-center justify-center shadow-lg shadow-emerald-500/30 transition-all hover:scale-105 active:scale-95"
          >
            {isVideo ? <Video size={22} /> : <Phone size={22} />}
          </button>
        </div>
      </div>
    </div>
  );
};

export default IncomingCallModal;
