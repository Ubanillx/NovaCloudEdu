import React, { useState, useEffect, useCallback } from 'react';
import { 
  Search, 
  UserPlus, 
  Edit2, 
  Trash2, 
  Ban, 
  Filter,
  Download,
  ChevronLeft,
  ChevronRight,
  User,
  Users as UsersIcon,
  Mail,
  Phone as PhoneIcon,
  RefreshCw,
  X,
  Eye,
  EyeOff,
  Loader2
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { UserDetailResponse, QueryUserRequest, CreateUserRequest, UpdateUserRequest } from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

const ROLE_OPTIONS = [
  { value: 'student', label: '学生' },
  { value: 'teacher', label: '教师' },
  { value: 'admin', label: '系统管理员' },
] as const;

const normalizeUserRole = (role?: string) => {
  const normalized = (role || '').trim().toLowerCase();
  if (normalized === 'user' || normalized === 'student') return 'student';
  if (normalized === 'teacher') return 'teacher';
  if (normalized === 'admin') return 'admin';
  return normalized || 'student';
};

const getUserRoleLabel = (role?: string) => {
  const normalized = normalizeUserRole(role);
  return ROLE_OPTIONS.find(option => option.value === normalized)?.label || role || '未知角色';
};

// 用户表单弹窗组件
interface UserFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  user?: UserDetailResponse | null;
}

