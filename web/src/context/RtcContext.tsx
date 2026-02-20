import React, { createContext, useContext, useEffect, useState, useCallback, useRef } from 'react';
import RtcSignalingService from '../api/rtcSignaling';
import { useWebRTC } from '../hooks/useWebRTC';
import { getToken } from '../api';
import { ringtone } from '../utils/ringtone';
import type {
  CallState,
  MediaType,
  CallMode,
  CurrentCall,
  RtcConnectionState,
  IncomingCallData,
  AnswerData,
  ICEData,
  CallControlData,
  CallEndedData,
  SFUFallbackData,
  TURNConfigData,
  RtcErrorData,
} from '../api/rtcTypes';

// ============ Context 类型 ============

interface RtcContextValue {
  rtcConnectionState: RtcConnectionState;
  callState: CallState;
  currentCall: CurrentCall | null;
  localStream: MediaStream | null;
  remoteStream: MediaStream | null;
  isMuted: boolean;
  isVideoOff: boolean;
  callDuration: number;

  connectRtc: () => void;
  disconnectRtc: () => void;
  startCall: (targetUserId: string, targetName: string, targetAvatar: string | undefined, mediaType: MediaType) => Promise<void>;
  answerCall: () => Promise<void>;
  rejectCall: () => void;
  hangUp: () => void;
  toggleMute: () => void;
  toggleVideo: () => void;
}

const RtcContext = createContext<RtcContextValue | null>(null);

// ============ Provider ============

