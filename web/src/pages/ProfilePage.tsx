import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  ArrowLeft, User, Mail, Phone, Calendar, Edit3, Save,
  Shield, Clock, Flame, Heart, Camera, Loader2, MapPin, Cake,
  X, Hash, UserCheck, Ban, RefreshCw, BookMarked, ChevronRight,
  GraduationCap, Send, CheckCircle2, XCircle, Clock3, Plus, Trash2,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { UserDetailResponse, UpdateProfileRequest, UserStatsResult, TeacherApplicationResponse } from '../api/generated/models';
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
  if (role === 'teacher') return '教师';
  if (role === 'user' || role === 'student') return '普通用户';
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

  // ====== 申请成为老师 ======
  const [teacherApp, setTeacherApp] = useState<TeacherApplicationResponse | null>(null);
  const [teacherAppLoading, setTeacherAppLoading] = useState(false);
  const [showApplyForm, setShowApplyForm] = useState(false);
  const [applySubmitting, setApplySubmitting] = useState(false);
  const [applyForm, setApplyForm] = useState({ name: '', introduction: '', expertise: [''], certificateUrl: '' });

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

  // 获取教师申请状态
  const fetchTeacherApplication = useCallback(async () => {
    setTeacherAppLoading(true);
    try {
      const res = await api.getMyApplication();
      if (res.data?.code === 0 && res.data.data) {
        setTeacherApp(res.data.data);
      }
    } catch {
      // 404 表示没有申请记录，忽略
      setTeacherApp(null);
    } finally {
      setTeacherAppLoading(false);
    }
  }, []);

  // 当用户角色为普通用户时，获取教师申请状态
  useEffect(() => {
    if (user) {
      const role = (user.role || '').toLowerCase();
      if (role === 'user' || role === 'student' || role === '') {
        fetchTeacherApplication();
      }
    }
  }, [user, fetchTeacherApplication]);

  // 提交教师申请
  const handleApplyTeacher = async () => {
    if (applySubmitting) return;
    if (!applyForm.name.trim()) { toast.warning('请输入您的姓名'); return; }
    const validExpertise = applyForm.expertise.filter(e => e.trim());
    if (validExpertise.length === 0) { toast.warning('请至少填写一个专业领域'); return; }
    setApplySubmitting(true);
    try {
      const res = await api.applyTeacher({
        applyTeacherRequest: {
          name: applyForm.name.trim(),
          introduction: applyForm.introduction.trim() || undefined,
          expertise: validExpertise,
          certificateUrl: applyForm.certificateUrl.trim() || undefined,
        },
      });
      if (res.data?.code === 0) {
        toast.success('申请已提交，请等待管理员审核');
        setShowApplyForm(false);
        fetchTeacherApplication();
      } else {
        toast.error(res.data?.message || '提交失败');
      }
    } catch (err: any) {
      const msg = err?.response?.data?.message || '提交失败，请稍后重试';
      toast.error(msg);
    } finally {
      setApplySubmitting(false);
    }
  };

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

      {/* ==================== 申请成为老师 ==================== */}
      {(() => {
        const role = (user.role || '').toLowerCase();
        if (role === 'admin' || role === 'teacher') return null;
        return (
          <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 shadow-sm p-5">
            <h3 className="text-sm font-bold text-gray-900 dark:text-white mb-3 flex items-center gap-2">
              <span className="w-1 h-4 bg-brand-600 rounded-full" />
              申请成为老师
            </h3>

            {teacherAppLoading ? (
              <div className="flex items-center justify-center py-6">
                <Loader2 size={20} className="animate-spin text-brand-500" />
              </div>
            ) : teacherApp ? (
              /* ---------- 已有申请记录 ---------- */
              <div className="space-y-3">
                <div className={`flex items-center gap-3 p-4 rounded-xl border ${
                  teacherApp.status === 0
                    ? 'bg-amber-50 dark:bg-amber-900/10 border-amber-200 dark:border-amber-800'
                    : teacherApp.status === 1
                      ? 'bg-green-50 dark:bg-green-900/10 border-green-200 dark:border-green-800'
                      : 'bg-red-50 dark:bg-red-900/10 border-red-200 dark:border-red-800'
                }`}>
                  <div className="flex-shrink-0">
                    {teacherApp.status === 0 && <Clock3 size={22} className="text-amber-500" />}
                    {teacherApp.status === 1 && <CheckCircle2 size={22} className="text-green-500" />}
                    {teacherApp.status === 2 && <XCircle size={22} className="text-red-500" />}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-bold text-gray-900 dark:text-white">
                      {teacherApp.status === 0 && '审核中'}
                      {teacherApp.status === 1 && '已通过'}
                      {teacherApp.status === 2 && '已被拒绝'}
                    </p>
                    <p className="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                      {teacherApp.status === 0 && '您的申请正在审核中，请耐心等待管理员处理'}
                      {teacherApp.status === 1 && '恭喜！您的教师申请已通过，请重新登录以激活教师权限'}
                      {teacherApp.status === 2 && (teacherApp.rejectReason || '很遗憾，您的申请未通过')}
                    </p>
                  </div>
                </div>

                {/* 申请详情 */}
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 text-sm">
                  <InfoRow icon={<User size={14} />} label="姓名" value={teacherApp.name || '—'} />
                  <InfoRow icon={<Calendar size={14} />} label="申请时间" value={formatDateTime(teacherApp.createTime)} />
                  {teacherApp.expertise && teacherApp.expertise.length > 0 && (
                    <div className="sm:col-span-2 flex items-center gap-2.5 p-2.5 rounded-lg bg-gray-50 dark:bg-gray-800/50">
                      <div className="w-7 h-7 rounded-md bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700 flex items-center justify-center text-gray-400 dark:text-gray-500 flex-shrink-0">
                        <GraduationCap size={14} />
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className="text-[10px] font-medium text-gray-400 dark:text-gray-500 leading-none mb-1">专业领域</p>
                        <div className="flex flex-wrap gap-1">
                          {teacherApp.expertise.map((e, i) => (
                            <span key={i} className="px-2 py-0.5 rounded-full text-[11px] font-medium bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400">
                              {e}
                            </span>
                          ))}
                        </div>
                      </div>
                    </div>
                  )}
                </div>

                {/* 被拒绝后可重新申请 */}
                {teacherApp.status === 2 && (
                  <button
                    onClick={() => {
                      setTeacherApp(null);
                      setShowApplyForm(true);
                      setApplyForm({ name: '', introduction: '', expertise: [''], certificateUrl: '' });
                    }}
                    className="w-full mt-2 flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl text-sm font-bold text-brand-600 bg-brand-50 dark:bg-brand-900/20 dark:text-brand-400 hover:bg-brand-100 dark:hover:bg-brand-900/30 transition-colors"
                  >
                    <RefreshCw size={14} />
                    重新申请
                  </button>
                )}
              </div>
            ) : showApplyForm ? (
              /* ---------- 申请表单 ---------- */
              <div className="space-y-4">
                <div>
                  <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
                    姓名 <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="text"
                    value={applyForm.name}
                    onChange={e => setApplyForm(p => ({ ...p, name: e.target.value }))}
                    className={inputCls}
                    placeholder="请输入您的真实姓名"
                    maxLength={20}
                  />
                </div>

                <div>
                  <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">个人简介</label>
                  <textarea
                    value={applyForm.introduction}
                    onChange={e => setApplyForm(p => ({ ...p, introduction: e.target.value }))}
                    className={`${inputCls} resize-none`}
                    rows={3}
                    placeholder="请简要介绍您的教学经验和背景"
                    maxLength={500}
                  />
                </div>

                <div>
                  <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
                    专业领域 <span className="text-red-500">*</span>
                  </label>
                  <div className="space-y-2">
                    {applyForm.expertise.map((exp, idx) => (
                      <div key={idx} className="flex items-center gap-2">
                        <input
                          type="text"
                          value={exp}
                          onChange={e => {
                            const newArr = [...applyForm.expertise];
                            newArr[idx] = e.target.value;
                            setApplyForm(p => ({ ...p, expertise: newArr }));
                          }}
                          className={inputCls}
                          placeholder={`专业领域 ${idx + 1}`}
                          maxLength={30}
                        />
                        {applyForm.expertise.length > 1 && (
                          <button
                            onClick={() => setApplyForm(p => ({
                              ...p,
                              expertise: p.expertise.filter((_, i) => i !== idx),
                            }))}
                            className="flex-shrink-0 p-1.5 rounded-lg text-gray-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors"
                          >
                            <Trash2 size={14} />
                          </button>
                        )}
                      </div>
                    ))}
                    {applyForm.expertise.length < 5 && (
                      <button
                        onClick={() => setApplyForm(p => ({ ...p, expertise: [...p.expertise, ''] }))}
                        className="flex items-center gap-1 text-xs text-brand-600 dark:text-brand-400 hover:text-brand-700 dark:hover:text-brand-300 font-medium"
                      >
                        <Plus size={12} />
                        添加领域
                      </button>
                    )}
                  </div>
                </div>

                <div>
                  <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">资质证书链接（选填）</label>
                  <input
                    type="url"
                    value={applyForm.certificateUrl}
                    onChange={e => setApplyForm(p => ({ ...p, certificateUrl: e.target.value }))}
                    className={inputCls}
                    placeholder="https://..."
                  />
                </div>

                <div className="flex items-center gap-2 pt-1">
                  <button
                    onClick={() => setShowApplyForm(false)}
                    className="flex-1 px-4 py-2.5 rounded-xl text-sm font-bold text-gray-600 dark:text-gray-300 bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
                  >
                    取消
                  </button>
                  <button
                    onClick={handleApplyTeacher}
                    disabled={applySubmitting}
                    className="flex-1 flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 transition-colors disabled:opacity-50"
                  >
                    {applySubmitting ? <Loader2 size={14} className="animate-spin" /> : <Send size={14} />}
                    提交申请
                  </button>
                </div>
              </div>
            ) : (
              /* ---------- 未申请 ---------- */
              <div className="text-center py-4">
                <div className="w-14 h-14 mx-auto mb-3 rounded-2xl bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center">
                  <GraduationCap size={28} className="text-brand-500" />
                </div>
                <p className="text-sm text-gray-600 dark:text-gray-300 mb-1 font-medium">成为平台教师</p>
                <p className="text-xs text-gray-400 dark:text-gray-500 mb-4">创建课程、管理班级、出题组卷，发挥您的教学才能</p>
                <button
                  onClick={() => setShowApplyForm(true)}
                  className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 transition-colors shadow-sm shadow-brand-600/20"
                >
                  <GraduationCap size={16} />
                  申请成为老师
                </button>
              </div>
            )}
          </div>
        );
      })()}

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
