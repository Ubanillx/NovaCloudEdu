import React, { useState, useEffect, useCallback } from 'react';
import {
  Users, UsersRound, Search, UserPlus,
  Check, X, Clock, Send, ArrowLeft,
  MailPlus, UserCheck, Loader2, RefreshCw, MessageCircle, WifiOff, Bot,
  Phone, Video,
} from 'lucide-react';
import { useSearchParams } from 'react-router-dom';
import { apiClient, DefaultApi, Configuration } from '../api';
import type {
  FriendResponse,
  FriendRequestResponse,
  SearchUserResponse,
} from '../api/generated/models';
import toast from '../components/ui/Toast';
import { Avatar } from '../components/ui/Avatar';
import { useChat } from '../context/ChatContext';
import PrivateChatPanel from '../components/chat/PrivateChatPanel';
import GroupChatPanel from '../components/chat/GroupChatPanel';
import AiChatPanel from '../components/chat/AiChatPanel';
import { useRtc } from '../context/RtcContext';

const api = new DefaultApi(new Configuration(), '', apiClient);

// ============ 工具函数 ============

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

// ============ 状态徽章 ============

const StatusBadge: React.FC<{ status?: string }> = ({ status }) => {
  const map: Record<string, { bg: string; text: string; label: string }> = {
    pending: {
      bg: 'bg-amber-50 dark:bg-amber-900/20 border-amber-200 dark:border-amber-800',
      text: 'text-amber-700 dark:text-amber-300',
      label: '待处理',
    },
    accepted: {
      bg: 'bg-emerald-50 dark:bg-emerald-900/20 border-emerald-200 dark:border-emerald-800',
      text: 'text-emerald-700 dark:text-emerald-300',
      label: '已接受',
    },
    rejected: {
      bg: 'bg-rose-50 dark:bg-rose-900/20 border-rose-200 dark:border-rose-800',
      text: 'text-rose-700 dark:text-rose-300',
      label: '已拒绝',
    },
  };
  const s = map[status || ''] || { bg: 'bg-gray-100 dark:bg-gray-800', text: 'text-gray-500', label: '未知' };
  return (
    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium border ${s.bg} ${s.text}`}>
      {s.label}
    </span>
  );
};

// ============ Tab 类型 ============

type MainTab = 'messages' | 'friends' | 'requests' | 'groups' | 'intelligence';
type RequestTab = 'received' | 'sent';

// ============ 好友列表 Tab ============

const FriendsTab: React.FC<{ onChatWith?: (userId: number, userName?: string, userAvatar?: string) => void }> = ({ onChatWith }) => {
  const { startCall } = useRtc();
  const [friends, setFriends] = useState<FriendResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [showAddFriend, setShowAddFriend] = useState(false);

  const loadFriends = useCallback(async () => {
    setLoading(true);
    try {
      const res = await api.getAllFriends();
      setFriends(res.data?.data || []);
    } catch {
      toast.error('加载好友列表失败');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { loadFriends(); }, [loadFriends]);

  const filtered = friends.filter(
    (f) =>
      !searchKeyword ||
      f.userName?.toLowerCase().includes(searchKeyword.toLowerCase()) ||
      f.userAccount?.toLowerCase().includes(searchKeyword.toLowerCase()),
  );

  if (showAddFriend) {
    return <AddFriendPanel onBack={() => { setShowAddFriend(false); loadFriends(); }} />;
  }

  return (
    <div className="flex flex-col h-full">
      {/* 标题栏 */}
      <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <h3 className="text-sm font-semibold text-gray-900 dark:text-white">好友</h3>
      </div>
      {/* 搜索与操作栏 */}
      <div className="flex items-center gap-3 px-4 py-2.5 border-b border-gray-100 dark:border-gray-800">
        <div className="relative flex-1">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            placeholder="搜索好友..."
            value={searchKeyword}
            onChange={(e) => setSearchKeyword(e.target.value)}
            className="w-full pl-9 pr-4 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 transition-all"
          />
        </div>
        <button
          onClick={() => setShowAddFriend(true)}
          className="flex items-center gap-1.5 px-3 py-2 text-sm font-medium text-white bg-brand-500 hover:bg-brand-600 rounded-lg transition-colors shadow-sm"
        >
          <UserPlus size={16} />
          <span>添加好友</span>
        </button>
      </div>

      {/* 好友列表 */}
      <div className="flex-1 overflow-y-auto">
        {loading ? (
          <div className="flex items-center justify-center py-20 text-gray-400">
            <Loader2 size={24} className="animate-spin" />
          </div>
        ) : filtered.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 text-gray-400">
            <Users size={48} className="mb-3 opacity-40" />
            <p className="text-sm">{searchKeyword ? '没有找到匹配的好友' : '暂无好友，快去添加吧'}</p>
          </div>
        ) : (
          <div className="divide-y divide-gray-100 dark:divide-gray-800">
            {filtered.map((friend) => (
              <div
                key={friend.userId}
                onClick={() => onChatWith?.(friend.userId!, friend.userName, friend.userAvatar)}
                className="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors cursor-pointer"
              >
                <Avatar src={friend.userAvatar} name={friend.userName} />
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                    {friend.userName || '未知用户'}
                  </p>
                  <p className="text-xs text-gray-400 truncate">
                    {friend.userProfile || `@${friend.userAccount || ''}`}
                  </p>
                </div>
                <div className="flex items-center gap-1.5 shrink-0">
                  <button
                    onClick={(e) => { e.stopPropagation(); startCall(String(friend.userId), friend.userName || '未知用户', friend.userAvatar, 'audio'); }}
                    className="p-1.5 rounded-lg text-gray-400 hover:text-brand-500 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-colors"
                    title="语音通话"
                  >
                    <Phone size={16} />
                  </button>
                  <button
                    onClick={(e) => { e.stopPropagation(); startCall(String(friend.userId), friend.userName || '未知用户', friend.userAvatar, 'video'); }}
                    className="p-1.5 rounded-lg text-gray-400 hover:text-brand-500 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-colors"
                    title="视频通话"
                  >
                    <Video size={16} />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

// ============ 添加好友面板 ============

const AddFriendPanel: React.FC<{ onBack: () => void }> = ({ onBack }) => {
  const [keyword, setKeyword] = useState('');
  const [results, setResults] = useState<SearchUserResponse[]>([]);
  const [searching, setSearching] = useState(false);
  const [sendingTo, setSendingTo] = useState<Set<number>>(new Set());
  const [messageMap, setMessageMap] = useState<Record<number, string>>({});
  const [showMessageInput, setShowMessageInput] = useState<number | null>(null);

  const handleSearch = useCallback(async () => {
    if (!keyword.trim()) return;
    setSearching(true);
    try {
      const res = await api.searchUsers({ searchUserRequestDTO: { keyword: keyword.trim(), pageNum: 1, pageSize: 20 } });
      setResults(res.data?.data?.records || []);
    } catch {
      toast.error('搜索失败');
    } finally {
      setSearching(false);
    }
  }, [keyword]);

  const handleSendRequest = async (userId: number) => {
    setSendingTo((prev) => new Set(prev).add(userId));
    try {
      await api.sendFriendRequest({
        sendFriendRequestDTO: {
          receiverId: userId,
          message: messageMap[userId] || undefined,
        },
      });
      toast.success('好友申请已发送');
      setResults((prev) =>
        prev.map((u) => (u.userId === userId ? { ...u, hasPendingRequest: true } : u)),
      );
      setShowMessageInput(null);
    } catch {
      toast.error('发送申请失败');
    } finally {
      setSendingTo((prev) => {
        const next = new Set(prev);
        next.delete(userId);
        return next;
      });
    }
  };

  return (
    <div className="flex flex-col h-full">
      {/* 头部 */}
      <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <button
          onClick={onBack}
          className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
        >
          <ArrowLeft size={18} className="text-gray-500" />
        </button>
        <h3 className="text-sm font-semibold text-gray-900 dark:text-white">添加好友</h3>
      </div>

      {/* 搜索栏 */}
      <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <div className="flex gap-2">
          <div className="relative flex-1">
            <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
            <input
              type="text"
              placeholder="输入用户名或账号搜索..."
              value={keyword}
              onChange={(e) => setKeyword(e.target.value)}
              onKeyDown={(e) => e.key === 'Enter' && !e.nativeEvent.isComposing && handleSearch()}
              className="w-full pl-9 pr-4 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 transition-all"
            />
          </div>
          <button
            onClick={handleSearch}
            disabled={searching || !keyword.trim()}
            className="px-4 py-2 text-sm font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 disabled:cursor-not-allowed rounded-lg transition-colors shadow-sm"
          >
            {searching ? <Loader2 size={16} className="animate-spin" /> : '搜索'}
          </button>
        </div>
      </div>

      {/* 搜索结果 */}
      <div className="flex-1 overflow-y-auto">
        {results.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 text-gray-400">
            <Search size={48} className="mb-3 opacity-40" />
            <p className="text-sm">输入关键词搜索用户</p>
          </div>
        ) : (
          <div className="divide-y divide-gray-100 dark:divide-gray-800">
            {results.map((user) => (
              <div key={user.userId} className="px-4 py-3">
                <div className="flex items-center gap-3">
                  <Avatar src={user.userAvatar} name={user.userName} />
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                      {user.userName || '未知用户'}
                    </p>
                    <p className="text-xs text-gray-400 truncate">
                      {user.userProfile || `@${user.userAccount || ''}`}
                    </p>
                  </div>
                  {user.isFriend ? (
                    <span className="flex items-center gap-1 text-xs text-emerald-600 dark:text-emerald-400 font-medium">
                      <UserCheck size={14} />
                      已是好友
                    </span>
                  ) : user.hasPendingRequest ? (
                    <span className="flex items-center gap-1 text-xs text-amber-600 dark:text-amber-400 font-medium">
                      <Clock size={14} />
                      已申请
                    </span>
                  ) : (
                    <button
                      onClick={() => {
                        if (showMessageInput === user.userId) {
                          handleSendRequest(user.userId!);
                        } else {
                          setShowMessageInput(user.userId!);
                        }
                      }}
                      disabled={sendingTo.has(user.userId!)}
                      className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 rounded-lg transition-colors"
                    >
                      {sendingTo.has(user.userId!) ? (
                        <Loader2 size={14} className="animate-spin" />
                      ) : showMessageInput === user.userId ? (
                        <>
                          <Send size={14} />
                          发送
                        </>
                      ) : (
                        <>
                          <MailPlus size={14} />
                          添加
                        </>
                      )}
                    </button>
                  )}
                </div>
                {/* 申请留言输入框 */}
                {showMessageInput === user.userId && !user.isFriend && !user.hasPendingRequest && (
                  <div className="mt-2 ml-14">
                    <input
                      type="text"
                      placeholder="附言（可选）：你好，我是..."
                      value={messageMap[user.userId!] || ''}
                      onChange={(e) =>
                        setMessageMap((prev) => ({ ...prev, [user.userId!]: e.target.value }))
                      }
                      onKeyDown={(e) => e.key === 'Enter' && !e.nativeEvent.isComposing && handleSendRequest(user.userId!)}
                      className="w-full px-3 py-1.5 text-xs bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 transition-all"
                      autoFocus
                    />
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

// ============ 好友申请 Tab ============

const RequestsTab: React.FC = () => {
  const [activeTab, setActiveTab] = useState<RequestTab>('received');
  const [receivedRequests, setReceivedRequests] = useState<FriendRequestResponse[]>([]);
  const [sentRequests, setSentRequests] = useState<FriendRequestResponse[]>([]);
  const [loadingReceived, setLoadingReceived] = useState(true);
  const [loadingSent, setLoadingSent] = useState(true);
  const [processingIds, setProcessingIds] = useState<Set<number>>(new Set());

  const loadReceived = useCallback(async () => {
    setLoadingReceived(true);
    try {
      const res = await api.getReceivedRequests({ friendRequestListDTO: { pageNum: 1, pageSize: 50 } });
      setReceivedRequests(res.data?.data?.records || []);
    } catch {
      toast.error('加载收到的申请失败');
    } finally {
      setLoadingReceived(false);
    }
  }, []);

  const loadSent = useCallback(async () => {
    setLoadingSent(true);
    try {
      const res = await api.getSentRequests({ friendRequestListDTO: { pageNum: 1, pageSize: 50 } });
      setSentRequests(res.data?.data?.records || []);
    } catch {
      toast.error('加载发送的申请失败');
    } finally {
      setLoadingSent(false);
    }
  }, []);

  useEffect(() => {
    loadReceived();
    loadSent();
  }, [loadReceived, loadSent]);

  const handleRequest = async (requestId: number, accept: boolean) => {
    setProcessingIds((prev) => new Set(prev).add(requestId));
    try {
      await api.handleFriendRequest({ handleFriendRequestDTO: { requestId, accept } });
      toast.success(accept ? '已接受好友申请' : '已拒绝好友申请');
      loadReceived();
    } catch {
      toast.error('操作失败');
    } finally {
      setProcessingIds((prev) => {
        const next = new Set(prev);
        next.delete(requestId);
        return next;
      });
    }
  };

  const pendingCount = receivedRequests.filter((r) => r.status === 'pending').length;

  return (
    <div className="flex flex-col h-full">
      {/* 标题栏 */}
      <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <h3 className="text-sm font-semibold text-gray-900 dark:text-white">好友申请</h3>
      </div>
      {/* 子 Tab */}
      <div className="flex items-center gap-1 px-4 py-2 border-b border-gray-100 dark:border-gray-800">
        <button
          onClick={() => setActiveTab('received')}
          className={`flex items-center gap-1.5 px-3 py-1.5 text-sm rounded-lg transition-colors ${
            activeTab === 'received'
              ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
              : 'text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-800/50'
          }`}
        >
          收到的
          {pendingCount > 0 && (
            <span className="inline-flex items-center justify-center w-5 h-5 text-[10px] font-bold text-white bg-rose-500 rounded-full">
              {pendingCount}
            </span>
          )}
        </button>
        <button
          onClick={() => setActiveTab('sent')}
          className={`px-3 py-1.5 text-sm rounded-lg transition-colors ${
            activeTab === 'sent'
              ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
              : 'text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-800/50'
          }`}
        >
          发送的
        </button>
        <div className="flex-1" />
        <button
          onClick={() => { loadReceived(); loadSent(); }}
          className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors text-gray-400"
          title="刷新"
        >
          <RefreshCw size={16} />
        </button>
      </div>

      {/* 列表 */}
      <div className="flex-1 overflow-y-auto">
        {activeTab === 'received' ? (
          loadingReceived ? (
            <div className="flex items-center justify-center py-20 text-gray-400">
              <Loader2 size={24} className="animate-spin" />
            </div>
          ) : receivedRequests.length === 0 ? (
            <EmptyState icon={<MailPlus size={48} />} message="暂无收到的好友申请" />
          ) : (
            <div className="p-4 space-y-3">
              {receivedRequests.map((req) => (
                <ReceivedRequestCard
                  key={req.id}
                  request={req}
                  processing={processingIds.has(req.id!)}
                  onAccept={() => handleRequest(req.id!, true)}
                  onReject={() => handleRequest(req.id!, false)}
                />
              ))}
            </div>
          )
        ) : loadingSent ? (
          <div className="flex items-center justify-center py-20 text-gray-400">
            <Loader2 size={24} className="animate-spin" />
          </div>
        ) : sentRequests.length === 0 ? (
          <EmptyState icon={<Send size={48} />} message="暂无发送的好友申请" />
        ) : (
          <div className="p-4 space-y-3">
            {sentRequests.map((req) => (
              <SentRequestCard key={req.id} request={req} />
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

// ============ 收到的申请卡片 ============

const ReceivedRequestCard: React.FC<{
  request: FriendRequestResponse;
  processing: boolean;
  onAccept: () => void;
  onReject: () => void;
}> = ({ request, processing, onAccept, onReject }) => {
  const isPending = request.status === 'pending';

  return (
    <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4 shadow-sm hover:shadow-md transition-shadow">
      <div className="flex items-center gap-3">
        <Avatar src={request.senderAvatar} name={request.senderName} />
        <div className="flex-1 min-w-0">
          <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
            {request.senderName || '未知用户'}
          </p>
          <p className="text-xs text-gray-400">{formatTime(request.createTime)}</p>
        </div>
        <StatusBadge status={request.status} />
      </div>

      {request.message && (
        <div className="mt-3 px-3 py-2 bg-gray-50 dark:bg-gray-800/50 rounded-lg">
          <p className="text-xs text-gray-600 dark:text-gray-400">{request.message}</p>
        </div>
      )}

      {isPending && (
        <div className="mt-3 flex gap-2">
          <button
            onClick={onReject}
            disabled={processing}
            className="flex-1 flex items-center justify-center gap-1 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 disabled:opacity-50 rounded-lg transition-colors"
          >
            {processing ? <Loader2 size={14} className="animate-spin" /> : <X size={14} />}
            拒绝
          </button>
          <button
            onClick={onAccept}
            disabled={processing}
            className="flex-1 flex items-center justify-center gap-1 py-2 text-sm font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 rounded-lg transition-colors"
          >
            {processing ? <Loader2 size={14} className="animate-spin" /> : <Check size={14} />}
            接受
          </button>
        </div>
      )}
    </div>
  );
};

// ============ 发送的申请卡片 ============

const SentRequestCard: React.FC<{ request: FriendRequestResponse }> = ({ request }) => (
  <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4 shadow-sm">
    <div className="flex items-center gap-3">
      <Avatar src={request.receiverAvatar} name={request.receiverName} />
      <div className="flex-1 min-w-0">
        <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
          {request.receiverName || '未知用户'}
        </p>
        <p className="text-xs text-gray-400">{formatTime(request.createTime)}</p>
      </div>
      <StatusBadge status={request.status} />
    </div>
    {request.message && (
      <div className="mt-3 px-3 py-2 bg-gray-50 dark:bg-gray-800/50 rounded-lg">
        <p className="text-xs text-gray-600 dark:text-gray-400">{request.message}</p>
      </div>
    )}
  </div>
);

// ============ 空状态组件 ============

const EmptyState: React.FC<{ icon: React.ReactNode; message: string }> = ({ icon, message }) => (
  <div className="flex flex-col items-center justify-center py-20 text-gray-400">
    <div className="mb-3 opacity-40">{icon}</div>
    <p className="text-sm">{message}</p>
  </div>
);

// ============ 主页面 ============

const TABS: { key: MainTab; label: string; icon: React.ElementType }[] = [
  { key: 'messages', label: '消息', icon: MessageCircle },
  { key: 'friends', label: '好友', icon: Users },
  { key: 'requests', label: '好友申请', icon: MailPlus },
  { key: 'groups', label: '群聊', icon: UsersRound },
  { key: 'intelligence', label: '智慧体', icon: Bot },
];

const ChatPage: React.FC = () => {
  const [searchParams, setSearchParams] = useSearchParams();
  const initialTab = (searchParams.get('tab') as MainTab) || 'messages';
  const [activeTab, setActiveTab] = useState<MainTab>(
    ['messages', 'friends', 'requests', 'groups', 'intelligence'].includes(initialTab) ? initialTab : 'messages'
  );

  // URL 参数变化时同步 tab
  useEffect(() => {
    const tab = searchParams.get('tab') as MainTab;
    if (tab && ['messages', 'friends', 'requests', 'groups', 'intelligence'].includes(tab)) {
      setActiveTab(tab);
      // 清除 URL 参数，避免污染
      setSearchParams({}, { replace: true });
    }
  }, [searchParams, setSearchParams]);
  const [pendingCount, setPendingCount] = useState(0);
  const [chatTarget, setChatTarget] = useState<{ partnerId: number; partnerName?: string; partnerAvatar?: string } | null>(null);
  const { connectionState, connect, notifications } = useChat();

  // 从好友列表点击好友 → 打开私聊
  const handleChatWithFriend = useCallback((userId: number, userName?: string, userAvatar?: string) => {
    setChatTarget({ partnerId: userId, partnerName: userName, partnerAvatar: userAvatar });
    setActiveTab('messages');
  }, []);

  // 加载待处理申请数量
  useEffect(() => {
    (async () => {
      try {
        const res = await api.getReceivedRequests({ friendRequestListDTO: { status: 'pending', pageNum: 1, pageSize: 50 } });
        const records = res.data?.data?.records || [];
        setPendingCount(records.length);
      } catch {
        // ignore
      }
    })();
  }, [activeTab]);

  // 通知触发好友申请数更新
  useEffect(() => {
    const latest = notifications[0];
    if (latest?.type === 'FRIEND_REQUEST_RECEIVED' || latest?.type === 'FRIEND_REQUEST_HANDLED') {
      (async () => {
        try {
          const res = await api.getReceivedRequests({ friendRequestListDTO: { status: 'pending', pageNum: 1, pageSize: 50 } });
          setPendingCount(res.data?.data?.records?.length || 0);
        } catch { /* ignore */ }
      })();
    }
  }, [notifications]);

  return (
    <div className="flex gap-3 h-[calc(100vh-7.5rem)]">
      {/* 左侧导航 - 不遮挡内容 */}
      <div className="flex-shrink-0 pt-1 group/nav">
        <div className="flex flex-col gap-1 bg-white/80 dark:bg-gray-900/80 backdrop-blur-xl rounded-2xl shadow-lg shadow-black/5 dark:shadow-black/20 border border-gray-200/50 dark:border-gray-700/50 p-1.5 transition-all">
          {TABS.map((tab) => {
            const Icon = tab.icon;
            const isActive = activeTab === tab.key;
            return (
              <button
                key={tab.key}
                onClick={() => setActiveTab(tab.key)}
                title={tab.label}
                className={`relative flex items-center gap-2.5 p-2.5 rounded-xl transition-all duration-300 ease-in-out ${
                  isActive
                    ? 'bg-brand-500 text-white shadow-md shadow-brand-500/25'
                    : 'text-gray-400 hover:text-gray-700 dark:hover:text-gray-200 hover:bg-gray-100/80 dark:hover:bg-gray-800/80'
                }`}
              >
                <Icon size={18} className="flex-shrink-0" strokeWidth={isActive ? 2.5 : 2} />
                <span className={`text-xs font-semibold whitespace-nowrap overflow-hidden transition-all duration-300 ease-in-out ${
                  isActive ? 'max-w-[60px] opacity-100 ml-0' : 'max-w-0 opacity-0 group-hover/nav:max-w-[60px] group-hover/nav:opacity-100'
                }`}>
                  {tab.label}
                </span>
                {tab.key === 'requests' && pendingCount > 0 && (
                  <span className={`absolute -top-1 -right-1 w-4 h-4 text-[9px] font-bold rounded-full flex items-center justify-center ${
                    isActive ? 'bg-white text-brand-600' : 'bg-rose-500 text-white'
                  }`}>
                    {pendingCount > 9 ? '9+' : pendingCount}
                  </span>
                )}
              </button>
            );
          })}

          {/* 分隔线 */}
          <div className="w-6 h-px bg-gray-200 dark:bg-gray-700 mx-auto my-0.5" />

          {/* 连接状态 */}
          <div className="flex items-center justify-center p-2">
            {connectionState === 'connected' ? (
              <span className="relative flex h-2.5 w-2.5" title="已连接">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-50" />
                <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-emerald-500" />
              </span>
            ) : connectionState === 'connecting' ? (
              <Loader2 size={14} className="text-amber-500 animate-spin" />
            ) : (
              <button onClick={connect} title="点击重连" className="text-gray-300 dark:text-gray-600 hover:text-brand-500 transition-colors">
                <WifiOff size={14} />
              </button>
            )}
          </div>
        </div>
      </div>

      {/* 内容区 - 磨砂背景 */}
      <div className="flex-1 min-w-0 h-full overflow-hidden bg-white/50 dark:bg-gray-900/50 backdrop-blur-sm rounded-2xl ring-1 ring-gray-200/40 dark:ring-gray-700/30">
        {activeTab === 'messages' && (
          <PrivateChatPanel
            key={chatTarget?.partnerId}
            initialPartnerId={chatTarget?.partnerId}
            initialPartnerName={chatTarget?.partnerName}
            initialPartnerAvatar={chatTarget?.partnerAvatar}
          />
        )}
        {activeTab === 'friends' && <FriendsTab onChatWith={handleChatWithFriend} />}
        {activeTab === 'requests' && <RequestsTab />}
        {activeTab === 'groups' && <GroupChatPanel />}
        {activeTab === 'intelligence' && <AiChatPanel />}
      </div>
    </div>
  );
};

export default ChatPage;
