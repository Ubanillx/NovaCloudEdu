import { useRef, useCallback, useState } from 'react';
import type { TURNConfigData, MediaType } from '../api/rtcTypes';

export interface WebRTCState {
  localStream: MediaStream | null;
  remoteStream: MediaStream | null;
  iceState: RTCIceConnectionState | null;
}

interface UseWebRTCOptions {
  onICECandidate: (candidate: string) => void;
  onICEFailed: () => void;
}

export function useWebRTC({ onICECandidate, onICEFailed }: UseWebRTCOptions) {
  const pcRef = useRef<RTCPeerConnection | null>(null);
  const localStreamRef = useRef<MediaStream | null>(null);
  const remoteStreamRef = useRef<MediaStream | null>(null);
  const turnConfigRef = useRef<TURNConfigData | null>(null);
  const pendingCandidatesRef = useRef<string[]>([]);

  const [state, setState] = useState<WebRTCState>({
    localStream: null,
    remoteStream: null,
    iceState: null,
  });

  // 保存 TURN 配置（由信令服务下发）
  const setTURNConfig = useCallback((config: TURNConfigData) => {
    turnConfigRef.current = config;
  }, []);

  // 获取本地媒体流
  const getLocalStream = useCallback(async (mediaType: MediaType): Promise<MediaStream> => {
    const constraints: MediaStreamConstraints = {
      audio: true,
      video: mediaType === 'video' ? { width: { ideal: 1280 }, height: { ideal: 720 }, facingMode: 'user' } : false,
    };
    const stream = await navigator.mediaDevices.getUserMedia(constraints);
    localStreamRef.current = stream;
    setState((prev) => ({ ...prev, localStream: stream }));
    return stream;
  }, []);

  // 创建 PeerConnection
  const createPeerConnection = useCallback((): RTCPeerConnection => {
    const iceServers: RTCIceServer[] = [
      { urls: 'stun:stun.l.google.com:19302' },
    ];
    if (turnConfigRef.current) {
      iceServers.push({
        urls: turnConfigRef.current.urls,
        username: turnConfigRef.current.username,
        credential: turnConfigRef.current.credential,
      });
    }

    const pc = new RTCPeerConnection({ iceServers, iceCandidatePoolSize: 10 });
    pcRef.current = pc;

    // 远程流
    const remoteStream = new MediaStream();
    remoteStreamRef.current = remoteStream;
    setState((prev) => ({ ...prev, remoteStream }));

    pc.ontrack = (event) => {
      remoteStream.addTrack(event.track);
      setState((prev) => ({ ...prev, remoteStream }));
    };

    // ICE candidate
    pc.onicecandidate = (event) => {
      if (event.candidate) {
        onICECandidate(JSON.stringify(event.candidate.toJSON()));
      }
    };

    // ICE 连接状态
    pc.oniceconnectionstatechange = () => {
      const iceState = pc.iceConnectionState;
      setState((prev) => ({ ...prev, iceState }));

      if (iceState === 'failed' || iceState === 'disconnected') {
        console.warn('[WebRTC] ICE state:', iceState);
        if (iceState === 'failed') {
          onICEFailed();
        }
      }
    };

    // 添加本地流的轨道
    if (localStreamRef.current) {
      localStreamRef.current.getTracks().forEach((track) => {
        pc.addTrack(track, localStreamRef.current!);
      });
    }

    return pc;
  }, [onICECandidate, onICEFailed]);

  // 创建 Offer（主叫方）— 返回纯 SDP 文本
  const createOffer = useCallback(async (): Promise<string> => {
    const pc = createPeerConnection();
    const offer = await pc.createOffer();
    await pc.setLocalDescription(offer);
    return offer.sdp ?? '';
  }, [createPeerConnection]);

  // 刷新缓冲的 ICE 候选
  const flushPendingCandidates = useCallback(async (pc: RTCPeerConnection) => {
    const pending = pendingCandidatesRef.current;
    pendingCandidatesRef.current = [];
    for (const c of pending) {
      try {
        const candidate = JSON.parse(c) as RTCIceCandidateInit;
        await pc.addIceCandidate(new RTCIceCandidate(candidate));
      } catch (e) {
        console.warn('[WebRTC] flush buffered candidate error:', e);
      }
    }
  }, []);

  // 处理来电 Offer 并创建 Answer（被叫方）— 接收/返回纯 SDP 文本
  const createAnswer = useCallback(async (offerSdp: string): Promise<string> => {
    const pc = createPeerConnection();
    await pc.setRemoteDescription({ type: 'offer', sdp: offerSdp });
    await flushPendingCandidates(pc);
    const answer = await pc.createAnswer();
    await pc.setLocalDescription(answer);
    return answer.sdp ?? '';
  }, [createPeerConnection, flushPendingCandidates]);

  // 设置远端 Answer（主叫方收到应答后）— 接收纯 SDP 文本
  const setRemoteAnswer = useCallback(async (answerSdp: string): Promise<void> => {
    const pc = pcRef.current;
    if (!pc) return;
    await pc.setRemoteDescription({ type: 'answer', sdp: answerSdp });
    await flushPendingCandidates(pc);
  }, [flushPendingCandidates]);

  // 添加远端 ICE candidate（PC 未创建或远程描述未设置时缓冲）
  const addICECandidate = useCallback(async (candidateStr: string): Promise<void> => {
    const pc = pcRef.current;
    if (!pc || !pc.remoteDescription) {
      pendingCandidatesRef.current.push(candidateStr);
      return;
    }
    try {
      const candidate = JSON.parse(candidateStr) as RTCIceCandidateInit;
      await pc.addIceCandidate(new RTCIceCandidate(candidate));
    } catch (e) {
      console.error('[WebRTC] addIceCandidate error:', e);
    }
  }, []);

  // 静音/取消静音
  const toggleMute = useCallback((): boolean => {
    const stream = localStreamRef.current;
    if (!stream) return false;
    const audioTrack = stream.getAudioTracks()[0];
    if (audioTrack) {
      audioTrack.enabled = !audioTrack.enabled;
      return !audioTrack.enabled; // true = muted
    }
    return false;
  }, []);

  // 开关摄像头
  const toggleVideo = useCallback((): boolean => {
    const stream = localStreamRef.current;
    if (!stream) return false;
    const videoTrack = stream.getVideoTracks()[0];
    if (videoTrack) {
      videoTrack.enabled = !videoTrack.enabled;
      return !videoTrack.enabled; // true = camera off
    }
    return false;
  }, []);

  // 清理所有资源
  const cleanup = useCallback(() => {
    if (pcRef.current) {
      pcRef.current.close();
      pcRef.current = null;
    }
    if (localStreamRef.current) {
      localStreamRef.current.getTracks().forEach((t) => t.stop());
      localStreamRef.current = null;
    }
    remoteStreamRef.current = null;
    pendingCandidatesRef.current = [];
    setState({ localStream: null, remoteStream: null, iceState: null });
  }, []);

  return {
    ...state,
    setTURNConfig,
    getLocalStream,
    createOffer,
    createAnswer,
    setRemoteAnswer,
    addICECandidate,
    toggleMute,
    toggleVideo,
    cleanup,
  };
}
