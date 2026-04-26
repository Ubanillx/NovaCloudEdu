import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  PenSquare, Search, ThumbsUp, MessageCircle, Star, Clock, TrendingUp,
  Users, Flame, User, X, ChevronRight, MapPin,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { PostResponse, UserPublicResponse } from '../api/generated/models';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 时间格式化
const formatTime = (dateStr?: string) => {
  if (!dateStr) return '';
  const now = new Date();
  const time = new Date(dateStr);
  const diff = now.getTime() - time.getTime();
  const minutes = Math.floor(diff / 60000);
  if (minutes < 1) return '刚刚';
  if (minutes < 60) return `${minutes}分钟前`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours}小时前`;
  const days = Math.floor(hours / 24);
  if (days < 7) return `${days}天前`;
  return `${time.getMonth() + 1}月${time.getDate()}日`;
};

const decodeHtmlEntities = (text: string) => {
  if (typeof document === 'undefined') return text;
  const textarea = document.createElement('textarea');
  textarea.innerHTML = text;
  return textarea.value;
};

const stripPostContent = (content?: string) => {
  if (!content) return '';

  const hasHtmlTags = /<\/?[a-z][\s\S]*>/i.test(content);
  const plainText = hasHtmlTags
    ? decodeHtmlEntities(content.replace(/<style[\s\S]*?<\/style>/gi, ' ')
      .replace(/<script[\s\S]*?<\/script>/gi, ' ')
      .replace(/<[^>]+>/g, ' '))
    : content;

  return plainText
    .replace(/!\[[^\]]*]\([^)]+\)/g, ' ')
    .replace(/\[([^\]]+)]\([^)]+\)/g, '$1')
    .replace(/[#*`>_[\]!()-]/g, '')
    .replace(/\s+/g, ' ')
    .trim();
};

const normalizeTags = (tags?: string[]) => (
  Array.from(new Set((tags || []).map(tag => tag.trim()).filter(Boolean))).slice(0, 3)
);

type PostWithIpRegion = PostResponse & {
  ipLocation?: string;
  ipRegion?: string;
  ipArea?: string;
};

const isPrivateIp = (ip: string) => {
  if (/^(127\.|10\.|192\.168\.)/.test(ip)) return true;

  const match172 = /^172\.(\d{1,3})\./.exec(ip);
  if (match172) {
    const second = Number(match172[1]);
    return second >= 16 && second <= 31;
  }

  return /^(fc|fd)[0-9a-f]{2}:/i.test(ip) || /^fe80:/i.test(ip);
};

const getIpRegionText = (post: PostWithIpRegion) => {
  const region = post.ipLocation || post.ipRegion || post.ipArea;
  if (region) return region;

  const ip = post.ipAddress?.trim();
  if (!ip) return '';
  if (ip === '::1' || ip === '0:0:0:0:0:0:0:1' || ip === '127.0.0.1' || ip === 'localhost') {
    return '本机';
  }
  if (isPrivateIp(ip)) return '内网';
  return '未知地区';
};

// 用户头像组件
const UserAvatar: React.FC<{ user?: UserPublicResponse | null; size?: 'sm' | 'md' | 'lg' }> = ({ user, size = 'sm' }) => {
  const sizeMap = {
    sm: 'w-8 h-8',
    md: 'w-10 h-10',
    lg: 'w-12 h-12'
  };
  const sizeClass = sizeMap[size];
  const iconSize = size === 'sm' ? 14 : size === 'md' ? 18 : 22;
  
  if (user?.userAvatar) {
    return <img src={user.userAvatar} alt="" className={`${sizeClass} rounded-xl object-cover ring-2 ring-white dark:ring-gray-800 shadow-sm`} />;
  }
  return (
    <div className={`${sizeClass} rounded-xl bg-gradient-to-br from-brand-100 to-brand-50 dark:from-brand-900/40 dark:to-brand-800/20 text-brand-600 dark:text-brand-400 flex items-center justify-center shadow-inner`}>
      <User size={iconSize} />
    </div>
  );
};

// Tab 配置
const TABS = [
  { key: 'recommend', label: '推荐', icon: Flame },
  { key: 'following', label: '关注', icon: Users },
  { key: 'top', label: '热榜', icon: TrendingUp },
] as const;

