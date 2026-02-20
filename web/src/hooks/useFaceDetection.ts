import { useRef, useState, useCallback, useEffect } from 'react';
import { FaceLandmarker, FilesetResolver } from '@mediapipe/tasks-vision';

// ==================== 类型定义 ====================

export type FocusStatus = 'focused' | 'distracted' | 'drowsy' | 'away';
export type DistanceStatus = 'normal' | 'too_close' | 'unknown';
export type DistractionReason =
  | 'none'
  | 'no_face'           // 未检测到人脸
  | 'eyes_closed'       // 闭眼/打瞌睡
  | 'looking_away'      // 视线偏离屏幕（眼球方向）
  | 'head_turned'       // 头部偏转过大
  | 'head_tilted';      // 头部倾斜（低头/仰头）

export interface FaceDetectionState {
  /** 是否已初始化完成 */
  ready: boolean;
  /** 摄像头是否已开启 */
  cameraActive: boolean;
  /** 专注状态 */
  focusStatus: FocusStatus;
  /** 分心原因 */
  distractionReason: DistractionReason;
  /** 距离状态 */
  distanceStatus: DistanceStatus;
  /** 估算距离（厘米），0 表示未知 */
  estimatedDistanceCm: number;
  /** 连续分心秒数 */
  distractedSeconds: number;
  /** 连续距离过近秒数 */
  tooCloseSeconds: number;
  /** 连续闭眼秒数 */
  eyesClosedSeconds: number;
  /** 左眼张开度 0~1 (0=完全闭合, 1=完全睁开) */
  leftEyeOpenness: number;
  /** 右眼张开度 0~1 */
  rightEyeOpenness: number;
  /** 头部偏航角（左右转头），度，0=正面 */
  headYawDeg: number;
  /** 头部俯仰角（低头/抬头），度，0=正面 */
  headPitchDeg: number;
  /** 视线水平偏移 -1~1 (负=看左，正=看右，0=正前方) */
  gazeX: number;
  /** 视线垂直偏移 -1~1 (负=看上，正=看下，0=正前方) */
  gazeY: number;
  /** 错误信息 */
  error: string | null;
}

interface UseFaceDetectionOptions {
  /** 是否启用检测 */
  enabled?: boolean;
  /** 检测间隔（毫秒），默认 500ms */
  detectionIntervalMs?: number;
  /** 判定为分心的连续秒数阈值，默认 5 秒 */
  distractedThresholdSec?: number;
  /** 判定为距离过近的连续秒数阈值，默认 3 秒 */
  tooCloseThresholdSec?: number;
  /** 判定为打瞌睡的连续闭眼秒数阈值，默认 2 秒 */
  drowsyThresholdSec?: number;
  /** 距离过近的阈值（厘米），默认 35cm */
  tooCloseDistanceCm?: number;
  /** 人脸占画面宽度比例超过此值视为过近，默认 0.35 */
  tooCloseFaceRatio?: number;
  /** 眼睛闭合度阈值，blendshape 值超过此阈值视为闭眼，默认 0.55 */
  eyeClosedThreshold?: number;
  /** 头部偏航角阈值（度），超过此值视为转头，默认 25 */
  headYawThresholdDeg?: number;
  /** 头部俯仰角阈值（度），超过此值视为低头/仰头，默认 20 */
  headPitchThresholdDeg?: number;
  /** 视线偏移阈值，超过此值视为视线偏离屏幕，默认 0.45 */
  gazeOffsetThreshold?: number;
}

// ==================== 常量 ====================

// 平均人脸宽度（厘米）
const AVG_FACE_WIDTH_CM = 14.5;
// 典型笔记本摄像头水平视场角（度）
const CAMERA_FOV_DEG = 60;
// 平均瞳距（厘米）- 备用距离估算
const AVG_IPD_CM = 6.3;

// MediaPipe FaceMesh 关键点索引
const LEFT_EYE_INDICES = { top: 159, bottom: 145, inner: 133, outer: 33 };
const RIGHT_EYE_INDICES = { top: 386, bottom: 374, inner: 362, outer: 263 };
const LEFT_IRIS_CENTER = 468;
const RIGHT_IRIS_CENTER = 473;
const NOSE_TIP = 1;
const FOREHEAD = 10;
const CHIN = 152;
const LEFT_CHEEK = 234;
const RIGHT_CHEEK = 454;

