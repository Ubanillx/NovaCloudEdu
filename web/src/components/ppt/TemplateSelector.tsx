import React, { useState, useEffect } from 'react';
import { X, Upload, Check, Loader2 } from 'lucide-react';
import { PPTApi } from '../../api/generated/api/pptapi';
import { apiClient, Configuration } from '../../api';
import type { PptTemplateListResponse } from '../../api/generated/models';

const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';

interface TemplateSelectorProps {
  onSelect: (templateId?: string, templateUrl?: string) => void;
  onClose: () => void;
}

export const TemplateSelector: React.FC<TemplateSelectorProps> = ({ onSelect, onClose }) => {
  const [templates, setTemplates] = useState<PptTemplateListResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedId, setSelectedId] = useState<string | null>(null);

  useEffect(() => {
    const fetchTemplates = async () => {
      try {
        const config = new Configuration({ basePath: API_BASE });
        const api = new PPTApi(config, API_BASE, apiClient);
        const res = await api.listTemplates();
        const data = (res.data as any)?.data || [];
        setTemplates(data);
      } catch (err) {
        console.error('加载模板失败', err);
      } finally {
        setLoading(false);
      }
    };
    fetchTemplates();
  }, []);

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
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">选择 PPT 模板</h3>
          <button
            onClick={onClose}
            className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
          >
            <X size={20} />
          </button>
        </div>

        {/* Modal content */}
        <div className="flex-1 overflow-y-auto p-6">
          {loading ? (
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
                return (
                  <button
                    key={tid}
                    onClick={() => setSelectedId(isSelected ? null : tid)}
                    className={`
                      group relative rounded-2xl overflow-hidden border-2 transition-all duration-300
                      ${isSelected
                        ? 'border-brand-500 shadow-lg shadow-brand-500/20'
                        : 'border-gray-100 dark:border-gray-800 hover:border-brand-300 dark:hover:border-brand-600 hover:shadow-md'
                      }
                    `}
                  >
                    <div className="aspect-video bg-gray-50 dark:bg-gray-800 overflow-hidden">
                      {t.coverUrl ? (
                        <img
                          src={t.coverUrl}
                          alt={t.name || '模板'}
                          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                        />
                      ) : (
                        <div className="w-full h-full flex items-center justify-center text-gray-300 dark:text-gray-600">
                          <Upload className="w-8 h-8" />
                        </div>
                      )}
                      {isSelected && (
                        <div className="absolute inset-0 bg-brand-500/20 flex items-center justify-center">
                          <div className="w-8 h-8 rounded-full bg-brand-500 flex items-center justify-center animate-bounceIn">
                            <Check className="w-5 h-5 text-white" />
                          </div>
                        </div>
                      )}
                    </div>
                    <div className="px-3 py-2">
                      <p className="text-sm font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors truncate">
                        {t.name || '未命名模板'}
                      </p>
                      <p className="text-xs text-gray-400">{t.slideCount || 0} 页</p>
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
          <button
            onClick={handleConfirm}
            disabled={!selectedId}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 disabled:cursor-not-allowed transition-all active:scale-95"
          >
            使用此模板
          </button>
        </div>
      </div>
    </div>
  );
};
