import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import DOMPurify from 'dompurify';
import {
  ArrowLeft, ThumbsUp, Star, MessageCircle, Send,
  Edit3, Trash2, Clock, User, X, TrendingUp,
  Loader2,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { PostDetailResponse, CommentResponse, UserPublicResponse } from '../api/generated/models';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const getIdKey = (id?: number | string | null) => (id == null ? '' : String(id));

const renderInlineMarkdown = (text: string) => {
  return text
    .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
    .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
    .replace(/\*(.+?)\*/g, '<em>$1</em>')
    .replace(/`(.+?)`/g, '<code>$1</code>')
    .replace(/!\[(.*?)\]\((.+?)\)/g, '<img src="$2" alt="$1" />')
    .replace(/\[(.+?)\]\((.+?)\)/g, '<a href="$2" target="_blank" rel="noopener noreferrer">$1</a>');
};

const renderMarkdown = (md: string) => {
  const lines = md.split(/\r?\n/);
  const html: string[] = [];
  let listType: 'ul' | 'ol' | null = null;

  const closeList = () => {
    if (listType) {
      html.push(`</${listType}>`);
      listType = null;
    }
  };

  lines.forEach(line => {
    const trimmed = line.trim();
    const unorderedMatch = /^[-*]\s+(.+)$/.exec(trimmed);
    const orderedMatch = /^\d+\.\s+(.+)$/.exec(trimmed);

    if (!trimmed) {
      closeList();
      return;
    }
    if (orderedMatch) {
      if (listType !== 'ol') {
        closeList();
        html.push('<ol>');
        listType = 'ol';
      }
      html.push(`<li>${renderInlineMarkdown(orderedMatch[1])}</li>`);
      return;
    }
    if (unorderedMatch) {
      if (listType !== 'ul') {
        closeList();
        html.push('<ul>');
        listType = 'ul';
      }
      html.push(`<li>${renderInlineMarkdown(unorderedMatch[1])}</li>`);
      return;
    }

    closeList();
    if (trimmed.startsWith('### ')) html.push(`<h3>${renderInlineMarkdown(trimmed.slice(4))}</h3>`);
    else if (trimmed.startsWith('## ')) html.push(`<h2>${renderInlineMarkdown(trimmed.slice(3))}</h2>`);
    else if (trimmed.startsWith('# ')) html.push(`<h1>${renderInlineMarkdown(trimmed.slice(2))}</h1>`);
    else if (trimmed.startsWith('> ')) html.push(`<blockquote>${renderInlineMarkdown(trimmed.slice(2))}</blockquote>`);
    else html.push(`<p>${renderInlineMarkdown(trimmed)}</p>`);
  });

  closeList();
  return html.join('');
};

const renderPostContent = (content: string) => {
  const hasHtmlTags = /<\/?[a-z][\s\S]*>/i.test(content);
  const html = hasHtmlTags ? content : renderMarkdown(content);
  return DOMPurify.sanitize(html, {
    ADD_ATTR: ['target'],
  });
};

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

const UserAvatar: React.FC<{ user?: UserPublicResponse | null; size?: 'sm' | 'md' | 'lg' }> = ({ user, size = 'md' }) => {
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

const PostDetailPage: React.FC = () => {
  const { postId: postIdStr } = useParams<{ postId: string }>();
  const postId = postIdStr as unknown as number; // 保持字符串原样，避免大整数精度丢失
  const navigate = useNavigate();

  const [post, setPost] = useState<PostDetailResponse | null>(null);
  const [comments, setComments] = useState<CommentResponse[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isLoadingComments, setIsLoadingComments] = useState(false);
  const [hasThumb, setHasThumb] = useState(false);
  const [hasFavour, setHasFavour] = useState(false);
  const [commentPage, setCommentPage] = useState(1);
  const [hasMoreComments, setHasMoreComments] = useState(true);
  const [commentText, setCommentText] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [currentUserId, setCurrentUserId] = useState<number | string>(0);
  const [currentUserInfo, setCurrentUserInfo] = useState<UserPublicResponse | null>(null);
  const [isFollowingAuthor, setIsFollowingAuthor] = useState(false);
  const [isFollowLoading, setIsFollowLoading] = useState(false);

  // 用户信息
  const [authorInfo, setAuthorInfo] = useState<UserPublicResponse | null>(null);
  const [commentUserCache, setCommentUserCache] = useState<Record<number, UserPublicResponse>>({});
  const loadingUsers = useRef<Set<number>>(new Set());
  const scrollRef = useRef<HTMLDivElement>(null);

  const loadCommentUserInfo = useCallback(async (userId: number) => {
    if (loadingUsers.current.has(userId)) return;
    loadingUsers.current.add(userId);
    try {
      const res = await api.getUserPublicInfo({ id: userId });
      if (res.data?.code === 0 && res.data.data) {
        setCommentUserCache(prev => ({ ...prev, [userId]: res.data.data! }));
      }
    } catch { /* silent */ }
  }, []);

  const loadComments = useCallback(async () => {
    setIsLoadingComments(true);
    try {
      const res = await api.getPostComments({ postId, pageNum: 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        setComments(res.data.data.comments || []);
        setCommentPage(1);
        setHasMoreComments((res.data.data.comments?.length || 0) < (res.data.data.total || 0));
      }
    } catch { /* silent */ }
    finally { setIsLoadingComments(false); }
  }, [postId]);

  const loadData = useCallback(async () => {
    setIsLoading(true);
    try {
      // 获取当前用户
      let uid = 0 as number | string;
      const userInfoStr = localStorage.getItem('user_info');
      if (userInfoStr) {
        const userInfo = JSON.parse(userInfoStr);
        uid = (userInfo?.id ?? 0) as number | string; // 保持原始值，避免大整数精度丢失
        setCurrentUserId(uid);
        if (uid) {
          try {
            const meRes = await api.getUserPublicInfo({ id: uid as number });
            if (meRes.data?.code === 0 && meRes.data.data) {
              setCurrentUserInfo(meRes.data.data);
            }
          } catch { /* silent */ }
        }
      }

      // 获取帖子详情
      const res = await api.getPostDetail({ postId });
      if (res.data?.code === 0 && res.data.data) {
        const data = res.data.data;
        setPost(data);
        setHasThumb(data.hasThumb ?? false);
        setHasFavour(data.hasFavour ?? false);
        setIsFollowingAuthor(false);

        // 加载作者信息
        if (data.userId) {
          const authorRes = await api.getUserPublicInfo({ id: data.userId });
          if (authorRes.data?.code === 0 && authorRes.data.data) {
            setAuthorInfo(authorRes.data.data);
          }

          if (getIdKey(data.userId) !== getIdKey(uid)) {
            const followRes = await api.isFollowing({ targetUserId: data.userId });
            if (followRes.data?.code === 0) {
              setIsFollowingAuthor(followRes.data.data ?? false);
            }
          }
        }
      }

      // 加载评论
      await loadComments();
    } catch {
      toast.error('加载失败');
    } finally {
      setIsLoading(false);
    }
  }, [postId, loadComments]);

  const loadMoreComments = useCallback(async () => {
    if (isLoadingComments || !hasMoreComments) return;
    setIsLoadingComments(true);
    try {
      const res = await api.getPostComments({ postId, pageNum: commentPage + 1, pageSize: 20 });
      if (res.data?.code === 0 && res.data.data) {
        const newComments = res.data.data.comments || [];
        setComments(prev => [...prev, ...newComments]);
        setCommentPage(prev => prev + 1);
        setHasMoreComments(comments.length + newComments.length < (res.data.data.total || 0));
      }
    } catch { /* silent */ }
    finally { setIsLoadingComments(false); }
  }, [isLoadingComments, hasMoreComments, commentPage, postId, comments.length]);

  const handleToggleThumb = useCallback(async () => {
    try {
      const res = await api.toggleThumb({ postId });
      if (res.data?.code === 0) {
        const newState = res.data.data ?? false;
        setHasThumb(newState);
        setPost(prev => prev ? { ...prev, thumbNum: (prev.thumbNum || 0) + (newState ? 1 : -1) } : null);
      }
    } catch {
      toast.error('操作失败');
    }
  }, [postId]);

  const handleToggleFavour = useCallback(async () => {
    try {
      const res = await api.toggleFavour({ postId });
      if (res.data?.code === 0) {
        const newState = res.data.data ?? false;
        setHasFavour(newState);
        setPost(prev => prev ? { ...prev, favourNum: (prev.favourNum || 0) + (newState ? 1 : -1) } : null);
      }
    } catch {
      toast.error('操作失败');
    }
  }, [postId]);

  const handleSubmitComment = useCallback(async () => {
    const content = commentText.trim();
    if (!content || isSubmitting) return;
    setIsSubmitting(true);
    try {
      const res = await api.createComment({ postId, createCommentRequest: { content } });
      if (res.data?.code === 0) {
        setCommentText('');
        toast.success('评论成功');
        await loadComments();
      }
    } catch {
      toast.error('评论失败');
    } finally {
      setIsSubmitting(false);
    }
  }, [commentText, isSubmitting, postId, loadComments]);

  const handleDeletePost = useCallback(async () => {
    if (!window.confirm('删除后无法恢复，确定要删除这篇帖子吗？')) return;
    try {
      const res = await api.deletePost({ postId });
      if (res.data?.code === 0) {
        toast.success('删除成功');
        navigate('/circle', { replace: true });
      }
    } catch {
      toast.error('删除失败');
    }
  }, [postId, navigate]);

  const handleDeleteComment = useCallback(async (commentId: number) => {
    if (!window.confirm('确定要删除这条评论吗？')) return;
    try {
      const res = await api.deleteComment({ commentId });
      if (res.data?.code === 0) {
        toast.success('删除成功');
        await loadComments();
      }
    } catch {
      toast.error('删除失败');
    }
  }, [loadComments]);

  const handleToggleFollowAuthor = useCallback(async () => {
    if (!post?.userId || isFollowLoading) return;
    if (getIdKey(post.userId) === getIdKey(currentUserId)) return;

    setIsFollowLoading(true);
    try {
      const res = await api.toggleFollow({ targetUserId: post.userId });
      if (res.data?.code === 0) {
        const newState = res.data.data ?? !isFollowingAuthor;
        setIsFollowingAuthor(newState);
        toast.success(newState ? '关注成功' : '已取消关注');
      } else {
        toast.error(res.data?.message || '操作失败');
      }
    } catch {
      toast.error('操作失败');
    } finally {
      setIsFollowLoading(false);
    }
  }, [currentUserId, isFollowLoading, isFollowingAuthor, post?.userId]);

  useEffect(() => {
    if (postId) loadData();
  }, [postId, loadData]);

  const handleScroll = useCallback(() => {
    const el = scrollRef.current;
    if (el && el.scrollHeight - el.scrollTop - el.clientHeight < 300) {
      loadMoreComments();
    }
  }, [loadMoreComments]);

  // ==================== 骨架屏 ====================
  if (isLoading) {
    return (
      <div className="max-w-6xl mx-auto animate-in fade-in duration-500 px-4 sm:px-0 pb-12">
        <div className="mb-8">
          <div className="h-10 w-32 bg-gray-200 dark:bg-gray-700 rounded-xl animate-pulse" />
        </div>
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
          <div className="lg:col-span-8">
            <div className="bg-white dark:bg-gray-900 rounded-[2rem] border border-gray-100 dark:border-gray-800 p-8 animate-pulse">
              <div className="h-10 w-3/4 bg-gray-200 dark:bg-gray-700 rounded-xl mb-6" />
              <div className="space-y-3">
                <div className="h-5 bg-gray-100 dark:bg-gray-800 rounded-lg w-full" />
                <div className="h-5 bg-gray-100 dark:bg-gray-800 rounded-lg w-5/6" />
                <div className="h-5 bg-gray-100 dark:bg-gray-800 rounded-lg w-2/3" />
              </div>
            </div>
          </div>
          <div className="lg:col-span-4">
            <div className="bg-white dark:bg-gray-900 rounded-[2rem] border border-gray-100 dark:border-gray-800 p-8 animate-pulse">
              <div className="w-20 h-20 rounded-2xl bg-gray-200 dark:bg-gray-700 mx-auto mb-4" />
              <div className="h-6 w-32 bg-gray-200 dark:bg-gray-700 rounded-lg mx-auto" />
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (!post) {
    return (
      <div className="max-w-6xl mx-auto text-center py-24 px-4">
        <div className="w-24 h-24 bg-gray-50 dark:bg-gray-900 rounded-full flex items-center justify-center mx-auto mb-6">
          <X size={40} className="text-gray-300" />
        </div>
        <h2 className="text-xl font-bold text-gray-900 dark:text-white mb-2">帖子不存在</h2>
        <p className="text-gray-500 dark:text-gray-400 mb-8">该帖子可能已被删除或暂时无法访问</p>
        <button
          onClick={() => navigate('/circle')}
          className="px-8 py-3 bg-brand-600 hover:bg-brand-500 text-white font-bold rounded-xl transition-all shadow-lg shadow-brand-600/20 active:scale-95"
        >
          返回社区
        </button>
      </div>
    );
  }

  const isOwner = getIdKey(post.userId) === getIdKey(currentUserId) && currentUserId !== 0;

  return (
    <div className="max-w-6xl mx-auto animate-in fade-in duration-500 pb-12 px-4 sm:px-0">
      {/* 返回按钮 */}
      <div className="mb-6">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-sm font-bold text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-all group"
        >
          <div className="p-2 rounded-xl bg-white dark:bg-gray-900 border border-gray-100 dark:border-gray-800 group-hover:border-brand-100 shadow-sm transition-all">
            <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
          </div>
          返回上一页
        </button>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* 左侧：帖子内容与评论 */}
        <div className="lg:col-span-8 space-y-6">
          {/* 帖子内容 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
            <div className="p-6">
              {/* 标题 */}
              <h1 className="text-xl font-bold text-gray-900 dark:text-white leading-snug mb-5 tracking-tight">
                {post.title}
              </h1>

              {/* 内容 */}
              <div
                className="community-rendered-content prose dark:prose-invert max-w-none text-gray-700 dark:text-gray-300 text-sm leading-relaxed mb-6 font-medium opacity-90"
                dangerouslySetInnerHTML={{ __html: renderPostContent(post.content || '') }}
              />

              {/* 标签 */}
              {post.tags && post.tags.length > 0 && post.tags.some(t => t) && (
                <div className="flex flex-wrap gap-2 mb-6">
                  {post.tags.filter(t => t).map(tag => (
                    <span key={tag} className="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-bold bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 border border-brand-100 dark:border-brand-800/50">
                      #{tag}
                    </span>
                  ))}
                </div>
              )}

              {/* 互动栏 */}
              <div className="flex items-center gap-5 pt-5 border-t border-gray-50 dark:border-gray-800/50">
                <button
                  onClick={handleToggleThumb}
                  className={`flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-bold transition-all active:scale-95 ${
                    hasThumb
                      ? 'bg-brand-600 text-white shadow-md shadow-brand-600/30'
                      : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'
                  }`}
                >
                  <ThumbsUp size={16} fill={hasThumb ? 'currentColor' : 'none'} />
                  <span>{post.thumbNum || 0}</span>
                </button>
                <button
                  onClick={handleToggleFavour}
                  className={`flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-bold transition-all active:scale-95 ${
                    hasFavour
                      ? 'bg-amber-500 text-white shadow-md shadow-amber-500/30'
                      : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-amber-500'
                  }`}
                >
                  <Star size={16} fill={hasFavour ? 'currentColor' : 'none'} />
                  <span>{post.favourNum || 0}</span>
                </button>
                <div className="flex items-center gap-2 text-gray-400 dark:text-gray-500 text-sm font-bold ml-1">
                  <MessageCircle size={16} />
                  <span>{post.commentNum || 0} 条评论</span>
                </div>
              </div>
            </div>
          </div>

          {/* 评论区 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
            {/* 评论头部 */}
            <div className="px-5 py-4 border-b border-gray-50 dark:border-gray-800/50">
              <h2 className="text-base font-bold text-gray-900 dark:text-white flex items-center gap-2">
                全部评论
                <div className="px-2 py-0.5 rounded-md bg-gray-100 dark:bg-gray-800 text-xs font-bold text-gray-500 dark:text-gray-400">
                  {post.commentNum || 0}
                </div>
              </h2>
            </div>

            {/* 评论输入 */}
            <div className="px-5 py-5 bg-gray-50/30 dark:bg-gray-800/10 border-b border-gray-50 dark:border-gray-800/50">
              <div className="flex items-start gap-3">
                {currentUserInfo?.userAvatar ? (
                  <img src={currentUserInfo.userAvatar} alt="" className="w-8 h-8 rounded-xl object-cover ring-2 ring-white dark:ring-gray-800 shadow-sm" />
                ) : (
                  <div className="w-8 h-8 rounded-xl bg-gray-100 dark:bg-gray-800 text-gray-400 dark:text-gray-500 flex items-center justify-center">
                    <User size={14} />
                  </div>
                )}
                <div className="flex-1 relative group">
                  <textarea
                    value={commentText}
                    onChange={e => setCommentText(e.target.value)}
                    onKeyDown={e => { if (e.key === 'Enter' && !e.shiftKey && !e.nativeEvent.isComposing) { e.preventDefault(); handleSubmitComment(); } }}
                    placeholder="友善发言，共同进步..."
                    rows={2}
                    className="w-full bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl px-4 py-3 text-sm text-gray-900 dark:text-white placeholder-gray-400 resize-none focus:outline-none focus:ring-2 focus:ring-brand-500/10 focus:border-brand-500 transition-all shadow-sm"
                  />
                  <div className="mt-3 flex justify-end">
                    <button
                      onClick={handleSubmitComment}
                      disabled={!commentText.trim() || isSubmitting}
                      className="flex items-center gap-1.5 px-5 py-2 bg-brand-600 hover:bg-brand-500 disabled:bg-gray-200 dark:disabled:bg-gray-800 text-white text-sm font-bold rounded-lg transition-all shadow-sm active:scale-95"
                    >
                      <Send size={14} />
                      {isSubmitting ? '发送中...' : '发表评论'}
                    </button>
                  </div>
                </div>
              </div>
            </div>

            {/* 评论列表 */}
            <div ref={scrollRef} onScroll={handleScroll} className="max-h-[600px] overflow-y-auto custom-scrollbar">
              {comments.length === 0 ? (
                <div className="py-16 text-center">
                  <div className="w-14 h-14 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-3">
                    <MessageCircle size={24} className="text-gray-200 dark:text-gray-700" />
                  </div>
                  <p className="text-sm text-gray-400 dark:text-gray-500 font-bold">暂无评论，快来抢沙发吧</p>
                </div>
              ) : (
                <div className="divide-y divide-gray-50 dark:divide-gray-800/50">
                  {comments.map(comment => {
                    const userId = comment.userId;
                    const user = userId ? commentUserCache[userId] : undefined;
                    if (userId && !commentUserCache[userId] && !loadingUsers.current.has(userId)) {
                      loadCommentUserInfo(userId);
                    }
                    const isCommentOwner = comment.userId === currentUserId && currentUserId !== 0;

                    return (
                      <div key={comment.id} className="px-5 py-4 hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                        <div className="flex items-start gap-3">
                          <UserAvatar user={user} size="sm" />
                          <div className="flex-1 min-w-0">
                            <div className="flex items-center justify-between mb-1">
                              <div className="flex items-center gap-2">
                                <span className="text-sm font-bold text-gray-900 dark:text-white">
                                  {user?.userName || `用户${comment.userId || ''}`}
                                </span>
                                <span className="text-[11px] font-medium text-gray-400 dark:text-gray-500 flex items-center gap-1 bg-gray-100/50 dark:bg-gray-800/50 px-1.5 py-0.5 rounded">
                                  <Clock size={9} />
                                  {formatTime(comment.createTime)}
                                </span>
                              </div>
                              {isCommentOwner && (
                                <button
                                  onClick={() => handleDeleteComment(comment.id!)}
                                  className="opacity-0 group-hover:opacity-100 p-1.5 text-gray-400 hover:text-rose-500 hover:bg-rose-50 dark:hover:bg-rose-900/20 rounded-lg transition-all"
                                  title="删除评论"
                                >
                                  <Trash2 size={14} />
                                </button>
                              )}
                            </div>
                            <p className="text-sm text-gray-700 dark:text-gray-300 leading-relaxed font-medium opacity-90">
                              {comment.content}
                            </p>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                  {isLoadingComments && (
                    <div className="py-8 text-center">
                      <div className="inline-block w-6 h-6 border-2 border-brand-500 border-t-transparent rounded-full animate-spin" />
                    </div>
                  )}
                  {!hasMoreComments && comments.length > 0 && (
                    <div className="py-6 text-center text-xs font-bold text-gray-300 dark:text-gray-600">— 已经看到最后啦 —</div>
                  )}
                </div>
              )}
            </div>
          </div>
        </div>

        {/* 右侧：作者信息与相关信息 */}
        <div className="lg:col-span-4 space-y-5">
          {/* 作者卡片 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-5 shadow-sm">
            <div className="flex flex-col items-center text-center">
              <UserAvatar user={authorInfo} size="lg" />
              <h3 className="text-base font-bold text-gray-900 dark:text-white mt-3 mb-0.5">
                {authorInfo?.userName || `用户${post.userId || ''}`}
              </h3>
              <p className="text-xs text-gray-500 dark:text-gray-400 font-medium mb-4">
                发布于 {formatTime(post.createTime)}
              </p>

              <div className="flex items-center gap-2 mb-5">
                {authorInfo?.role && (
                  <span className="px-2.5 py-0.5 rounded-lg bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 text-[11px] font-bold">
                    {authorInfo.role}
                  </span>
                )}
                {authorInfo?.level != null && (
                  <span className="px-2.5 py-0.5 rounded-lg bg-amber-50 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400 text-[11px] font-bold">
                    Lv.{authorInfo.level}
                  </span>
                )}
              </div>

              {authorInfo?.userProfile && (
                <p className="text-xs text-gray-500 dark:text-gray-400 leading-relaxed mb-5 italic">
                  &quot;{authorInfo.userProfile}&quot;
                </p>
              )}

              <div className="w-full pt-4 border-t border-gray-50 dark:border-gray-800/50 flex items-center justify-between">
                {isOwner ? (
                  <div className="w-full grid grid-cols-2 gap-2">
                    <button
                      onClick={() => navigate(`/circle/edit/${post.id}`)}
                      className="flex items-center justify-center gap-1.5 py-2 text-sm bg-gray-50 dark:bg-gray-800 text-gray-700 dark:text-gray-300 font-bold rounded-xl hover:bg-gray-100 transition-all active:scale-95"
                    >
                      <Edit3 size={14} /> 编辑
                    </button>
                    <button
                      onClick={handleDeletePost}
                      className="flex items-center justify-center gap-1.5 py-2 text-sm bg-rose-50 text-rose-600 font-bold rounded-xl hover:bg-rose-100 transition-all active:scale-95"
                    >
                      <Trash2 size={14} /> 删除
                    </button>
                  </div>
                ) : (
                  <button
                    onClick={handleToggleFollowAuthor}
                    disabled={isFollowLoading || !post.userId}
                    className={`w-full py-2 text-sm font-bold rounded-xl shadow-md transition-all active:scale-95 disabled:cursor-not-allowed disabled:opacity-70 flex items-center justify-center gap-1.5 ${
                      isFollowingAuthor
                        ? 'bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 shadow-gray-200/40 dark:shadow-black/10'
                        : 'bg-brand-600 text-white hover:bg-brand-500 shadow-brand-600/20'
                    }`}
                  >
                    {isFollowLoading && <Loader2 size={14} className="animate-spin" />}
                    {isFollowingAuthor ? '已关注' : '关注作者'}
                  </button>
                )}
              </div>
            </div>
          </div>

          {/* 社区导航/规则 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-5 shadow-sm">
            <h3 className="text-base font-bold text-gray-900 dark:text-white mb-3 flex items-center gap-2">
              <TrendingUp size={16} className="text-brand-600" />
              星社区规则
            </h3>
            <ul className="space-y-3 text-xs font-medium text-gray-500 dark:text-gray-400">
              <li className="flex gap-2.5">
                <div className="w-4 h-4 rounded-full bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 flex items-center justify-center text-[9px] font-bold shrink-0">1</div>
                <span>发布内容需遵守国家法律法规及社区公约。</span>
              </li>
              <li className="flex gap-2.5">
                <div className="w-4 h-4 rounded-full bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 flex items-center justify-center text-[9px] font-bold shrink-0">2</div>
                <span>提倡友善交流，严禁人身攻击、骚扰等行为。</span>
              </li>
              <li className="flex gap-2.5">
                <div className="w-4 h-4 rounded-full bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 flex items-center justify-center text-[9px] font-bold shrink-0">3</div>
                <span>鼓励高质量的学习心得、资源分享和知识问答。</span>
              </li>
            </ul>
            <button
              onClick={() => navigate('/circle')}
              className="w-full mt-5 py-2 text-sm bg-brand-600 text-white font-bold rounded-xl hover:bg-brand-500 shadow-sm transition-all active:scale-95"
            >
              探索更多动态
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PostDetailPage;