// ==================== 工具函数 ====================

/** 根据人脸宽度比例估算距离 */
function estimateDistanceByFaceWidth(faceWidthRatio: number): number {
  if (faceWidthRatio <= 0) return 0;
  const halfFovRad = (CAMERA_FOV_DEG / 2) * (Math.PI / 180);
  return Math.round(AVG_FACE_WIDTH_CM / (2 * faceWidthRatio * Math.tan(halfFovRad)));
}

/** 根据瞳距估算距离（更准确） */
function estimateDistanceByIPD(ipdRatio: number): number {
  if (ipdRatio <= 0) return 0;
  const halfFovRad = (CAMERA_FOV_DEG / 2) * (Math.PI / 180);
  return Math.round(AVG_IPD_CM / (2 * ipdRatio * Math.tan(halfFovRad)));
}

/** 两点间距 */
function dist2D(a: { x: number; y: number }, b: { x: number; y: number }): number {
  return Math.sqrt((a.x - b.x) ** 2 + (a.y - b.y) ** 2);
}

/** 从 blendshapes 中取值 */
function getBlendshape(
  blendshapes: { categoryName: string; score: number }[],
  name: string,
): number {
  const item = blendshapes.find(b => b.categoryName === name);
  return item?.score ?? 0;
}

/** 计算眼睛纵横比 (EAR) - 用 landmarks 备用 */
function computeEAR(
  landmarks: { x: number; y: number; z: number }[],
  indices: typeof LEFT_EYE_INDICES,
): number {
  const top = landmarks[indices.top];
  const bottom = landmarks[indices.bottom];
  const inner = landmarks[indices.inner];
  const outer = landmarks[indices.outer];
  if (!top || !bottom || !inner || !outer) return 1;
  const vertical = dist2D(top, bottom);
  const horizontal = dist2D(inner, outer);
  return horizontal > 0 ? vertical / horizontal : 1;
}

/** 从 landmarks 估算头部偏航角（左右转头） */
function estimateHeadYaw(landmarks: { x: number; y: number; z: number }[]): number {
  const nose = landmarks[NOSE_TIP];
  const leftCheek = landmarks[LEFT_CHEEK];
  const rightCheek = landmarks[RIGHT_CHEEK];
  if (!nose || !leftCheek || !rightCheek) return 0;
  const leftDist = Math.abs(nose.x - leftCheek.x);
  const rightDist = Math.abs(nose.x - rightCheek.x);
  const total = leftDist + rightDist;
  if (total < 0.001) return 0;
  // ratio: 0.5 = 正面, <0.5 = 向左转, >0.5 = 向右转
  const ratio = leftDist / total;
  // 映射到大致角度（线性近似，最大约 ±60°）
  return (ratio - 0.5) * 120;
}

/** 从 landmarks 估算头部俯仰角（低头/抬头） */
function estimateHeadPitch(landmarks: { x: number; y: number; z: number }[]): number {
  const forehead = landmarks[FOREHEAD];
  const chin = landmarks[CHIN];
  const nose = landmarks[NOSE_TIP];
  if (!forehead || !chin || !nose) return 0;
  const faceHeight = dist2D(forehead, chin);
  if (faceHeight < 0.001) return 0;
  // 鼻尖在额头-下巴之间的相对位置
  const noseRel = (nose.y - forehead.y) / (chin.y - forehead.y);
  // 正面时约 0.35，低头时增大，抬头时减小
  return (noseRel - 0.35) * 120;
}

