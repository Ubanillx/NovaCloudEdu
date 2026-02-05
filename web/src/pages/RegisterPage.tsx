/**
 * 注册页面
 * 参考 app/lib/features/auth/pages/register_page.dart
 */

import { useState, useEffect, useCallback } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Eye, EyeOff, User, Lock, Phone, ShieldCheck, ArrowLeft } from 'lucide-react';
import { apiClient, getToken, DefaultApi, Configuration } from '../api';
import { toast } from '../components/ui';
import logo from '../assets/logo.svg';

// 创建 API 实例
const api = new DefaultApi(new Configuration(), '', apiClient);

export default function RegisterPage() {
  const navigate = useNavigate();

  // 表单
  const [account, setAccount] = useState('');
  const [password, setPassword] = useState('');
  const [passwordVisible, setPasswordVisible] = useState(false);
  const [phone, setPhone] = useState('');
  const [code, setCode] = useState('');

  // 状态
  const [isLoading, setIsLoading] = useState(false);
  const [isSendingCode, setIsSendingCode] = useState(false);
  const [codeCountdown, setCodeCountdown] = useState(0);

  // 检查是否已登录
  useEffect(() => {
    if (getToken()) {
      navigate('/', { replace: true });
    }
  }, [navigate]);

  // 验证码倒计时
  useEffect(() => {
    if (codeCountdown > 0) {
      const timer = setTimeout(() => setCodeCountdown(codeCountdown - 1), 1000);
      return () => clearTimeout(timer);
    }
  }, [codeCountdown]);

  // 发送验证码
  const handleSendCode = useCallback(async () => {
    if (codeCountdown > 0 || isSendingCode) return;

    if (!phone.trim()) {
      toast.warning('请输入手机号');
      return;
    }
    if (phone.length < 7) {
      toast.warning('手机号格式不正确');
      return;
    }

    setIsSendingCode(true);

    try {
      const response = await api.sendRegisterCode({
        sendCodeRequest: { phone },
      });
      const data = response.data;
      if (data?.code === 0) {
        toast.success('验证码已发送');
        setCodeCountdown(60);
      } else {
        toast.error(data?.message || '发送失败');
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || e?.message || '发送失败');
    } finally {
      setIsSendingCode(false);
    }
  }, [phone, codeCountdown, isSendingCode]);

  // 注册
  const handleRegister = useCallback(async () => {
    // 表单验证
    if (!account.trim()) {
      toast.warning('请输入账号');
      return;
    }
    if (account.length < 4) {
      toast.warning('账号至少 4 位');
      return;
    }
    if (!password || password.length < 6) {
      toast.warning('密码至少 6 位');
      return;
    }
    if (!phone.trim() || phone.length < 7) {
      toast.warning('请输入正确的手机号');
      return;
    }
    if (!code.trim() || code.length < 4) {
      toast.warning('请输入验证码');
      return;
    }

    setIsLoading(true);

    try {
      const response = await api.userRegister({
        userRegisterRequest: {
          userAccount: account,
          userPassword: password,
          checkPassword: password,
          phone,
          smsCode: code,
        },
      });
      const data = response.data;
      if (data?.code === 0) {
        toast.success('注册成功，请登录');
        navigate('/login', { replace: true });
      } else {
        toast.error(data?.message || '注册失败');
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || e?.message || '注册失败');
    } finally {
      setIsLoading(false);
    }
  }, [account, password, phone, code, navigate]);

  // 回车提交
  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !isLoading) {
      handleRegister();
    }
  };

  return (
    <div className="min-h-screen flex flex-col bg-gradient-to-br from-gray-50 to-brand-50 dark:from-gray-950 dark:to-gray-900">
      {/* 背景装饰 */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute -top-24 -right-24 w-96 h-96 bg-brand-200/30 dark:bg-brand-600/10 rounded-full blur-3xl" />
        <div className="absolute -bottom-24 -left-24 w-96 h-96 bg-cyan-200/30 dark:bg-cyan-500/10 rounded-full blur-3xl" />
      </div>

      <div className="flex-1 flex items-center justify-center p-4 relative z-10">
        <div className="w-full max-w-md">
          {/* 返回按钮 */}
          <button
            onClick={() => navigate('/login')}
            className="mb-6 flex items-center gap-2 text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 font-medium transition-colors group"
          >
            <div className="p-2 rounded-full bg-white dark:bg-gray-800 shadow-sm border border-gray-100 dark:border-gray-800 group-hover:border-brand-200 dark:group-hover:border-brand-900 transition-all">
              <ArrowLeft size={18} />
            </div>
            <span>返回登录</span>
          </button>

          {/* 注册卡片 */}
          <div className="bg-white/80 dark:bg-gray-900/80 backdrop-blur-xl rounded-[2.5rem] shadow-2xl shadow-brand-500/5 border border-white/20 dark:border-gray-800/50 p-10">
            {/* 标题 */}
            <div className="mb-10 flex flex-col items-center">
              <img src={logo} alt="智云星课" className="w-16 h-16 object-contain mb-4" />
              <div className="text-center">
                <h1 className="text-3xl font-black text-gray-900 dark:text-white mb-3">
                  注册账号
                </h1>
                <p className="text-gray-500 dark:text-gray-400 font-medium">
                  创建您的智云星课账号，开启学习之旅
                </p>
              </div>
            </div>

            {/* 注册表单 */}
            <div className="space-y-6" onKeyDown={handleKeyDown}>
              {/* 账号 */}
              <div className="space-y-2">
                <label className="text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">账号</label>
                <div className="relative group">
                  <div className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors">
                    <User size={20} />
                  </div>
                  <input
                    type="text"
                    value={account}
                    onChange={(e) => setAccount(e.target.value)}
                    placeholder="设置账号（至少 4 位）"
                    className="w-full pl-12 pr-4 py-4 bg-gray-50/50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-2xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all"
                  />
                </div>
              </div>

              {/* 密码 */}
              <div className="space-y-2">
                <label className="text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">密码</label>
                <div className="relative group">
                  <div className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors">
                    <Lock size={20} />
                  </div>
                  <input
                    type={passwordVisible ? 'text' : 'password'}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="设置密码（至少 6 位）"
                    className="w-full pl-12 pr-12 py-4 bg-gray-50/50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-2xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all"
                  />
                  <button
                    type="button"
                    onClick={() => setPasswordVisible(!passwordVisible)}
                    className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-brand-500 transition-colors"
                  >
                    {passwordVisible ? <EyeOff size={20} /> : <Eye size={20} />}
                  </button>
                </div>
              </div>

              {/* 手机号 */}
              <div className="space-y-2">
                <label className="text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">手机号</label>
                <div className="relative group">
                  <div className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors">
                    <Phone size={20} />
                  </div>
                  <input
                    type="tel"
                    value={phone}
                    onChange={(e) => setPhone(e.target.value)}
                    placeholder="请输入手机号"
                    className="w-full pl-12 pr-4 py-4 bg-gray-50/50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-2xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all"
                  />
                </div>
              </div>

              {/* 验证码 */}
              <div className="space-y-2">
                <label className="text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">验证码</label>
                <div className="flex gap-3">
                  <div className="relative flex-1 group">
                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors">
                      <ShieldCheck size={20} />
                    </div>
                    <input
                      type="text"
                      value={code}
                      onChange={(e) => setCode(e.target.value)}
                      placeholder="验证码"
                      maxLength={6}
                      className="w-full pl-12 pr-4 py-4 bg-gray-50/50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-2xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all"
                    />
                  </div>
                  <button
                    onClick={handleSendCode}
                    disabled={codeCountdown > 0 || isSendingCode}
                    className="px-6 py-4 bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-bold rounded-2xl hover:bg-brand-100 dark:hover:bg-brand-900/50 disabled:opacity-50 transition-all whitespace-nowrap"
                  >
                    {codeCountdown > 0 ? `${codeCountdown}s` : isSendingCode ? '发送中' : '获取验证码'}
                  </button>
                </div>
              </div>
            </div>

            {/* 注册按钮 */}
            <button
              onClick={handleRegister}
              disabled={isLoading}
              className="w-full mt-10 py-4 bg-gradient-to-r from-brand-600 to-indigo-600 hover:from-brand-700 hover:to-indigo-700 text-white font-bold rounded-2xl shadow-xl shadow-brand-500/25 hover:shadow-brand-500/40 disabled:opacity-50 disabled:cursor-not-allowed transition-all active:scale-[0.98] flex items-center justify-center gap-2"
            >
              {isLoading ? (
                <>
                  <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  <span>正在注册...</span>
                </>
              ) : (
                '立即注册'
              )}
            </button>

            {/* 登录链接 */}
            <div className="mt-8 text-center text-sm font-medium text-gray-500 dark:text-gray-400">
              已有账号？
              <Link
                to="/login"
                className="ml-2 text-brand-600 dark:text-brand-400 font-bold hover:text-brand-700 transition-colors underline underline-offset-4"
              >
                立即登录
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
