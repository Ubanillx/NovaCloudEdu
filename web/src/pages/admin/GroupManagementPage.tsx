import React, { useState, useEffect, useCallback, useRef } from 'react';
import {
  Search,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  MessageCircle,
  Trash2,
  Edit2,
  Users,
  User,
  UserMinus,
  VolumeX,
  Volume2,
  Eye,
  Crown,
  Shield,
  Loader2,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type {
  GroupResponse,
  AdminGroupPageResponse,
  UpdateGroupRequest,
  UserPublicResponse,
  MemberPage,
} from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// ============ 状态映射 ============

const JOIN_MODE_MAP: Record<number, string> = { 0: '自由加入', 1: '需审批', 2: '禁止加入' };

const getJoinModeBadge = (mode?: number) => {
  switch (mode) {
    case 0: return 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800';
    case 1: return 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400 border-yellow-200 dark:border-yellow-800';
    case 2: return 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800';
    default: return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700';
  }
};

const MEMBER_ROLE_MAP: Record<number, string> = { 0: '成员', 1: '管理员', 2: '群主' };

const getRoleBadge = (role?: number) => {
  switch (role) {
    case 2: return 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800';
    case 1: return 'bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400 border-brand-200 dark:border-brand-800';
    default: return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700';
  }
};

const getRoleIcon = (role?: number) => {
  switch (role) {
    case 2: return Crown;
    case 1: return Shield;
    default: return User;
  }
};

// ============ 编辑群信息弹窗 ============

interface EditGroupModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  group: GroupResponse | null;
}

