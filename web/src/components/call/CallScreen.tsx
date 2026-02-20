import React, { useRef, useEffect } from 'react';
import { Phone, User, Loader2 } from 'lucide-react';
import { useRtc } from '../../context/RtcContext';
import CallControls from './CallControls';

const formatDuration = (seconds: number): string => {
  const m = Math.floor(seconds / 60).toString().padStart(2, '0');
  const s = (seconds % 60).toString().padStart(2, '0');
  return `${m}:${s}`;
};

const CallScreen: React.FC = () => {
  const {
    callState,
    currentCall,
    localStream,
    remoteStream,
    isMuted,
    isVideoOff,
    callDuration,
    hangUp,
    toggleMute,
    toggleVideo,
  } = useRtc();

  const localVideoRef = useRef<HTMLVideoElement>(null);
  const remoteVideoRef = useRef<HTMLVideoElement>(null);

  // 绑定本地视频流
  useEffect(() => {
    if (localVideoRef.current && localStream) {
      localVideoRef.current.srcObject = localStream;
    }
  }, [localStream]);

  // 绑定远程视频流
  useEffect(() => {
    if (remoteVideoRef.current && remoteStream) {
      remoteVideoRef.current.srcObject = remoteStream;
    }
  }, [remoteStream]);

  // 不在通话中不渲染
  if (callState === 'idle' || callState === 'ringing_in' || !currentCall) return null;

  const isVideo = currentCall.mediaType === 'video';
  const isConnected = callState === 'connected';

  // ============ 视频通话界面 ============
  if (isVideo) {
    return (
      <div className="fixed inset-0 z-[9998] bg-gray-950 flex flex-col">
        {/* 远程视频全屏 */}
        <div className="flex-1 relative bg-gray-900">
          {isConnected && remoteStream ? (
            <video
              ref={remoteVideoRef}
              autoPlay
              playsInline
              className="w-full h-full object-cover"
              style={{ transform: 'scaleX(-1)' }}
            />
          ) : (
            <div className="w-full h-full flex flex-col items-center justify-center gap-4">
              <div className="w-24 h-24 rounded-full bg-gray-800 flex items-center justify-center">
                {currentCall.peerAvatar ? (
                  <img src={currentCall.peerAvatar} alt="" className="w-24 h-24 rounded-full object-cover" />
                ) : (
                  <User size={48} className="text-gray-500" />
                )}
              </div>
              <p className="text-white text-lg font-medium">{currentCall.peerName}</p>
              <div className="flex items-center gap-2 text-gray-400 text-sm">
                <Loader2 size={16} className="animate-spin" />
                {callState === 'ringing_out' ? '正在呼叫...' : '连接中...'}
              </div>
            </div>
          )}

          {/* 本地视频小窗 */}
          {localStream && (
            <div className="absolute top-4 right-4 w-36 h-48 rounded-xl overflow-hidden shadow-2xl border-2 border-white/20 bg-gray-800">
              <video
                ref={localVideoRef}
                autoPlay
                playsInline
                muted
                className="w-full h-full object-cover mirror"
                style={{ transform: 'scaleX(-1)' }}
              />
              {isVideoOff && (
                <div className="absolute inset-0 bg-gray-800 flex items-center justify-center">
                  <User size={32} className="text-gray-500" />
                </div>
              )}
            </div>
          )}
        </div>

        {/* 底部信息栏 + 控制 */}
        <div className="bg-gray-900/95 backdrop-blur-lg border-t border-white/5 px-6 py-5">
          {/* 通话信息 */}
          <div className="text-center mb-4">
            <p className="text-white font-medium">{currentCall.peerName}</p>
            {isConnected ? (
              <p className="text-emerald-400 text-sm mt-0.5">{formatDuration(callDuration)}</p>
            ) : (
              <p className="text-gray-400 text-sm mt-0.5">
                {callState === 'ringing_out' ? '正在呼叫...' : '连接中...'}
              </p>
            )}
          </div>
          <CallControls
            isMuted={isMuted}
            isVideoOff={isVideoOff}
            mediaType="video"
            onToggleMute={toggleMute}
            onToggleVideo={toggleVideo}
            onHangUp={hangUp}
          />
        </div>
      </div>
    );
  }

  // ============ 音频通话界面 ============
  return (
    <div className="fixed inset-0 z-[9998] bg-gradient-to-b from-gray-900 via-gray-950 to-gray-900 flex flex-col items-center justify-center">
      {/* 对方信息 */}
      <div className="flex flex-col items-center gap-4 mb-12">
        <div className="relative">
          {isConnected && (
            <div className="absolute -inset-3 rounded-full bg-emerald-500/20 animate-pulse" />
          )}
          <div className="relative w-28 h-28 rounded-full bg-gray-800 flex items-center justify-center ring-4 ring-white/10">
            {currentCall.peerAvatar ? (
              <img src={currentCall.peerAvatar} alt="" className="w-28 h-28 rounded-full object-cover" />
            ) : (
              <User size={56} className="text-gray-500" />
            )}
          </div>
        </div>
        <h2 className="text-white text-xl font-semibold">{currentCall.peerName}</h2>
        <div className="flex items-center gap-2 text-sm">
          {isConnected ? (
            <>
              <Phone size={14} className="text-emerald-400" />
              <span className="text-emerald-400 font-medium">{formatDuration(callDuration)}</span>
            </>
          ) : (
            <>
              <Loader2 size={14} className="animate-spin text-gray-400" />
              <span className="text-gray-400">
                {callState === 'ringing_out' ? '正在呼叫...' : '连接中...'}
              </span>
            </>
          )}
        </div>
      </div>

      {/* 隐藏音频元素 */}
      {remoteStream && (
        <audio ref={remoteVideoRef as React.RefObject<HTMLAudioElement>} autoPlay />
      )}

      {/* 控制按钮 */}
      <CallControls
        isMuted={isMuted}
        isVideoOff={isVideoOff}
        mediaType="audio"
        onToggleMute={toggleMute}
        onToggleVideo={toggleVideo}
        onHangUp={hangUp}
      />
    </div>
  );
};

export default CallScreen;