export const RtcProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [rtcConnectionState, setRtcConnectionState] = useState<RtcConnectionState>('disconnected');
  const [callState, setCallState] = useState<CallState>('idle');
  const [currentCall, setCurrentCall] = useState<CurrentCall | null>(null);
  const [isMuted, setIsMuted] = useState(false);
  const [isVideoOff, setIsVideoOff] = useState(false);
  const [callDuration, setCallDuration] = useState(0);

  const signalingRef = useRef(RtcSignalingService.getInstance());
  const durationTimerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const pendingIncomingRef = useRef<IncomingCallData | null>(null);
  const currentCallRef = useRef<CurrentCall | null>(null);

  // 保持 ref 与 state 同步
  const updateCurrentCall = useCallback((call: CurrentCall | null) => {
    currentCallRef.current = call;
    setCurrentCall(call);
  }, []);

  const onICECandidate = useCallback((candidate: string) => {
    const call = currentCallRef.current;
    if (call) {
      signalingRef.current.sendICE({ callId: call.callId, candidate });
    }
  }, []);

  const onICEFailed = useCallback(() => {
    const call = currentCallRef.current;
    if (call) {
      console.warn('[RTC] ICE failed, requesting SFU fallback');
      signalingRef.current.sendFallbackSFU(call.callId);
    }
  }, []);

  const webrtc = useWebRTC({ onICECandidate, onICEFailed });

  // 通话计时器
  const startDurationTimer = useCallback(() => {
    stopDurationTimer();
    setCallDuration(0);
    durationTimerRef.current = setInterval(() => {
      setCallDuration((prev) => prev + 1);
    }, 1000);
  }, []);

  const stopDurationTimer = useCallback(() => {
    if (durationTimerRef.current) {
      clearInterval(durationTimerRef.current);
      durationTimerRef.current = null;
    }
  }, []);

  // 重置通话状态
  const resetCall = useCallback(() => {
    setCallState('idle');
    setCurrentCall(null);
    setIsMuted(false);
    setIsVideoOff(false);
    stopDurationTimer();
    setCallDuration(0);
    webrtc.cleanup();
    pendingIncomingRef.current = null;
    currentCallRef.current = null;
  }, [stopDurationTimer, webrtc]);

  // ============ 信令事件处理 ============

  useEffect(() => {
    const signaling = signalingRef.current;

    const removeListener = signaling.addListener({
      onConnectionChange: (state: RtcConnectionState) => {
        setRtcConnectionState(state);
      },

      onIncomingCall: (data: IncomingCallData) => {
        if (callState !== 'idle') {
          signaling.sendBusy(data.callId);
          return;
        }
        pendingIncomingRef.current = data;
        updateCurrentCall({
          callId: data.callId,
          peerId: data.callerUserId,
          peerName: data.callerName || '未知用户',
          peerAvatar: data.callerAvatar,
          mediaType: data.mediaType,
          mode: 'p2p',
        });
        setCallState('ringing_in');
      },

      onCallAnswered: async (data: AnswerData) => {
        try {
          await webrtc.setRemoteAnswer(data.sdp);
          setCallState('connected');
          startDurationTimer();
        } catch (e) {
          console.error('[RTC] setRemoteAnswer error:', e);
          resetCall();
        }
      },

      onICECandidate: async (data: ICEData) => {
        await webrtc.addICECandidate(data.candidate);
      },

      onCallRejected: (_data: CallControlData) => {
        resetCall();
      },

      onCallBusy: (_data: CallControlData) => {
        resetCall();
      },

      onCallEnded: (_data: CallEndedData) => {
        resetCall();
      },

      onTURNConfig: (data: TURNConfigData) => {
        webrtc.setTURNConfig(data);
      },

      onSFUFallback: (data: SFUFallbackData) => {
        console.log('[RTC] SFU fallback received, LiveKit URL:', data.livekitUrl);
        if (currentCallRef.current) {
          updateCurrentCall(currentCallRef.current ? { ...currentCallRef.current, mode: 'sfu' as CallMode } : null);
        }
        // TODO: 接入 LiveKit JS SDK 实现 SFU 模式
      },

      onError: (data: RtcErrorData) => {
        console.error('[RTC] Error:', data.code, data.message);
        if (callState === 'ringing_out' || callState === 'connecting') {
          resetCall();
        }
      },
    });

    // 有 Token 时自动连接
    const token = getToken();
    if (token) {
      signaling.connect();
    }

    return () => {
      removeListener();
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // ============ 用户操作 ============

  const connectRtc = useCallback(() => {
    signalingRef.current.connect();
  }, []);

  const disconnectRtc = useCallback(() => {
    signalingRef.current.disconnect();
  }, []);

  // 发起呼叫
  const startCall = useCallback(async (
    targetUserId: string,
    targetName: string,
    targetAvatar: string | undefined,
    mediaType: MediaType,
  ) => {
    if (callState !== 'idle') return;

    const callId = crypto.randomUUID();
    updateCurrentCall({
      callId,
      peerId: targetUserId,
      peerName: targetName,
      peerAvatar: targetAvatar,
      mediaType,
      mode: 'p2p',
    });
    setCallState('ringing_out');

    try {
      await webrtc.getLocalStream(mediaType);
      const sdp = await webrtc.createOffer();
      signalingRef.current.sendInvite({
        callId,
        targetUserId,
        mediaType,
        sdp,
      });
    } catch (e) {
      console.error('[RTC] startCall error:', e);
      resetCall();
    }
  }, [callState, webrtc, resetCall]);

  // 接听来电
  const answerCall = useCallback(async () => {
    const incoming = pendingIncomingRef.current;
    if (!incoming || callState !== 'ringing_in') return;

    setCallState('connecting');
    try {
      await webrtc.getLocalStream(incoming.mediaType);
      const sdp = await webrtc.createAnswer(incoming.sdp);
      signalingRef.current.sendAnswer({ callId: incoming.callId, sdp });
      setCallState('connected');
      startDurationTimer();
    } catch (e) {
      console.error('[RTC] answerCall error:', e);
      resetCall();
    }
  }, [callState, webrtc, startDurationTimer, resetCall]);

  // 拒绝来电
  const rejectCall = useCallback(() => {
    if (currentCall && callState === 'ringing_in') {
      signalingRef.current.sendReject(currentCall.callId);
    }
    resetCall();
  }, [callState, currentCall, resetCall]);

  // 挂断
  const hangUp = useCallback(() => {
    if (currentCall) {
      signalingRef.current.sendBye(currentCall.callId);
    }
    resetCall();
  }, [currentCall, resetCall]);

  // 静音
  const toggleMuteHandler = useCallback(() => {
    const muted = webrtc.toggleMute();
    setIsMuted(muted);
  }, [webrtc]);

  // 关摄像头
  const toggleVideoHandler = useCallback(() => {
    const off = webrtc.toggleVideo();
    setIsVideoOff(off);
  }, [webrtc]);

  const value: RtcContextValue = {
    rtcConnectionState,
    callState,
    currentCall,
    localStream: webrtc.localStream,
    remoteStream: webrtc.remoteStream,
    isMuted,
    isVideoOff,
    callDuration,
    connectRtc,
    disconnectRtc,
    startCall,
    answerCall,
    rejectCall,
    hangUp,
    toggleMute: toggleMuteHandler,
    toggleVideo: toggleVideoHandler,
  };

  // ============ 铃声管理 ============
  useEffect(() => {
    if (callState === 'ringing_in') {
      ringtone.play('incoming');
    } else if (callState === 'ringing_out') {
      ringtone.play('outgoing');
    } else {
      ringtone.stop();
    }
    return () => { ringtone.stop(); };
  }, [callState]);

  return <RtcContext.Provider value={value}>{children}</RtcContext.Provider>;
};

// ============ Hook ============

export function useRtc(): RtcContextValue {
  const ctx = useContext(RtcContext);
  if (!ctx) {
    throw new Error('useRtc must be used within a RtcProvider');
  }
  return ctx;
}

export default RtcContext;
