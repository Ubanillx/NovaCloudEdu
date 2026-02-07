import React, { useState, useEffect, useRef, useCallback } from 'react';
import { X, Phone, MessageSquare, Loader2, Info } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import toast from './Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const inputCls = 'w-full px-3 py-2 rounded-lg border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 transition-all';

interface PhoneEditModalProps {
  open: boolean;
  currentPhone: string;
  onClose: () => void;
  onSuccess: () => void;
}

const PhoneEditModal: React.FC<PhoneEditModalProps> = ({ open, currentPhone, onClose, onSuccess }) => {
  const [phone, setPhone] = useState('');
  const [code, setCode] = useState('');
  const [sending, setSending] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [countdown, setCountdown] = useState(0);
  const codeInputRef = useRef<HTMLInputElement>(null);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);

  // 打开时初始化
  useEffect(() => {
    if (open) {
      setPhone(currentPhone || '');
      setCode('');
      setCountdown(0);
      setSending(false);
      setSubmitting(false);
    }
    return () => {
      if (timerRef.current) clearInterval(timerRef.current);
    };
  }, [open, currentPhone]);

  // 倒计时
  useEffect(() => {
    if (countdown <= 0) {
      if (timerRef.current) { clearInterval(timerRef.current); timerRef.current = null; }
      return;
    }
    timerRef.current = setInterval(() => {
      setCountdown(prev => {
        if (prev <= 1) {
          if (timerRef.current) clearInterval(timerRef.current);
          timerRef.current = null;
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    return () => { if (timerRef.current) clearInterval(timerRef.current); };
  }, [countdown > 0]); // eslint-disable-line react-hooks/exhaustive-deps

  // 发送验证码
  const handleSendCode = useCallback(async () => {
    if (countdown > 0 || sending) return;
    const trimmed = phone.trim();
    if (!trimmed) { toast.warning('请输入手机号'); return; }
    if (trimmed.length < 7) { toast.warning('手机号格式不正确'); return; }

    setSending(true);
    try {
      const res = await api.sendRegisterCode({ sendCodeRequest: { phone: trimmed } });
      if (res.data?.code === 0) {
        toast.success('验证码已发送');
        setCountdown(60);
        codeInputRef.current?.focus();
      } else {
        toast.error(res.data?.message || '发送失败');
      }
    } catch {
      toast.error('发送失败，请稍后重试');
    } finally {
      setSending(false);
    }
  }, [phone, countdown, sending]);

  // 提交修改
  const handleSubmit = useCallback(async () => {
    if (submitting) return;
    const trimmedPhone = phone.trim();
    const trimmedCode = code.trim();
    if (!trimmedPhone) { toast.warning('请输入手机号'); return; }
    if (trimmedPhone.length < 7) { toast.warning('手机号格式不正确'); return; }
    if (!trimmedCode) { toast.warning('请输入验证码'); return; }
    if (trimmedCode.length < 4) { toast.warning('验证码格式不正确'); return; }

    setSubmitting(true);
    try {
      const res = await api.updateProfile({
        updateProfileRequest: {
          userPhone: trimmedPhone,
          phoneSmsCode: trimmedCode,
        },
      });
      if (res.data?.code === 0) {
        toast.success('手机号修改成功');
        onSuccess();
        onClose();
      } else {
        toast.error(res.data?.message || '修改失败');
      }
    } catch {
      toast.error('修改失败，请稍后重试');
    } finally {
      setSubmitting(false);
    }
  }, [phone, code, submitting, onSuccess, onClose]);

  if (!open) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      {/* 遮罩 */}
      <div className="absolute inset-0 bg-black/40 backdrop-blur-sm" onClick={onClose} />
      {/* 弹窗 */}
      <div className="relative w-full max-w-md mx-4 bg-white dark:bg-gray-900 rounded-2xl shadow-2xl border border-gray-100 dark:border-gray-800 animate-in fade-in zoom-in-95 duration-200">
        {/* 头部 */}
        <div className="flex items-center justify-between p-5 border-b border-gray-100 dark:border-gray-800">
          <h2 className="text-base font-bold text-gray-900 dark:text-white">修改手机号</h2>
          <button onClick={onClose} className="p-1 rounded-lg text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={18} />
          </button>
        </div>

        <div className="p-5 space-y-5">
          {/* 当前手机号提示 */}
          {currentPhone && (
            <div className="flex items-center gap-2.5 p-3 rounded-lg bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300">
              <Info size={16} className="flex-shrink-0" />
              <span className="text-xs">当前手机号：<strong>{currentPhone}</strong></span>
            </div>
          )}

          {/* 新手机号 */}
          <div>
            <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">新手机号</label>
            <div className="relative">
              <Phone size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
              <input
                type="tel"
                value={phone}
                onChange={e => setPhone(e.target.value)}
                className={`${inputCls} pl-9`}
                placeholder="请输入新手机号"
                maxLength={11}
              />
            </div>
          </div>

          {/* 验证码 */}
          <div>
            <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">验证码</label>
            <div className="flex gap-2">
              <div className="relative flex-1">
                <MessageSquare size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                <input
                  ref={codeInputRef}
                  type="text"
                  inputMode="numeric"
                  value={code}
                  onChange={e => setCode(e.target.value.replace(/\D/g, ''))}
                  className={`${inputCls} pl-9`}
                  placeholder="请输入验证码"
                  maxLength={6}
                />
              </div>
              <button
                onClick={handleSendCode}
                disabled={countdown > 0 || sending}
                className="flex-shrink-0 px-4 py-2 rounded-lg text-xs font-bold bg-brand-600 text-white hover:bg-brand-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed min-w-[100px]"
              >
                {sending ? (
                  <Loader2 size={14} className="animate-spin mx-auto" />
                ) : countdown > 0 ? (
                  `${countdown}s`
                ) : (
                  '发送验证码'
                )}
              </button>
            </div>
          </div>

          {/* 提示信息 */}
          <div className="p-3 rounded-lg bg-gray-50 dark:bg-gray-800/50 space-y-1">
            <p className="text-[11px] font-medium text-gray-500 dark:text-gray-400">温馨提示</p>
            <ul className="text-[11px] text-gray-400 dark:text-gray-500 space-y-0.5 list-disc list-inside">
              <li>验证码将发送到新手机号</li>
              <li>请确保新手机号能正常接收短信</li>
              <li>修改成功后将使用新手机号登录</li>
            </ul>
          </div>
        </div>

        {/* 底部按钮 */}
        <div className="flex gap-3 p-5 border-t border-gray-100 dark:border-gray-800">
          <button
            onClick={onClose}
            className="flex-1 py-2.5 rounded-lg text-sm font-bold text-gray-600 dark:text-gray-300 border border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors"
          >
            取消
          </button>
          <button
            onClick={handleSubmit}
            disabled={submitting}
            className="flex-1 py-2.5 rounded-lg text-sm font-bold bg-brand-600 text-white hover:bg-brand-700 transition-colors disabled:opacity-50 flex items-center justify-center gap-1.5"
          >
            {submitting ? <Loader2 size={14} className="animate-spin" /> : null}
            确认修改
          </button>
        </div>
      </div>
    </div>
  );
};

export default PhoneEditModal;
