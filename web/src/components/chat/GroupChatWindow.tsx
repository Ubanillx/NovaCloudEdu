import React, { useState, useEffect, useCallback, useRef } from 'react';
import {
  ArrowLeft, Send, Loader2, UsersRound, Hash, CheckCheck, X, Eye,
  Image, Paperclip, Upload, Settings, UserMinus, Shield, Crown, LogOut,
  Trash2, UserCheck, Check, Reply,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type {
  GroupResponse,
  MessageReadUserResponse,
  GroupMemberResponse,
  JoinRequestResponse,
  UserPublicResponse,
  UpdateGroupRequest,
} from '../../api/generated/models';
import { useChat } from '../../context/ChatContext';
import toast from '../ui/Toast';
import { Avatar } from '../ui/Avatar';
import AvatarUploadField from '../ui/AvatarUploadField';
import { MessageBubble } from './MessageContent';
import { ReplyComposerBar, ReplyPreview } from './MessageReply';
import { useChatUpload } from './useChatUpload';

const api = new DefaultApi(new Configuration(), '', apiClient);

const JOIN_MODE_LABELS: Record<number, string> = { 0: '自由加入', 1: '需审批', 2: '禁止加入' };
const INVITE_MODE_LABELS: Record<number, string> = { 0: '所有成员可邀请', 1: '仅管理员可邀请' };

const JOIN_MODE_OPTIONS = [
  { value: 0, label: '自由加入' },
  { value: 1, label: '需审批' },
  { value: 2, label: '禁止加入' },
] as const;

const INVITE_MODE_OPTIONS = [
  { value: 0, label: '所有成员可邀请' },
  { value: 1, label: '仅管理员可邀请' },
] as const;

const SETTINGS_PANEL_ANIMATION_MS = 240;

const normalizeAnnouncementText = (value?: string | null) => {
  if (!value) return '';
  const trimmed = value.trim();
  if (trimmed.length >= 2 && trimmed.startsWith('"') && trimmed.endsWith('"')) {
    try {
      const parsed = JSON.parse(trimmed);
      return typeof parsed === 'string' ? parsed : value;
    } catch {
      return trimmed.slice(1, -1);
    }
  }
  return value;
};

// ============ 群消息类型（API 返回的） ============

interface GroupChatMessage {
  messageId?: number;
  groupId?: number;
  senderId?: number;
  senderName?: string;
  senderAvatar?: string;
  content?: string;
  type?: string;
  replyTo?: number;
  createTime?: string;
  readCount?: number;
  memberCount?: number;
}

// ============ 已读用户弹出层 ============

interface ReadUsersPopoverProps {
  messageId: number;
  readCount: number;
  onClose: () => void;
}

const ReadUsersPopover: React.FC<ReadUsersPopoverProps> = ({ messageId, readCount, onClose }) => {
  const [users, setUsers] = useState<MessageReadUserResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const popoverRef = useRef<HTMLDivElement>(null);
  const { groupReadReceipts } = useChat();

  // HTTP 一次性加载
  useEffect(() => {
    const load = async () => {
      try {
        const res = await api.getReadUsers({ messageId });
        setUsers(res.data?.data || []);
      } catch {
        toast.error('加载已读列表失败');
      } finally {
        setLoading(false);
      }
    };
    load();
  }, [messageId]);

  // WebSocket 实时追加新已读用户
  useEffect(() => {
    if (groupReadReceipts.length === 0) return;
    const latest = groupReadReceipts[0];
    if (String(latest.messageId) !== String(messageId)) return;
    // 去重：如果该用户已存在则不追加
    setUsers((prev) => {
      if (prev.some((u) => String(u.userId) === String(latest.readerId))) return prev;
      return [...prev, {
        userId: latest.readerId,
        userName: latest.readerName,
        userAvatar: latest.readerAvatar,
        readTime: latest.readTime,
      }];
    });
  }, [groupReadReceipts, messageId]);

  // 点击外部关闭
  useEffect(() => {
    const handler = (e: MouseEvent) => {
      if (popoverRef.current && !popoverRef.current.contains(e.target as Node)) {
        onClose();
      }
    };
    document.addEventListener('mousedown', handler);
    return () => document.removeEventListener('mousedown', handler);
  }, [onClose]);

  return (
    <div
      ref={popoverRef}
      className="absolute bottom-full mb-2 right-0 z-50 w-56 bg-white dark:bg-gray-800 rounded-xl shadow-xl border border-gray-200 dark:border-gray-700 overflow-hidden animate-in fade-in slide-in-from-bottom-2 duration-200"
    >
      <div className="flex items-center justify-between px-3 py-2 border-b border-gray-100 dark:border-gray-700">
        <div className="flex items-center gap-1.5 text-xs font-medium text-gray-600 dark:text-gray-300">
          <Eye size={13} />
          <span>{readCount} 人已读</span>
        </div>
        <button onClick={onClose} className="p-0.5 rounded hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors">
          <X size={13} className="text-gray-400" />
        </button>
      </div>
      <div className="max-h-48 overflow-y-auto">
        {loading ? (
          <div className="flex items-center justify-center py-4">
            <Loader2 size={16} className="animate-spin text-gray-400" />
          </div>
        ) : users.length === 0 ? (
          <p className="text-xs text-gray-400 text-center py-4">暂无已读记录</p>
        ) : (
          users.map((u) => (
            <div key={String(u.userId)} className="flex items-center gap-2.5 px-3 py-2 hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors">
              <Avatar src={u.userAvatar} name={u.userName} size="sm" />
              <div className="flex-1 min-w-0">
                <p className="text-xs font-medium text-gray-700 dark:text-gray-200 truncate">
                  {u.userName || '未知用户'}
                </p>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
};

// ============ 工具函数 ============

const formatMessageTime = (dateStr?: string) => {
  if (!dateStr) return '';
  const time = new Date(dateStr);
  const hours = time.getHours().toString().padStart(2, '0');
  const mins = time.getMinutes().toString().padStart(2, '0');
  return `${hours}:${mins}`;
};

// ============ 已读数徽标（可点击展开已读用户列表） ============

const ReadCountBadge: React.FC<{ messageId: number; readCount: number }> = ({ messageId, readCount }) => {
  const [showPopover, setShowPopover] = useState(false);

  return (
    <span className="relative">
      <button
        onClick={() => setShowPopover((v) => !v)}
        className="text-[10px] text-brand-400 flex items-center gap-0.5 hover:text-brand-500 transition-colors cursor-pointer"
      >
        <CheckCheck size={12} />
        {readCount}
      </button>
      {showPopover && (
        <ReadUsersPopover
          messageId={messageId}
          readCount={readCount}
          onClose={() => setShowPopover(false)}
        />
      )}
    </span>
  );
};

// ============ 群聊窗口 ============

interface GroupChatWindowProps {
  groupId: number;
  groupName?: string;
  groupAvatar?: string;
  onBack: () => void;
  onGroupUpdated?: () => void;
}

const getCurrentUserId = (): string => {
  try {
    const stored = localStorage.getItem('user_info');
    if (stored) return String(JSON.parse(stored)?.id ?? '');
  } catch { /* ignore */ }
  return '';
};

interface GroupSettingsPanelProps {
  groupId: number;
  isOpen: boolean;
  onClose: () => void;
  onChanged: () => void;
  onLeft: () => void;
}

const GroupSettingsPanel: React.FC<GroupSettingsPanelProps> = ({
  groupId, isOpen, onClose, onChanged, onLeft,
}) => {
  const [shouldRender, setShouldRender] = useState(isOpen);
  const [isVisible, setIsVisible] = useState(false);
  const currentUserId = getCurrentUserId();
  const [groupInfo, setGroupInfo] = useState<GroupResponse | null>(null);
  const [members, setMembers] = useState<GroupMemberResponse[]>([]);
  const [requests, setRequests] = useState<JoinRequestResponse[]>([]);
  const [userMap, setUserMap] = useState<Record<string, UserPublicResponse>>({});
  const userMapRef = useRef(userMap);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [avatar, setAvatar] = useState('');
  const [announcement, setAnnouncement] = useState('');
  const [joinMode, setJoinMode] = useState(0);
  const [inviteMode, setInviteMode] = useState(0);

  const currentMember = members.find((m) => String(m.userId) === currentUserId);
  const currentRole = currentMember?.role ?? (groupInfo?.ownerId && String(groupInfo.ownerId) === currentUserId ? 2 : 0);
  const isOwner = currentRole === 2;
  const canManage = currentRole === 1 || currentRole === 2;

  useEffect(() => {
    if (isOpen) {
      setShouldRender(true);
      const frame = requestAnimationFrame(() => setIsVisible(true));
      return () => cancelAnimationFrame(frame);
    }

    setIsVisible(false);
    const timer = window.setTimeout(() => setShouldRender(false), SETTINGS_PANEL_ANIMATION_MS);
    return () => window.clearTimeout(timer);
  }, [isOpen]);

  useEffect(() => {
    userMapRef.current = userMap;
  }, [userMap]);

  const fetchUserInfos = useCallback(async (ids: Array<number | string | undefined>) => {
    const uniqueIds = [...new Set(ids.filter((id): id is number | string => id != null).map(String))]
      .filter((id) => !userMapRef.current[id]);
    if (uniqueIds.length === 0) return;

    const results = await Promise.allSettled(
      uniqueIds.map((id) => api.getUserPublicInfo({ id: id as unknown as number }))
    );
    const next: Record<string, UserPublicResponse> = {};
    results.forEach((result, index) => {
      if (result.status === 'fulfilled' && result.value.data?.data) {
        next[uniqueIds[index]] = result.value.data.data;
      }
    });
    if (Object.keys(next).length > 0) {
      setUserMap((prev) => ({ ...prev, ...next }));
    }
  }, []);

  const loadSettings = useCallback(async () => {
    if (!isOpen) return;
    setLoading(true);
    try {
      const [infoRes, memberRes] = await Promise.all([
        api.getGroupInfo({ groupId }),
        api.getGroupMembers({ groupId }),
      ]);
      const info = infoRes.data?.data || null;
      const memberList = memberRes.data?.data || [];
      setGroupInfo(info);
      setMembers(memberList);
      setName(info?.groupName || '');
      setDescription(info?.description || '');
      setAvatar(info?.avatar || '');
      setAnnouncement(normalizeAnnouncementText(info?.announcement));
      setJoinMode(info?.joinMode ?? 0);
      setInviteMode(info?.inviteMode ?? 0);
      await fetchUserInfos([
        info?.ownerId,
        ...memberList.map((member) => member.userId),
      ]);

      const role = memberList.find((m) => String(m.userId) === currentUserId)?.role
        ?? (info?.ownerId && String(info.ownerId) === currentUserId ? 2 : 0);
      if (role === 1 || role === 2) {
        const requestRes = await api.getPendingRequests({ groupId });
        const pending = requestRes.data?.data || [];
        setRequests(pending);
        await fetchUserInfos(pending.map((request) => request.userId));
      } else {
        setRequests([]);
      }
    } catch {
      toast.error('加载群设置失败');
    } finally {
      setLoading(false);
    }
  }, [currentUserId, fetchUserInfos, groupId, isOpen]);

  useEffect(() => { loadSettings(); }, [loadSettings]);

  const handleSaveSettings = async () => {
    if (!groupInfo?.id || !name.trim()) {
      toast.warning('群名称不能为空');
      return;
    }
    setSaving(true);
    try {
      const updateGroupRequest: UpdateGroupRequest = {
        groupName: name.trim(),
        description: description.trim() || undefined,
        avatar: avatar.trim() || undefined,
      };
      await api.updateGroupInfo({ groupId, updateGroupRequest });
      await api.setJoinMode({ groupId, mode: joinMode });
      await apiClient.put(`/api/groups/${groupId}/invite-mode`, null, { params: { mode: inviteMode } });
      await apiClient.put(`/api/groups/${groupId}/announcement`, announcement.trim(), {
        headers: { 'Content-Type': 'text/plain;charset=UTF-8' },
      });
      toast.success('群设置已保存');
      await loadSettings();
      onChanged();
    } catch {
      toast.error('保存群设置失败');
    } finally {
      setSaving(false);
    }
  };

  const handleRequest = async (requestId: number | undefined, approve: boolean) => {
    if (!requestId) return;
    try {
      await api.handleJoinRequest({ requestId, handleJoinRequestDTO: { approve } });
      toast.success(approve ? '已通过申请' : '已拒绝申请');
      await loadSettings();
      onChanged();
    } catch {
      toast.error('处理申请失败');
    }
  };

  const handleSetAdmin = async (member: GroupMemberResponse, nextIsAdmin: boolean) => {
    if (!member.userId) return;
    try {
      await api.setAdmin({ groupId, targetUserId: member.userId, isAdmin: nextIsAdmin });
      toast.success(nextIsAdmin ? '已设为管理员' : '已取消管理员');
      await loadSettings();
    } catch {
      toast.error('设置管理员失败');
    }
  };

  const handleRemoveMember = async (member: GroupMemberResponse) => {
    if (!member.userId) return;
    if (!window.confirm('确定要移除该成员吗？')) return;
    try {
      await api.removeMember({ groupId, targetUserId: member.userId });
      toast.success('已移除成员');
      await loadSettings();
      onChanged();
    } catch {
      toast.error('移除成员失败');
    }
  };

  const handleLeave = async () => {
    if (!window.confirm(isOwner ? '群主不能直接退出，请先转让或解散群。' : '确定要退出该群聊吗？')) return;
    if (isOwner) return;
    try {
      await api.leaveGroup({ groupId });
      toast.success('已退出群聊');
      onLeft();
    } catch {
      toast.error('退出群聊失败');
    }
  };

  const handleDissolve = async () => {
    if (!window.confirm('确定要解散该群聊吗？此操作不可恢复。')) return;
    try {
      await api.dissolveGroup({ groupId });
      toast.success('群聊已解散');
      onLeft();
    } catch {
      toast.error('解散群聊失败');
    }
  };

  if (!shouldRender) return null;

  const ownerUser = groupInfo?.ownerId ? userMap[String(groupInfo.ownerId)] : null;

  return (
    <div
      className={`fixed inset-0 z-50 flex justify-end bg-gray-950/40 transition-opacity duration-200 ease-out ${
        isVisible ? 'opacity-100' : 'opacity-0'
      }`}
    >
      <button
        className="flex-1 cursor-default"
        onClick={onClose}
        aria-label="关闭群设置"
        tabIndex={isVisible ? 0 : -1}
      />
      <div
        className={`h-full w-full max-w-[560px] bg-white dark:bg-gray-900 border-l border-gray-200 dark:border-gray-800 shadow-2xl flex flex-col transition-transform duration-300 ease-[cubic-bezier(0.16,1,0.3,1)] will-change-transform ${
          isVisible ? 'translate-x-0' : 'translate-x-full'
        }`}
      >
        <div className="flex items-center gap-3 px-5 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="w-10 h-10 rounded-xl bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center text-brand-600 dark:text-brand-300">
            <Settings size={20} />
          </div>
          <div className="flex-1 min-w-0">
            <h3 className="text-sm font-semibold text-gray-900 dark:text-white">群聊设置</h3>
            <p className="text-xs text-gray-400 truncate">
              {groupInfo?.groupNumber ? `群号 ${groupInfo.groupNumber}` : '管理群资料、成员和加入申请'}
            </p>
          </div>
          <button onClick={onClose} className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={18} className="text-gray-400" />
          </button>
        </div>

        <div className="flex-1 overflow-y-auto">
          {loading ? (
            <div className="p-5 space-y-3">
              {Array.from({ length: 6 }).map((_, index) => (
                <div key={index} className="h-16 rounded-xl bg-gray-100 dark:bg-gray-800 animate-pulse" />
              ))}
            </div>
          ) : (
            <div className="p-5 space-y-5">
              <section className="space-y-3">
                <div>
                  <p className="text-xs font-semibold text-gray-500 dark:text-gray-400">群资料</p>
                  <p className="text-[11px] text-gray-400 mt-0.5">
                    {ownerUser?.userName ? `群主：${ownerUser.userName}` : `${groupInfo?.memberCount || members.length} 名成员`}
                  </p>
                </div>
                <div className="space-y-3">
                  <label className="block">
                    <span className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">群名称</span>
                    <input
                      value={name}
                      onChange={(e) => setName(e.target.value)}
                      disabled={!canManage}
                      maxLength={128}
                      className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 disabled:opacity-60"
                    />
                  </label>
                  <label className="block">
                    <span className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">群简介</span>
                    <textarea
                      value={description}
                      onChange={(e) => setDescription(e.target.value)}
                      disabled={!canManage}
                      maxLength={512}
                      rows={2}
                      className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 disabled:opacity-60 resize-none"
                    />
                  </label>
                  {canManage && (
                    <AvatarUploadField
                      label="群头像"
                      value={avatar}
                      onChange={setAvatar}
                      name={name}
                      icon="group"
                      businessType="group/avatar"
                    />
                  )}
                </div>
              </section>

              <section className="space-y-3">
                <p className="text-xs font-semibold text-gray-500 dark:text-gray-400">加入与邀请</p>
                {canManage ? (
                  <>
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
                  </>
                ) : (
                  <div className="text-sm text-gray-600 dark:text-gray-300 bg-gray-50 dark:bg-gray-800/50 rounded-lg px-3 py-2">
                    {JOIN_MODE_LABELS[groupInfo?.joinMode ?? 0]}，{INVITE_MODE_LABELS[groupInfo?.inviteMode ?? 0]}
                  </div>
                )}
              </section>

              <section className="space-y-3">
                <p className="text-xs font-semibold text-gray-500 dark:text-gray-400">群公告</p>
                <textarea
                  value={announcement}
                  onChange={(e) => setAnnouncement(e.target.value)}
                  disabled={!canManage}
                  maxLength={512}
                  rows={3}
                  placeholder="暂无公告"
                  className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400 disabled:opacity-60 resize-none"
                />
              </section>

              {canManage && (
                <section className="space-y-3">
                  <div className="flex items-center justify-between">
                    <p className="text-xs font-semibold text-gray-500 dark:text-gray-400">入群申请</p>
                    <span className="text-[11px] text-gray-400">{requests.length} 条待处理</span>
                  </div>
                  {requests.length === 0 ? (
                    <p className="text-sm text-gray-400 bg-gray-50 dark:bg-gray-800/50 rounded-lg px-3 py-3">暂无待审批申请</p>
                  ) : (
                    <div className="divide-y divide-gray-100 dark:divide-gray-800 border border-gray-100 dark:border-gray-800 rounded-xl overflow-hidden">
                      {requests.map((request) => {
                        const user = request.userId ? userMap[String(request.userId)] : null;
                        return (
                          <div key={String(request.id)} className="flex items-center gap-3 px-3 py-3">
                            <Avatar src={user?.userAvatar} name={user?.userName || String(request.userId)} size="sm" />
                            <div className="flex-1 min-w-0">
                              <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{user?.userName || `用户 ${request.userId}`}</p>
                              <p className="text-xs text-gray-400 truncate">{request.message || '申请加入群聊'}</p>
                            </div>
                            <button onClick={() => handleRequest(request.id, false)} className="p-2 rounded-lg text-gray-400 hover:text-rose-600 hover:bg-rose-50 dark:hover:bg-rose-900/20 transition-colors">
                              <X size={16} />
                            </button>
                            <button onClick={() => handleRequest(request.id, true)} className="p-2 rounded-lg text-gray-400 hover:text-emerald-600 hover:bg-emerald-50 dark:hover:bg-emerald-900/20 transition-colors">
                              <Check size={16} />
                            </button>
                          </div>
                        );
                      })}
                    </div>
                  )}
                </section>
              )}

              <section className="space-y-3">
                <div className="flex items-center justify-between">
                  <p className="text-xs font-semibold text-gray-500 dark:text-gray-400">群成员</p>
                  <span className="text-[11px] text-gray-400">{members.length} 人</span>
                </div>
                <div className="divide-y divide-gray-100 dark:divide-gray-800 border border-gray-100 dark:border-gray-800 rounded-xl overflow-hidden">
                  {members.map((member) => {
                    const user = member.userId ? userMap[String(member.userId)] : null;
                    const role = member.role ?? 0;
                    const isSelf = String(member.userId) === currentUserId;
                    return (
                      <div key={String(member.id)} className="flex items-center gap-3 px-3 py-3">
                        <Avatar src={user?.userAvatar} name={user?.userName || String(member.userId)} size="sm" />
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-1.5">
                            <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{user?.userName || `用户 ${member.userId}`}</p>
                            {isSelf && <span className="text-[10px] text-gray-400">我</span>}
                          </div>
                          <p className="text-xs text-gray-400">
                            {role === 2 ? '群主' : role === 1 ? '管理员' : '成员'}
                          </p>
                        </div>
                        {role === 2 && <Crown size={16} className="text-amber-500" />}
                        {role === 1 && <Shield size={16} className="text-brand-500" />}
                        {isOwner && role !== 2 && member.userId && (
                          <button
                            onClick={() => handleSetAdmin(member, role !== 1)}
                            className="p-2 rounded-lg text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-colors"
                            title={role === 1 ? '取消管理员' : '设为管理员'}
                          >
                            <UserCheck size={16} />
                          </button>
                        )}
                        {canManage && role !== 2 && !isSelf && member.userId && (
                          <button
                            onClick={() => handleRemoveMember(member)}
                            className="p-2 rounded-lg text-gray-400 hover:text-rose-600 hover:bg-rose-50 dark:hover:bg-rose-900/20 transition-colors"
                            title="移除成员"
                          >
                            <UserMinus size={16} />
                          </button>
                        )}
                      </div>
                    );
                  })}
                </div>
              </section>
            </div>
          )}
        </div>

        <div className="px-5 py-4 border-t border-gray-100 dark:border-gray-800 space-y-3">
          {canManage && (
            <button
              onClick={handleSaveSettings}
              disabled={saving || !name.trim()}
              className="w-full flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 rounded-lg transition-colors active:scale-[0.98]"
            >
              {saving && <Loader2 size={16} className="animate-spin" />}
              保存设置
            </button>
          )}
          <div className="grid grid-cols-2 gap-2">
            <button
              onClick={handleLeave}
              disabled={isOwner}
              className="flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-medium text-gray-600 dark:text-gray-300 bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 disabled:opacity-50 rounded-lg transition-colors active:scale-[0.98]"
            >
              <LogOut size={16} />
              退出群聊
            </button>
            <button
              onClick={handleDissolve}
              disabled={!isOwner}
              className="flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-medium text-rose-600 dark:text-rose-300 bg-rose-50 dark:bg-rose-900/20 hover:bg-rose-100 dark:hover:bg-rose-900/30 disabled:opacity-50 rounded-lg transition-colors active:scale-[0.98]"
            >
              <Trash2 size={16} />
              解散群聊
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

const GroupChatWindow: React.FC<GroupChatWindowProps> = ({
  groupId, groupName, groupAvatar, onBack, onGroupUpdated,
}) => {
  const { sendGroupMessage, subscribeToGroup, unsubscribeFromGroup, markGroupMessageAsRead, groupMessages, groupReadReceipts, groupMessagesSent } = useChat();
  const [messages, setMessages] = useState<GroupChatMessage[]>([]);
  const [groupInfo, setGroupInfo] = useState<GroupResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [inputValue, setInputValue] = useState('');
  const [sending, setSending] = useState(false);
  const [showSettings, setShowSettings] = useState(false);
  const [replyingTo, setReplyingTo] = useState<GroupChatMessage | null>(null);
  const [highlightedMessageId, setHighlightedMessageId] = useState<number | null>(null);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const scrollContainerRef = useRef<HTMLDivElement>(null);
  const messageRefs = useRef<Record<string, HTMLDivElement | null>>({});
  const currentUserId = useRef<string>(getCurrentUserId());

  // 上传功能
  const handleUploadSend = useCallback((content: string, type: string) => {
    const userInfo = (() => { try { return JSON.parse(localStorage.getItem('user_info') || '{}'); } catch { return {}; } })();
    const replyTo = replyingTo?.messageId;
    setReplyingTo(null);
    const optimisticMsg: GroupChatMessage = {
      messageId: Date.now(),
      groupId,
      senderId: -1,
      senderName: userInfo.userName,
      senderAvatar: userInfo.userAvatar,
      content,
      type,
      replyTo,
      createTime: new Date().toISOString(),
    };
    setMessages((prev) => [...prev, optimisticMsg]);
    sendGroupMessage(groupId, content, type, replyTo);
  }, [groupId, replyingTo, sendGroupMessage]);

  const {
    uploading, isDragging, imageInputRef, fileInputRef,
    triggerImagePick, triggerFilePick, handleInputChange,
    handleDragEnter, handleDragLeave, handleDragOver, handleDrop,
  } = useChatUpload({ onSend: handleUploadSend });

  // 订阅群消息
  useEffect(() => {
    subscribeToGroup(groupId);
    return () => {
      unsubscribeFromGroup(groupId);
    };
  }, [groupId, subscribeToGroup, unsubscribeFromGroup]);

  // 加载群信息和历史消息
  const loadData = useCallback(async () => {
    setLoading(true);
    try {
      const [infoRes, msgsRes] = await Promise.all([
        api.getGroupInfo({ groupId }),
        api.getLatestMessages({ groupId, limit: 50 }),
      ]);
      setGroupInfo(infoRes.data?.data || null);
      const msgs: GroupChatMessage[] = msgsRes.data?.data || [];
      setMessages(msgs.reverse());

      // 标记最后一条消息已读
      if (msgs.length > 0) {
        const lastMsg = msgs[msgs.length - 1];
        if (lastMsg.messageId && String(lastMsg.senderId) !== currentUserId.current) {
          markGroupMessageAsRead(groupId, lastMsg.messageId);
        }
      }
    } catch {
      toast.error('加载群聊数据失败');
    } finally {
      setLoading(false);
    }
  }, [groupId, markGroupMessageAsRead]);

  useEffect(() => { loadData(); }, [loadData]);

  const handleGroupChanged = useCallback(() => {
    loadData();
    onGroupUpdated?.();
  }, [loadData, onGroupUpdated]);

  const handleLeftGroup = useCallback(() => {
    setShowSettings(false);
    onGroupUpdated?.();
    onBack();
  }, [onBack, onGroupUpdated]);

  // 监听 WebSocket 新群消息（只收他人消息，后端已排除发送者）
  useEffect(() => {
    if (groupMessages.length === 0) return;
    const latest = groupMessages[0];
    if (String(latest.groupId) === String(groupId)) {
      const newMsg: GroupChatMessage = {
        messageId: latest.messageId,
        groupId: latest.groupId,
        senderId: latest.senderId,
        senderName: latest.senderName,
        senderAvatar: latest.senderAvatar,
        content: latest.content,
        type: latest.type,
        replyTo: latest.replyTo,
        createTime: latest.createTime,
        readCount: latest.readCount,
        memberCount: latest.memberCount,
      };
      setMessages((prev) => {
        // 防重：如果该 messageId 已存在则不追加
        if (latest.messageId && prev.some((m) => String(m.messageId) === String(latest.messageId))) {
          return prev;
        }
        return [...prev, newMsg];
      });
      // 收到他人消息时，标记已读
      if (latest.messageId) {
        markGroupMessageAsRead(groupId, latest.messageId);
      }
    }
  }, [groupMessages, groupId, markGroupMessageAsRead]);

  // 监听发送确认（发送者专用），用服务端返回的真实 messageId 替换乐观消息
  useEffect(() => {
    if (groupMessagesSent.length === 0) return;
    const confirmed = groupMessagesSent[0];
    if (String(confirmed.groupId) === String(groupId)) {
      setMessages((prev) => {
        // 找到最后一条乐观更新的消息（senderId === -1）并替换
        let idx = -1;
        for (let i = prev.length - 1; i >= 0; i--) {
          if (String(prev[i].senderId) === '-1' && prev[i].content === confirmed.content) { idx = i; break; }
        }
        if (idx !== -1) {
          const updated = [...prev];
          updated[idx] = {
            messageId: confirmed.messageId,
            groupId: confirmed.groupId,
            senderId: confirmed.senderId,
            senderName: confirmed.senderName,
            senderAvatar: confirmed.senderAvatar,
            content: confirmed.content,
            type: confirmed.type,
            replyTo: confirmed.replyTo,
            createTime: confirmed.createTime,
            readCount: 0,
            memberCount: confirmed.memberCount,
          };
          return updated;
        }
        return prev;
      });
    }
  }, [groupMessagesSent, groupId]);

  // 监听 WebSocket 群已读回执，实时更新 readCount
  useEffect(() => {
    if (groupReadReceipts.length === 0) return;
    const latest = groupReadReceipts[0];
    if (String(latest.groupId) === String(groupId)) {
      setMessages((prev) =>
        prev.map((msg) =>
          String(msg.messageId) === String(latest.messageId)
            ? { ...msg, readCount: latest.totalReadCount }
            : msg
        )
      );
    }
  }, [groupReadReceipts, groupId]);

  // 滚动到底部（仅滚动消息容器，不影响页面）
  useEffect(() => {
    const container = scrollContainerRef.current;
    if (container) {
      container.scrollTop = container.scrollHeight;
    }
  }, [messages]);

  // 发送消息
  const handleSend = () => {
    const content = inputValue.trim();
    if (!content) return;

    setSending(true);
    setInputValue('');
    const replyTo = replyingTo?.messageId;
    setReplyingTo(null);

    // 乐观更新（senderId 用 -1 作为占位标记，后续 WebSocket 回传时替换）
    const userInfo = (() => { try { return JSON.parse(localStorage.getItem('user_info') || '{}'); } catch { return {}; } })();
    const optimisticMsg: GroupChatMessage = {
      messageId: Date.now(),
      groupId,
      senderId: -1,
      senderName: userInfo.userName,
      senderAvatar: userInfo.userAvatar,
      content,
      type: 'TEXT',
      replyTo,
      createTime: new Date().toISOString(),
    };
    setMessages((prev) => [...prev, optimisticMsg]);

    try {
      sendGroupMessage(groupId, content, 'TEXT', replyTo);
    } catch {
      toast.error('发送失败');
    } finally {
      setSending(false);
    }
  };

  // 判断是否是自己发的消息（ID 全部转字符串比较，避免大整数精度丢失）
  const isSelf = (msg: GroupChatMessage) =>
    msg.senderId === -1 || (currentUserId.current !== '' && String(msg.senderId) === currentUserId.current);

  const findReplyMessage = (replyTo?: number) =>
    replyTo ? messages.find((msg) => String(msg.messageId) === String(replyTo)) || null : null;

  const scrollToMessage = (messageId?: number) => {
    if (!messageId) return;
    const node = messageRefs.current[String(messageId)];
    if (!node) {
      toast.info('引用的消息不在当前记录中');
      return;
    }
    node.scrollIntoView({ behavior: 'smooth', block: 'center' });
    setHighlightedMessageId(messageId);
    window.setTimeout(() => setHighlightedMessageId((current) => (current === messageId ? null : current)), 1400);
  };

  return (
    <div className="flex flex-col h-full">
      {/* 头部 */}
      <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-100 dark:border-gray-800 bg-white/80 dark:bg-gray-900/80 backdrop-blur-sm">
        <button
          onClick={onBack}
          className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
        >
          <ArrowLeft size={18} className="text-gray-500" />
        </button>
        <Avatar src={groupAvatar || groupInfo?.avatar} name={groupName || groupInfo?.groupName} icon="group" size="sm" />
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2">
            <p className="text-sm font-semibold text-gray-900 dark:text-white truncate">
              {groupName || groupInfo?.groupName || '群聊'}
            </p>
            {groupInfo?.groupNumber && (
              <span className="flex items-center gap-0.5 text-[10px] text-gray-400 bg-gray-100 dark:bg-gray-800 px-1.5 py-0.5 rounded">
                <Hash size={10} />
                {groupInfo.groupNumber}
              </span>
            )}
          </div>
          <p className="text-[11px] text-gray-400">
            {groupInfo?.memberCount || 0} 名成员
          </p>
        </div>
        <button
          onClick={() => setShowSettings(true)}
          className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
          title="群设置"
        >
          <Settings size={18} className="text-gray-500" />
        </button>
      </div>

      <GroupSettingsPanel
        groupId={groupId}
        isOpen={showSettings}
        onClose={() => setShowSettings(false)}
        onChanged={handleGroupChanged}
        onLeft={handleLeftGroup}
      />

      {/* 消息列表（支持拖拽上传） */}
      <div
        ref={scrollContainerRef}
        className="flex-1 overflow-y-auto px-4 py-3 space-y-3 bg-gray-50/50 dark:bg-gray-950/50 relative"
        onDragEnter={handleDragEnter}
        onDragLeave={handleDragLeave}
        onDragOver={handleDragOver}
        onDrop={handleDrop}
      >
        {/* 拖拽遮罩 */}
        {isDragging && (
          <div className="absolute inset-0 z-20 flex flex-col items-center justify-center bg-brand-50/90 dark:bg-brand-950/90 border-2 border-dashed border-brand-400 rounded-xl backdrop-blur-sm">
            <Upload size={40} className="text-brand-500 mb-2" />
            <p className="text-sm font-medium text-brand-600 dark:text-brand-400">释放以发送文件</p>
            <p className="text-xs text-brand-400 mt-1">支持图片和文件</p>
          </div>
        )}
        {loading ? (
          <div className="flex items-center justify-center py-16 text-gray-400">
            <Loader2 size={24} className="animate-spin" />
          </div>
        ) : messages.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 text-gray-400">
            <UsersRound size={40} className="mb-3 opacity-40" />
            <p className="text-sm">暂无消息，开始群聊吧</p>
          </div>
        ) : (
          messages.map((msg) => {
            const self = isSelf(msg);
            return (
              <div
                key={msg.messageId}
                ref={(node) => { if (msg.messageId) messageRefs.current[String(msg.messageId)] = node; }}
                className={`group flex gap-2 rounded-2xl transition-shadow ${self ? 'flex-row-reverse' : ''} ${
                  highlightedMessageId && String(highlightedMessageId) === String(msg.messageId)
                    ? 'ring-2 ring-brand-300 ring-offset-2 ring-offset-gray-50 dark:ring-offset-gray-950'
                    : ''
                }`}
              >
                <Avatar src={msg.senderAvatar} name={msg.senderName} size="sm" />
                <div className={`max-w-[70%] flex flex-col ${self ? 'items-end' : 'items-start'}`}>
                  {!self && msg.senderName && (
                    <span className="text-[11px] text-gray-400 mb-0.5 px-1">
                      {msg.senderName}
                    </span>
                  )}
                  <MessageBubble
                    content={msg.content || ''}
                    type={msg.type || 'TEXT'}
                    isSelf={self}
                    replyPreview={msg.replyTo ? (
                      <ReplyPreview
                        message={findReplyMessage(msg.replyTo)}
                        fallbackName={groupName || groupInfo?.groupName}
                        isSelf={self}
                        embedded
                        onClick={() => scrollToMessage(msg.replyTo)}
                      />
                    ) : undefined}
                  />
                  <div className={`flex items-center gap-1 mt-1 ${self ? 'flex-row-reverse' : ''}`}>
                    <span className="text-[10px] text-gray-400">
                      {formatMessageTime(msg.createTime)}
                    </span>
                    {self && msg.messageId && msg.messageId !== -1 && (
                      <ReadCountBadge messageId={msg.messageId} readCount={msg.readCount ?? 0} />
                    )}
                  </div>
                </div>
                {msg.messageId && msg.senderId !== -1 && (
                  <button
                    type="button"
                    onClick={() => setReplyingTo(msg)}
                    className="self-center p-1.5 rounded-lg text-gray-300 hover:text-brand-500 hover:bg-white dark:hover:bg-gray-800 opacity-0 group-hover:opacity-100 focus:opacity-100 transition-all"
                    title="引用回复"
                  >
                    <Reply size={14} />
                  </button>
                )}
              </div>
            );
          })
        )}
        <div ref={messagesEndRef} />
      </div>

      {/* 隐藏的文件输入 */}
      <input ref={imageInputRef} type="file" accept="image/*" multiple className="hidden" onChange={handleInputChange} />
      <input ref={fileInputRef} type="file" multiple className="hidden" onChange={handleInputChange} />

      {/* 上传进度提示 */}
      {uploading && (
        <div className="px-4 py-2 bg-brand-50 dark:bg-brand-900/20 border-t border-brand-100 dark:border-brand-800 flex items-center gap-2">
          <Loader2 size={14} className="animate-spin text-brand-500" />
          <span className="text-xs text-brand-600 dark:text-brand-400">正在上传...</span>
        </div>
      )}

      {/* 输入栏 */}
      <div className="px-4 py-3 border-t border-gray-100 dark:border-gray-800 bg-white dark:bg-gray-900">
        {replyingTo && (
          <ReplyComposerBar
            message={replyingTo}
            fallbackName={groupName || groupInfo?.groupName}
            onCancel={() => setReplyingTo(null)}
          />
        )}
        <div className="flex items-center gap-1.5">
          {/* 图片按钮 */}
          <button
            onClick={triggerImagePick}
            disabled={uploading}
            className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-50 transition-colors text-gray-400 hover:text-brand-500"
            title="发送图片"
          >
            <Image size={20} />
          </button>
          {/* 文件按钮 */}
          <button
            onClick={triggerFilePick}
            disabled={uploading}
            className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-50 transition-colors text-gray-400 hover:text-brand-500"
            title="发送文件"
          >
            <Paperclip size={20} />
          </button>
          <input
            type="text"
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === 'Enter' && !e.shiftKey && !e.nativeEvent.isComposing) {
                e.preventDefault();
                handleSend();
              }
            }}
            placeholder="输入消息..."
            className="flex-1 px-4 py-2.5 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 transition-all"
          />
          <button
            onClick={handleSend}
            disabled={sending || !inputValue.trim()}
            className="p-2.5 bg-brand-500 hover:bg-brand-600 disabled:opacity-50 disabled:cursor-not-allowed text-white rounded-xl transition-colors shadow-sm"
          >
            {sending ? <Loader2 size={18} className="animate-spin" /> : <Send size={18} />}
          </button>
        </div>
      </div>
    </div>
  );
};

export default GroupChatWindow;
