/**
 * 胶囊消息组件
 * 用于显示操作反馈消息
 */

import { useState, useEffect, useCallback } from 'react';
import { createRoot } from 'react-dom/client';
import { CheckCircle, XCircle, AlertCircle, Info, X } from 'lucide-react';

type ToastType = 'success' | 'error' | 'warning' | 'info';

interface ToastProps {
  type: ToastType;
  message: string;
  duration?: number;
  onClose: () => void;
}

const iconMap = {
  success: CheckCircle,
  error: XCircle,
  warning: AlertCircle,
  info: Info,
};

const colorMap = {
  success: 'bg-emerald-500',
  error: 'bg-rose-500',
  warning: 'bg-amber-500',
  info: 'bg-brand-500',
};

const bgMap = {
  success: 'bg-emerald-50 dark:bg-emerald-900/20 border-emerald-200 dark:border-emerald-800',
  error: 'bg-rose-50 dark:bg-rose-900/20 border-rose-200 dark:border-rose-800',
  warning: 'bg-amber-50 dark:bg-amber-900/20 border-amber-200 dark:border-amber-800',
  info: 'bg-brand-50 dark:bg-brand-900/20 border-brand-200 dark:border-brand-800',
};

const textMap = {
  success: 'text-emerald-800 dark:text-emerald-200',
  error: 'text-rose-800 dark:text-rose-200',
  warning: 'text-amber-800 dark:text-amber-200',
  info: 'text-brand-800 dark:text-brand-200',
};

function ToastItem({ type, message, duration = 3000, onClose }: ToastProps) {
  const [isVisible, setIsVisible] = useState(false);
  const [isLeaving, setIsLeaving] = useState(false);

  const Icon = iconMap[type];

  const handleClose = useCallback(() => {
    setIsLeaving(true);
    setTimeout(onClose, 300);
  }, [onClose]);

  useEffect(() => {
    // 入场动画
    requestAnimationFrame(() => setIsVisible(true));

    // 自动关闭
    const timer = setTimeout(handleClose, duration);
    return () => clearTimeout(timer);
  }, [duration, handleClose]);

  return (
    <div
      className={`
        flex items-center gap-3 px-4 py-3 rounded-full border shadow-lg backdrop-blur-sm
        transition-all duration-300 ease-out max-w-sm
        ${bgMap[type]}
        ${isVisible && !isLeaving ? 'opacity-100 translate-y-0 scale-100' : 'opacity-0 -translate-y-2 scale-95'}
      `}
    >
      <div className={`p-1 rounded-full ${colorMap[type]}`}>
        <Icon size={16} className="text-white" />
      </div>
      <span className={`text-sm font-medium flex-1 ${textMap[type]}`}>
        {message}
      </span>
      <button
        onClick={handleClose}
        className={`p-1 rounded-full hover:bg-black/5 dark:hover:bg-white/10 transition-colors ${textMap[type]}`}
      >
        <X size={14} />
      </button>
    </div>
  );
}

// Toast 容器
let toastContainer: HTMLDivElement | null = null;
let toastRoot: ReturnType<typeof createRoot> | null = null;
let toasts: Array<{ id: number; type: ToastType; message: string }> = [];
let toastId = 0;

function getContainer() {
  if (!toastContainer) {
    toastContainer = document.createElement('div');
    toastContainer.id = 'toast-container';
    toastContainer.className = 'fixed top-4 left-1/2 -translate-x-1/2 z-[9999] flex flex-col items-center gap-2';
    document.body.appendChild(toastContainer);
    toastRoot = createRoot(toastContainer);
  }
  return { container: toastContainer, root: toastRoot! };
}

function renderToasts() {
  const { root } = getContainer();
  root.render(
    <>
      {toasts.map((toast) => (
        <ToastItem
          key={toast.id}
          type={toast.type}
          message={toast.message}
          onClose={() => {
            toasts = toasts.filter((t) => t.id !== toast.id);
            renderToasts();
          }}
        />
      ))}
    </>
  );
}

function showToast(type: ToastType, message: string) {
  const id = ++toastId;
  toasts.push({ id, type, message });
  renderToasts();
}

// 导出的 Toast API
export const toast = {
  success: (message: string) => showToast('success', message),
  error: (message: string) => showToast('error', message),
  warning: (message: string) => showToast('warning', message),
  info: (message: string) => showToast('info', message),
};

export default toast;
