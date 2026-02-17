import React, { useState, useEffect, useCallback } from 'react';
import { 
  Search, 
  Plus, 
  Edit2, 
  Trash2, 
  Play,
  Pause,
  RefreshCw,
  X,
  Globe,
  Settings,
  ChevronLeft,
  ChevronRight,
  Code,
  Zap,
  Loader2
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { ScraperConfigResponse, ScraperConfigPageResponse, ScraperConfigRequest } from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

interface ConfigFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  config?: ScraperConfigResponse | null;
}

const ConfigFormModal: React.FC<ConfigFormModalProps> = ({ isOpen, onClose, onSuccess, config }) => {
  const isEdit = !!config;
  const [loading, setLoading] = useState(false);
  const [activeTab, setActiveTab] = useState<'basic' | 'selector' | 'advanced'>('basic');
  const [formData, setFormData] = useState<ScraperConfigRequest>({
    name: '',
    sourceCode: '',
    baseUrl: '',
    description: '',
    titleSelector: 'h1, .title, .article-title',
    authorSelector: '.author, .byline',
    sourceSelector: '.source, .category',
    contentSelector: 'article, .content, .article-content',
    dateSelector: '.date, time',
    imageSelector: 'article img',
    linkSelector: 'a[href]',
    maxDepth: 2,
    maxPages: 10,
    delayMs: 1500,
    useDynamic: false,
    waitForJsMs: 3000,
    cronExpression: '',
    enabled: true,
    defaultMaxArticles: 5,
    defaultCategory: '',
    defaultDifficulty: 2,
  });

  useEffect(() => {
    if (config) {
      setFormData({
        name: config.name || '',
        sourceCode: config.sourceCode || '',
        baseUrl: config.baseUrl || '',
        description: config.description || '',
        titleSelector: config.titleSelector || 'h1, .title',
        authorSelector: config.authorSelector || '.author',
        sourceSelector: config.sourceSelector || '.source',
        contentSelector: config.contentSelector || 'article, .content',
        dateSelector: config.dateSelector || '.date, time',
        imageSelector: config.imageSelector || 'article img',
        linkSelector: config.linkSelector || 'a[href]',
        maxDepth: config.maxDepth || 2,
        maxPages: config.maxPages || 10,
        delayMs: config.delayMs || 1500,
        useDynamic: config.useDynamic || false,
        waitForJsMs: config.waitForJsMs || 3000,
        cronExpression: config.cronExpression || '',
        enabled: config.enabled !== false,
        defaultMaxArticles: config.defaultMaxArticles || 5,
        defaultCategory: config.defaultCategory || '',
        defaultDifficulty: config.defaultDifficulty || 2,
      });
    } else {
      setFormData({
        name: '',
        sourceCode: '',
        baseUrl: '',
        description: '',
        titleSelector: 'h1, .title, .article-title',
        authorSelector: '.author, .byline',
        sourceSelector: '.source, .category',
        contentSelector: 'article, .content, .article-content',
        dateSelector: '.date, time',
        imageSelector: 'article img',
        linkSelector: 'a[href]',
        maxDepth: 2,
        maxPages: 10,
        delayMs: 1500,
        useDynamic: false,
        waitForJsMs: 3000,
        cronExpression: '',
        enabled: true,
        defaultMaxArticles: 5,
        defaultCategory: '',
        defaultDifficulty: 2,
      });
    }
    setActiveTab('basic');
  }, [config, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.name.trim()) {
      toast.warning('请输入配置名称');
      return;
    }
    if (!formData.sourceCode.trim()) {
      toast.warning('请输入来源代码');
      return;
    }
    if (!formData.baseUrl.trim()) {
      toast.warning('请输入基础URL');
      return;
    }

    setLoading(true);
    try {
      if (isEdit && config?.id) {
        const response = await api.updateConfig({ id: config.id, scraperConfigRequest: formData });
        if (response.data.code === 0) {
          toast.success('更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const response = await api.createConfig({ scraperConfigRequest: formData });
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

  const tabs = [
    { key: 'basic', label: '基本信息', icon: Globe },
    { key: 'selector', label: 'CSS选择器', icon: Code },
    { key: 'advanced', label: '高级配置', icon: Settings },
  ] as const;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex-shrink-0">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑抓取配置' : '新增抓取配置'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Tabs */}
        <div className="flex border-b border-gray-100 dark:border-gray-800 px-6 flex-shrink-0">
          {tabs.map((tab) => (
            <button
              key={tab.key}
              onClick={() => setActiveTab(tab.key)}
              className={`flex items-center gap-2 px-4 py-3 text-sm font-medium border-b-2 transition-colors ${
                activeTab === tab.key
                  ? 'border-brand-600 text-brand-600'
                  : 'border-transparent text-gray-500 hover:text-gray-700 dark:hover:text-gray-300'
              }`}
            >
              <tab.icon size={16} />
              {tab.label}
            </button>
          ))}
        </div>

        {/* Form */}
        <div className="flex-1 overflow-y-auto">
          <form onSubmit={handleSubmit} className="p-6 space-y-4">
            {activeTab === 'basic' && (
              <>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                      配置名称 <span className="text-red-500">*</span>
                    </label>
                    <input
                      type="text"
                      value={formData.name}
                      onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder="如：科技新闻抓取"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                      来源代码 <span className="text-red-500">*</span>
                    </label>
                    <input
                      type="text"
                      value={formData.sourceCode}
                      onChange={(e) => setFormData({ ...formData, sourceCode: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder="如：tech_news"
                    />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    基础URL <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="url"
                    value={formData.baseUrl}
                    onChange={(e) => setFormData({ ...formData, baseUrl: e.target.value })}
                    className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    placeholder="https://example.com/news"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
                  <textarea
                    value={formData.description || ''}
                    onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                    rows={3}
                    className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                    placeholder="配置描述..."
                  />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">默认分类</label>
                    <input
                      type="text"
                      value={formData.defaultCategory || ''}
                      onChange={(e) => setFormData({ ...formData, defaultCategory: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder="科技"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">默认难度</label>
                    <select
                      value={formData.defaultDifficulty}
                      onChange={(e) => setFormData({ ...formData, defaultDifficulty: Number(e.target.value) })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    >
                      <option value={1}>简单</option>
                      <option value={2}>中等</option>
                      <option value={3}>困难</option>
                    </select>
                  </div>
                </div>
              </>
            )}

            {activeTab === 'selector' && (
              <>
                <div className="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-xl p-4 mb-4">
                  <p className="text-sm text-blue-700 dark:text-blue-300">
                    CSS选择器用于从网页中提取对应内容。多个选择器用逗号分隔，系统会按顺序尝试匹配。
                  </p>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">标题选择器</label>
                    <input
                      type="text"
                      value={formData.titleSelector || ''}
                      onChange={(e) => setFormData({ ...formData, titleSelector: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white font-mono text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder="h1, .title"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">作者选择器</label>
                    <input
                      type="text"
                      value={formData.authorSelector || ''}
                      onChange={(e) => setFormData({ ...formData, authorSelector: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white font-mono text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder=".author, .byline"
                    />
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">来源选择器</label>
                    <input
                      type="text"
                      value={formData.sourceSelector || ''}
                      onChange={(e) => setFormData({ ...formData, sourceSelector: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white font-mono text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder=".source, .category"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">日期选择器</label>
                    <input
                      type="text"
                      value={formData.dateSelector || ''}
                      onChange={(e) => setFormData({ ...formData, dateSelector: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white font-mono text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder=".date, time"
                    />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">内容选择器</label>
                  <input
                    type="text"
                    value={formData.contentSelector || ''}
                    onChange={(e) => setFormData({ ...formData, contentSelector: e.target.value })}
                    className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white font-mono text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    placeholder="article, .content, .article-content"
                  />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">图片选择器</label>
                    <input
                      type="text"
                      value={formData.imageSelector || ''}
                      onChange={(e) => setFormData({ ...formData, imageSelector: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white font-mono text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder="article img"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">链接选择器</label>
                    <input
                      type="text"
                      value={formData.linkSelector || ''}
                      onChange={(e) => setFormData({ ...formData, linkSelector: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white font-mono text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder="a[href]"
                    />
                  </div>
                </div>
              </>
            )}

            {activeTab === 'advanced' && (
              <>
                <div className="grid grid-cols-3 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">最大深度</label>
                    <input
                      type="number"
                      min={1}
                      max={10}
                      value={formData.maxDepth}
                      onChange={(e) => setFormData({ ...formData, maxDepth: Number(e.target.value) })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">最大页面数</label>
                    <input
                      type="number"
                      min={1}
                      max={100}
                      value={formData.maxPages}
                      onChange={(e) => setFormData({ ...formData, maxPages: Number(e.target.value) })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">默认文章数</label>
                    <input
                      type="number"
                      min={1}
                      max={50}
                      value={formData.defaultMaxArticles}
                      onChange={(e) => setFormData({ ...formData, defaultMaxArticles: Number(e.target.value) })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    />
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">请求延迟 (毫秒)</label>
                    <input
                      type="number"
                      min={500}
                      max={10000}
                      step={100}
                      value={formData.delayMs}
                      onChange={(e) => setFormData({ ...formData, delayMs: Number(e.target.value) })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">Cron 表达式</label>
                    <input
                      type="text"
                      value={formData.cronExpression || ''}
                      onChange={(e) => setFormData({ ...formData, cronExpression: e.target.value })}
                      className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white font-mono text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder="0 0 8 * * ? (每天8点)"
                    />
                  </div>
                </div>
                
                <div className="border-t border-gray-100 dark:border-gray-800 pt-4 mt-4">
                  <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">动态抓取设置</h4>
                  <div className="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-800 rounded-xl">
                    <div className="flex items-center gap-3">
                      <Zap size={20} className={formData.useDynamic ? 'text-yellow-500' : 'text-gray-400'} />
                      <div>
                        <p className="text-sm font-medium text-gray-900 dark:text-white">启用动态抓取</p>
                        <p className="text-xs text-gray-500">使用无头浏览器抓取 JavaScript 渲染的页面</p>
                      </div>
                    </div>
                    <button
                      type="button"
                      onClick={() => setFormData({ ...formData, useDynamic: !formData.useDynamic })}
                      className={`relative w-12 h-6 rounded-full transition-colors ${
                        formData.useDynamic ? 'bg-brand-600' : 'bg-gray-300 dark:bg-gray-600'
                      }`}
                    >
                      <span className={`absolute left-1 top-1 w-4 h-4 bg-white rounded-full shadow transition-transform ${
                        formData.useDynamic ? 'translate-x-6' : ''
                      }`} />
                    </button>
                  </div>
                  {formData.useDynamic && (
                    <div className="mt-4">
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">JS等待时间 (毫秒)</label>
                      <input
                        type="number"
                        min={1000}
                        max={30000}
                        step={500}
                        value={formData.waitForJsMs}
                        onChange={(e) => setFormData({ ...formData, waitForJsMs: Number(e.target.value) })}
                        className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      />
                    </div>
                  )}
                </div>

                <div className="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-800 rounded-xl">
                  <div className="flex items-center gap-3">
                    <Play size={20} className={formData.enabled ? 'text-green-500' : 'text-gray-400'} />
                    <div>
                      <p className="text-sm font-medium text-gray-900 dark:text-white">启用配置</p>
                      <p className="text-xs text-gray-500">启用后可参与定时任务</p>
                    </div>
                  </div>
                  <button
                    type="button"
                    onClick={() => setFormData({ ...formData, enabled: !formData.enabled })}
                    className={`relative w-12 h-6 rounded-full transition-colors ${
                      formData.enabled ? 'bg-green-500' : 'bg-gray-300 dark:bg-gray-600'
                    }`}
                  >
                    <span className={`absolute left-1 top-1 w-4 h-4 bg-white rounded-full shadow transition-transform ${
                      formData.enabled ? 'translate-x-6' : ''
                    }`} />
                  </button>
                </div>
              </>
            )}
          </form>
        </div>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50 flex-shrink-0">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            取消
          </button>
          <button
            type="submit"
            onClick={handleSubmit}
            disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading && <Loader2 size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建配置'}
          </button>
        </div>
      </div>
    </div>
  );
};

interface ExecuteModalProps {
  isOpen: boolean;
  onClose: () => void;
  config: ScraperConfigResponse | null;
  onSuccess: () => void;
}

const ExecuteModal: React.FC<ExecuteModalProps> = ({ isOpen, onClose, config, onSuccess }) => {
  const [loading, setLoading] = useState(false);
  const [maxArticles, setMaxArticles] = useState(5);

  useEffect(() => {
    if (config) {
      setMaxArticles(config.defaultMaxArticles || 5);
    }
  }, [config]);

  const handleExecute = async () => {
    if (!config?.id) return;
    
    setLoading(true);
    try {
      const response = await api.executeTask({ executeTaskRequest: { configId: config.id, maxArticles } });
      if (response.data.code === 0) {
        toast.success('任务已启动');
        onSuccess();
        onClose();
      } else {
        toast.error(response.data.message || '执行失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '执行失败');
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen || !config) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">执行抓取任务</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>
        <div className="p-6 space-y-4">
          <div className="bg-gray-50 dark:bg-gray-800 rounded-xl p-4">
            <p className="text-sm text-gray-600 dark:text-gray-400">配置名称</p>
            <p className="text-lg font-semibold text-gray-900 dark:text-white">{config.name}</p>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
              最大抓取文章数
            </label>
            <input
              type="number"
              min={1}
              max={50}
              value={maxArticles}
              onChange={(e) => setMaxArticles(Number(e.target.value))}
              className="w-full px-4 py-2.5 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
            />
          </div>
        </div>
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            取消
          </button>
          <button
            onClick={handleExecute}
            disabled={loading}
            className="px-6 py-2 bg-green-600 text-white text-sm font-bold rounded-xl hover:bg-green-700 shadow-lg shadow-green-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading ? <Loader2 size={16} className="animate-spin" /> : <Play size={16} />}
            开始抓取
          </button>
        </div>
      </div>
    </div>
  );
};

export const ScraperConfigPage: React.FC = () => {
  const [configs, setConfigs] = useState<ScraperConfigResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [isFormModalOpen, setIsFormModalOpen] = useState(false);
  const [isExecuteModalOpen, setIsExecuteModalOpen] = useState(false);
  const [selectedConfig, setSelectedConfig] = useState<ScraperConfigResponse | null>(null);
  const pageSize = 10;

  const fetchConfigs = useCallback(async () => {
    setLoading(true);
    try {
      // 使用分页接口获取配置列表
      const response = await api.getConfigsByPage({ page: 1, size: 100 });
      if (response.data.code === 0 && response.data.data) {
        const pageData = response.data.data as ScraperConfigPageResponse;
        setConfigs(pageData.records || []);
      }
    } catch (error) {
      toast.error('获取配置列表失败');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchConfigs();
  }, [fetchConfigs]);

  const handleToggleEnabled = async (config: ScraperConfigResponse) => {
    if (!config.id) return;
    
    try {
      if (config.enabled) {
        await api.disableConfig({ id: config.id });
        toast.success('已禁用');
      } else {
        await api.enableConfig({ id: config.id });
        toast.success('已启用');
      }
      fetchConfigs();
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const handleDelete = async (config: ScraperConfigResponse) => {
    if (!config.id) return;
    if (!confirm(`确定删除配置「${config.name}」吗？`)) return;

    try {
      await api.deleteConfig({ id: config.id });
      toast.success('删除成功');
      fetchConfigs();
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '删除失败');
    }
  };

  const filteredConfigs = configs.filter(config =>
    config.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    config.sourceCode?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    config.baseUrl?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const totalPages = Math.ceil(filteredConfigs.length / pageSize);
  const paginatedConfigs = filteredConfigs.slice(
    (currentPage - 1) * pageSize,
    currentPage * pageSize
  );

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">抓取配置管理</h1>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
            管理网页抓取源配置，支持静态和动态抓取
          </p>
        </div>
        <button
          onClick={() => {
            setSelectedConfig(null);
            setIsFormModalOpen(true);
          }}
          className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
        >
          <Plus size={18} />
          新增配置
        </button>
      </div>

      {/* Search & Filters */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <div className="flex flex-col sm:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text"
              placeholder="搜索配置名称、来源代码或URL..."
              value={searchTerm}
              onChange={(e) => {
                setSearchTerm(e.target.value);
                setCurrentPage(1);
              }}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <button
            onClick={fetchConfigs}
            className="inline-flex items-center gap-2 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-400 transition-colors"
          >
            <RefreshCw size={18} className={loading ? 'animate-spin' : ''} />
            刷新
          </button>
        </div>
      </div>

      {/* Configs Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-left text-xs font-bold text-gray-400 uppercase tracking-wider">配置信息</th>
                <th className="px-6 py-4 text-left text-xs font-bold text-gray-400 uppercase tracking-wider">来源URL</th>
                <th className="px-6 py-4 text-center text-xs font-bold text-gray-400 uppercase tracking-wider">抓取类型</th>
                <th className="px-6 py-4 text-center text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-right text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                <tr>
                  <td colSpan={5} className="px-6 py-16 text-center">
                    <RefreshCw className="w-8 h-8 text-brand-600 animate-spin mx-auto mb-3" />
                    <p className="text-gray-500 dark:text-gray-400">加载中...</p>
                  </td>
                </tr>
              ) : paginatedConfigs.length === 0 ? (
                <tr>
                  <td colSpan={5} className="px-6 py-16 text-center">
                    <Globe className="w-12 h-12 text-gray-300 dark:text-gray-600 mx-auto mb-3" />
                    <p className="text-gray-500 dark:text-gray-400">暂无配置数据</p>
                  </td>
                </tr>
              ) : (
                paginatedConfigs.map((config) => (
                  <tr key={config.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <div>
                        <p className="font-medium text-gray-900 dark:text-white">{config.name}</p>
                        <p className="text-sm text-gray-500 dark:text-gray-400 font-mono">{config.sourceCode}</p>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <a
                        href={config.baseUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-sm text-brand-600 hover:text-brand-700 dark:text-brand-400 dark:hover:text-brand-300 hover:underline truncate block max-w-xs"
                      >
                        {config.baseUrl}
                      </a>
                    </td>
                    <td className="px-6 py-4 text-center">
                      <span className={`inline-flex items-center gap-1 px-2.5 py-1 text-xs font-medium rounded-full ${
                        config.useDynamic
                          ? 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-400'
                          : 'bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400'
                      }`}>
                        {config.useDynamic ? <Zap size={12} /> : <Globe size={12} />}
                        {config.useDynamic ? '动态' : '静态'}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-center">
                      <button
                        onClick={() => handleToggleEnabled(config)}
                        className={`inline-flex items-center gap-1 px-2.5 py-1 text-xs font-medium rounded-full transition-colors ${
                          config.enabled
                            ? 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400 hover:bg-green-200 dark:hover:bg-green-900/50'
                            : 'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700'
                        }`}
                      >
                        {config.enabled ? <Play size={12} /> : <Pause size={12} />}
                        {config.enabled ? '启用' : '禁用'}
                      </button>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <div className="flex items-center justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button
                          onClick={() => {
                            setSelectedConfig(config);
                            setIsExecuteModalOpen(true);
                          }}
                          className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                          title="执行抓取"
                        >
                          <Play size={16} />
                        </button>
                        <button
                          onClick={() => {
                            setSelectedConfig(config);
                            setIsFormModalOpen(true);
                          }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                          title="编辑"
                        >
                          <Edit2 size={16} />
                        </button>
                        <button
                          onClick={() => handleDelete(config)}
                          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                          title="删除"
                        >
                          <Trash2 size={16} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              共 {filteredConfigs.length} 条记录
            </p>
            <div className="flex items-center gap-2">
              <button
                onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                disabled={currentPage === 1}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
              >
                <ChevronLeft size={18} />
              </button>
              <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
                {currentPage} / {totalPages}
              </span>
              <button
                onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                disabled={currentPage === totalPages}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
              >
                <ChevronRight size={18} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Modals */}
      <ConfigFormModal
        isOpen={isFormModalOpen}
        onClose={() => setIsFormModalOpen(false)}
        onSuccess={fetchConfigs}
        config={selectedConfig}
      />
      <ExecuteModal
        isOpen={isExecuteModalOpen}
        onClose={() => setIsExecuteModalOpen(false)}
        config={selectedConfig}
        onSuccess={fetchConfigs}
      />
    </div>
  );
};
