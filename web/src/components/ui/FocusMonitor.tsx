import React, { useState, useEffect, useCallback, useSyncExternalStore, useRef } from 'react';
import { createPortal } from 'react-dom';
import { Eye, EyeOff, AlertTriangle, Monitor, X, Camera, CameraOff, Moon, Video, VideoOff } from 'lucide-react';
import { useFaceDetection, type DistractionReason } from '../../hooks/useFaceDetection';

/** 订阅 fullscreenchange，返回当前全屏元素（没有则返回 document.body） */
function getPortalTarget(): Element {
  return document.fullscreenElement ?? document.body;
}
let _fsListeners: (() => void)[] = [];
function subscribeFullscreen(cb: () => void) {
  _fsListeners.push(cb);
  document.addEventListener('fullscreenchange', cb);
  return () => {
    _fsListeners = _fsListeners.filter(l => l !== cb);
    document.removeEventListener('fullscreenchange', cb);
  };
}
function usePortalTarget() {
  return useSyncExternalStore(subscribeFullscreen, getPortalTarget, () => document.body);
}

interface FocusMonitorProps {
  /** 是否启用监控（如视频正在播放时启用） */
  enabled?: boolean;
}

// 分心原因 → 用户友好的标题 & 描述
const REASON_TEXT: Record<DistractionReason, { title: string; desc: string }> = {
  none:          { title: '', desc: '' },
  no_face:       { title: '未检测到您的面部', desc: '请确保面部在摄像头范围内' },
  eyes_closed:   { title: '检测到您闭眼时间过长', desc: '如果感到疲倦，建议适当休息' },
  looking_away:  { title: '视线似乎偏离了屏幕', desc: '请将目光移回屏幕继续学习' },
  head_turned:   { title: '您的头部偏转角度较大', desc: '请面朝屏幕以获得更好的学习效果' },
  head_tilted:   { title: '检测到低头或仰头', desc: '请保持头部端正，注视屏幕' },
};