/** 从虹膜位置计算视线偏移 */
function computeGaze(
  landmarks: { x: number; y: number; z: number }[],
  irisCenter: number,
  eyeIndices: typeof LEFT_EYE_INDICES,
): { x: number; y: number } {
  const iris = landmarks[irisCenter];
  const inner = landmarks[eyeIndices.inner];
  const outer = landmarks[eyeIndices.outer];
  const top = landmarks[eyeIndices.top];
  const bottom = landmarks[eyeIndices.bottom];
  if (!iris || !inner || !outer || !top || !bottom) return { x: 0, y: 0 };

  const hRange = dist2D(inner, outer);
  const vRange = dist2D(top, bottom);
  const hCenter = (inner.x + outer.x) / 2;
  const vCenter = (top.y + bottom.y) / 2;

  const gazeX = hRange > 0 ? (iris.x - hCenter) / (hRange / 2) : 0;
  const gazeY = vRange > 0 ? (iris.y - vCenter) / (vRange / 2) : 0;
  return { x: Math.max(-1, Math.min(1, gazeX)), y: Math.max(-1, Math.min(1, gazeY)) };
}

// ==================== Hook ====================

const initialState: FaceDetectionState = {
  ready: false,
  cameraActive: false,
  focusStatus: 'focused',
  distractionReason: 'none',
  distanceStatus: 'normal',
  estimatedDistanceCm: 0,
  distractedSeconds: 0,
  tooCloseSeconds: 0,
  eyesClosedSeconds: 0,
  leftEyeOpenness: 1,
  rightEyeOpenness: 1,
  headYawDeg: 0,
  headPitchDeg: 0,
  gazeX: 0,
  gazeY: 0,
  error: null,
};