const EditGroupModal: React.FC<EditGroupModalProps> = ({ isOpen, onClose, onSuccess, group }) => {
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({ groupName: '', description: '', avatar: '' });

  useEffect(() => {
    if (group) {
      setFormData({
        groupName: group.groupName || '',
        description: group.description || '',
        avatar: group.avatar || '',
      });
    }
  }, [group, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!group?.id || !formData.groupName.trim()) { toast.warning('群名称不能为空'); return; }
    setLoading(true);
    try {
      const req: UpdateGroupRequest = {
        groupName: formData.groupName,
        description: formData.description || undefined,
        avatar: formData.avatar || undefined,
      };
      const res = await api.updateGroupInfo1({ groupId: group.id as unknown as number, updateGroupRequest: req });
      if (res.data.code === 0) { toast.success('更新成功'); onSuccess(); onClose(); }
      else toast.error(res.data.message || '更新失败');
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally { setLoading(false); }
  };

  if (!isOpen || !group) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">编辑群信息</h3>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
        </div>
        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">群名称 *</label>
            <input type="text" value={formData.groupName}
              onChange={(e) => setFormData(prev => ({ ...prev, groupName: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入群名称" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">群描述</label>
            <textarea value={formData.description} rows={3}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="群描述信息" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">群头像 URL</label>
            <input type="text" value={formData.avatar}
              onChange={(e) => setFormData(prev => ({ ...prev, avatar: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="https://..." />
          </div>
        </form>
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button type="button" onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
          <button onClick={handleSubmit} disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
            {loading && <Loader2 size={16} className="animate-spin" />}
            保存修改
          </button>
        </div>
      </div>
    </div>
  );
};

// ============ 群详情弹窗（成员管理） ============

interface GroupDetailModalProps {
  isOpen: boolean;
  onClose: () => void;
  group: GroupResponse | null;
  onRefresh: () => void;
}

const GroupDetailModal: React.FC<GroupDetailModalProps> = ({ isOpen, onClose, group, onRefresh }) => {
  const [members, setMembers] = useState<any[]>([]);
  const [memberLoading, setMemberLoading] = useState(false);
  const [memberPage, setMemberPage] = useState(1);
  const [memberTotal, setMemberTotal] = useState(0);
  const memberPageSize = 20;

  // 用户信息缓存
  const [userMap, setUserMap] = useState<Record<string, UserPublicResponse>>({});
  const userMapRef = useRef(userMap);
  userMapRef.current = userMap;

  const fetchUserInfos = useCallback(async (userIds: (number | string | undefined)[]) => {
    const ids = userIds.filter((id): id is number | string => id != null);
    const uniqueIds = [...new Set(ids.map(id => String(id)))].filter(id => !userMapRef.current[id]);
    if (uniqueIds.length === 0) return;
    const results = await Promise.allSettled(
      uniqueIds.map(id => api.getUserPublicInfo({ id: id as unknown as number }))
    );
    const newMap: Record<string, UserPublicResponse> = {};
    results.forEach((r, i) => {
      if (r.status === 'fulfilled' && r.value.data.code === 0 && r.value.data.data) {
        newMap[uniqueIds[i]] = r.value.data.data;
      }
    });
    if (Object.keys(newMap).length > 0) {
      setUserMap(prev => ({ ...prev, ...newMap }));
    }
  }, []);

  const fetchMembers = useCallback(async () => {
    if (!group?.id) return;
    setMemberLoading(true);
    try {
      const res = await api.getGroupMembers1({ groupId: group.id as unknown as number, pageNum: memberPage, pageSize: memberPageSize });
      if (res.data.code === 0) {
        const pageData = res.data.data as MemberPage | undefined;
        const list = pageData?.members || [];
        setMembers(list);
        setMemberTotal(pageData?.total || 0);
        fetchUserInfos(list.map((m: any) => m.userId));
      }
    } catch { /* ignore */ }
    finally { setMemberLoading(false); }
  }, [group?.id, memberPage, fetchUserInfos]);

  useEffect(() => {
    if (isOpen && group) {
      setMemberPage(1);
      setUserMap({});
    }
  }, [isOpen, group]);

  useEffect(() => { if (isOpen) fetchMembers(); }, [fetchMembers, isOpen]);

  // 获取群主信息
  useEffect(() => {
    if (isOpen && group?.ownerId) {
      fetchUserInfos([group.ownerId]);
    }
  }, [isOpen, group?.ownerId, fetchUserInfos]);

  const handleRemoveMember = async (userId?: number) => {
    if (!group?.id || !userId) return;
    if (!window.confirm('确定要移除该成员吗？')) return;
    try {
      const res = await api.removeMember2({ groupId: group.id as unknown as number, targetUserId: userId as unknown as number });
      if (res.data.code === 0) { toast.success('移除成功'); fetchMembers(); onRefresh(); }
      else toast.error(res.data.message || '移除失败');
    } catch (error: any) { toast.error(error?.response?.data?.message || '操作失败'); }
  };

  if (!isOpen || !group) return null;

  const memberTotalPages = Math.ceil(memberTotal / memberPageSize);
  const ownerUser = group.ownerId ? userMap[String(group.ownerId)] : null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[85vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 flex items-center justify-center overflow-hidden shadow-sm">
              {group.avatar ? (
                <img src={group.avatar} alt="" className="w-full h-full object-cover" />
              ) : (
                <MessageCircle size={20} className="text-brand-500" />
              )}
            </div>
            <div>
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">{group.groupName}</h3>
              <div className="flex items-center gap-2 mt-0.5">
                <span className="text-xs text-gray-400">群号: {group.groupNumber || '-'}</span>
                <span className="text-xs text-gray-300 dark:text-gray-600">|</span>
                <span className="text-xs text-gray-400">{group.memberCount ?? 0}/{group.maxMembers ?? 500} 人</span>
                {group.mute && <span className="text-xs text-red-500 font-medium">已全员禁言</span>}
              </div>
            </div>
          </div>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
        </div>

        {/* Group Info Summary */}
        <div className="px-6 py-3 bg-gray-50/50 dark:bg-gray-800/30 border-b border-gray-100 dark:border-gray-800">
          <div className="grid grid-cols-3 gap-4 text-sm">
            <div>
              <span className="text-xs text-gray-400 font-medium">群主</span>
              <div className="flex items-center gap-1.5 mt-0.5">
                {ownerUser ? (
                  <>
                    {ownerUser.userAvatar ? (
                      <img src={ownerUser.userAvatar} alt="" className="w-5 h-5 rounded object-cover" />
                    ) : (
                      <div className="w-5 h-5 rounded bg-gray-200 dark:bg-gray-700 flex items-center justify-center"><User size={12} className="text-gray-400" /></div>
                    )}
                    <span className="font-medium text-gray-900 dark:text-white">{ownerUser.userName || '未设置'}</span>
                  </>
                ) : (
                  <span className="text-gray-400">加载中...</span>
                )}
              </div>
            </div>
            <div>
              <span className="text-xs text-gray-400 font-medium">加入模式</span>
              <p className="mt-0.5"><span className={`px-2 py-0.5 rounded-lg text-xs font-bold border ${getJoinModeBadge(group.joinMode)}`}>{JOIN_MODE_MAP[group.joinMode ?? 0] || '未知'}</span></p>
            </div>
            <div>
              <span className="text-xs text-gray-400 font-medium">创建时间</span>
              <p className="mt-0.5 text-gray-700 dark:text-gray-300">{group.createTime ? new Date(group.createTime).toLocaleDateString() : '-'}</p>
            </div>
          </div>
          {group.announcement && (
            <div className="mt-3 p-2.5 bg-yellow-50 dark:bg-yellow-900/10 border border-yellow-100 dark:border-yellow-900/20 rounded-lg">
              <span className="text-xs text-yellow-600 dark:text-yellow-400 font-medium">群公告: </span>
              <span className="text-xs text-yellow-700 dark:text-yellow-300">{group.announcement}</span>
            </div>
          )}
        </div>

        {/* Members */}
        <div className="flex-1 overflow-y-auto p-6">
          <div className="flex items-center justify-between mb-3">
            <h4 className="text-sm font-bold text-gray-700 dark:text-gray-300 flex items-center gap-1.5"><Users size={16} /> 群成员 ({memberTotal})</h4>
          </div>
          <div className="border border-gray-100 dark:border-gray-800 rounded-xl overflow-hidden">
            <table className="w-full text-left">
              <thead>
                <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                  <th className="px-4 py-3 text-xs font-bold text-gray-400 uppercase tracking-wider">用户</th>
                  <th className="px-4 py-3 text-xs font-bold text-gray-400 uppercase tracking-wider">群角色</th>
                  <th className="px-4 py-3 text-xs font-bold text-gray-400 uppercase tracking-wider">加入时间</th>
                  <th className="px-4 py-3 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
                {memberLoading ? (
                  <tr><td colSpan={4} className="px-4 py-8 text-center text-gray-400">加载中...</td></tr>
                ) : members.length > 0 ? (
                  members.map((m: any) => {
                    const u = m.userId ? userMap[String(m.userId)] : null;
                    const RoleIcon = getRoleIcon(m.role);
                    return (
                      <tr key={String(m.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors">
                        <td className="px-4 py-3">
                          {m.userId ? (
                            u ? (
                              <div className="flex items-center gap-2.5">
                                {u.userAvatar ? (
                                  <img src={u.userAvatar} alt="" className="w-8 h-8 rounded-lg object-cover border border-gray-100 dark:border-gray-700" />
                                ) : (
                                  <div className="w-8 h-8 rounded-lg bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
                                    <User size={16} className="text-gray-400" />
                                  </div>
                                )}
                                <div>
                                  <p className="text-sm font-medium text-gray-900 dark:text-white">{u.userName || '未设置'}</p>
                                  {m.nickname && <p className="text-xs text-gray-400">群昵称: {m.nickname}</p>}
                                </div>
                              </div>
                            ) : (
                              <span className="text-xs text-gray-400">加载中...</span>
                            )
                          ) : (
                            <span className="text-xs text-gray-400">AI 成员</span>
                          )}
                        </td>
                        <td className="px-4 py-3">
                          <span className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-lg text-xs font-bold border ${getRoleBadge(m.role)}`}>
                            <RoleIcon size={12} /> {MEMBER_ROLE_MAP[m.role ?? 0] || '成员'}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-sm text-gray-500 dark:text-gray-400">
                          {m.joinTime ? new Date(m.joinTime).toLocaleDateString() : '-'}
                        </td>
                        <td className="px-4 py-3">
                          {m.role !== 2 && m.userId && (
                            <button onClick={() => handleRemoveMember(m.userId)}
                              className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="移除">
                              <UserMinus size={16} />
                            </button>
                          )}
                        </td>
                      </tr>
                    );
                  })
                ) : (
                  <tr><td colSpan={4} className="px-4 py-8 text-center text-gray-400">暂无成员</td></tr>
                )}
              </tbody>
            </table>
            {memberTotal > memberPageSize && (
              <div className="px-4 py-3 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
                <span className="text-xs text-gray-500">共 {memberTotal} 条</span>
                <div className="flex items-center gap-1">
                  <button disabled={memberPage === 1} onClick={() => setMemberPage(p => p - 1)}
                    className="p-1.5 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 disabled:opacity-50 transition-all">
                    <ChevronLeft size={14} />
                  </button>
                  <span className="text-xs text-gray-500 px-2">{memberPage}/{memberTotalPages}</span>
                  <button disabled={memberPage >= memberTotalPages} onClick={() => setMemberPage(p => p + 1)}
                    className="p-1.5 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 disabled:opacity-50 transition-all">
                    <ChevronRight size={14} />
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

// ============ 群聊管理主页面 ============

export const GroupManagementPage: React.FC = () => {
  const [groups, setGroups] = useState<GroupResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [page, setPage] = useState(1);
  const [total, setTotal] = useState(0);
  const [keyword, setKeyword] = useState('');
  const [editModalOpen, setEditModalOpen] = useState(false);
  const [editingGroup, setEditingGroup] = useState<GroupResponse | null>(null);
  const [detailModalOpen, setDetailModalOpen] = useState(false);
  const [detailGroup, setDetailGroup] = useState<GroupResponse | null>(null);
  const pageSize = 10;

  // 群主用户信息缓存
  const [userMap, setUserMap] = useState<Record<string, UserPublicResponse>>({});
  const userMapRef = useRef(userMap);
  userMapRef.current = userMap;

  const fetchUserInfos = useCallback(async (userIds: (number | string | undefined)[]) => {
    const ids = userIds.filter((id): id is number | string => id != null);
    const uniqueIds = [...new Set(ids.map(id => String(id)))].filter(id => !userMapRef.current[id]);
    if (uniqueIds.length === 0) return;
    const results = await Promise.allSettled(
      uniqueIds.map(id => api.getUserPublicInfo({ id: id as unknown as number }))
    );
    const newMap: Record<string, UserPublicResponse> = {};
    results.forEach((r, i) => {
      if (r.status === 'fulfilled' && r.value.data.code === 0 && r.value.data.data) {
        newMap[uniqueIds[i]] = r.value.data.data;
      }
    });
    if (Object.keys(newMap).length > 0) {
      setUserMap(prev => ({ ...prev, ...newMap }));
    }
  }, []);

  const fetchGroups = useCallback(async () => {
    setLoading(true);
    try {
      let res;
      if (keyword.trim()) {
        res = await api.searchGroups1({ keyword: keyword.trim(), pageNum: page, pageSize: pageSize });
      } else {
        res = await api.listGroups({ pageNum: page, pageSize: pageSize });
      }
      if (res.data.code === 0) {
        const pageData = res.data.data as AdminGroupPageResponse | undefined;
        const list = pageData?.list || [];
        setGroups(list);
        setTotal(pageData?.total || 0);
        fetchUserInfos(list.map(g => g.ownerId));
      } else {
        toast.error(res.data.message || '获取群列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally { setLoading(false); }
  }, [page, keyword, fetchUserInfos]);

  useEffect(() => { fetchGroups(); }, [fetchGroups]);

  const handleDissolve = async (group: GroupResponse) => {
    if (!group.id) return;
    if (!window.confirm(`确定要解散群 "${group.groupName}" 吗？此操作不可恢复，所有成员将被移除。`)) return;
    try {
      const res = await api.dissolveGroup1({ groupId: group.id as unknown as number });
      if (res.data.code === 0) { toast.success('解散成功'); fetchGroups(); }
      else toast.error(res.data.message || '解散失败');
    } catch (error: any) { toast.error(error?.response?.data?.message || '网络错误'); }
  };

  const handleToggleMute = async (group: GroupResponse) => {
    if (!group.id) return;
    const newMute = !group.mute;
    try {
      const res = await api.setMute({ groupId: group.id as unknown as number, mute: newMute });
      if (res.data.code === 0) { toast.success(newMute ? '已全员禁言' : '已解除禁言'); fetchGroups(); }
      else toast.error(res.data.message || '操作失败');
    } catch (error: any) { toast.error(error?.response?.data?.message || '网络错误'); }
  };

  const totalPages = Math.ceil(total / pageSize);

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">群聊管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理平台所有群聊，查看成员、编辑信息、禁言和解散</p>
        </div>
      </div>

      {/* Filter */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <div className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input type="text" value={keyword}
              onChange={(e) => { setKeyword(e.target.value); setPage(1); }}
              placeholder="搜索群名称..."
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all" />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <button type="button" onClick={() => fetchGroups()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all">
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </div>
      </div>

      {/* Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">群信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">群主</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">成员 / 加入模式</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">创建时间</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={6} className="px-6 py-8 h-16">
                      <div className="flex gap-4"><div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1"><div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" /><div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" /></div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : groups.length > 0 ? (
                groups.map((g) => {
                  const ownerUser = g.ownerId ? userMap[String(g.ownerId)] : null;
                  return (
                    <tr key={String(g.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 rounded-xl bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 flex items-center justify-center overflow-hidden flex-shrink-0 shadow-sm">
                            {g.avatar ? (
                              <img src={g.avatar} alt="" className="w-full h-full object-cover" />
                            ) : (
                              <MessageCircle size={20} className="text-brand-500" />
                            )}
                          </div>
                          <div className="min-w-0">
                            <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors truncate max-w-[200px]">{g.groupName || '未命名'}</p>
                            {g.groupNumber && <p className="text-xs text-gray-400">群号: {g.groupNumber}</p>}
                            {g.description && <p className="text-xs text-gray-500 dark:text-gray-400 truncate max-w-[200px]">{g.description}</p>}
                          </div>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        {g.ownerId ? (
                          ownerUser ? (
                            <div className="flex items-center gap-2">
                              {ownerUser.userAvatar ? (
                                <img src={ownerUser.userAvatar} alt="" className="w-7 h-7 rounded-lg object-cover border border-gray-100 dark:border-gray-700" />
                              ) : (
                                <div className="w-7 h-7 rounded-lg bg-gray-100 dark:bg-gray-800 flex items-center justify-center"><User size={14} className="text-gray-400" /></div>
                              )}
                              <span className="text-sm font-medium text-gray-900 dark:text-white">{ownerUser.userName || '未设置'}</span>
                            </div>
                          ) : (
                            <span className="text-xs text-gray-400">加载中...</span>
                          )
                        ) : <span className="text-sm text-gray-400">-</span>}
                      </td>
                      <td className="px-6 py-4">
                        <div className="space-y-1">
                          <div className="flex items-center gap-1 text-sm text-gray-700 dark:text-gray-300">
                            <Users size={14} className="text-gray-400" />
                            <span className="font-medium">{g.memberCount ?? 0}</span>
                            <span className="text-gray-400">/ {g.maxMembers ?? 500}</span>
                          </div>
                          <span className={`px-2 py-0.5 rounded-lg text-[10px] font-bold border ${getJoinModeBadge(g.joinMode)}`}>
                            {JOIN_MODE_MAP[g.joinMode ?? 0] || '未知'}
                          </span>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        {g.mute ? (
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-lg text-xs font-bold border bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800">
                            <VolumeX size={12} /> 已禁言
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-lg text-xs font-bold border bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800">
                            <Volume2 size={12} /> 正常
                          </span>
                        )}
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-500 dark:text-gray-400">
                        {g.createTime ? new Date(g.createTime).toLocaleDateString() : '-'}
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2">
                          <button onClick={() => { setDetailGroup(g); setDetailModalOpen(true); }}
                            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="查看成员">
                            <Eye size={18} />
                          </button>
                          <button onClick={() => { setEditingGroup(g); setEditModalOpen(true); }}
                            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="编辑">
                            <Edit2 size={18} />
                          </button>
                          <button onClick={() => handleToggleMute(g)}
                            className={`p-2 rounded-lg transition-all ${g.mute
                              ? 'text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20'
                              : 'text-gray-400 hover:text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20'
                            }`} title={g.mute ? '解除禁言' : '全员禁言'}>
                            {g.mute ? <Volume2 size={18} /> : <VolumeX size={18} />}
                          </button>
                          <button onClick={() => handleDissolve(g)}
                            className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="解散群">
                            <Trash2 size={18} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })
              ) : (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <MessageCircle size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无群聊数据</p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 条，第 <span className="font-bold text-gray-900 dark:text-white">{page}</span> / {totalPages || 1} 页
          </p>
          <div className="flex items-center gap-2">
            <button disabled={page === 1 || loading} onClick={() => setPage(p => p - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
              <ChevronLeft size={18} />
            </button>
            {Array.from({ length: Math.min(5, totalPages) }).map((_, i) => {
              const pageNum = i + 1;
              return (
                <button key={pageNum} onClick={() => setPage(pageNum)}
                  className={`w-10 h-10 rounded-lg text-sm font-bold transition-all ${
                    page === pageNum ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' : 'text-gray-500 hover:bg-white dark:hover:bg-gray-800 border border-transparent hover:border-gray-200 dark:hover:border-gray-700'
                  }`}>{pageNum}</button>
              );
            })}
            <button disabled={page >= totalPages || loading} onClick={() => setPage(p => p + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* Modals */}
      <EditGroupModal
        isOpen={editModalOpen}
        onClose={() => { setEditModalOpen(false); setEditingGroup(null); }}
        onSuccess={fetchGroups}
        group={editingGroup}
      />
      <GroupDetailModal
        isOpen={detailModalOpen}
        onClose={() => { setDetailModalOpen(false); setDetailGroup(null); }}
        group={detailGroup}
        onRefresh={fetchGroups}
      />
    </div>
  );
};