const UserFormModal: React.FC<UserFormModalProps> = ({ isOpen, onClose, onSuccess, user }) => {
  const isEdit = !!user;
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [formData, setFormData] = useState({
    userAccount: '',
    userPassword: '',
    confirmPassword: '',
    userName: '',
    role: 'student',
    userPhone: '',
    userEmail: '',
    userGender: 0,
  });

  useEffect(() => {
    if (user) {
      setFormData({
        userAccount: user.userAccount || '',
        userPassword: '',
        confirmPassword: '',
        userName: user.userName || '',
        role: normalizeUserRole(user.role),
        userPhone: user.userPhone || '',
        userEmail: user.userEmail || '',
        userGender: user.userGender || 0,
      });
    } else {
      setFormData({
        userAccount: '',
        userPassword: '',
        confirmPassword: '',
        userName: '',
        role: 'student',
        userPhone: '',
        userEmail: '',
        userGender: 0,
      });
    }
  }, [user, isOpen]);

  const handleSubmit = async (e?: React.FormEvent) => {
    e?.preventDefault();
    
    if (!isEdit && !formData.userAccount.trim()) {
      toast.warning('请输入账号');
      return;
    }
    if (!isEdit && (!formData.userPassword || formData.userPassword.length < 6)) {
      toast.warning('密码至少 6 位');
      return;
    }
    if (formData.userPassword) {
      if (formData.userPassword.length < 6 || formData.userPassword.length > 20) {
        toast.warning('密码长度需为 6-20 位');
        return;
      }
      if (formData.userPassword !== formData.confirmPassword) {
        toast.warning('两次输入的密码不一致');
        return;
      }
    }

    setLoading(true);
    try {
      if (isEdit && user?.id) {
        const updateData: UpdateUserRequest = {
          id: user.id,
          userName: formData.userName,
          role: formData.role,
          userPhone: formData.userPhone,
          userEmail: formData.userEmail,
          userGender: formData.userGender,
        };
        const response = await api.updateUser({ updateUserRequest: updateData });
        if (response.data.code === 0) {
          if (formData.userPassword) {
            const resetResponse = await api.resetPassword({
              resetPasswordRequest: {
                userId: user.id,
                newPassword: formData.userPassword,
              },
            });
            if (resetResponse.data.code !== 0) {
              toast.error(resetResponse.data.message || '密码修改失败');
              return;
            }
          }
          toast.success(formData.userPassword ? '用户信息和密码已更新' : '更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const createData: CreateUserRequest = {
          userAccount: formData.userAccount,
          userPassword: formData.userPassword,
          userName: formData.userName,
          role: formData.role,
          userPhone: formData.userPhone,
          userEmail: formData.userEmail,
          userGender: formData.userGender,
        };
        const response = await api.createUser({ createUserRequest: createData });
        if (response.data.code === 0) {
          toast.success('创建成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '创建失败');
        }
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑用户' : '新增用户'}
          </h3>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          {!isEdit && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">账号 *</label>
                <input
                  type="text"
                  value={formData.userAccount}
                  onChange={(e) => setFormData(prev => ({ ...prev, userAccount: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="请输入账号"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">密码 *</label>
                <div className="relative">
                  <input
                    type={showPassword ? 'text' : 'password'}
                    value={formData.userPassword}
                    onChange={(e) => setFormData(prev => ({ ...prev, userPassword: e.target.value }))}
                    className="w-full px-4 py-2.5 pr-12 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    placeholder="至少 6 位密码"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-brand-500 transition-colors"
                  >
                    {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                  </button>
                </div>
              </div>
            </>
          )}

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">用户名</label>
              <input
                type="text"
                value={formData.userName}
                onChange={(e) => setFormData(prev => ({ ...prev, userName: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="显示名称"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">角色</label>
              <select
                value={formData.role}
                onChange={(e) => setFormData(prev => ({ ...prev, role: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
              >
                {ROLE_OPTIONS.map(option => (
                  <option key={option.value} value={option.value}>{option.label}</option>
                ))}
              </select>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">手机号</label>
              <input
                type="tel"
                value={formData.userPhone}
                onChange={(e) => setFormData(prev => ({ ...prev, userPhone: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="手机号码"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">邮箱</label>
              <input
                type="email"
                value={formData.userEmail}
                onChange={(e) => setFormData(prev => ({ ...prev, userEmail: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="电子邮箱"
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">性别</label>
            <div className="flex gap-4">
              {[
                { value: 0, label: '未知' },
                { value: 1, label: '男' },
                { value: 2, label: '女' },
              ].map((option) => (
                <label key={option.value} className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="radio"
                    name="gender"
                    checked={formData.userGender === option.value}
                    onChange={() => setFormData(prev => ({ ...prev, userGender: option.value }))}
                    className="w-4 h-4 text-brand-600 border-gray-300 focus:ring-brand-500"
                  />
                  <span className="text-sm text-gray-600 dark:text-gray-400">{option.label}</span>
                </label>
              ))}
            </div>
          </div>

          {isEdit && (
            <div className="space-y-4">
              <div>
                <p className="text-sm font-semibold text-gray-900 dark:text-white">修改密码</p>
                <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">留空则保持原密码不变</p>
              </div>
              <div className="rounded-2xl border border-gray-100 dark:border-gray-800 bg-gray-50/60 dark:bg-gray-800/30 p-4">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">新密码</label>
                    <div className="relative">
                      <input
                        type={showPassword ? 'text' : 'password'}
                        value={formData.userPassword}
                        onChange={(e) => setFormData(prev => ({ ...prev, userPassword: e.target.value }))}
                        className="w-full px-4 py-2.5 pr-12 bg-white dark:bg-gray-900/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                        placeholder="6-20 位新密码"
                      />
                      <button
                        type="button"
                        onClick={() => setShowPassword(!showPassword)}
                        className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-brand-500 transition-colors"
                      >
                        {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                      </button>
                    </div>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">确认密码</label>
                    <div className="relative">
                      <input
                        type={showConfirmPassword ? 'text' : 'password'}
                        value={formData.confirmPassword}
                        onChange={(e) => setFormData(prev => ({ ...prev, confirmPassword: e.target.value }))}
                        className="w-full px-4 py-2.5 pr-12 bg-white dark:bg-gray-900/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                        placeholder="再次输入新密码"
                      />
                      <button
                        type="button"
                        onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                        className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-brand-500 transition-colors"
                      >
                        {showConfirmPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}
        </form>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            取消
          </button>
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading && <Loader2 size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建用户'}
          </button>
        </div>
      </div>
    </div>
  );
};

export const UserManagementPage: React.FC = () => {
  const [users, setUsers] = useState<UserDetailResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingUser, setEditingUser] = useState<UserDetailResponse | null>(null);
  const [queryParams, setQueryParams] = useState<QueryUserRequest>({
    pageNum: 1,
    pageSize: 10,
    userName: '',
    role: '',
  });

  const fetchUsers = useCallback(async () => {
    setLoading(true);
    try {
      const response = await api.queryUsers({ queryUserRequest: queryParams });
      if (response.data.code === 0) {
        setUsers(response.data.data?.users || []);
        setTotal(response.data.data?.total || 0);
      } else {
        toast.error(response.data.message || '获取用户列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [queryParams]);

  useEffect(() => {
    fetchUsers();
  }, [fetchUsers]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setQueryParams(prev => ({ ...prev, pageNum: 1 }));
  };

  const handlePageChange = (newPage: number) => {
    setQueryParams(prev => ({ ...prev, pageNum: newPage }));
  };

  const getRoleBadgeColor = (role: string) => {
    switch (normalizeUserRole(role)) {
      case 'admin': return 'bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400 border-purple-200 dark:border-purple-800';
      case 'teacher': return 'bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400 border-brand-200 dark:border-brand-800';
      default: return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700';
    }
  };

  // 封禁/解封用户
  const handleBanUser = async (user: UserDetailResponse) => {
    if (!user.id) return;
    const newBannedStatus = !user.banned;
    try {
      const response = await api.batchBanUsers({
        batchBanUserRequest: {
          userIds: [user.id],
          banned: newBannedStatus,
        },
      });
      if (response.data.code === 0) {
        toast.success(newBannedStatus ? '已封禁用户' : '已解封用户');
        fetchUsers();
      } else {
        toast.error(response.data.message || '操作失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    }
  };

  // 删除用户 - 目前 API 可能不支持，先用封禁代替
  const handleDeleteUser = async (user: UserDetailResponse) => {
    if (!user.id) return;
    if (!window.confirm(`确定要删除用户 "${user.userName || user.userAccount}" 吗？此操作不可恢复。`)) {
      return;
    }
    // 如果后端有 deleteUser API，可以替换为实际删除
    // 目前使用封禁代替
    try {
      const response = await api.batchBanUsers({
        batchBanUserRequest: {
          userIds: [user.id],
          banned: true,
        },
      });
      if (response.data.code === 0) {
        toast.success('用户已被封禁');
        fetchUsers();
      } else {
        toast.error(response.data.message || '操作失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    }
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">用户管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理系统内的所有用户信息、角色和状态</p>
        </div>
        <div className="flex items-center gap-3">
          <button className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors">
            <Download size={18} />
            <span>导出数据</span>
          </button>
          <button 
            onClick={() => { setEditingUser(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <UserPlus size={18} />
            <span>新增用户</span>
          </button>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input 
              type="text" 
              placeholder="搜索用户名、账号、手机号..." 
              value={queryParams.userName}
              onChange={(e) => setQueryParams(prev => ({ ...prev, userName: e.target.value }))}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select 
              value={queryParams.role}
              onChange={(e) => setQueryParams(prev => ({ ...prev, role: e.target.value, pageNum: 1 }))}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="">所有角色</option>
              {ROLE_OPTIONS.map(option => (
                <option key={option.value} value={option.value}>{option.label}</option>
              ))}
            </select>
            <button 
              type="button"
              className="flex items-center gap-2 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-400 transition-colors"
            >
              <Filter size={18} />
              <span>更多筛选</span>
            </button>
            <button 
              type="button"
              onClick={() => fetchUsers()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* User Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">用户信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">联系方式</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">角色权限</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={5} className="px-6 py-8 h-20">
                      <div className="flex gap-4">
                        <div className="w-12 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : users.length > 0 ? (
                users.map((user) => (
                  <tr key={user.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-4">
                        <div className="w-12 h-12 rounded-xl bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 shadow-sm">
                          {user.userAvatar ? (
                            <img src={user.userAvatar} alt="" className="w-full h-full rounded-[10px] object-cover" />
                          ) : (
                            <div className="w-full h-full rounded-[10px] flex items-center justify-center">
                              <User size={20} className="text-gray-400" />
                            </div>
                          )}
                        </div>
                        <div>
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                            {user.userName || '未设置昵称'}
                          </p>
                          <p className="text-xs text-gray-500 dark:text-gray-400 font-medium">{user.userAccount}</p>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="space-y-1">
                        <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300">
                          <Mail size={14} className="text-gray-400" />
                          <span>{user.userEmail || '-'}</span>
                        </div>
                        <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300">
                          <PhoneIcon size={14} className="text-gray-400" />
                          <span>{user.userPhone || '-'}</span>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${getRoleBadgeColor(user.role || '')}`}>
                        {getUserRoleLabel(user.role)}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className={`w-2 h-2 rounded-full ${user.banned ? 'bg-red-500' : 'bg-green-500'}`} />
                        <span className="text-sm font-medium text-gray-600 dark:text-gray-300">
                          {user.banned ? '已封禁' : '正常'}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <button 
                          onClick={() => { setEditingUser(user); setModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" 
                          title="编辑"
                        >
                          <Edit2 size={18} />
                        </button>
                        <button 
                          onClick={() => handleBanUser(user)}
                          className={`p-2 rounded-lg transition-all ${user.banned ? 'text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20' : 'text-amber-500 hover:bg-amber-50 dark:hover:bg-amber-900/20'}`}
                          title={user.banned ? '解封' : '封禁'}
                        >
                          <Ban size={18} />
                        </button>
                        <button 
                          onClick={() => handleDeleteUser(user)}
                          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" 
                          title="删除"
                        >
                          <Trash2 size={18} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={5} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <UsersIcon size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">未找到匹配的用户</p>
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
            显示第 <span className="font-bold text-gray-900 dark:text-white">{((queryParams.pageNum || 1) - 1) * (queryParams.pageSize || 10) + 1}</span> 到 <span className="font-bold text-gray-900 dark:text-white">{Math.min((queryParams.pageNum || 1) * (queryParams.pageSize || 10), total)}</span> 条结果，共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 条
          </p>
          <div className="flex items-center gap-2">
            <button 
              disabled={queryParams.pageNum === 1 || loading}
              onClick={() => handlePageChange((queryParams.pageNum || 1) - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronLeft size={18} />
            </button>
            <div className="flex items-center gap-1">
              {Array.from({ length: Math.min(5, Math.ceil(total / (queryParams.pageSize || 10))) }).map((_, i) => (
                <button
                  key={i}
                  onClick={() => handlePageChange(i + 1)}
                  className={`w-10 h-10 rounded-lg text-sm font-bold transition-all ${
                    (queryParams.pageNum || 1) === i + 1 
                      ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' 
                      : 'text-gray-500 hover:bg-white dark:hover:bg-gray-800 border border-transparent hover:border-gray-200 dark:hover:border-gray-700'
                  }`}
                >
                  {i + 1}
                </button>
              ))}
            </div>
            <button 
              disabled={queryParams.pageNum === Math.ceil(total / (queryParams.pageSize || 10)) || loading}
              onClick={() => handlePageChange((queryParams.pageNum || 1) + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* 用户表单弹窗 */}
      <UserFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingUser(null); }}
        onSuccess={fetchUsers}
        user={editingUser}
      />
    </div>
  );
};
