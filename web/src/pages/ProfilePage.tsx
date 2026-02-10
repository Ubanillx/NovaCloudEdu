import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  ArrowLeft, User, Mail, Phone, Calendar, Edit3, Save,
  Shield, Clock, Flame, Heart, Camera, Loader2, MapPin, Cake,
  X, Hash, UserCheck, Ban, RefreshCw, BookMarked, ChevronRight,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { UserDetailResponse, UpdateProfileRequest, UserStatsResult } from '../api/generated/models';
import toast from '../components/ui/Toast';
import PhoneEditModal from '../components/ui/PhoneEditModal';
import RegionPicker from '../components/ui/RegionPicker';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 性别选项 - 与后端和 App 端保持一致: 0=男, 1=女, 2=保密
const GENDER_OPTIONS = [
  { value: 0, label: '男' },
  { value: 1, label: '女' },
  { value: 2, label: '保密' },
];

const getGenderLabel = (gender?: number) => {
  if (gender === 0) return '男';
  if (gender === 1) return '女';
  if (gender === 2) return '保密';
  return '未设置';
};

const getRoleLabel = (role?: string) => {
  if (role === 'admin') return '管理员';
  if (role === 'user') return '普通用户';
  return role ?? '未知';
};

const formatDate = (dateStr?: string) => {
  if (!dateStr) return '—';
  return new Date(dateStr).toLocaleDateString('zh-CN', { year: 'numeric', month: 'long', day: 'numeric' });
};

const formatDateTime = (dateStr?: string) => {
  if (!dateStr) return '—';
  const d = new Date(dateStr);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')} ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`;
};

const inputCls = 'w-full px-3 py-2 rounded-lg border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 transition-all';

// 编辑表单类型（不包含 phone，phone 需要验证码单独修改）
interface ProfileFormData {
  userName: string;
  userAvatar: string;
  userProfile: string;
  userGender: number;
  userEmail: string;
  userAddress: string;
  birthday: string;
}

