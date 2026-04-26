import React, { useEffect, useRef, useState } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { ArrowLeft, Loader2, AlertCircle } from 'lucide-react';
import { apiClient, Configuration, OnlyOfficeApi } from '../../api';

interface OnlyOfficeConfig {
  documentServerUrl: string;
  config: Record<string, unknown>;
}

const onlyOfficeApi = new OnlyOfficeApi(new Configuration(), '', apiClient);

const PptEditorPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const editorRef = useRef<HTMLDivElement>(null);
  const editorInstanceRef = useRef<unknown>(null);

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fileUrl = searchParams.get('fileUrl') || '';
  const fileName = searchParams.get('fileName') || '演示文稿.pptx';

  useEffect(() => {
    if (!fileUrl) {
      setError('缺少文件 URL 参数');
      setLoading(false);
      return;
    }

    let cancelled = false;

    const initEditor = async () => {
      try {
        // 1. 获取编辑器配置
        const res = await onlyOfficeApi.getEditorConfig({ fileUrl, fileName });
        const data = res.data as unknown as OnlyOfficeConfig;
        if (cancelled) return;

        const { documentServerUrl, config } = data;

        // 2. 动态加载 OnlyOffice JS API
        await loadScript(`${documentServerUrl}/web-apps/apps/api/documents/api.js`);
        if (cancelled) return;

        // 3. 初始化编辑器
        const DocsAPI = (window as unknown as Record<string, unknown>).DocsAPI as {
          DocEditor: new (id: string, config: Record<string, unknown>) => unknown;
        };

        if (!DocsAPI?.DocEditor) {
          throw new Error('OnlyOffice JS API 加载失败，请检查 Document Server 是否启动');
        }

        editorInstanceRef.current = new DocsAPI.DocEditor('onlyoffice-editor', config);
        setLoading(false);
      } catch (e) {
        if (cancelled) return;
        const msg = e instanceof Error ? e.message : '加载编辑器失败';
        setError(msg);
        setLoading(false);
      }
    };

    initEditor();

    return () => {
      cancelled = true;
      // 清理编辑器实例
      if (editorInstanceRef.current && typeof (editorInstanceRef.current as Record<string, unknown>).destroyEditor === 'function') {
        (editorInstanceRef.current as { destroyEditor: () => void }).destroyEditor();
      }
    };
  }, [fileUrl, fileName]);

  const handleBack = () => {
    navigate(-1);
  };

  return (
    <div className="h-screen w-screen flex flex-col bg-gray-900">
      {/* 顶部栏 */}
      <div className="flex items-center gap-3 px-4 py-2 bg-gray-800 border-b border-gray-700 flex-shrink-0">
        <button
          onClick={handleBack}
          className="flex items-center gap-1.5 px-3 py-1.5 text-sm text-gray-300 hover:text-white hover:bg-gray-700 rounded-lg transition-colors"
        >
          <ArrowLeft size={16} />
          返回
        </button>
        <div className="w-px h-5 bg-gray-600" />
        <span className="text-sm text-gray-300 truncate">{fileName}</span>
      </div>

      {/* 编辑器区域 */}
      <div className="flex-1 relative">
        {loading && (
          <div className="absolute inset-0 flex items-center justify-center bg-gray-900 z-10">
            <div className="flex flex-col items-center gap-3">
              <Loader2 size={32} className="text-brand-500 animate-spin" />
              <p className="text-sm text-gray-400">正在加载在线编辑器...</p>
            </div>
          </div>
        )}

        {error && (
          <div className="absolute inset-0 flex items-center justify-center bg-gray-900 z-10">
            <div className="flex flex-col items-center gap-3 max-w-md text-center">
              <AlertCircle size={32} className="text-red-500" />
              <p className="text-sm text-red-400">{error}</p>
              <button
                onClick={handleBack}
                className="px-4 py-2 text-sm bg-gray-700 text-gray-300 rounded-lg hover:bg-gray-600 transition-colors"
              >
                返回
              </button>
            </div>
          </div>
        )}

        <div
          id="onlyoffice-editor"
          ref={editorRef}
          className="w-full h-full"
        />
      </div>
    </div>
  );
};

/**
 * 动态加载外部 JS 脚本
 */
function loadScript(src: string): Promise<void> {
  return new Promise((resolve, reject) => {
    // 避免重复加载
    if (document.querySelector(`script[src="${src}"]`)) {
      resolve();
      return;
    }
    const script = document.createElement('script');
    script.src = src;
    script.async = true;
    script.onload = () => resolve();
    script.onerror = () => reject(new Error(`加载脚本失败: ${src}`));
    document.head.appendChild(script);
  });
}

export default PptEditorPage;
