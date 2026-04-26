import React, { useState, useEffect } from 'react';
import { X, Upload, Check, Loader2, AlertTriangle, Clock, RefreshCw, SkipForward, Palette, ArrowLeft } from 'lucide-react';
import { PPTApi } from '../../api/generated/api/pptapi';
import { apiClient, Configuration } from '../../api';
import type { PptTemplateListResponse } from '../../api/generated/models';

const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
const pptApi = new PPTApi(new Configuration({ basePath: API_BASE }), API_BASE, apiClient);

const parseStatusConfig: Record<string, { label: string; color: string; icon: React.ReactNode }> = {
  ready:   { label: '可用',   color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400', icon: <Check className="w-3 h-3" /> },
  parsing: { label: '解析中', color: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400',   icon: <Loader2 className="w-3 h-3 animate-spin" /> },
  pending: { label: '等待中', color: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400', icon: <Clock className="w-3 h-3" /> },
  failed:  { label: '解析失败', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400',     icon: <AlertTriangle className="w-3 h-3" /> },
};

interface TemplateSelectorProps {
  onSelect: (templateId?: string, templateUrl?: string) => void;
  onSkip?: (styleHint: string) => void;
  onClose: () => void;
}

export const TemplateSelector: React.FC<TemplateSelectorProps> = ({ onSelect, onSkip, onClose }) => {
  const [templates, setTemplates] = useState<PptTemplateListResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [retrying, setRetrying] = useState<string | null>(null);
  const [showSkipPanel, setShowSkipPanel] = useState(false);
  const [styleHint, setStyleHint] = useState('');

  const STYLE_PRESETS = [
    { label: '简约商务', hint: '简约商务风格，深蓝主色调，白色背景，干净利落' },
    { label: '科技感', hint: '科技未来风格，深色背景，霓虹蓝绿渐变，数据感' },
    { label: '学术论文', hint: '学术严谨风格，白色背景，黑色正文，蓝色强调' },
    { label: '清新自然', hint: '清新自然风格，浅绿色系，柔和渐变，留白充足' },
    { label: '创意设计', hint: '大胆创意风格，鲜艳撞色，不对称布局，有艺术感' },
    { label: '暗色高端', hint: '高端暗色风格，纯黑背景，金色点缀，极简排版' },
  ];

  const fetchTemplates = async () => {
    try {
      const res = await pptApi.listTemplates();
      const data = (res.data as any)?.data || [];
      setTemplates(data);
    } catch (err) {
      console.error('加载模板失败', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchTemplates(); }, []);

  const handleRetryParse = async (e: React.MouseEvent, templateId: string) => {
    e.stopPropagation();
    setRetrying(templateId);
    try {
      await pptApi.retryParsing({ id: templateId as unknown as number });
      // Refresh list after triggering retry
      setTimeout(() => fetchTemplates(), 1000);
    } catch (err) {
      console.error('重试解析失败', err);
    } finally {
      setRetrying(null);
    }
  };

  const handleConfirm = () => {
    if (selectedId) {
      onSelect(selectedId);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl mx-4 max-h-[80vh] flex flex-col overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Modal header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          {showSkipPanel ? (
            <div className="flex items-center gap-2">
              <button
                onClick={() => setShowSkipPanel(false)}
                className="p-1.5 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
              >
                <ArrowLeft size={18} />
              </button>
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">自定义 PPT 风格</h3>
            </div>
          ) : (
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">选择 PPT 模板</h3>
          )}
          <button
            onClick={onClose}
            className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
          >
            <X size={20} />
          </button>
        </div>

        {/* Modal content */}
        <div className="flex-1 overflow-y-auto p-6">
          {showSkipPanel ? (
            /* ---- Skip template: style hint panel ---- */
            <div className="space-y-5">
              <div>
                <p className="text-sm text-gray-500 dark:text-gray-400 mb-3">
                  描述你想要的 PPT 视觉风格，AI 将根据你的描述设计每一页幻灯片。留空则使用默认风格。
                </p>
                <textarea
                  value={styleHint}
                  onChange={(e) => setStyleHint(e.target.value)}
                  placeholder="例如：深色科技风格，蓝紫渐变背景，白色文字，卡片式布局..."
                  className="w-full h-28 px-4 py-3 text-sm rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 text-gray-900 dark:text-white placeholder-gray-400 focus:ring-2 focus:ring-brand-500 focus:border-transparent resize-none transition-all"
                />
              </div>
              <div>
                <p className="text-xs font-semibold text-gray-500 dark:text-gray-400 mb-2 uppercase tracking-wide">快捷风格</p>
                <div className="flex flex-wrap gap-2">
                  {STYLE_PRESETS.map((preset) => (
                    <button
                      key={preset.label}
                      onClick={() => setStyleHint(preset.hint)}
                      className={`px-3 py-1.5 text-xs font-medium rounded-lg border transition-all ${
                        styleHint === preset.hint
                          ? 'border-brand-500 bg-brand-50 dark:bg-brand-900/20 text-brand-700 dark:text-brand-400'
                          : 'border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:border-brand-300 dark:hover:border-brand-600'
                      }`}
                    >
                      {preset.label}
                    </button>
                  ))}
                </div>
              </div>
            </div>
          ) : loading ? (
            <div className="flex items-center justify-center h-48">
              <Loader2 className="w-8 h-8 animate-spin text-brand-500" />
            </div>
          ) : templates.length === 0 ? (
            <div className="text-center py-12 text-gray-400">
              <p className="text-lg mb-2">暂无模板</p>
              <p className="text-sm">请先在模板管理页面上传模板</p>
            </div>
          ) : (
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
              {templates.map(t => {
                const tid = String(t.id);
                const isSelected = tid === selectedId;
                const status = t.parseStatus || 'pending';
                const isReady = status === 'ready';
                const isFailed = status === 'failed';
                const statusCfg = parseStatusConfig[status] || parseStatusConfig.pending;

                return (
                  <button
                    key={tid}
                    onClick={() => isReady ? setSelectedId(isSelected ? null : tid) : undefined}
                    disabled={!isReady}
                    className={`
                      group relative rounded-2xl overflow-hidden border-2 transition-all duration-300 text-left
                      ${!isReady
                        ? 'opacity-60 cursor-not-allowed border-gray-200 dark:border-gray-700'
                        : isSelected
                          ? 'border-brand-500 shadow-lg shadow-brand-500/20'
                          : 'border-gray-100 dark:border-gray-800 hover:border-brand-300 dark:hover:border-brand-600 hover:shadow-sm'
                      }
                    `}
                  >
                    <div className="aspect-video bg-gray-50 dark:bg-gray-800 overflow-hidden relative">
                      {t.coverUrl ? (
                        <img
                          src={t.coverUrl}
                          alt={t.name || '模板'}
                          className={`w-full h-full object-cover transition-transform duration-300 ${isReady ? 'group-hover:scale-105' : 'grayscale'}`}
                        />
                      ) : (
                        <div className="w-full h-full flex items-center justify-center text-gray-300 dark:text-gray-600">
                          <Upload className="w-8 h-8" />
                        </div>
                      )}
                      {isSelected && isReady && (
                        <div className="absolute inset-0 bg-brand-500/20 flex items-center justify-center">
                          <div className="w-8 h-8 rounded-full bg-brand-500 flex items-center justify-center animate-bounceIn">
                            <Check className="w-5 h-5 text-white" />
                          </div>
                        </div>
                      )}
                      {/* Parse status badge */}
                      {!isReady && (
                        <div className="absolute inset-0 bg-black/30 flex items-center justify-center">
                          <span className={`inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium ${statusCfg.color}`}>
                            {statusCfg.icon}
                            {statusCfg.label}
                          </span>
                        </div>
                      )}
                    </div>
                    <div className="px-3 py-2 flex items-center justify-between">
                      <div className="min-w-0">
                        <p className={`text-sm font-bold truncate transition-colors ${isReady ? 'text-gray-900 dark:text-white group-hover:text-brand-600' : 'text-gray-400 dark:text-gray-500'}`}>
                          {t.name || '未命名模板'}
                        </p>
                        <p className="text-xs text-gray-400">{t.slideCount || 0} 页</p>
                      </div>
                      {isFailed && (
                        <button
                          onClick={(e) => handleRetryParse(e, tid)}
                          disabled={retrying === tid}
                          className="flex-shrink-0 p-1.5 rounded-lg text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors"
                          title="重新解析"
                        >
                          <RefreshCw className={`w-4 h-4 ${retrying === tid ? 'animate-spin' : ''}`} />
                        </button>
                      )}
                    </div>
                  </button>
                );
              })}
            </div>
          )}
        </div>

        {/* Modal footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            取消
          </button>
          {showSkipPanel ? (
            <button
              onClick={() => { onClose(); onSkip?.(styleHint); }}
              className="inline-flex items-center gap-1.5 px-6 py-2 text-sm font-bold text-white bg-gradient-to-r from-amber-500 to-orange-500 rounded-xl hover:from-amber-600 hover:to-orange-600 shadow-lg shadow-amber-500/20 transition-all active:scale-95"
            >
              <Palette className="w-4 h-4" />
              开始生成
            </button>
          ) : (
            <>
              {onSkip && (
                <button
                  onClick={() => setShowSkipPanel(true)}
                  className="inline-flex items-center gap-1.5 px-5 py-2 text-sm font-bold text-amber-700 dark:text-amber-400 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-700 rounded-xl hover:bg-amber-100 dark:hover:bg-amber-900/40 transition-all active:scale-95"
                >
                  <SkipForward className="w-4 h-4" />
                  跳过模板
                </button>
              )}
              <button
                onClick={handleConfirm}
                disabled={!selectedId}
                className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 disabled:cursor-not-allowed transition-all active:scale-95"
              >
                使用此模板
              </button>
            </>
          )}
        </div>
      </div>
    </div>
  );
};