const FocusMonitor: React.FC<FocusMonitorProps> = ({ enabled = true }) => {
  const portalTarget = usePortalTarget();
  const [monitorEnabled, setMonitorEnabled] = useState(false);
  const [showPreview, setShowPreview] = useState(false);
  const [dismissedDistracted, setDismissedDistracted] = useState(false);
  const [dismissedDrowsy, setDismissedDrowsy] = useState(false);
  const [dismissedTooClose, setDismissedTooClose] = useState(false);
  const [showPermissionPrompt, setShowPermissionPrompt] = useState(false);
  const previewVideoRef = useRef<HTMLVideoElement | null>(null);

  const {
    cameraActive,
    focusStatus,
    distractionReason,
    distanceStatus,
    estimatedDistanceCm,
    distractedSeconds,
    eyesClosedSeconds,
    leftEyeOpenness,
    rightEyeOpenness,
    headYawDeg,
    shouldWarnDistracted,
    shouldWarnTooClose,
    shouldWarnDrowsy,
    stream,
    error,
  } = useFaceDetection({
    enabled: monitorEnabled && enabled,
    detectionIntervalMs: 500,
    distractedThresholdSec: 5,
    tooCloseThresholdSec: 3,
    drowsyThresholdSec: 2,
    tooCloseDistanceCm: 35,
    tooCloseFaceRatio: 0.35,
    eyeClosedThreshold: 0.55,
    headYawThresholdDeg: 25,
    headPitchThresholdDeg: 20,
    gazeOffsetThreshold: 0.45,
  });

  // 将摄像头流绑定到预览 video 元素
  useEffect(() => {
    const video = previewVideoRef.current;
    if (!video) return;
    if (stream && showPreview) {
      video.srcObject = stream;
      video.play().catch(() => {});
    } else {
      video.srcObject = null;
    }
  }, [stream, showPreview]);

  // 关闭监控时隐藏预览
  useEffect(() => {
    if (!monitorEnabled) setShowPreview(false);
  }, [monitorEnabled]);

  // 当用户重新专注时，自动重置 dismissed 状态
  useEffect(() => {
    if (focusStatus === 'focused') {
      setDismissedDistracted(false);
      setDismissedDrowsy(false);
    }
  }, [focusStatus]);

  useEffect(() => {
    if (distanceStatus === 'normal') {
      setDismissedTooClose(false);
    }
  }, [distanceStatus]);

  const handleToggleMonitor = useCallback(() => {
    if (!monitorEnabled) {
      setShowPermissionPrompt(true);
    } else {
      setMonitorEnabled(false);
    }
  }, [monitorEnabled]);

  const handleConfirmEnable = useCallback(() => {
    setShowPermissionPrompt(false);
    setMonitorEnabled(true);
  }, []);

  const handleCancelEnable = useCallback(() => {
    setShowPermissionPrompt(false);
  }, []);

  // 状态点颜色
  const statusDotClass =
    focusStatus === 'focused'    ? 'bg-green-500' :
    focusStatus === 'drowsy'     ? 'bg-purple-500 animate-pulse' :
    focusStatus === 'distracted' ? 'bg-amber-500 animate-pulse' :
                                   'bg-red-500 animate-pulse';

  // 简洁状态文字
  const statusLabel =
    focusStatus === 'focused'    ? '专注' :
    focusStatus === 'drowsy'     ? '困倦' :
    focusStatus === 'distracted' ? '分心' : '离开';

  // 计算当前有几个提醒浮层正在显示（用于排列位置）
  const showDrowsyAlert = monitorEnabled && shouldWarnDrowsy && !dismissedDrowsy;
  const showDistractedAlert = monitorEnabled && shouldWarnDistracted && !shouldWarnDrowsy && !dismissedDistracted;
  const showTooCloseAlert = monitorEnabled && shouldWarnTooClose && !dismissedTooClose;

  let alertTopOffset = 5; // rem
  const drowsyTop = alertTopOffset;
  if (showDrowsyAlert) alertTopOffset += 5;
  const distractedTop = alertTopOffset;
  if (showDistractedAlert) alertTopOffset += 5;
  const tooCloseTop = alertTopOffset;

  return (
    <>
      {/* 开关按钮 - 始终渲染在底部栏内 */}
      <button
        onClick={handleToggleMonitor}
        className={`flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg text-xs font-medium transition-all ${
          monitorEnabled
            ? 'text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/30'
            : 'text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
        }`}
        title={monitorEnabled ? '关闭专注度监控' : '开启专注度监控'}
      >
        {monitorEnabled ? <Eye size={14} /> : <EyeOff size={14} />}
        <span className="hidden sm:inline">专注</span>
      </button>

      {/* 状态指示器 + 预览切换按钮 - 仅在开启时显示 */}
      {monitorEnabled && cameraActive && (
        <div className="flex items-center gap-1.5">
          <div
            className="flex items-center gap-1.5 cursor-default"
            title={`眼睛张开度: 左${Math.round(leftEyeOpenness * 100)}% 右${Math.round(rightEyeOpenness * 100)}% | 头部偏转: ${headYawDeg}°`}
          >
            <div className={`w-1.5 h-1.5 rounded-full ${statusDotClass}`} />
            <span className="text-[11px] text-gray-400 tabular-nums">
              {statusLabel}
              {estimatedDistanceCm > 0 ? ` · ${estimatedDistanceCm}cm` : ''}
            </span>
          </div>
          <button
            onClick={() => setShowPreview(v => !v)}
            className={`p-1 rounded-md transition-colors ${
              showPreview
                ? 'text-brand-500 bg-brand-50 dark:bg-brand-900/20'
                : 'text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800'
            }`}
            title={showPreview ? '隐藏摄像头预览' : '显示摄像头预览'}
          >
            {showPreview ? <Video size={13} /> : <VideoOff size={13} />}
          </button>
        </div>
      )}

      {/* 加载/错误状态 */}
      {monitorEnabled && !cameraActive && !error && (
        <span className="text-[11px] text-gray-400 flex items-center gap-1">
          <div className="w-3 h-3 border border-brand-500 border-t-transparent rounded-full animate-spin" />
          初始化中...
        </span>
      )}

      {monitorEnabled && error && (
        <span className="text-[11px] text-red-500 flex items-center gap-1">
          <CameraOff size={12} />
          {error}
        </span>
      )}

      {/* ===== 以下所有弹层通过 Portal 渲染到 body，避免被父容器 overflow 裁剪 ===== */}

      {/* 摄像头预览浮窗 */}
      {monitorEnabled && cameraActive && showPreview && createPortal(
        <div
          className="fixed bottom-20 right-5 z-[9998] rounded-2xl overflow-hidden shadow-2xl border-2 border-white/20 dark:border-gray-700/50 bg-black"
          style={{ width: 200, height: 150, animation: 'fadeSlideDown .2s ease' }}
        >
          <video
            ref={previewVideoRef}
            muted
            playsInline
            className="w-full h-full object-cover scale-x-[-1]"
          />
          {/* 状态角标 */}
          <div className="absolute top-2 left-2 flex items-center gap-1.5 bg-black/50 backdrop-blur-sm rounded-full px-2 py-0.5">
            <div className={`w-1.5 h-1.5 rounded-full ${statusDotClass}`} />
            <span className="text-[10px] text-white font-medium">{statusLabel}</span>
          </div>
          {/* 关闭按钮 */}
          <button
            onClick={() => setShowPreview(false)}
            className="absolute top-1.5 right-1.5 w-5 h-5 rounded-full bg-black/50 backdrop-blur-sm flex items-center justify-center text-white/70 hover:text-white hover:bg-black/70 transition-colors"
          >
            <X size={10} />
          </button>
        </div>,
        portalTarget,
      )}

      {/* 权限请求弹窗 */}
      {showPermissionPrompt && createPortal(
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/40 backdrop-blur-sm">
          <div className="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl p-6 max-w-sm mx-4 border border-gray-200 dark:border-gray-700">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-10 h-10 rounded-xl bg-brand-50 dark:bg-brand-900/30 flex items-center justify-center">
                <Camera size={20} className="text-brand-500" />
              </div>
              <div>
                <h3 className="text-base font-bold text-gray-900 dark:text-white">开启专注度监控</h3>
                <p className="text-xs text-gray-500 dark:text-gray-400">需要使用摄像头</p>
              </div>
            </div>
            <div className="text-sm text-gray-600 dark:text-gray-300 space-y-2 mb-5">
              <p>此功能将通过摄像头实时检测：</p>
              <ul className="list-disc list-inside text-xs space-y-1 text-gray-500 dark:text-gray-400">
                <li>眼睛闭合与睁开状态（疲劳/瞌睡提醒）</li>
                <li>眼球视线方向（是否注视屏幕）</li>
                <li>头部朝向与倾斜角度（偏头/低头检测）</li>
                <li>面部是否在画面中（离开检测）</li>
                <li>与屏幕的距离（护眼提醒）</li>
              </ul>
              <p className="text-xs text-gray-400 dark:text-gray-500">
                所有处理均在本地完成，不会上传任何图像数据。
              </p>
            </div>
            <div className="flex gap-3">
              <button
                onClick={handleCancelEnable}
                className="flex-1 px-4 py-2 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-400 bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
              >
                取消
              </button>
              <button
                onClick={handleConfirmEnable}
                className="flex-1 px-4 py-2 rounded-xl text-sm font-medium text-white bg-brand-500 hover:bg-brand-600 transition-colors"
              >
                开启
              </button>
            </div>
          </div>
        </div>,
        portalTarget,
      )}

      {/* 瞌睡/闭眼提醒弹层（紫色） */}
      {showDrowsyAlert && createPortal(
        <div
          className="fixed left-1/2 -translate-x-1/2 z-[9999]"
          style={{ top: `${drowsyTop}rem`, animation: 'fadeSlideDown .3s ease' }}
        >
          <div className="bg-purple-50 dark:bg-purple-900/90 border border-purple-200 dark:border-purple-700 rounded-2xl shadow-xl px-5 py-4 flex items-start gap-3 max-w-md backdrop-blur-sm">
            <div className="w-9 h-9 rounded-xl bg-purple-100 dark:bg-purple-800 flex items-center justify-center flex-shrink-0 mt-0.5">
              <Moon size={18} className="text-purple-600 dark:text-purple-400" />
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-bold text-purple-800 dark:text-purple-200">
                {REASON_TEXT.eyes_closed.title}
              </p>
              <p className="text-xs text-purple-600 dark:text-purple-400 mt-1">
                已闭眼 {eyesClosedSeconds} 秒 — {REASON_TEXT.eyes_closed.desc}
              </p>
            </div>
            <button
              onClick={() => setDismissedDrowsy(true)}
              className="p-1 rounded-lg text-purple-400 hover:text-purple-600 dark:hover:text-purple-300 hover:bg-purple-100 dark:hover:bg-purple-800 transition-colors flex-shrink-0"
            >
              <X size={14} />
            </button>
          </div>
        </div>,
        portalTarget,
      )}

      {/* 分心提醒弹层（琥珀色） — 不在瞌睡时同时显示 */}
      {showDistractedAlert && createPortal(
        <div
          className="fixed left-1/2 -translate-x-1/2 z-[9999]"
          style={{ top: `${distractedTop}rem`, animation: 'fadeSlideDown .3s ease' }}
        >
          <div className="bg-amber-50 dark:bg-amber-900/90 border border-amber-200 dark:border-amber-700 rounded-2xl shadow-xl px-5 py-4 flex items-start gap-3 max-w-md backdrop-blur-sm">
            <div className="w-9 h-9 rounded-xl bg-amber-100 dark:bg-amber-800 flex items-center justify-center flex-shrink-0 mt-0.5">
              <AlertTriangle size={18} className="text-amber-600 dark:text-amber-400" />
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-bold text-amber-800 dark:text-amber-200">
                {REASON_TEXT[distractionReason]?.title || '您似乎没有在看屏幕'}
              </p>
              <p className="text-xs text-amber-600 dark:text-amber-400 mt-1">
                已分心 {distractedSeconds} 秒 — {REASON_TEXT[distractionReason]?.desc || '请保持专注以获得更好的学习效果'}
              </p>
            </div>
            <button
              onClick={() => setDismissedDistracted(true)}
              className="p-1 rounded-lg text-amber-400 hover:text-amber-600 dark:hover:text-amber-300 hover:bg-amber-100 dark:hover:bg-amber-800 transition-colors flex-shrink-0"
            >
              <X size={14} />
            </button>
          </div>
        </div>,
        portalTarget,
      )}

      {/* 距离过近提醒弹层（红色） */}
      {showTooCloseAlert && createPortal(
        <div
          className="fixed left-1/2 -translate-x-1/2 z-[9999]"
          style={{ top: `${tooCloseTop}rem`, animation: 'fadeSlideDown .3s ease' }}
        >
          <div className="bg-red-50 dark:bg-red-900/90 border border-red-200 dark:border-red-700 rounded-2xl shadow-xl px-5 py-4 flex items-start gap-3 max-w-md backdrop-blur-sm">
            <div className="w-9 h-9 rounded-xl bg-red-100 dark:bg-red-800 flex items-center justify-center flex-shrink-0 mt-0.5">
              <Monitor size={18} className="text-red-600 dark:text-red-400" />
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-bold text-red-800 dark:text-red-200">
                距离屏幕过近
              </p>
              <p className="text-xs text-red-600 dark:text-red-400 mt-1">
                {estimatedDistanceCm > 0
                  ? `当前约 ${estimatedDistanceCm}cm，建议保持 40cm 以上距离以保护视力`
                  : '请保持 40cm 以上距离以保护视力'}
              </p>
            </div>
            <button
              onClick={() => setDismissedTooClose(true)}
              className="p-1 rounded-lg text-red-400 hover:text-red-600 dark:hover:text-red-300 hover:bg-red-100 dark:hover:bg-red-800 transition-colors flex-shrink-0"
            >
              <X size={14} />
            </button>
          </div>
        </div>,
        portalTarget,
      )}
    </>
  );
};

export default FocusMonitor;
