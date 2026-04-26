import React, { useEffect, useMemo, useRef, useState } from 'react';
import QRCode from 'qrcode';
import { Copy, ImageUp, Loader2, QrCode, ScanLine } from 'lucide-react';
import toast from '../ui/Toast';
import { Avatar } from '../ui/Avatar';

export type SocialQrPayload =
  | {
      app: 'NovaCloudEdu';
      v: 1;
      type: 'friend';
      userId: number;
      name?: string;
      avatar?: string;
      createdAt?: string;
    }
  | {
      app: 'NovaCloudEdu';
      v: 1;
      type: 'group';
      groupId: number;
      groupNumber?: string;
      name?: string;
      avatar?: string;
      createdAt?: string;
    };

type SocialQrPayloadInput =
  | Omit<Extract<SocialQrPayload, { type: 'friend' }>, 'app' | 'v' | 'createdAt'>
  | Omit<Extract<SocialQrPayload, { type: 'group' }>, 'app' | 'v' | 'createdAt'>;

const textEncoder = new TextEncoder();
const textDecoder = new TextDecoder();

const toBase64Url = (value: string) => {
  const bytes = textEncoder.encode(value);
  let binary = '';
  bytes.forEach((byte) => { binary += String.fromCharCode(byte); });
  return btoa(binary).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/g, '');
};

const fromBase64Url = (value: string) => {
  const normalized = value.replace(/-/g, '+').replace(/_/g, '/');
  const padded = normalized.padEnd(Math.ceil(normalized.length / 4) * 4, '=');
  const binary = atob(padded);
  const bytes = Uint8Array.from(binary, (char) => char.charCodeAt(0));
  return textDecoder.decode(bytes);
};

export const createSocialQrPayload = (
  payload: SocialQrPayloadInput,
): SocialQrPayload => ({
  app: 'NovaCloudEdu',
  v: 1,
  createdAt: new Date().toISOString(),
  ...payload,
} as SocialQrPayload);

export const encodeSocialQrPayload = (payload: SocialQrPayload) => toBase64Url(JSON.stringify(payload));

export const buildSocialQrLink = (payload: SocialQrPayload) => {
  const origin = typeof window !== 'undefined' ? window.location.origin : '';
  return `${origin}/chat?qr=${encodeSocialQrPayload(payload)}`;
};

export const parseSocialQrPayload = (raw: string): SocialQrPayload | null => {
  const value = raw.trim();
  if (!value) return null;

  const candidates = [value];
  try {
    const url = new URL(value);
    const qr = url.searchParams.get('qr');
    if (qr) candidates.unshift(qr);
  } catch {
    // Not a URL; continue with raw value.
  }

  for (const candidate of candidates) {
    try {
      const parsed = JSON.parse(candidate) as SocialQrPayload;
      if (parsed?.app === 'NovaCloudEdu' && parsed.v === 1 && (parsed.type === 'friend' || parsed.type === 'group')) {
        return parsed;
      }
    } catch {
      // Try base64url below.
    }

    try {
      const parsed = JSON.parse(fromBase64Url(candidate)) as SocialQrPayload;
      if (parsed?.app === 'NovaCloudEdu' && parsed.v === 1 && (parsed.type === 'friend' || parsed.type === 'group')) {
        return parsed;
      }
    } catch {
      // Ignore invalid candidate.
    }
  }

  return null;
};

interface QrCodeCardProps {
  payload: SocialQrPayload;
  title: string;
  subtitle?: string;
  copyLabel?: string;
}

