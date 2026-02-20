import React from 'react';
import { Mic, MicOff, Video, VideoOff, PhoneOff } from 'lucide-react';

interface CallControlsProps {
  isMuted: boolean;
  isVideoOff: boolean;
  mediaType: 'audio' | 'video';
  onToggleMute: () => void;
  onToggleVideo: () => void;
  onHangUp: () => void;
}

const CallControls: React.FC<CallControlsProps> = ({
  isMuted,
  isVideoOff,
  mediaType,
  onToggleMute,
  onToggleVideo,
  onHangUp,
}) => {
  return (
    <div className="flex items-center justify-center gap-5">
      {/* 静音 */}
      <button
        onClick={onToggleMute}
        className={`w-12 h-12 rounded-full flex items-center justify-center transition-all hover:scale-105 active:scale-95 ${
          isMuted
            ? 'bg-red-500/20 text-red-500 ring-2 ring-red-500/30'
            : 'bg-white/10 text-white hover:bg-white/20'
        }`}
        title={isMuted ? '取消静音' : '静音'}
      >
        {isMuted ? <MicOff size={20} /> : <Mic size={20} />}
      </button>

      {/* 摄像头（仅视频通话） */}
      {mediaType === 'video' && (
        <button
          onClick={onToggleVideo}
          className={`w-12 h-12 rounded-full flex items-center justify-center transition-all hover:scale-105 active:scale-95 ${
            isVideoOff
              ? 'bg-red-500/20 text-red-500 ring-2 ring-red-500/30'
              : 'bg-white/10 text-white hover:bg-white/20'
          }`}
          title={isVideoOff ? '打开摄像头' : '关闭摄像头'}
        >
          {isVideoOff ? <VideoOff size={20} /> : <Video size={20} />}
        </button>
      )}

      {/* 挂断 */}
      <button
        onClick={onHangUp}
        className="w-14 h-14 rounded-full bg-red-500 hover:bg-red-600 text-white flex items-center justify-center shadow-lg shadow-red-500/30 transition-all hover:scale-105 active:scale-95"
        title="挂断"
      >
        <PhoneOff size={22} />
      </button>
    </div>
  );
};

export default CallControls;
