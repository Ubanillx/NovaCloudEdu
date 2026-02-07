import React, { useState, useEffect, useCallback } from 'react';
import {
  UsersRound, Plus, Globe, RefreshCw, Loader2, Search, ArrowLeft, Hash,
  Users, UserPlus, Check
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { GroupResponse, FriendResponse } from '../../api/generated/models';
import toast from '../ui/Toast';
import { Avatar } from '../ui/Avatar';
import GroupChatWindow from './GroupChatWindow';

const api = new DefaultApi(new Configuration(), '', apiClient);

// ============ 创建群聊面板 ============

const CreateGroupPanel: React.FC<{ onBack: () => void }> = ({ onBack }) => {
  const [groupName, setGroupName] = useState('');
  const [description, setDescription] = useState('');
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
          description: description.trim() || undefined,
        },
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
  const [searchType, setSearchType] = useState<'name' | 'id'>('name');
  const [results, setResults] = useState<GroupResponse[]>([]);
  const [searching, setSearching] = useState(false);
  const [applyingTo, setApplyingTo] = useState<Set<number>>(new Set());

  const handleSearch = async () => {
    const trimmed = keyword.trim();
    if (!trimmed) return;
    setSearching(true);
    try {
      if (searchType === 'id') {
        const groupId = parseInt(trimmed, 10);
        if (isNaN(groupId)) {
          toast.warning('请输入有效的群ID');
          setSearching(false);
          return;
        }
        const res = await api.getGroupInfo({ groupId });
        setResults(res.data?.data ? [res.data.data] : []);
      } else {
        const res = await api.searchGroups({ keyword: trimmed, pageNum: 1, pageSize: 20 });
        const data = res.data?.data;
        if (data && Array.isArray(data)) {
          setResults(data);
        } else if (data && typeof data === 'object' && 'groups' in data) {
          const groups = (data as { groups?: GroupResponse[] }).groups || [];
          setResults(groups);
        } else {
          setResults([]);
        }
      }
    } catch {
      toast.error('搜索失败');
    } finally {
      setSearching(false);
    }
  };

  const handleApply = async (groupId: number) => {
    setApplyingTo((prev) => new Set(prev).add(groupId));
    try {
      await api.applyToJoin({ groupId });
      toast.success('申请已发送');
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
            { key: 'id' as const, label: '按群ID' },
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
              type={searchType === 'id' ? 'number' : 'text'}
              placeholder={searchType === 'id' ? '输入群ID' : '输入群名称'}
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
            <Globe size={48} className="mb-3 opacity-40" />
            <p className="text-sm">{searchType === 'id' ? '输入群ID搜索' : '输入群名称搜索'}</p>
          </div>
        ) : (
          <div className="p-4 space-y-3">
            {results.map((group) => (
              <div
                key={group.id}
                className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4 shadow-sm hover:shadow-md transition-shadow"
              >
                <div className="flex items-center gap-3">
                  <Avatar src={group.avatar} name={group.groupName} icon="group" size="lg" />
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                      {group.groupName || '未知群聊'}
                    </p>
                    <div className="flex items-center gap-3 text-xs text-gray-400 mt-0.5">
                      <span>ID: {group.id}</span>
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
                    disabled={applyingTo.has(group.id!)}
                    className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 rounded-lg transition-colors whitespace-nowrap"
                  >
                    {applyingTo.has(group.id!) ? (
                      <Loader2 size={14} className="animate-spin" />
                    ) : (
                      <>
                        <UserPlus size={14} />
                        申请加入
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

const GroupChatPanel: React.FC = () => {
  const [groups, setGroups] = useState<GroupResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [showCreate, setShowCreate] = useState(false);
  const [showSearch, setShowSearch] = useState(false);
  const [activeGroupId, setActiveGroupId] = useState<number | null>(null);

  const loadGroups = useCallback(async () => {
    setLoading(true);
    try {
      const res = await api.getMyGroups();
      setGroups(res.data?.data || []);
    } catch {
      toast.error('加载群聊列表失败');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { loadGroups(); }, [loadGroups]);

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
                  onClick={() => { setActiveGroupId(group.id!); setShowCreate(false); setShowSearch(false); }}
                  className={`flex items-center gap-3 px-4 py-3 cursor-pointer transition-colors ${
                    activeGroupId === group.id
                      ? 'bg-brand-50 dark:bg-brand-900/20 border-r-2 border-brand-500'
                      : 'hover:bg-gray-50 dark:hover:bg-gray-800/50 border-r-2 border-transparent'
                  }`}
                >
                  <Avatar src={group.avatar} name={group.groupName} icon="group" />
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                        {group.groupName || '未知群聊'}
                      </p>
                      {group.groupNumber && (
                        <span className="flex items-center gap-0.5 text-[10px] text-gray-400 bg-gray-100 dark:bg-gray-800 px-1.5 py-0.5 rounded">
                          <Hash size={10} />
                          {group.groupNumber}
                        </span>
                      )}
                    </div>
                    <p className="text-xs text-gray-400 truncate">
                      {group.description || `${group.memberCount || 0} 名成员`}
                    </p>
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
          />
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