export const QrCodeCard: React.FC<QrCodeCardProps> = ({ payload, title, subtitle, copyLabel }) => {
  const [dataUrl, setDataUrl] = useState('');
  const link = useMemo(() => buildSocialQrLink(payload), [payload]);

  useEffect(() => {
    let mounted = true;
    QRCode.toDataURL(link, {
      width: 240,
      margin: 2,
      errorCorrectionLevel: 'M',
      color: {
        dark: '#111827',
        light: '#ffffff',
      },
    }).then((url) => {
      if (mounted) setDataUrl(url);
    }).catch(() => {
      if (mounted) toast.error('二维码生成失败');
    });
    return () => { mounted = false; };
  }, [link]);

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(link);
      toast.success('二维码链接已复制');
    } catch {
      toast.error('复制失败');
    }
  };

  return (
    <div className="rounded-xl border border-gray-100 dark:border-gray-800 bg-gray-50 dark:bg-gray-800/40 p-4">
      <div className="flex items-center gap-3">
        <Avatar src={payload.avatar} name={payload.name} icon={payload.type === 'group' ? 'group' : undefined} />
        <div className="min-w-0 flex-1">
          <p className="text-sm font-semibold text-gray-900 dark:text-white truncate">{title}</p>
          {subtitle && <p className="mt-0.5 text-xs text-gray-400 truncate">{subtitle}</p>}
        </div>
        <button
          type="button"
          onClick={handleCopy}
          className="p-2 rounded-lg text-gray-400 hover:text-brand-600 hover:bg-white dark:hover:bg-gray-800 transition-colors"
          title="复制链接"
        >
          <Copy size={16} />
        </button>
      </div>
      <div className="mt-4 flex justify-center">
        <div className="h-60 w-60 rounded-2xl bg-white p-3 shadow-sm ring-1 ring-gray-200/70 flex items-center justify-center">
          {dataUrl ? (
            <img src={dataUrl} alt={title} className="h-full w-full object-contain" />
          ) : (
            <Loader2 size={24} className="animate-spin text-gray-400" />
          )}
        </div>
      </div>
      <button
        type="button"
        onClick={handleCopy}
        className="mt-4 w-full flex items-center justify-center gap-2 rounded-lg bg-white dark:bg-gray-900 px-4 py-2.5 text-sm font-medium text-brand-700 dark:text-brand-300 ring-1 ring-gray-200 dark:ring-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors active:scale-[0.98]"
      >
        <Copy size={15} />
        {copyLabel || (payload.type === 'group' ? '复制群聊邀请链接' : '复制个人二维码链接')}
      </button>
    </div>
  );
};

interface QrScannerProps {
  onResolved: (payload: SocialQrPayload) => void | Promise<void>;
}

export const QrScanner: React.FC<QrScannerProps> = ({ onResolved }) => {
  const inputRef = useRef<HTMLInputElement>(null);
  const [rawValue, setRawValue] = useState('');
  const [scanning, setScanning] = useState(false);

  const resolveRaw = async (value: string) => {
    const payload = parseSocialQrPayload(value);
    if (!payload) {
      toast.error('无法识别二维码内容');
      return;
    }
    await onResolved(payload);
  };

  const handleFile = async (file?: File) => {
    if (!file) return;
    const Detector = (window as unknown as {
      BarcodeDetector?: new (options?: { formats?: string[] }) => {
        detect: (source: ImageBitmapSource) => Promise<Array<{ rawValue: string }>>;
      };
    }).BarcodeDetector;

    if (!Detector) {
      toast.warning('当前浏览器不支持识别图片二维码，可粘贴二维码链接');
      return;
    }

    setScanning(true);
    let bitmap: ImageBitmap | null = null;
    try {
      bitmap = await createImageBitmap(file);
      const detector = new Detector({ formats: ['qr_code'] });
      const codes = await detector.detect(bitmap);
      if (codes.length === 0) {
        toast.error('未识别到二维码');
        return;
      }
      await resolveRaw(codes[0].rawValue);
    } catch {
      toast.error('二维码识别失败');
    } finally {
      bitmap?.close();
      setScanning(false);
      if (inputRef.current) inputRef.current.value = '';
    }
  };

  return (
    <div className="rounded-xl border border-gray-100 dark:border-gray-800 bg-white dark:bg-gray-900 p-4 space-y-3">
      <div className="flex items-center gap-3">
        <div className="w-10 h-10 rounded-xl bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-300 flex items-center justify-center">
          <ScanLine size={20} />
        </div>
        <div>
          <p className="text-sm font-semibold text-gray-900 dark:text-white">扫码添加</p>
          <p className="text-xs text-gray-400 mt-0.5">支持个人二维码和群聊二维码</p>
        </div>
      </div>
      <input
        ref={inputRef}
        type="file"
        accept="image/*"
        className="hidden"
        onChange={(e) => handleFile(e.target.files?.[0])}
      />
      <button
        type="button"
        onClick={() => inputRef.current?.click()}
        disabled={scanning}
        className="w-full flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 rounded-lg transition-colors active:scale-[0.98]"
      >
        {scanning ? <Loader2 size={16} className="animate-spin" /> : <ImageUp size={16} />}
        上传二维码图片
      </button>
      <div className="flex gap-2">
        <div className="relative flex-1">
          <QrCode size={15} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            value={rawValue}
            onChange={(e) => setRawValue(e.target.value)}
            placeholder="粘贴二维码链接"
            className="w-full pl-9 pr-3 py-2 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-400"
          />
        </div>
        <button
          type="button"
          onClick={() => resolveRaw(rawValue)}
          disabled={!rawValue.trim()}
          className="px-4 py-2 text-sm font-medium text-brand-700 dark:text-brand-300 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/40 disabled:opacity-50 rounded-lg transition-colors"
        >
          识别
        </button>
      </div>
    </div>
  );
};
