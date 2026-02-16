import React, { useRef, useEffect } from 'react';
import Artplayer from 'artplayer';
import Hls from 'hls.js';

interface ThumbnailsConfig {
  url: string;
  number: number;
  column: number;
  width?: number;
  height?: number;
}

interface ArtPlayerWrapperProps {
  url: string;
  poster?: string;
  initialSeek?: number;
  thumbnails?: ThumbnailsConfig;
  onProgress?: (currentTime: number, duration: number) => void;
  onReady?: (art: Artplayer) => void;
  onEnded?: () => void;
  className?: string;
  style?: React.CSSProperties;
}

const ArtPlayerWrapper: React.FC<ArtPlayerWrapperProps> = ({
  url,
  poster,
  initialSeek = 0,
  thumbnails,
  onProgress,
  onReady,
  onEnded,
  className = '',
  style,
}) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const artRef = useRef<Artplayer | null>(null);
  const progressTimerRef = useRef<ReturnType<typeof setInterval> | null>(null);

  useEffect(() => {
    if (!containerRef.current || !url) return;

    const isHls = url.includes('.m3u8');

    const art = new Artplayer({
      container: containerRef.current,
      url,
      poster: poster || '',
      volume: 0.7,
      autoSize: false,
      autoMini: false,
      loop: false,
      flip: true,
      playbackRate: true,
      aspectRatio: true,
      setting: true,
      hotkey: true,
      pip: true,
      mutex: true,
      fullscreen: true,
      fullscreenWeb: false,
      miniProgressBar: true,
      backdrop: true,
      theme: '#3b82f6',
      lang: 'zh-cn',
      lock: true,
      fastForward: true,
      autoPlayback: true,
      autoOrientation: true,
      moreVideoAttr: {
        preload: 'metadata',
        crossOrigin: 'anonymous',
      },
      customType: isHls
        ? {
            m3u8: (video: HTMLVideoElement, hlsUrl: string) => {
              if (Hls.isSupported()) {
                const hls = new Hls();
                hls.loadSource(hlsUrl);
                hls.attachMedia(video);
              } else if (video.canPlayType('application/vnd.apple.mpegurl')) {
                video.src = hlsUrl;
              }
            },
          }
        : undefined,
      type: isHls ? 'm3u8' : undefined,
      ...(thumbnails ? {
        thumbnails: {
          url: thumbnails.url,
          number: thumbnails.number,
          column: thumbnails.column,
          width: thumbnails.width || 160,
          height: thumbnails.height || 90,
        },
      } : {}),
    });

    artRef.current = art;

    // 拦截全屏：确保使用原生 Fullscreen API（而非网页全屏）
    art.on('fullscreen', (state: boolean) => {
      if (state) {
        // Artplayer 可能已经请求了全屏，检查是否真正进入了原生全屏
        if (!document.fullscreenElement) {
          // 原生全屏未生效，手动请求容器元素全屏
          const el = containerRef.current;
          if (el?.requestFullscreen) {
            el.requestFullscreen().catch(() => {
              // 原生全屏不可用（如 Chrome 自动测试模式），回退到网页全屏
              art.fullscreenWeb = true;
            });
          }
        }
      }
    });

    // 监听原生全屏退出，同步 Artplayer 状态
    const onFullscreenChange = () => {
      if (!document.fullscreenElement && art.fullscreen) {
        art.fullscreen = false;
      }
    };
    document.addEventListener('fullscreenchange', onFullscreenChange);

    // 初始跳转
    if (initialSeek > 0) {
      art.on('ready', () => {
        art.currentTime = initialSeek;
      });
    }

    // 就绪回调
    art.on('ready', () => {
      onReady?.(art);
    });

    // 结束回调
    art.on('video:ended', () => {
      onEnded?.();
    });

    // 进度定时上报
    if (onProgress) {
      progressTimerRef.current = setInterval(() => {
        if (art.playing && art.duration > 0) {
          onProgress(art.currentTime, art.duration);
        }
      }, 15000);

      // 暂停时也上报一次
      art.on('video:pause', () => {
        if (art.duration > 0) {
          onProgress(art.currentTime, art.duration);
        }
      });
    }

    return () => {
      document.removeEventListener('fullscreenchange', onFullscreenChange);
      if (progressTimerRef.current) {
        clearInterval(progressTimerRef.current);
        progressTimerRef.current = null;
      }
      // 销毁前最后上报一次进度
      if (onProgress && art.duration > 0) {
        onProgress(art.currentTime, art.duration);
      }
      art.destroy(false);
      artRef.current = null;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [url]);

  return (
    <div
      ref={containerRef}
      className={`w-full aspect-video bg-black ${className}`}
      style={style}
    />
  );
};

export default ArtPlayerWrapper;