const ProfilePage: React.FC = () => {
  const navigate = useNavigate();

  const [user, setUser] = useState<UserDetailResponse | null>(null);
  const [stats, setStats] = useState<UserStatsResult | null>(null);
  const [loading, setLoading] = useState(true);
  const [isEditing, setIsEditing] = useState(false);
  const [saving, setSaving] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [phoneModalOpen, setPhoneModalOpen] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const [form, setForm] = useState<ProfileFormData>({
    userName: '', userAvatar: '', userProfile: '',
    userGender: 2, userEmail: '', userAddress: '', birthday: '',
  });

  // 上传头像
  const handleAvatarUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (!file.type.startsWith('image/')) { toast.warning('请选择图片文件'); return; }
    if (file.size > 5 * 1024 * 1024) { toast.warning('图片大小不能超过 5MB'); return; }
    setUploading(true);
    try {
      const fd = new FormData();
      fd.append('file', file);
      const res = await apiClient.post('/api/file/upload/user/avatar', fd, {
        headers: { 'Content-Type': 'multipart/form-data' },
      });
      if (res.data?.code === 0 && res.data.data?.fileUrl) {
        const avatarUrl = res.data.data.fileUrl;
        const updateRes = await api.updateProfile({ updateProfileRequest: { userAvatar: avatarUrl } });
        if (updateRes.data?.code === 0) {
          setUser(prev => prev ? { ...prev, userAvatar: avatarUrl } : prev);
          setForm(prev => ({ ...prev, userAvatar: avatarUrl }));
          syncLocalStorage({ userAvatar: avatarUrl });
          toast.success('头像更新成功');
        }
      } else { toast.error(res.data?.message || '上传失败'); }
    } catch { toast.error('上传失败，请稍后重试'); }
    finally {
      setUploading(false);
      if (fileInputRef.current) fileInputRef.current.value = '';
    }
  };

  // 同步 localStorage 中的用户信息
  const syncLocalStorage = (updates: Record<string, unknown>) => {
    try {
      const stored = localStorage.getItem('user_info');
      if (stored) {
        const old = JSON.parse(stored);
        localStorage.setItem('user_info', JSON.stringify({ ...old, ...updates }));
      }
    } catch { /* ignore */ }
  };

  // 加载数据（先通过 getLoginUser 拿到精确 id，再调 getUserDetailInfo）
  const fetchData = useCallback(async () => {
    setLoading(true);
    try {
      const loginRes = await api.getLoginUser();
      const uid = loginRes.data?.data?.id;
      if (!uid) { toast.error('请先登录'); setLoading(false); return; }

      const [detailRes, statsRes] = await Promise.all([
        api.getUserDetailInfo({ id: uid as unknown as number }),
        api.getUserStats(),
      ]);
      if (detailRes.data?.code === 0 && detailRes.data.data) {
        setUser(detailRes.data.data);
      }
      if (statsRes.data?.code === 0 && statsRes.data.data) {
        setStats(statsRes.data.data);
      }
    } catch {
      toast.error('获取用户信息失败');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { fetchData(); }, [fetchData]);

  // 进入编辑模式 - 不包含 phone（需要验证码单独修改）
  const startEditing = () => {
    if (!user) return;
    setForm({
      userName: user.userName || '',
      userAvatar: user.userAvatar || '',
      userProfile: user.userProfile || '',
      userGender: user.userGender ?? 2,
      userEmail: user.userEmail || '',
      userAddress: user.userAddress || '',
      birthday: user.birthday || '',
    });
    setIsEditing(true);
  };

  const cancelEditing = () => {
    setIsEditing(false);
    setForm({
      userName: '', userAvatar: '', userProfile: '',
      userGender: 2, userEmail: '', userAddress: '', birthday: '',
    });
  };

  // 保存 - 排除 phone 字段
  const handleSave = async () => {
    if (saving) return;
    if (!form.userName?.trim()) { toast.warning('昵称不能为空'); return; }
    setSaving(true);
    try {
      const payload: UpdateProfileRequest = {
        userName: form.userName.trim() || undefined,
        userAvatar: form.userAvatar || undefined,
        userProfile: form.userProfile.trim() || undefined,
        userGender: form.userGender,
        userEmail: form.userEmail.trim() || undefined,
        userAddress: form.userAddress.trim() || undefined,
        birthday: form.birthday || undefined,
      };
      const res = await api.updateProfile({ updateProfileRequest: payload });
      if (res.data?.code === 0) {
        toast.success('资料更新成功');
        setIsEditing(false);
        // 重新加载
        const uid = user?.id;
        if (uid) {
          const detailRes = await api.getUserDetailInfo({ id: uid });
          if (detailRes.data?.code === 0 && detailRes.data.data) {
            setUser(detailRes.data.data);
            syncLocalStorage({
              userName: detailRes.data.data.userName,
              userAvatar: detailRes.data.data.userAvatar,
              userGender: detailRes.data.data.userGender,
            });
          }
        }
      } else { toast.error(res.data?.message || '更新失败'); }
    } catch { toast.error('更新失败，请稍后重试'); }
    finally { setSaving(false); }
  };

  // ==================== 骨架屏 ====================
  if (loading) {
    return (
      <div className="max-w-3xl mx-auto animate-pulse space-y-5 py-4">
        <div className="h-8 w-16 bg-gray-200 dark:bg-gray-800 rounded-lg" />
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-6">
          <div className="flex items-center gap-4 mb-6">
            <div className="w-20 h-20 bg-gray-200 dark:bg-gray-800 rounded-full" />
            <div className="space-y-2 flex-1">
              <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-28" />
              <div className="h-3 bg-gray-200 dark:bg-gray-800 rounded w-44" />
            </div>
          </div>
          {[1, 2, 3].map(i => (
            <div key={i} className="mb-4">
              <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-20 mb-3" />
              <div className="space-y-2">
                {[1, 2, 3].map(j => <div key={j} className="h-12 bg-gray-50 dark:bg-gray-800 rounded-lg" />)}
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  if (!user) {
    return (
      <div className="max-w-3xl mx-auto py-20 text-center">
        <User size={40} className="mx-auto text-gray-300 dark:text-gray-600 mb-3" />
        <p className="text-sm text-gray-500 dark:text-gray-400 mb-3">未能获取用户信息</p>
        <button onClick={() => navigate('/login')} className="text-sm text-brand-600 hover:text-brand-700 font-medium">
          去登录
        </button>
      </div>
    );
  }

  const roleLabel = getRoleLabel(user.role);

  // ==================== 渲染 ====================
  return (
    <div className="max-w-3xl mx-auto animate-in fade-in duration-500 py-4 space-y-5">
      {/* 返回 + 编辑按钮 */}
      <div className="flex items-center justify-between">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-sm font-bold text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-all group"
        >
          <div className="p-1.5 rounded-lg bg-white dark:bg-gray-900 border border-gray-100 dark:border-gray-800 group-hover:border-brand-200 shadow-sm transition-all">
            <ArrowLeft size={16} className="group-hover:-translate-x-0.5 transition-transform" />
          </div>
          返回
        </button>
        {!isEditing ? (
          <button
            onClick={startEditing}
            className="flex items-center gap-1.5 px-3.5 py-1.5 rounded-lg text-xs font-bold text-gray-600 dark:text-gray-300 border border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors"
          >
            <Edit3 size={13} />
            编辑资料
          </button>
        ) : (
          <div className="flex items-center gap-2">
            <button onClick={cancelEditing} className="flex items-center gap-1 px-3 py-1.5 rounded-lg text-xs font-bold text-gray-500 border border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors">
              <X size={12} />
              取消
            </button>
            <button onClick={handleSave} disabled={saving} className="flex items-center gap-1 px-3.5 py-1.5 rounded-lg text-xs font-bold bg-brand-600 text-white hover:bg-brand-700 transition-colors disabled:opacity-50">
              {saving ? <Loader2 size={12} className="animate-spin" /> : <Save size={12} />}
              保存
            </button>
          </div>
        )}
      </div>

      {/* ==================== 头像 + 名称区 ==================== */}
      <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 shadow-sm p-6">
        <div className="flex flex-col items-center mb-6">
          {/* 头像 */}
          <div className="relative mb-4">
            <div className={`rounded-full p-1 border-[3px] transition-all ${isEditing ? 'border-brand-500 shadow-lg shadow-brand-500/10' : 'border-gray-100 dark:border-gray-800'}`}>
              {user.userAvatar ? (
                <img src={user.userAvatar} alt="" className="w-20 h-20 rounded-full object-cover" />
              ) : (
                <div className="w-20 h-20 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
                  <User size={36} className="text-gray-400" />
                </div>
              )}
            </div>
            <input ref={fileInputRef} type="file" accept="image/*" className="hidden" onChange={handleAvatarUpload} />
            <button
              onClick={() => fileInputRef.current?.click()}
              disabled={uploading}
              className="absolute bottom-0 right-0 w-7 h-7 rounded-full bg-brand-600 text-white flex items-center justify-center hover:bg-brand-700 transition-colors disabled:opacity-50 border-2 border-white dark:border-gray-900 shadow-md"
            >
              {uploading ? <Loader2 size={12} className="animate-spin" /> : <Camera size={12} />}
            </button>
          </div>
          {/* 名称 + 标签 */}
          <h1 className="text-xl font-bold text-gray-900 dark:text-white mb-2">
            {user.userName || user.userAccount || '未设置'}
          </h1>
          <div className="flex items-center gap-2 flex-wrap justify-center">
            <span className="px-2 py-0.5 rounded-full text-[11px] font-bold bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400">
              Lv.{user.level ?? 0}
            </span>
            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[11px] font-bold bg-amber-50 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400">
              <Shield size={10} />
              {roleLabel}
            </span>
            {user.userGender !== undefined && user.userGender !== null && (
              <span className={`px-2 py-0.5 rounded-full text-[11px] font-bold ${
                user.userGender === 0
                  ? 'bg-blue-50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400'
                  : user.userGender === 1
                    ? 'bg-pink-50 dark:bg-pink-900/30 text-pink-600 dark:text-pink-400'
                    : 'bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400'
              }`}>
                {getGenderLabel(user.userGender)}
              </span>
            )}
            {user.banned && (
              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[11px] font-bold bg-red-50 dark:bg-red-900/30 text-red-600 dark:text-red-400">
                <Ban size={10} />
                已封禁
              </span>
            )}
          </div>
          {!isEditing && (
            <p className="text-xs text-gray-500 dark:text-gray-400 mt-2 text-center max-w-sm">
              {user.userProfile || '这个人很懒，什么都没写~'}
            </p>
          )}
        </div>

        {/* ==================== 基本信息 ==================== */}
        <SectionTitle title="基本信息" />
        {isEditing ? (
          <div className="space-y-3 mb-6">
            <EditField label="昵称" value={form.userName} onChange={v => setForm(p => ({ ...p, userName: v }))} placeholder="请输入昵称" maxLength={20} />
            <EditField label="简介" value={form.userProfile} onChange={v => setForm(p => ({ ...p, userProfile: v }))} placeholder="介绍一下自己吧" maxLength={200} multiline />
            <div>
              <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">性别</label>
              <div className="flex gap-2">
                {GENDER_OPTIONS.map(g => (
                  <button
                    key={g.value}
                    onClick={() => setForm(p => ({ ...p, userGender: g.value }))}
                    className={`px-4 py-1.5 rounded-full text-xs font-bold transition-all ${
                      form.userGender === g.value
                        ? 'bg-brand-600 text-white shadow-sm'
                        : 'bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700'
                    }`}
                  >
                    {g.label}
                  </button>
                ))}
              </div>
            </div>
            <EditField label="生日" value={form.birthday} onChange={v => setForm(p => ({ ...p, birthday: v }))} type="date" />
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 mb-6">
            <InfoRow icon={<User size={14} />} label="账号" value={user.userAccount || '—'} />
            <InfoRow icon={<User size={14} />} label="昵称" value={user.userName || '未设置'} />
            <InfoRow icon={<User size={14} />} label="性别" value={getGenderLabel(user.userGender)} />
            <InfoRow icon={<Shield size={14} />} label="等级" value={`Lv.${user.level ?? 0}`} />
            <InfoRow icon={<UserCheck size={14} />} label="角色" value={roleLabel} />
            <InfoRow icon={<Cake size={14} />} label="生日" value={formatDate(user.birthday)} />
            <InfoRow icon={<User size={14} />} label="简介" value={user.userProfile || '这个用户很懒，什么都没留下'} fullWidth />
          </div>
        )}

        {/* ==================== 联系信息 ==================== */}
        <SectionTitle title="联系信息" />
        {isEditing ? (
          <div className="space-y-3 mb-6">
            {/* 手机号只读 - 需要验证码才能修改，点击修改按钮弹出弹窗 */}
            <div>
              <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
                手机号
                <span className="ml-1.5 text-[10px] text-gray-400 dark:text-gray-500 font-normal">（修改手机号需要短信验证）</span>
              </label>
              <div className="flex items-center gap-2">
                <div className={`${inputCls} bg-gray-50 dark:bg-gray-800/80 text-gray-500 dark:text-gray-400 cursor-not-allowed flex-1`}>
                  {user.userPhone || '未设置'}
                </div>
                <button
                  type="button"
                  onClick={() => setPhoneModalOpen(true)}
                  className="flex-shrink-0 px-3 py-2 rounded-lg text-xs font-bold text-brand-600 bg-brand-50 dark:bg-brand-900/20 dark:text-brand-400 hover:bg-brand-100 dark:hover:bg-brand-900/30 transition-colors"
                >
                  修改
                </button>
              </div>
            </div>
            <EditField label="邮箱" value={form.userEmail} onChange={v => setForm(p => ({ ...p, userEmail: v }))} placeholder="请输入邮箱" type="email" />
            <RegionPicker value={form.userAddress} onChange={v => setForm(p => ({ ...p, userAddress: v }))} />
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 mb-6">
            <PhoneInfoRow phone={user.userPhone} onEdit={() => setPhoneModalOpen(true)} />
            <InfoRow icon={<Mail size={14} />} label="邮箱" value={user.userEmail || '未设置'} />
            <InfoRow icon={<MapPin size={14} />} label="地址" value={user.userAddress || '未设置'} fullWidth />
          </div>
        )}

        {/* ==================== 账号状态 ==================== */}
        <SectionTitle title="账号状态" />
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
          <InfoRow icon={<Hash size={14} />} label="用户 ID" value={user.id?.toString() || '未知'} />
          <InfoRow
            icon={user.banned ? <Ban size={14} /> : <UserCheck size={14} />}
            label="状态"
            value={user.banned ? '已封禁' : '正常'}
            valueClassName={user.banned ? 'text-red-500 dark:text-red-400' : 'text-green-600 dark:text-green-400'}
          />
          <InfoRow icon={<Calendar size={14} />} label="注册时间" value={formatDateTime(user.createTime)} />
          <InfoRow icon={<RefreshCw size={14} />} label="最后更新" value={formatDateTime(user.updateTime)} />
        </div>
      </div>

      {/* ==================== 学习数据 ==================== */}
      <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 shadow-sm p-5">
        <h3 className="text-sm font-bold text-gray-900 dark:text-white mb-3 flex items-center gap-2">
          <span className="w-1 h-4 bg-brand-600 rounded-full" />
          学习数据
        </h3>
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          <StatCard icon={<Clock size={18} className="text-blue-500" />} label="已学习" value={`${stats?.registerDays ?? 0}`} unit="天" color="blue" />
          <StatCard icon={<Flame size={18} className="text-red-500" />} label="累计打卡" value={`${stats?.totalCheckinDays ?? 0}`} unit="天" color="red" />
          <StatCard icon={<Flame size={18} className="text-amber-500" />} label="连续打卡" value={`${stats?.currentStreak ?? 0}`} unit="天" color="amber" />
          <StatCard icon={<Heart size={18} className="text-pink-500" />} label="获赞总数" value={`${stats?.totalLikes ?? 0}`} unit="" color="pink" />
        </div>
      </div>

      {/* ==================== 快捷入口 ==================== */}
      <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 shadow-sm p-5">
        <h3 className="text-sm font-bold text-gray-900 dark:text-white mb-3 flex items-center gap-2">
          <span className="w-1 h-4 bg-brand-600 rounded-full" />
          我的工具
        </h3>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
          <button
            onClick={() => navigate('/word-book')}
            className="flex items-center gap-3 p-3 rounded-xl bg-amber-50 dark:bg-amber-900/20 hover:bg-amber-100 dark:hover:bg-amber-900/30 transition-colors text-left group"
          >
            <div className="w-10 h-10 rounded-xl bg-amber-100 dark:bg-amber-800/30 flex items-center justify-center flex-shrink-0">
              <BookMarked size={20} className="text-amber-600 dark:text-amber-400" />
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-bold text-gray-900 dark:text-white">生词本</p>
              <p className="text-[11px] text-gray-500 dark:text-gray-400">收藏的单词，随时复习</p>
            </div>
            <ChevronRight size={16} className="text-gray-400 group-hover:text-amber-600 dark:group-hover:text-amber-400 group-hover:translate-x-0.5 transition-all" />
          </button>
          <button
            onClick={() => navigate('/daily-words')}
            className="flex items-center gap-3 p-3 rounded-xl bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/30 transition-colors text-left group"
          >
            <div className="w-10 h-10 rounded-xl bg-brand-100 dark:bg-brand-800/30 flex items-center justify-center flex-shrink-0">
              <BookMarked size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-bold text-gray-900 dark:text-white">每日单词</p>
              <p className="text-[11px] text-gray-500 dark:text-gray-400">每天学习新单词</p>
            </div>
            <ChevronRight size={16} className="text-gray-400 group-hover:text-brand-600 dark:group-hover:text-brand-400 group-hover:translate-x-0.5 transition-all" />
          </button>
        </div>
      </div>

      {/* 手机号修改弹窗 */}
      <PhoneEditModal
        open={phoneModalOpen}
        currentPhone={user.userPhone || ''}
        onClose={() => setPhoneModalOpen(false)}
        onSuccess={() => fetchData()}
      />
    </div>
  );
};

// ==================== 子组件 ====================

const SectionTitle: React.FC<{ title: string }> = ({ title }) => (
  <div className="flex items-center gap-2 mb-3">
    <span className="w-0.5 h-3.5 bg-brand-600 rounded-full" />
    <h3 className="text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">{title}</h3>
  </div>
);

interface InfoRowProps {
  icon: React.ReactNode;
  label: string;
  value: string;
  badge?: boolean;
  fullWidth?: boolean;
  valueClassName?: string;
}

const InfoRow: React.FC<InfoRowProps> = ({ icon, label, value, badge, fullWidth, valueClassName }) => (
  <div className={`flex items-center gap-2.5 p-2.5 rounded-lg bg-gray-50 dark:bg-gray-800/50 ${fullWidth ? 'sm:col-span-2' : ''}`}>
    <div className="w-7 h-7 rounded-md bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700 flex items-center justify-center text-gray-400 dark:text-gray-500 flex-shrink-0">
      {icon}
    </div>
    <div className="flex-1 min-w-0">
      <p className="text-[10px] font-medium text-gray-400 dark:text-gray-500 leading-none mb-1">{label}</p>
      <div className="flex items-center gap-1.5">
        <p className={`text-sm truncate ${valueClassName || 'text-gray-900 dark:text-white'}`}>{value}</p>
        {badge && (
          <span className="px-1.5 py-0.5 rounded text-[9px] font-bold bg-gradient-to-r from-amber-400 to-orange-400 text-white">
            {value}
          </span>
        )}
      </div>
    </div>
  </div>
);

// 手机号展示行（带修改按钮）
const PhoneInfoRow: React.FC<{ phone?: string; onEdit: () => void }> = ({ phone, onEdit }) => (
  <div className="flex items-center gap-2.5 p-2.5 rounded-lg bg-gray-50 dark:bg-gray-800/50">
    <div className="w-7 h-7 rounded-md bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700 flex items-center justify-center text-gray-400 dark:text-gray-500 flex-shrink-0">
      <Phone size={14} />
    </div>
    <div className="flex-1 min-w-0">
      <p className="text-[10px] font-medium text-gray-400 dark:text-gray-500 leading-none mb-1">手机号</p>
      <p className="text-sm text-gray-900 dark:text-white truncate">{phone || '未设置'}</p>
    </div>
    <button
      onClick={onEdit}
      className="flex-shrink-0 px-2 py-0.5 rounded-full text-[10px] font-bold text-brand-600 bg-brand-50 dark:bg-brand-900/20 dark:text-brand-400 hover:bg-brand-100 dark:hover:bg-brand-900/30 transition-colors"
    >
      修改
    </button>
  </div>
);

interface EditFieldProps {
  label: string;
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  type?: string;
  maxLength?: number;
  multiline?: boolean;
}

const EditField: React.FC<EditFieldProps> = ({ label, value, onChange, placeholder, type = 'text', maxLength, multiline }) => (
  <div>
    <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">{label}</label>
    {multiline ? (
      <textarea
        value={value}
        onChange={e => onChange(e.target.value)}
        className={`${inputCls} resize-none`}
        rows={2}
        placeholder={placeholder}
        maxLength={maxLength}
      />
    ) : (
      <input
        type={type}
        value={value}
        onChange={e => onChange(e.target.value)}
        className={inputCls}
        placeholder={placeholder}
        maxLength={maxLength}
      />
    )}
  </div>
);

interface StatCardProps {
  icon: React.ReactNode;
  label: string;
  value: string;
  unit: string;
  color: 'blue' | 'red' | 'amber' | 'pink';
}

const StatCard: React.FC<StatCardProps> = ({ icon, label, value, unit, color }) => {
  const bgMap = {
    blue: 'bg-blue-50 dark:bg-blue-900/20',
    red: 'bg-red-50 dark:bg-red-900/20',
    amber: 'bg-amber-50 dark:bg-amber-900/20',
    pink: 'bg-pink-50 dark:bg-pink-900/20',
  };
  return (
    <div className={`${bgMap[color]} rounded-xl p-3.5 text-center`}>
      <div className="flex justify-center mb-2">{icon}</div>
      <div className="text-lg font-bold text-gray-900 dark:text-white leading-none mb-1">
        {value}
        {unit && <span className="text-xs font-normal text-gray-500 ml-0.5">{unit}</span>}
      </div>
      <p className="text-[10px] text-gray-500 dark:text-gray-400">{label}</p>
    </div>
  );
};

export default ProfilePage;