export function useFaceDetection(options: UseFaceDetectionOptions = {}) {
  const {
    enabled = true,
    detectionIntervalMs = 500,
    distractedThresholdSec = 5,
    tooCloseThresholdSec = 3,
    drowsyThresholdSec = 2,
    tooCloseDistanceCm = 35,
    tooCloseFaceRatio = 0.35,
    eyeClosedThreshold = 0.55,
    headYawThresholdDeg = 25,
    headPitchThresholdDeg = 20,
    gazeOffsetThreshold = 0.45,
  } = options;

  const [state, setState] = useState<FaceDetectionState>(initialState);

  const videoRef = useRef<HTMLVideoElement | null>(null);
  const landmarkerRef = useRef<FaceLandmarker | null>(null);
  const streamRef = useRef<MediaStream | null>(null);
  const rafRef = useRef<number>(0);
  const lastDetectTimeRef = useRef<number>(0);
  const distractedCountRef = useRef<number>(0);
  const tooCloseCountRef = useRef<number>(0);
  const eyesClosedCountRef = useRef<number>(0);
  const enabledRef = useRef(enabled);
  enabledRef.current = enabled;

  // 初始化 MediaPipe FaceLandmarker
  const initDetector = useCallback(async () => {
    try {
      const vision = await FilesetResolver.forVisionTasks(
        'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@latest/wasm'
      );
      const landmarker = await FaceLandmarker.createFromOptions(vision, {
        baseOptions: {
          modelAssetPath:
            'https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/1/face_landmarker.task',
          delegate: 'GPU',
        },
        runningMode: 'VIDEO',
        numFaces: 1,
        minFaceDetectionConfidence: 0.5,
        minTrackingConfidence: 0.5,
        outputFaceBlendshapes: true,
        outputFacialTransformationMatrixes: false,
      });
      landmarkerRef.current = landmarker;
      setState(prev => ({ ...prev, ready: true }));
    } catch (err) {
      console.error('[FaceDetection] FaceLandmarker 初始化失败:', err);
      setState(prev => ({ ...prev, error: '人脸检测模型加载失败' }));
    }
  }, []);

  // 启动摄像头
  const startCamera = useCallback(async () => {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({
        video: { width: 320, height: 240, facingMode: 'user' },
        audio: false,
      });
      streamRef.current = stream;

      const video = document.createElement('video');
      video.srcObject = stream;
      video.setAttribute('playsinline', 'true');
      video.muted = true;
      await video.play();
      videoRef.current = video;

      setState(prev => ({ ...prev, cameraActive: true, error: null }));
    } catch (err) {
      console.error('[FaceDetection] 摄像头访问失败:', err);
      setState(prev => ({
        ...prev,
        error: '无法访问摄像头，请检查权限设置',
        cameraActive: false,
      }));
    }
  }, []);

  // 停止摄像头
  const stopCamera = useCallback(() => {
    if (streamRef.current) {
      streamRef.current.getTracks().forEach(track => track.stop());
      streamRef.current = null;
    }
    if (videoRef.current) {
      videoRef.current.srcObject = null;
      videoRef.current = null;
    }
    setState(prev => ({ ...prev, cameraActive: false }));
  }, []);

  // 检测循环
  const detectLoop = useCallback(() => {
    if (!enabledRef.current) return;

    const now = performance.now();
    const landmarker = landmarkerRef.current;
    const video = videoRef.current;

    if (landmarker && video && video.readyState >= 2) {
      if (now - lastDetectTimeRef.current >= detectionIntervalMs) {
        lastDetectTimeRef.current = now;

        try {
          const result = landmarker.detectForVideo(video, now);
          const intervalSec = detectionIntervalMs / 1000;

          if (!result.faceLandmarks || result.faceLandmarks.length === 0) {
            // ── 未检测到人脸 ──
            distractedCountRef.current += intervalSec;
            tooCloseCountRef.current = 0;
            eyesClosedCountRef.current = 0;

            setState(prev => ({
              ...prev,
              focusStatus: 'away',
              distractionReason: 'no_face',
              distanceStatus: 'unknown',
              estimatedDistanceCm: 0,
              distractedSeconds: Math.round(distractedCountRef.current),
              tooCloseSeconds: 0,
              eyesClosedSeconds: 0,
              leftEyeOpenness: 0,
              rightEyeOpenness: 0,
              headYawDeg: 0,
              headPitchDeg: 0,
              gazeX: 0,
              gazeY: 0,
            }));
          } else {
            const landmarks = result.faceLandmarks[0];
            const blendshapes = result.faceBlendshapes?.[0]?.categories ?? [];

            // ── 1. 距离估算 ──
            // 优先用瞳距，回退到面宽
            const leftIris = landmarks[LEFT_IRIS_CENTER];
            const rightIris = landmarks[RIGHT_IRIS_CENTER];
            let distCm = 0;
            let faceWidthRatio = 0;

            if (leftIris && rightIris) {
              const ipdRatio = dist2D(leftIris, rightIris);
              distCm = estimateDistanceByIPD(ipdRatio);
            }
            // 面宽回退
            const leftCheek = landmarks[LEFT_CHEEK];
            const rightCheek = landmarks[RIGHT_CHEEK];
            if (leftCheek && rightCheek) {
              faceWidthRatio = dist2D(leftCheek, rightCheek);
              if (distCm === 0) {
                distCm = estimateDistanceByFaceWidth(faceWidthRatio);
              }
            }

            const isTooClose = faceWidthRatio > tooCloseFaceRatio || (distCm > 0 && distCm < tooCloseDistanceCm);
            if (isTooClose) {
              tooCloseCountRef.current += intervalSec;
            } else {
              tooCloseCountRef.current = 0;
            }

            // ── 2. 眼睛闭合检测 ──
            let leftBlink = getBlendshape(blendshapes, 'eyeBlinkLeft');
            let rightBlink = getBlendshape(blendshapes, 'eyeBlinkRight');

            // 如果 blendshapes 不可用，用 EAR 回退
            if (blendshapes.length === 0) {
              const leftEAR = computeEAR(landmarks, LEFT_EYE_INDICES);
              const rightEAR = computeEAR(landmarks, RIGHT_EYE_INDICES);
              // EAR < 0.2 通常为闭眼，映射到 0~1 的 blink 值
              leftBlink = Math.max(0, Math.min(1, 1 - (leftEAR / 0.35)));
              rightBlink = Math.max(0, Math.min(1, 1 - (rightEAR / 0.35)));
            }

            const leftEyeOpenness = Math.max(0, Math.min(1, 1 - leftBlink));
            const rightEyeOpenness = Math.max(0, Math.min(1, 1 - rightBlink));
            const avgBlink = (leftBlink + rightBlink) / 2;
            const eyesClosed = avgBlink > eyeClosedThreshold;

            if (eyesClosed) {
              eyesClosedCountRef.current += intervalSec;
            } else {
              eyesClosedCountRef.current = 0;
            }

            // ── 3. 头部姿态 ──
            const headYaw = estimateHeadYaw(landmarks);
            const headPitch = estimateHeadPitch(landmarks);
            const headTurned = Math.abs(headYaw) > headYawThresholdDeg;
            const headTilted = Math.abs(headPitch) > headPitchThresholdDeg;

            // ── 4. 视线方向（虹膜追踪） ──
            const leftGaze = computeGaze(landmarks, LEFT_IRIS_CENTER, LEFT_EYE_INDICES);
            const rightGaze = computeGaze(landmarks, RIGHT_IRIS_CENTER, RIGHT_EYE_INDICES);
            const gazeX = (leftGaze.x + rightGaze.x) / 2;
            const gazeY = (leftGaze.y + rightGaze.y) / 2;

            // 如果没闭眼才检查视线
            const gazeLookingAway = !eyesClosed && (
              Math.abs(gazeX) > gazeOffsetThreshold || Math.abs(gazeY) > gazeOffsetThreshold
            );

            // ── 5. 综合判断专注度 ──
            let focusStatus: FocusStatus = 'focused';
            let distractionReason: DistractionReason = 'none';

            // 优先级：闭眼 > 头部偏转 > 视线偏离
            if (eyesClosed && eyesClosedCountRef.current >= drowsyThresholdSec) {
              focusStatus = 'drowsy';
              distractionReason = 'eyes_closed';
            } else if (headTurned) {
              focusStatus = 'distracted';
              distractionReason = 'head_turned';
            } else if (headTilted) {
              focusStatus = 'distracted';
              distractionReason = 'head_tilted';
            } else if (gazeLookingAway) {
              focusStatus = 'distracted';
              distractionReason = 'looking_away';
            }

            if (focusStatus === 'focused') {
              distractedCountRef.current = 0;
            } else {
              distractedCountRef.current += intervalSec;
            }

            setState(prev => ({
              ...prev,
              focusStatus,
              distractionReason,
              distanceStatus: isTooClose ? 'too_close' : 'normal',
              estimatedDistanceCm: distCm,
              distractedSeconds: Math.round(distractedCountRef.current),
              tooCloseSeconds: Math.round(tooCloseCountRef.current),
              eyesClosedSeconds: Math.round(eyesClosedCountRef.current),
              leftEyeOpenness,
              rightEyeOpenness,
              headYawDeg: Math.round(headYaw),
              headPitchDeg: Math.round(headPitch),
              gazeX: Math.round(gazeX * 100) / 100,
              gazeY: Math.round(gazeY * 100) / 100,
            }));
          }
        } catch {
          // 检测出错静默处理
        }
      }
    }

    rafRef.current = requestAnimationFrame(detectLoop);
  }, [
    detectionIntervalMs, tooCloseDistanceCm, tooCloseFaceRatio,
    eyeClosedThreshold, headYawThresholdDeg, headPitchThresholdDeg,
    gazeOffsetThreshold, drowsyThresholdSec,
  ]);

  // 启动/停止检测
  useEffect(() => {
    if (!enabled) {
      stopCamera();
      if (rafRef.current) cancelAnimationFrame(rafRef.current);
      distractedCountRef.current = 0;
      tooCloseCountRef.current = 0;
      eyesClosedCountRef.current = 0;
      setState(initialState);
      return;
    }

    let mounted = true;

    (async () => {
      await initDetector();
      if (!mounted) return;
      await startCamera();
      if (!mounted) return;
      rafRef.current = requestAnimationFrame(detectLoop);
    })();

    return () => {
      mounted = false;
      if (rafRef.current) cancelAnimationFrame(rafRef.current);
      stopCamera();
    };
  }, [enabled, initDetector, startCamera, stopCamera, detectLoop]);

  // 是否应该显示分心提醒
  const shouldWarnDistracted = state.distractedSeconds >= distractedThresholdSec;
  // 是否应该显示距离过近提醒
  const shouldWarnTooClose = state.tooCloseSeconds >= tooCloseThresholdSec;
  // 是否应该显示瞌睡提醒
  const shouldWarnDrowsy = state.eyesClosedSeconds >= drowsyThresholdSec;

  return {
    ...state,
    shouldWarnDistracted,
    shouldWarnTooClose,
    shouldWarnDrowsy,
    /** 摄像头 MediaStream，可绑定到 <video> 元素用于预览 */
    stream: streamRef.current,
  };
}
