import React, { useState, useEffect, useCallback } from 'react';
import {
  UsersRound, Plus, Globe, RefreshCw, Loader2, Search, ArrowLeft, Hash,
  Users, UserPlus, Check
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { GroupResponse, FriendResponse, CreateGroupRequest } from '../../api/generated/models';
import toast from '../ui/Toast';
import { Avatar } from '../ui/Avatar';
import AvatarUploadField from '../ui/AvatarUploadField';
import GroupChatWindow from './GroupChatWindow';
import { useChat } from '../../context/ChatContext';
import { QrScanner, type SocialQrPayload } from './SocialQrCode';

const api = new DefaultApi(new Configuration(), '', apiClient);

const JOIN_MODE_OPTIONS = [
  { value: 0, label: '自由加入' },
  { value: 1, label: '需审批' },
  { value: 2, label: '禁止加入' },
] as const;

const INVITE_MODE_OPTIONS = [
  { value: 0, label: '所有成员' },
  { value: 1, label: '仅管理员' },
] as const;

const getJoinActionLabel = (joinMode?: number) => {
  if (joinMode === 0) return '加入群聊';
  if (joinMode === 2) return '禁止加入';
  return '申请加入';
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

const formatGroupPreview = (group: GroupResponse) => {
  const prefix = group.lastMessageSenderName ? `${group.lastMessageSenderName}：` : '';
  const type = (group.lastMessageType || 'TEXT').toUpperCase();
  if (type === 'IMAGE') return `${prefix}[图片]`;
  if (type === 'FILE') {
    const content = group.lastMessage || '';
    return content.includes('|') ? `${prefix}[文件] ${content.split('|')[0] || '文件'}` : `${prefix}[文件]`;
  }
  if (type === 'AUDIO') return `${prefix}[语音]`;
  if (type === 'VIDEO') return `${prefix}[视频]`;
  if (type === 'CALL') return `${prefix}[通话]`;
  const text = group.lastMessage?.trim();
  return text ? `${prefix}${text}` : (group.description || `${group.memberCount || 0} 名成员`);
};

type SearchGroupPage = {
  groups?: unknown[];
  list?: unknown[];
  records?: unknown[];
};

type LongLike = number | string | { value?: number | string } | null | undefined;

const toNumberId = (value: LongLike): number | undefined => {
  const raw = value && typeof value === 'object' ? value.value : value;
  if (typeof raw === 'number' && Number.isFinite(raw)) return raw;
  if (typeof raw === 'string' && raw.trim()) {
    const parsed = Number(raw);
    return Number.isFinite(parsed) ? parsed : undefined;
  }
  return undefined;
};

const normalizeGroupResponse = (raw: unknown): GroupResponse | null => {
  if (!raw || typeof raw !== 'object') return null;

  const source = raw as Record<string, unknown>;
  const id = toNumberId(source.id as LongLike);
  if (id === undefined) return null;

  return {
    ...(source as GroupResponse),
    id,
    ownerId: toNumberId(source.ownerId as LongLike),
    classId: toNumberId(source.classId as LongLike),
    maxMembers: toNumberId(source.maxMembers as LongLike),
    memberCount: toNumberId(source.memberCount as LongLike),
    inviteMode: toNumberId(source.inviteMode as LongLike),
    joinMode: toNumberId(source.joinMode as LongLike),
    lastMessageSenderId: toNumberId(source.lastMessageSenderId as LongLike),
    unreadCount: toNumberId(source.unreadCount as LongLike),
  };
};

const extractGroupResults = (data: unknown): GroupResponse[] => {
  const groups = Array.isArray(data)
    ? data
    : data && typeof data === 'object'
      ? (data as SearchGroupPage).groups || (data as SearchGroupPage).list || (data as SearchGroupPage).records || []
      : [];

  return groups
    .map(normalizeGroupResponse)
    .filter((group): group is GroupResponse => group !== null);
};

// ============ 创建群聊面板 ============

const CreateGroupPanel: React.FC<{ onBack: () => void }> = ({ onBack }) => {
  const [groupName, setGroupName] = useState('');
  const [avatar, setAvatar] = useState('');
  const [description, setDescription] = useState('');
  const [announcement, setAnnouncement] = useState('');
  const [joinMode, setJoinMode] = useState(0);
  const [inviteMode, setInviteMode] = useState(0);
  const [creating, setCreating] = useState(false);

  // 好友列表（用于邀请成员）
  const [friends, setFriends] = useState<FriendResponse[]>([]);
  const [loadingFriends, setLoadingFriends] = useState(true);
  const [selectedIds, setSelectedIds] = useState<Set<number>>(new Set());

  useEffect(() => {
    (async () => {
      setLoadingFriends(true);
      try {
        const res = await api.getAllFriends();
        setFriends(res.data?.data || []);
      } catch {
        // ignore
      } finally {
        setLoadingFriends(false);
      }
    })();
  }, []);

  const toggleSelect = (userId: number) => {
    setSelectedIds((prev) => {
      const next = new Set(prev);
      if (next.has(userId)) next.delete(userId);
      else next.add(userId);
      return next;
    });
  };

  const handleCreate = async () => {
    if (!groupName.trim()) {
      toast.warning('请输入群名称');
      return;
    }
    setCreating(true);
    try {
      const res = await api.createGroup({
        createGroupRequest: {
          groupName: groupName.trim(),
          avatar: avatar.trim() || undefined,
          description: description.trim() || undefined,
          joinMode,
          inviteMode,
          announcement: announcement.trim() || undefined,
        } as CreateGroupRequest & { joinMode?: number; inviteMode?: number; announcement?: string },
      });
      const groupId = res.data?.data?.id;

      // 邀请选中的好友
      if (groupId && selectedIds.size > 0) {
        let successCount = 0;
        for (const userId of selectedIds) {
          try {
            await api.inviteMember({ groupId, inviteeId: userId });
            successCount++;
          } catch {
            // 单个邀请失败不影响整体
          }
        }
        if (successCount > 0) {
          toast.success(`群聊创建成功，已邀请 ${successCount} 位好友`);
        } else {
          toast.success('群聊创建成功');
        }
      } else {
        toast.success('群聊创建成功');
      }
      onBack();
    } catch {
      toast.error('创建群聊失败');
    } finally {
      setCreating(false);
    }
  };

  return (
    <div className="flex flex-col h-full bg-white dark:bg-gray-900">
      {/* 头部 */}
      <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <button
          onClick={onBack}
          className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
        >
          <ArrowLeft size={18} className="text-gray-500" />
        </button>
        <h3 className="text-sm font-semibold text-gray-900 dark:text-white">创建群聊</h3>
        <div className="flex-1" />
        <button
          onClick={handleCreate}
          disabled={creating || !groupName.trim()}
          className="flex items-center gap-1 px-4 py-1.5 text-sm font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 disabled:cursor-not-allowed rounded-lg transition-colors"
        >
          {creating ? <Loader2 size={14} className="animate-spin" /> : '创建'}
        </button>
      </div>

      <div className="flex-1 overflow-y-auto">
        {/* 群信息表单 */}
        <div className="p-4 space-y-4 border-b border-gray-100 dark:border-gray-800">
          <div>
            <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
              群名称 <span className="text-rose-500">*</span>
            </label>
            <input
              type="text"
              placeholder="请输入群名称"
              value={groupName}
              onChange={(e) => setGroupName(e.target.value)}
              maxLength={30}
              className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 transition-all"
            />
          </div>
          <AvatarUploadField
            label="群头像（可选）"
            value={avatar}
            onChange={setAvatar}
            name={groupName}
            icon="group"
            businessType="group/avatar"
          />
          <div>
            <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
              群简介（可选）
            </label>
            <textarea
              placeholder="介绍一下你的群聊吧..."
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              maxLength={200}
              rows={3}
              className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 transition-all resize-none"
            />
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
              加入方式
            </label>
            <div className="grid grid-cols-3 gap-2">
              {JOIN_MODE_OPTIONS.map((option) => (
                <button
                  key={option.value}
                  type="button"
                  onClick={() => setJoinMode(option.value)}
                  className={`px-3 py-2 text-xs font-medium rounded-lg border transition-all active:scale-[0.98] ${
                    joinMode === option.value
                      ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-300 dark:border-brand-700 text-brand-700 dark:text-brand-300'
                      : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-800'
                  }`}
                >
                  {option.label}
                </button>
              ))}
            </div>
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
              邀请权限
            </label>
            <div className="grid grid-cols-2 gap-2">
              {INVITE_MODE_OPTIONS.map((option) => (
                <button
                  key={option.value}
                  type="button"
                  onClick={() => setInviteMode(option.value)}
                  className={`px-3 py-2 text-xs font-medium rounded-lg border transition-all active:scale-[0.98] ${
                    inviteMode === option.value
                      ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-300 dark:border-brand-700 text-brand-700 dark:text-brand-300'
                      : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-800'
                  }`}
                >
                  {option.label}
                </button>
              ))}
            </div>
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
              群公告（可选）
            </label>
            <textarea
              placeholder="群规则、学习安排或入群须知"
              value={announcement}
              onChange={(e) => setAnnouncement(e.target.value)}
              maxLength={512}
              rows={2}
              className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 transition-all resize-none"
            />
          </div>
        </div>

        {/* 邀请好友 */}
        <div className="p-4">
          <div className="flex items-center justify-between mb-3">
            <p className="text-xs font-medium text-gray-500 dark:text-gray-400">
              邀请好友加入（可选）
            </p>
            {selectedIds.size > 0 && (
              <span className="text-xs text-brand-600 dark:text-brand-400 font-medium">
                已选 {selectedIds.size} 人
              </span>
            )}
          </div>

          {loadingFriends ? (
            <div className="flex items-center justify-center py-8 text-gray-400">
              <Loader2 size={20} className="animate-spin" />
            </div>
          ) : friends.length === 0 ? (
            <p className="text-xs text-gray-400 text-center py-6">暂无好友可邀请</p>
          ) : (
            <div className="space-y-1">
              {friends.map((friend) => {
                const selected = selectedIds.has(friend.userId!);
                return (
                  <button
                    key={friend.userId}
                    onClick={() => toggleSelect(friend.userId!)}
                    className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-colors ${
                      selected
                        ? 'bg-brand-50 dark:bg-brand-900/20 ring-1 ring-brand-200 dark:ring-brand-800'
                        : 'hover:bg-gray-50 dark:hover:bg-gray-800/50'
                    }`}
                  >
                    <div
                      className={`w-5 h-5 rounded-md border-2 flex items-center justify-center transition-colors ${
                        selected
                          ? 'bg-brand-500 border-brand-500'
                          : 'border-gray-300 dark:border-gray-600'
                      }`}
                    >
                      {selected && <Check size={12} className="text-white" />}
                    </div>
                    <Avatar src={friend.userAvatar} name={friend.userName} size="sm" />
                    <span className="text-sm text-gray-900 dark:text-white truncate">
                      {friend.userName || '未知用户'}
                    </span>
                  </button>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

// ============ 搜索群聊面板 ============

const SearchGroupPanel: React.FC<{ onBack: () => void }> = ({ onBack }) => {
  const [keyword, setKeyword] = useState('');
  const [searchType, setSearchType] = useState<'name' | 'number'>('name');
  const [results, setResults] = useState<GroupResponse[]>([]);
  const [searching, setSearching] = useState(false);
  const [applyingTo, setApplyingTo] = useState<Set<number>>(new Set());
  const [showScanner, setShowScanner] = useState(false);

  const handleSearch = async () => {
    const trimmed = keyword.trim();
    if (!trimmed) return;
    setSearching(true);
    try {
      const res = await api.searchGroups({ keyword: trimmed, pageNum: 1, pageSize: 20 });
      setResults(extractGroupResults(res.data?.data));
    } catch {
      toast.error('搜索失败');
    } finally {
      setSearching(false);
    }
  };

  const handleApply = async (groupId: number) => {
    setApplyingTo((prev) => new Set(prev).add(groupId));
    try {
      const res = await api.applyToJoin({ groupId });
      if (res.data?.data) {
        toast.success('申请已发送');
      } else {
        toast.success('已加入群聊');
        onBack();
      }
    } catch {
      toast.error('申请失败');
    } finally {
      setApplyingTo((prev) => {
        const next = new Set(prev);
        next.delete(groupId);
        return next;
      });
    }
  };

  const handleQrPayload = async (payload: SocialQrPayload) => {
    if (payload.type !== 'group') {
      toast.warning('这是个人二维码，请到好友页添加');
      return;
    }
    await handleApply(payload.groupId);
  };

  return (
    <div className="flex flex-col h-full bg-white dark:bg-gray-900">
      {/* 头部 */}
      <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <button
          onClick={onBack}
          className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
        >
          <ArrowLeft size={18} className="text-gray-500" />
        </button>
        <h3 className="text-sm font-semibold text-gray-900 dark:text-white">搜索群聊</h3>
      </div>

      {/* 搜索栏 */}
      <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800 space-y-3">
        {/* 搜索类型切换 */}
        <div className="flex gap-2">
          {[
            { key: 'name' as const, label: '按名称' },
            { key: 'number' as const, label: '按群号' },
          ].map((opt) => (
            <button
              key={opt.key}
              onClick={() => { setSearchType(opt.key); setResults([]); }}
              className={`px-3 py-1 text-xs font-medium rounded-full transition-colors ${
                searchType === opt.key
                  ? 'bg-brand-500 text-white'
                  : 'bg-gray-100 dark:bg-gray-800 text-gray-500 hover:bg-gray-200 dark:hover:bg-gray-700'
              }`}
            >
              {opt.label}
            </button>
          ))}
        </div>
        {/* 搜索输入 */}
        <div className="flex gap-2">
          <div className="relative flex-1">
            <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
            <input
              type="text"
              inputMode={searchType === 'number' ? 'numeric' : 'text'}
              placeholder={searchType === 'number' ? '输入群号' : '输入群名称'}
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
          <button
            type="button"
            onClick={() => setShowScanner((value) => !value)}
            className="px-3 py-2 text-sm font-medium text-brand-700 dark:text-brand-300 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/40 rounded-lg transition-colors"
          >
            扫码
          </button>
        </div>
        {showScanner && <QrScanner onResolved={handleQrPayload} />}
      </div>

      {/* 搜索结果 */}
      <div className="flex-1 overflow-y-auto">
        {results.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 text-gray-400">
            <Globe size={48} className="mb-3 opacity-40" />
            <p className="text-sm">{searchType === 'number' ? '输入群号搜索' : '输入群名称搜索'}</p>
          </div>
        ) : (
          <div className="p-4 space-y-3">
            {results.map((group) => (
              <div
                key={group.id}
                className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4 shadow-sm hover:shadow-sm transition-shadow"
              >
                <div className="flex items-center gap-3">
                  <Avatar src={group.avatar} name={group.groupName} icon="group" size="lg" />
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                      {group.groupName || '未知群聊'}
                    </p>
                    <div className="flex items-center gap-3 text-xs text-gray-400 mt-0.5">
                      <span>群号: {group.groupNumber || group.id}</span>
                      <span className="flex items-center gap-0.5">
                        <Users size={11} />
                        {group.memberCount || 0} 人
                      </span>
                    </div>
                    {group.description && (
                      <p className="text-xs text-gray-500 dark:text-gray-400 mt-1 line-clamp-2">
                        {group.description}
                      </p>
                    )}
                  </div>
                  <button
                    onClick={() => handleApply(group.id!)}
                    disabled={applyingTo.has(group.id!) || group.joinMode === 2}
                    className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 rounded-lg transition-colors whitespace-nowrap"
                  >
                    {applyingTo.has(group.id!) ? (
                      <Loader2 size={14} className="animate-spin" />
                    ) : (
                      <>
                        <UserPlus size={14} />
                        {getJoinActionLabel(group.joinMode)}
                      </>
                    )}
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

const EmptyState: React.FC<{ icon: React.ReactNode; message: string }> = ({ icon, message }) => (
  <div className="flex flex-col items-center justify-center py-20 text-gray-400">
    <div className="mb-3 opacity-40">{icon}</div>
    <p className="text-sm">{message}</p>
  </div>
);

// ============ GroupChatPanel (Split View) ============

interface GroupChatPanelProps {
  initialGroupId?: number;
  onOpenGroupChat?: (group: GroupResponse) => void;
}

const GroupChatPanel: React.FC<GroupChatPanelProps> = ({ initialGroupId, onOpenGroupChat }) => {
  const [groups, setGroups] = useState<GroupResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [showCreate, setShowCreate] = useState(false);
  const [showSearch, setShowSearch] = useState(false);
  const [activeGroupId, setActiveGroupId] = useState<number | null>(initialGroupId ?? null);
  const { groupMessages, groupMessagesSent } = useChat();

  const loadGroups = useCallback(async () => {
    setLoading(true);
    try {
      const res = await api.getMyGroups();
      const nextGroups = [...(res.data?.data || [])].sort((a, b) => {
        const aTime = new Date(a.lastMessageTime || a.createTime || 0).getTime();
        const bTime = new Date(b.lastMessageTime || b.createTime || 0).getTime();
        return bTime - aTime;
      });
      setGroups(nextGroups);
    } catch {
      toast.error('加载群聊列表失败');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { loadGroups(); }, [loadGroups]);

  useEffect(() => {
    if (groupMessages.length > 0 || groupMessagesSent.length > 0) {
      loadGroups();
    }
  }, [groupMessages, groupMessagesSent, loadGroups]);

  useEffect(() => {
    if (initialGroupId) {
      if (onOpenGroupChat) {
        const group = groups.find((item) => item.id === initialGroupId);
        if (group) {
          onOpenGroupChat(group);
        }
      } else {
        setActiveGroupId(initialGroupId);
      }
      setShowCreate(false);
      setShowSearch(false);
    }
  }, [groups, initialGroupId, onOpenGroupChat]);

  const activeGroup = groups.find(g => g.id === activeGroupId);

  // 如果在移动端（或小屏），显示单个面板逻辑（略，这里主要适配 PC 分栏）
  // 为了简化，这里我们假设是 PC 端宽屏布局，移动端可以通过 CSS hidden/block 切换

  return (
    <div className="flex h-full w-full overflow-hidden">
      {/* 左侧：群组列表 */}
      <div className={`w-full lg:w-80 lg:min-w-[320px] border-r border-gray-100 dark:border-gray-800 flex flex-col ${activeGroupId || showCreate || showSearch ? 'hidden lg:flex' : 'flex'}`}>
        {/* 操作栏 */}
        <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center justify-between mb-3">
             <h3 className="text-sm font-semibold text-gray-900 dark:text-white">群聊</h3>
             <button
              onClick={loadGroups}
              className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors text-gray-400"
              title="刷新"
            >
              <RefreshCw size={16} />
            </button>
          </div>
          <div className="flex gap-2">
            <button
              onClick={() => { setShowCreate(true); setShowSearch(false); setActiveGroupId(null); }}
              className="flex-1 flex items-center justify-center gap-1.5 px-3 py-2 text-sm font-medium text-white bg-brand-500 hover:bg-brand-600 rounded-lg transition-colors shadow-sm"
            >
              <Plus size={16} />
              创建群聊
            </button>
            <button
              onClick={() => { setShowSearch(true); setShowCreate(false); setActiveGroupId(null); }}
              className="flex-1 flex items-center justify-center gap-1.5 px-3 py-2 text-sm font-medium text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/40 rounded-lg transition-colors"
            >
              <Globe size={16} />
              搜索群聊
            </button>
          </div>
        </div>

        {/* 列表内容 */}
        <div className="flex-1 overflow-y-auto">
          {loading ? (
            <div className="flex items-center justify-center py-20 text-gray-400">
              <Loader2 size={24} className="animate-spin" />
            </div>
          ) : groups.length === 0 ? (
            <EmptyState icon={<UsersRound size={48} />} message="暂无群聊" />
          ) : (
            <div className="divide-y divide-gray-100 dark:divide-gray-800">
              {groups.map((group) => (
                <div
                  key={group.id}
                  onClick={() => {
                    if (onOpenGroupChat) {
                      onOpenGroupChat(group);
                      return;
                    }
                    setActiveGroupId(group.id!);
                    setShowCreate(false);
                    setShowSearch(false);
                    if ((group.unreadCount ?? 0) > 0) {
                      setGroups((prev) => prev.map((item) => (
                        item.id === group.id ? { ...item, unreadCount: 0 } : item
                      )));
                    }
                  }}
                  className={`flex items-center gap-3 px-4 py-3 cursor-pointer transition-colors ${
                    activeGroupId === group.id
                      ? 'bg-brand-50 dark:bg-brand-900/20 border-r-2 border-brand-500'
                      : 'hover:bg-gray-50 dark:hover:bg-gray-800/50 border-r-2 border-transparent'
                  }`}
                >
                  <div className="relative">
                    <Avatar src={group.avatar} name={group.groupName} icon="group" />
                    {(group.unreadCount ?? 0) > 0 && (
                      <span className="absolute -top-1 -right-1 inline-flex min-w-5 items-center justify-center h-5 px-1 text-[10px] font-bold text-white bg-rose-500 rounded-full ring-2 ring-white dark:ring-gray-900">
                        {group.unreadCount! > 99 ? '99+' : group.unreadCount}
                      </span>
                    )}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between gap-2">
                      <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                        {group.groupName || '未知群聊'}
                      </p>
                      {group.lastMessageTime && (
                        <span className="shrink-0 text-[10px] text-gray-400">
                          {formatTime(group.lastMessageTime)}
                        </span>
                      )}
                    </div>
                    <div className="mt-0.5 flex items-center gap-2">
                      {group.groupNumber && (
                        <span className="shrink-0 flex items-center gap-0.5 text-[10px] text-gray-400 bg-gray-100 dark:bg-gray-800 px-1.5 py-0.5 rounded">
                          <Hash size={10} />
                          {group.groupNumber}
                        </span>
                      )}
                      <p className="min-w-0 flex-1 text-xs text-gray-400 truncate">
                        {formatGroupPreview(group)}
                      </p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* 右侧：聊天窗口 / 创建面板 / 搜索面板 */}
      <div className={`flex-1 flex flex-col ${activeGroupId || showCreate || showSearch ? 'flex' : 'hidden lg:flex'}`}>
        {showCreate ? (
          <CreateGroupPanel onBack={() => { setShowCreate(false); loadGroups(); }} />
        ) : showSearch ? (
          <SearchGroupPanel onBack={() => { setShowSearch(false); loadGroups(); }} />
        ) : activeGroupId && activeGroup ? (
          <GroupChatWindow
            groupId={activeGroupId}
            groupName={activeGroup.groupName}
            groupAvatar={activeGroup.avatar}
            onBack={() => setActiveGroupId(null)}
            onGroupUpdated={loadGroups}
          />
        ) : activeGroupId && loading ? (
          <div className="flex flex-1 items-center justify-center text-gray-400">
            <Loader2 size={24} className="animate-spin" />
          </div>
        ) : (
          <div className="flex-1 flex flex-col items-center justify-center text-gray-400">
            <UsersRound size={48} className="mb-4 opacity-30" />
            <p className="text-sm">选择一个群聊开始聊天</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default GroupChatPanel;
