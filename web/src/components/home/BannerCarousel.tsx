import React, { useState, useEffect, useCallback, useRef } from 'react';
import { ChevronLeft, ChevronRight, Image as ImageIcon } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { BannerListResponse } from '../../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

interface BannerCarouselProps {
  autoPlayInterval?: number;
}

export const BannerCarousel: React.FC<BannerCarouselProps> = ({ autoPlayInterval = 4000 }) => {
  const [banners, setBanners] = useState<BannerListResponse[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [loading, setLoading] = useState(true);
  const [isHovered, setIsHovered] = useState(false);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const navigate = useNavigate();

  const fetchBanners = useCallback(async () => {
    setLoading(true);
    try {
      const response = await api.getBannerList();
      if (response.data.code === 0 && response.data.data) {
        setBanners(response.data.data);
      }
    } catch {
      // 静默处理，轮播图加载失败不影响主页
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchBanners();
  }, [fetchBanners]);

  // 自动轮播
  useEffect(() => {
    if (banners.length <= 1 || isHovered) {
      if (timerRef.current) clearInterval(timerRef.current);
      return;
    }

    timerRef.current = setInterval(() => {
      setCurrentIndex((prev) => (prev + 1) % banners.length);
    }, autoPlayInterval);

    return () => {
      if (timerRef.current) clearInterval(timerRef.current);
    };
  }, [banners.length, autoPlayInterval, isHovered]);

  const goTo = (index: number) => {
    setCurrentIndex(index);
  };

  const goPrev = () => {
    setCurrentIndex((prev) => (prev - 1 + banners.length) % banners.length);
  };

  const goNext = () => {
    setCurrentIndex((prev) => (prev + 1) % banners.length);
  };

  const handleBannerClick = (banner: BannerListResponse) => {
    if (banner.linkType === 1 && banner.linkUrl) {
      navigate(banner.linkUrl);
    } else if (banner.linkType === 2 && banner.linkUrl) {
      window.open(banner.linkUrl, '_blank', 'noopener,noreferrer');
    }
  };

  if (loading) {
    return (
      <div className="relative rounded-2xl overflow-hidden bg-gray-100 dark:bg-gray-800 aspect-[2.5/1] animate-pulse">
        <div className="absolute inset-0 flex items-center justify-center">
          <ImageIcon size={48} className="text-gray-300 dark:text-gray-600" />
        </div>
      </div>
    );
  }

  if (banners.length === 0) {
    return null;
  }

  return (
    <div
      className="relative rounded-2xl overflow-hidden group shadow-lg"
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      {/* 轮播内容 */}
      <div className="relative aspect-[2.5/1] overflow-hidden">
        {banners.map((banner, index) => (
          <div
            key={banner.id}
            className={`absolute inset-0 transition-all duration-700 ease-in-out ${
              index === currentIndex
                ? 'opacity-100 scale-100 z-10'
                : 'opacity-0 scale-105 z-0'
            } ${banner.linkType && banner.linkType > 0 ? 'cursor-pointer' : ''}`}
            onClick={() => handleBannerClick(banner)}
          >
            <img
              src={banner.imageUrl}
              alt={banner.title || ''}
              className="w-full h-full object-cover"
            />
            {/* 底部渐变遮罩 + 标题 */}
            {banner.title && (
              <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/60 via-black/20 to-transparent px-6 pb-4 pt-12">
                <h3 className="text-white text-lg md:text-xl font-bold drop-shadow-lg">
                  {banner.title}
                </h3>
              </div>
            )}
          </div>
        ))}
      </div>

      {/* 左右箭头 */}
      {banners.length > 1 && (
        <>
          <button
            onClick={(e) => { e.stopPropagation(); goPrev(); }}
            className="absolute left-3 top-1/2 -translate-y-1/2 z-20 p-2 rounded-full bg-white/80 dark:bg-gray-900/80 text-gray-700 dark:text-gray-200 shadow-lg backdrop-blur-sm transition-all duration-300 hover:bg-white dark:hover:bg-gray-800 hover:scale-110 active:scale-95"
            aria-label="上一张"
          >
            <ChevronLeft size={20} />
          </button>
          <button
            onClick={(e) => { e.stopPropagation(); goNext(); }}
            className="absolute right-3 top-1/2 -translate-y-1/2 z-20 p-2 rounded-full bg-white/80 dark:bg-gray-900/80 text-gray-700 dark:text-gray-200 shadow-lg backdrop-blur-sm transition-all duration-300 hover:bg-white dark:hover:bg-gray-800 hover:scale-110 active:scale-95"
            aria-label="下一张"
          >
            <ChevronRight size={20} />
          </button>
        </>
      )}

      {/* 指示器 */}
      {banners.length > 1 && (
        <div className="absolute bottom-3 left-1/2 -translate-x-1/2 z-20 flex items-center gap-2">
          {banners.map((_, index) => (
            <button
              key={index}
              onClick={(e) => { e.stopPropagation(); goTo(index); }}
              className={`rounded-full transition-all duration-300 ${
                index === currentIndex
                  ? 'w-6 h-2 bg-white shadow-lg'
                  : 'w-2 h-2 bg-white/50 hover:bg-white/80'
              }`}
              aria-label={`切换到第 ${index + 1} 张`}
            />
          ))}
        </div>
      )}
    </div>
  );
};