type TabKey = typeof TABS[number]['key'];

// 热榜时间筛选
const TOP_DAYS_OPTIONS = [
  { label: '24小时', days: 1 },
  { label: '7天', days: 7 },
  { label: '30天', days: 30 },
  { label: '全部', days: 0 },
];

const CirclePage: React.FC = () => {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState<TabKey>('recommend');

  // 搜索
  const [showSearch, setShowSearch] = useState(false);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [searchResults, setSearchResults] = useState<PostResponse[]>([]);
  const [isSearching, setIsSearching] = useState(false);
  const [searchTotal, setSearchTotal] = useState(0);
  const searchInputRef = useRef<HTMLInputElement>(null);

  // 推荐帖子
  const [posts, setPosts] = useState<PostResponse[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const [hasMore, setHasMore] = useState(true);
  const [isLoadingMore, setIsLoadingMore] = useState(false);

  // 关注帖子
  const [followingPosts, setFollowingPosts] = useState<PostResponse[]>([]);
  const [isLoadingFollowing, setIsLoadingFollowing] = useState(false);
  const [followingPage, setFollowingPage] = useState(1);
  const [hasMoreFollowing, setHasMoreFollowing] = useState(true);
  const [isLoadingMoreFollowing, setIsLoadingMoreFollowing] = useState(false);
  const [followingLoaded, setFollowingLoaded] = useState(false);

  // 热榜帖子
  const [topPosts, setTopPosts] = useState<PostResponse[]>([]);
  const [isLoadingTop, setIsLoadingTop] = useState(false);
  const [topPage, setTopPage] = useState(1);
  const [hasMoreTop, setHasMoreTop] = useState(true);
  const [isLoadingMoreTop, setIsLoadingMoreTop] = useState(false);
  const [topDays, setTopDays] = useState(7);
  const [topLoaded, setTopLoaded] = useState(false);

  // 侧边栏热榜（独立加载）
  const [sidebarTopPosts, setSidebarTopPosts] = useState<PostResponse[]>([]);
  const [isLoadingSidebarTop, setIsLoadingSidebarTop] = useState(false);
  const sidebarTopLoaded = useRef(false);

  // 点赞/收藏状态
  const [thumbStatus, setThumbStatus] = useState<Record<number, boolean>>({});
  const [favourStatus, setFavourStatus] = useState<Record<number, boolean>>({});

  // 用户信息缓存
  const [userInfoCache, setUserInfoCache] = useState<Record<number, UserPublicResponse>>({});
  const loadingUsers = useRef<Set<number>>(new Set());

  const loadUserInfo = useCallback(async (userId: number) => {
    if (loadingUsers.current.has(userId)) return;
    loadingUsers.current.add(userId);
    try {
      const res = await api.getUserPublicInfo({ id: userId });
      if (res.data?.code === 0 && res.data.data) {
        setUserInfoCache(prev => ({ ...prev, [userId]: res.data.data! }));
      }
    } catch { /* silent */ }
  }, []);

  // ==================== 推荐帖子 ====================
  const loadPosts = useCallback(async () => {
    setIsLoading(true);
    try {
      const res = await api.getPostList({ pageNum: 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        const list = res.data.data.posts || [];
        setPosts(list);
        setCurrentPage(1);
        setHasMore(list.length < (res.data.data.total || 0));
      }
    } catch {
      toast.error('加载帖子失败');
    } finally {
      setIsLoading(false);
    }
  }, []);

  const loadMorePosts = useCallback(async () => {
    if (isLoadingMore || !hasMore) return;
    setIsLoadingMore(true);
    try {
      const res = await api.getPostList({ pageNum: currentPage + 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        const newPosts = res.data.data.posts || [];
        setPosts(prev => [...prev, ...newPosts]);
        setCurrentPage(prev => prev + 1);
        setHasMore(posts.length + newPosts.length < (res.data.data.total || 0));
      }
    } catch { /* silent */ }
    finally { setIsLoadingMore(false); }
  }, [isLoadingMore, hasMore, currentPage, posts.length]);

  // ==================== 关注帖子 ====================
  const loadFollowingPosts = useCallback(async () => {
    setIsLoadingFollowing(true);
    try {
      const res = await api.getFollowingPosts({ pageNum: 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        const list = res.data.data.posts || [];
        setFollowingPosts(list);
        setFollowingPage(1);
        setHasMoreFollowing(list.length < (res.data.data.total || 0));
        setFollowingLoaded(true);
      }
    } catch {
      toast.error('加载关注帖子失败');
    } finally {
      setIsLoadingFollowing(false);
    }
  }, []);

  const loadMoreFollowingPosts = useCallback(async () => {
    if (isLoadingMoreFollowing || !hasMoreFollowing) return;
    setIsLoadingMoreFollowing(true);
    try {
      const res = await api.getFollowingPosts({ pageNum: followingPage + 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        const newPosts = res.data.data.posts || [];
        setFollowingPosts(prev => [...prev, ...newPosts]);
        setFollowingPage(prev => prev + 1);
        setHasMoreFollowing(followingPosts.length + newPosts.length < (res.data.data.total || 0));
      }
    } catch { /* silent */ }
    finally { setIsLoadingMoreFollowing(false); }
  }, [isLoadingMoreFollowing, hasMoreFollowing, followingPage, followingPosts.length]);

  // ==================== 热榜帖子 ====================
  const loadTopPosts = useCallback(async (days: number) => {
    setIsLoadingTop(true);
    try {
      const res = await api.getTopPostsByDays({ days: days === 0 ? undefined : days, pageNum: 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        const list = res.data.data.posts || [];
        setTopPosts(list);
        setTopPage(1);
        setHasMoreTop(list.length < (res.data.data.total || 0));
        setTopLoaded(true);
      }
    } catch {
      toast.error('加载热榜失败');
    } finally {
      setIsLoadingTop(false);
    }
  }, []);

  const loadMoreTopPosts = useCallback(async () => {
    if (isLoadingMoreTop || !hasMoreTop) return;
    setIsLoadingMoreTop(true);
    try {
      const res = await api.getTopPostsByDays({ days: topDays === 0 ? undefined : topDays, pageNum: topPage + 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        const newPosts = res.data.data.posts || [];
        setTopPosts(prev => [...prev, ...newPosts]);
        setTopPage(prev => prev + 1);
        setHasMoreTop(topPosts.length + newPosts.length < (res.data.data.total || 0));
      }
    } catch { /* silent */ }
    finally { setIsLoadingMoreTop(false); }
  }, [isLoadingMoreTop, hasMoreTop, topPage, topDays, topPosts.length]);

  // ==================== 搜索 ====================
  const handleSearch = useCallback(async () => {
    const keyword = searchKeyword.trim();
    if (!keyword) return;
    setIsSearching(true);
    try {
      const res = await api.searchPosts1({ keyword, pageNum: 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        setSearchResults(res.data.data.posts || []);
        setSearchTotal(res.data.data.total || 0);
      }
    } catch {
      toast.error('搜索失败');
    } finally {
      setIsSearching(false);
    }
  }, [searchKeyword]);

  // 更新帖子列表中的计数
  const updatePostField = useCallback((postId: number, field: 'thumbNum' | 'favourNum', delta: number) => {
    const updater = (list: PostResponse[]) =>
      list.map(p => p.id === postId ? { ...p, [field]: Math.max(0, (p[field] || 0) + delta) } : p);
    setPosts(updater);
    setFollowingPosts(updater);
    setTopPosts(updater);
    setSearchResults(updater);
  }, []);

  // ==================== 互动 ====================
  const handleToggleThumb = useCallback(async (postId: number) => {
    try {
      const res = await api.toggleThumb({ postId });
      if (res.data?.code === 0) {
        const liked = res.data.data ?? false;
        setThumbStatus(prev => ({ ...prev, [postId]: liked }));
        updatePostField(postId, 'thumbNum', liked ? 1 : -1);
        toast.success(liked ? '已点赞' : '已取消点赞');
      }
    } catch {
      toast.error('操作失败');
    }
  }, [updatePostField]);

  const handleToggleFavour = useCallback(async (postId: number) => {
    try {
      const res = await api.toggleFavour({ postId });
      if (res.data?.code === 0) {
        const collected = res.data.data ?? false;
        setFavourStatus(prev => ({ ...prev, [postId]: collected }));
        updatePostField(postId, 'favourNum', collected ? 1 : -1);
        toast.success(collected ? '已收藏' : '已取消收藏');
      }
    } catch {
      toast.error('操作失败');
    }
  }, [updatePostField]);

  // 侧边栏热榜独立加载
  const loadSidebarTopPosts = useCallback(async () => {
    if (sidebarTopLoaded.current) return;
    setIsLoadingSidebarTop(true);
    try {
      const res = await api.getTopPostsByDays({ days: 7, pageNum: 1, pageSize: 5 });
      if (res.data?.code === 0 && res.data.data) {
        setSidebarTopPosts(res.data.data.posts || []);
        sidebarTopLoaded.current = true;
      }
    } catch { /* silent */ }
    finally { setIsLoadingSidebarTop(false); }
  }, []);

  // ==================== Effects ====================
  useEffect(() => {
    loadPosts();
    loadSidebarTopPosts();
  }, [loadPosts, loadSidebarTopPosts]);

  useEffect(() => {
    if (activeTab === 'following' && !followingLoaded && !isLoadingFollowing) {
      loadFollowingPosts();
    }
    if (activeTab === 'top' && !topLoaded && !isLoadingTop) {
      loadTopPosts(topDays);
    }
  }, [activeTab, followingLoaded, isLoadingFollowing, loadFollowingPosts, topLoaded, isLoadingTop, loadTopPosts, topDays]);

  useEffect(() => {
    if (showSearch && searchInputRef.current) {
      searchInputRef.current.focus();
    }
  }, [showSearch]);

  // 滚动加载
  const handleScroll = useCallback((e: React.UIEvent<HTMLDivElement>) => {
    const el = e.currentTarget;
    if (el.scrollHeight - el.scrollTop - el.clientHeight < 300) {
      if (activeTab === 'recommend') loadMorePosts();
      else if (activeTab === 'following') loadMoreFollowingPosts();
      else if (activeTab === 'top') loadMoreTopPosts();
    }
  }, [activeTab, loadMorePosts, loadMoreFollowingPosts, loadMoreTopPosts]);

  const changeTopDays = (days: number) => {
    if (topDays !== days) {
      setTopDays(days);
      loadTopPosts(days);
    }
  };

  // ==================== 渲染帖子卡片 ====================
  const renderPostCard = (post: PostResponse) => {
    const userId = post.userId;
    const user = userId ? userInfoCache[userId] : undefined;
    if (userId && !userInfoCache[userId] && !loadingUsers.current.has(userId)) {
      loadUserInfo(userId);
    }
    const hasThumb = thumbStatus[post.id!] ?? false;
    const hasFavour = favourStatus[post.id!] ?? false;
    const excerpt = stripPostContent(post.content).slice(0, 200);
    const tags = normalizeTags(post.tags);
    const ipRegionText = getIpRegionText(post);

    return (
      <div
        key={post.id}
        className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4 hover:shadow-lg dark:hover:shadow-brand-900/10 transition-all duration-300 cursor-pointer group relative overflow-hidden"
        onClick={() => navigate(`/circle/post/${post.id}`)}
      >
        <div className="absolute top-0 right-0 w-20 h-20 bg-brand-500/5 rounded-full -mr-10 -mt-10 group-hover:scale-150 transition-transform duration-700" />
        
        {/* 用户信息 */}
        <div className="flex items-center gap-3 mb-3">
          <UserAvatar user={user} size="sm" />
          <div className="flex-1 min-w-0">
            <p className="text-sm font-bold text-gray-900 dark:text-white truncate group-hover:text-brand-600 transition-colors">
              {user?.userName || `用户${post.userId || ''}`}
            </p>
            <div className="flex items-center gap-2 mt-0.5">
              <span className="text-[11px] font-medium text-gray-400 dark:text-gray-500 flex items-center gap-1">
                <Clock size={11} />
                {formatTime(post.createTime)}
              </span>
              {ipRegionText && (
                <span
                  className="inline-flex items-center gap-0.5 text-[10px] text-gray-400 dark:text-gray-500 font-medium"
                  title={post.ipAddress ? `IP: ${post.ipAddress}` : undefined}
                >
                  <MapPin size={10} />
                  IP属地：{ipRegionText}
                </span>
              )}
            </div>
          </div>
        </div>

        {/* 标题 */}
        <h3 className="text-base font-bold text-gray-900 dark:text-white leading-snug mb-2 line-clamp-2 tracking-tight group-hover:translate-x-0.5 transition-transform">
          {post.title}
        </h3>

        {/* 内容摘要 */}
        {excerpt && (
          <p className="text-sm text-gray-500 dark:text-gray-400 leading-6 line-clamp-3 mb-3 font-medium">
            {excerpt}
          </p>
        )}

        {/* 标签 */}
        {tags.length > 0 && (
          <div className="flex flex-wrap gap-2 mb-4">
            {tags.map(tag => (
              <span
                key={tag}
                className="inline-flex h-6 max-w-full items-center gap-0.5 rounded-full border border-brand-100/70 bg-brand-50/70 px-2.5 text-[11px] font-semibold text-brand-700 shadow-[inset_0_1px_0_rgba(255,255,255,0.55)] transition-colors hover:border-brand-200 hover:bg-brand-100/80 dark:border-brand-800/50 dark:bg-brand-950/30 dark:text-brand-300 dark:hover:bg-brand-900/40"
                title={`#${tag}`}
                onClick={(e) => {
                  e.stopPropagation();
                  setSearchKeyword(`#${tag}`);
                  setShowSearch(true);
                }}
              >
                <span className="text-brand-400 dark:text-brand-500">#</span>
                <span className="truncate">{tag}</span>
              </span>
            ))}
          </div>
        )}

        {/* 互动栏 */}
        <div className="flex items-center justify-between pt-3 border-t border-gray-50 dark:border-gray-800/50">
          <div className="flex items-center gap-4">
            <button
              className={`flex items-center gap-1.5 text-xs font-bold transition-all active:scale-90 ${hasThumb ? 'text-brand-600 dark:text-brand-400' : 'text-gray-400 dark:text-gray-500 hover:text-brand-600'}`}
              onClick={(e) => { e.stopPropagation(); handleToggleThumb(post.id!); }}
            >
              <div className={`p-1.5 rounded-lg transition-colors ${hasThumb ? 'bg-brand-50 dark:bg-brand-900/20' : 'bg-gray-50 dark:bg-gray-800/50 group-hover:bg-brand-50'}`}>
                <ThumbsUp size={14} fill={hasThumb ? 'currentColor' : 'none'} />
              </div>
              <span>{post.thumbNum || 0}</span>
            </button>
            <button
              className="flex items-center gap-1.5 text-xs font-bold text-gray-400 dark:text-gray-500 hover:text-brand-600 transition-all active:scale-90"
              onClick={(e) => { e.stopPropagation(); navigate(`/circle/post/${post.id}`); }}
            >
              <div className="p-1.5 rounded-lg bg-gray-50 dark:bg-gray-800/50 group-hover:bg-brand-50 transition-colors">
                <MessageCircle size={14} />
              </div>
              <span>{post.commentNum || 0}</span>
            </button>
            <button
              className={`flex items-center gap-1.5 text-xs font-bold transition-all active:scale-90 ${hasFavour ? 'text-amber-500' : 'text-gray-400 dark:text-gray-500 hover:text-amber-500'}`}
              onClick={(e) => { e.stopPropagation(); handleToggleFavour(post.id!); }}
            >
              <div className={`p-1.5 rounded-lg transition-colors ${hasFavour ? 'bg-amber-50 dark:bg-amber-900/20' : 'bg-gray-50 dark:bg-gray-800/50 group-hover:bg-amber-50'}`}>
                <Star size={14} fill={hasFavour ? 'currentColor' : 'none'} />
              </div>
              <span>{post.favourNum || 0}</span>
            </button>
          </div>
          <button 
            className="p-1.5 rounded-lg bg-gray-50 dark:bg-gray-800/50 text-gray-400 hover:bg-brand-50 hover:text-brand-600 transition-all"
            onClick={(e) => { e.stopPropagation(); navigate(`/circle/post/${post.id}`); }}
          >
            <ChevronRight size={14} />
          </button>
        </div>
      </div>
    );
  };

  // ==================== 渲染热榜卡片 ====================
  const renderTopPostCard = (post: PostResponse, rank: number) => {
    const rankColors = rank <= 3
      ? ['bg-gradient-to-br from-rose-500 to-rose-600 text-white shadow-lg shadow-rose-500/20', 
         'bg-gradient-to-br from-orange-400 to-orange-500 text-white shadow-lg shadow-orange-400/20', 
         'bg-gradient-to-br from-amber-400 to-amber-500 text-white shadow-lg shadow-amber-400/20'][rank - 1]
      : 'bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400';

    return (
      <div
        key={post.id}
        className="flex items-center gap-3 bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-3 hover:shadow-md hover:translate-x-0.5 transition-all duration-300 cursor-pointer group"
        onClick={() => navigate(`/circle/post/${post.id}`)}
      >
        <div className={`w-8 h-8 rounded-lg flex items-center justify-center text-sm font-black flex-shrink-0 ${rankColors}`}>
          {rank}
        </div>
        <div className="flex-1 min-w-0">
          <h4 className="text-sm font-bold text-gray-900 dark:text-white leading-snug line-clamp-2 group-hover:text-brand-600 transition-colors">
            {post.title}
          </h4>
          <div className="flex items-center gap-3 mt-1.5 text-[11px] text-gray-400 dark:text-gray-500 font-medium">
            <span className="flex items-center gap-1 text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 px-1.5 py-0.5 rounded">
              <ThumbsUp size={10} /> {post.thumbNum || 0}
            </span>
            <span className="flex items-center gap-1">
              <MessageCircle size={10} /> {post.commentNum || 0}
            </span>
            <span>{formatTime(post.createTime)}</span>
          </div>
        </div>
        <ChevronRight size={14} className="text-gray-300 group-hover:text-brand-400 transition-colors" />
      </div>
    );
  };

  // ==================== 骨架屏 ====================
  const renderSkeleton = (count: number) => (
    <div className="space-y-3">
      {Array.from({ length: count }).map((_, i) => (
        <div key={i} className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 p-4 animate-pulse">
          <div className="flex items-center gap-2.5 mb-2.5">
            <div className="w-8 h-8 rounded-lg bg-gray-200 dark:bg-gray-700" />
            <div className="flex-1">
              <div className="h-3.5 bg-gray-200 dark:bg-gray-700 rounded w-20 mb-1" />
              <div className="h-2.5 bg-gray-100 dark:bg-gray-800 rounded w-14" />
            </div>
          </div>
          <div className="h-4 bg-gray-200 dark:bg-gray-700 rounded w-3/4 mb-1.5" />
          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-full mb-1" />
          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-2/3" />
        </div>
      ))}
    </div>
  );

  // ==================== 空状态 ====================
  const renderEmpty = (message: string, actionText?: string, onAction?: () => void) => (
    <div className="flex flex-col items-center justify-center py-14 text-center">
      <div className="w-14 h-14 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center mb-3">
        <MessageCircle size={24} className="text-gray-300 dark:text-gray-600" />
      </div>
      <p className="text-sm text-gray-500 dark:text-gray-400 mb-3">{message}</p>
      {actionText && onAction && (
        <button
          onClick={onAction}
          className="px-5 py-2 bg-brand-500 hover:bg-brand-600 text-white text-sm font-medium rounded-full transition-colors"
        >
          {actionText}
        </button>
      )}
    </div>
  );

  // ==================== 主渲染 ====================
  return (
    <div className="max-w-6xl mx-auto animate-in fade-in duration-500 pb-8">
      {/* 头部 */}
      <div className="flex items-center justify-between mb-5 px-4 sm:px-0">
        <h1 className="text-xl font-bold text-gray-900 dark:text-white tracking-tight flex items-center gap-2">
          <Users size={20} className="text-gray-900 dark:text-white" />
          探索圈子
        </h1>
        <div className="flex items-center gap-2">
          <button
            onClick={() => setShowSearch(!showSearch)}
            className="p-2 rounded-lg text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-brand-600 dark:hover:text-brand-400 transition-all active:scale-95"
          >
            <Search size={18} />
          </button>
          <button
            onClick={() => navigate('/circle/edit')}
            className="flex items-center gap-1.5 px-4 py-2 text-sm bg-brand-600 hover:bg-brand-500 text-white font-semibold rounded-lg transition-all shadow-md shadow-brand-600/20 active:scale-95"
          >
            <PenSquare size={14} />
            发布动态
          </button>
        </div>
      </div>

      {/* 搜索栏 */}
      {showSearch && (
        <div className="mb-5 px-4 sm:px-0 animate-in slide-in-from-top duration-300">
          <div className="relative flex items-center bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 p-1.5 shadow-lg">
            <Search size={16} className="ml-3 text-gray-400" />
            <input
              ref={searchInputRef}
              type="text"
              value={searchKeyword}
              onChange={e => setSearchKeyword(e.target.value)}
              onKeyDown={e => e.key === 'Enter' && !e.nativeEvent.isComposing && handleSearch()}
              placeholder="搜索感兴趣的话题..."
              className="flex-1 bg-transparent border-none outline-none px-3 py-2 text-sm text-gray-900 dark:text-white placeholder-gray-400"
            />
            {searchKeyword && (
              <button onClick={() => { setSearchKeyword(''); setSearchResults([]); }} className="p-1.5 mr-1 text-gray-400 hover:text-gray-600 transition-colors">
                <X size={16} />
              </button>
            )}
            <button
              onClick={handleSearch}
              className="px-5 py-2 text-sm bg-brand-600 hover:bg-brand-500 text-white font-bold rounded-lg transition-all shadow-sm active:scale-95"
            >
              搜索
            </button>
          </div>
          {/* 搜索结果 */}
          {(searchResults.length > 0 || isSearching) && (
            <div className="mt-4">
              <p className="text-xs font-medium text-gray-500 dark:text-gray-400 mb-3 ml-1">
                {isSearching ? '正在为您检索相关内容...' : `找到 ${searchTotal} 条相关结果`}
              </p>
              {isSearching ? renderSkeleton(3) : (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {searchResults.map(post => renderPostCard(post))}
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {/* Tab 切换 */}
      <div className="flex items-center gap-2 mb-5 px-4 sm:px-0 overflow-x-auto no-scrollbar py-0.5">
        {TABS.map(tab => {
          const Icon = tab.icon;
          const isActive = activeTab === tab.key;
          return (
            <button
              key={tab.key}
              onClick={() => setActiveTab(tab.key)}
              className={`flex items-center gap-1.5 px-4 py-1.5 rounded-lg text-xs font-bold transition-all duration-300 flex-shrink-0 ${
                isActive
                  ? 'bg-brand-600 text-white'
                  : 'bg-white dark:bg-gray-900 border border-gray-100 dark:border-gray-800 text-gray-500 dark:text-gray-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 hover:text-brand-600 dark:hover:text-brand-400'
              }`}
            >
              <Icon size={14} strokeWidth={isActive ? 2.5 : 2} />
              {tab.label}
            </button>
          );
        })}
      </div>

      {/* 内容区 - 响应式布局 */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-5 px-4 sm:px-0">
        <div className="lg:col-span-8" onScroll={handleScroll}>
          <div className="custom-scrollbar overflow-y-auto" style={{ maxHeight: 'calc(100vh - 180px)' }}>
            {/* 推荐/关注 */}
            {(activeTab === 'recommend' || activeTab === 'following') && (
              <>
                {activeTab === 'recommend' ? (
                  isLoading ? renderSkeleton(5) : posts.length === 0 ? (
                    renderEmpty('社区空荡荡的，快来分享第一条动态吧', '立即发布', () => navigate('/circle/edit'))
                  ) : (
                    <div className="space-y-4">
                      {posts.map(post => renderPostCard(post))}
                      {isLoadingMore && (
                        <div className="py-5 text-center">
                          <div className="inline-block w-5 h-5 border-2 border-brand-500 border-t-transparent rounded-full animate-spin" />
                          <p className="mt-1.5 text-xs text-gray-400">加载更多...</p>
                        </div>
                      )}
                      {!hasMore && posts.length > 0 && (
                        <div className="py-5 text-center text-xs font-medium text-gray-400">— 已经到底啦 —</div>
                      )}
                    </div>
                  )
                ) : (
                  (isLoadingFollowing && !followingLoaded) ? renderSkeleton(5) : followingPosts.length === 0 && followingLoaded ? (
                    renderEmpty('关注更多有趣的人，发现不一样的世界', '去发现', () => setActiveTab('recommend'))
                  ) : (
                    <div className="space-y-4">
                      {followingPosts.map(post => renderPostCard(post))}
                      {isLoadingMoreFollowing && (
                        <div className="py-5 text-center text-xs text-gray-400">加载中...</div>
                      )}
                      {!hasMoreFollowing && followingPosts.length > 0 && (
                        <div className="py-5 text-center text-xs text-gray-400">— 已显示全部关注动态 —</div>
                      )}
                    </div>
                  )
                )}
              </>
            )}

            {/* 热榜 - 在主栏也显示，如果是大屏可以有不同展示 */}
            {activeTab === 'top' && (
              <>
                <div className="flex items-center gap-2 mb-4 flex-wrap">
                  {TOP_DAYS_OPTIONS.map(opt => (
                    <button
                      key={opt.days}
                      onClick={() => changeTopDays(opt.days)}
                      className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-all ${
                        topDays === opt.days
                          ? 'bg-brand-600 text-white shadow-sm'
                          : 'bg-white dark:bg-gray-900 border border-gray-100 dark:border-gray-800 text-gray-500 dark:text-gray-400 hover:bg-brand-50'
                      }`}
                    >
                      {opt.label}
                    </button>
                  ))}
                </div>
                {(isLoadingTop && !topLoaded) ? renderSkeleton(5) : topPosts.length === 0 && topLoaded ? (
                  renderEmpty('暂无热门内容')
                ) : (
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-1 gap-3">
                    {topPosts.map((post, idx) => renderTopPostCard(post, idx + 1))}
                  </div>
                )}
                {hasMoreTop && (
                  <div className="mt-4 text-center">
                    <button 
                      onClick={loadMoreTopPosts}
                      disabled={isLoadingMoreTop}
                      className="px-5 py-2 text-xs bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 text-brand-600 font-bold rounded-lg hover:bg-brand-50 transition-all active:scale-95"
                    >
                      {isLoadingMoreTop ? '加载中...' : '加载更多热门动态'}
                    </button>
                  </div>
                )}
              </>
            )}
          </div>
        </div>

        {/* 右侧边栏 - 仅在大屏显示 */}
        <div className="hidden lg:block lg:col-span-4 space-y-5">
          {/* 热榜预览 */}
          {activeTab !== 'top' && (
            <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 p-4 shadow-sm">
              <div className="flex items-center justify-between mb-4">
                <h3 className="text-sm font-bold text-gray-900 dark:text-white flex items-center gap-1.5">
                  <TrendingUp size={14} className="text-rose-500" />
                  当前热榜
                </h3>
                <button 
                  onClick={() => setActiveTab('top')}
                  className="text-brand-600 hover:text-brand-700 text-[11px] font-bold flex items-center gap-0.5"
                >
                  查看全部 <ChevronRight size={12} />
                </button>
              </div>
              <div className="space-y-3">
                {isLoadingSidebarTop ? (
                  Array.from({ length: 5 }).map((_, i) => (
                    <div key={i} className="flex gap-2.5 animate-pulse">
                      <div className="w-5 h-5 rounded bg-gray-100 dark:bg-gray-800" />
                      <div className="flex-1 space-y-1.5">
                        <div className="h-3.5 bg-gray-100 dark:bg-gray-800 rounded w-full" />
                        <div className="h-2.5 bg-gray-50 dark:bg-gray-900 rounded w-1/2" />
                      </div>
                    </div>
                  ))
                ) : (
                  sidebarTopPosts.map((post, idx) => (
                    <div 
                      key={post.id} 
                      className="flex items-start gap-2.5 cursor-pointer group"
                      onClick={() => navigate(`/circle/post/${post.id}`)}
                    >
                      <span className={`text-xs font-black w-4 mt-0.5 ${idx < 3 ? 'text-rose-500' : 'text-gray-400'}`}>
                        {idx + 1}
                      </span>
                      <p className="text-xs font-semibold text-gray-700 dark:text-gray-300 line-clamp-2 leading-snug group-hover:text-brand-600 transition-colors">
                        {post.title}
                      </p>
                    </div>
                  ))
                )}
              </div>
            </div>
          )}

        </div>
      </div>
    </div>
  );
};

export default CirclePage;
