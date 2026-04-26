import React, { useState, useEffect, useCallback, useRef } from 'react';
import {
  Search,
  Plus,
  Edit2,
  Trash2,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  Bot,
  Globe,
  Lock,
  Send,
  Archive,
  Tag,
  Brain,
  Thermometer,
  MessageSquare,
  Star,
  Eye,
  Square,
  PlayCircle,
  Database,
  Link,
  Unlink,
  Loader2,
  GitBranch,
  ChevronDown,
  ChevronUp,
  Terminal,
  Sparkles,
  Image as ImageIcon,
} from 'lucide-react';
import MarkdownRenderer from '../../components/chat/MarkdownRenderer';
import { apiClient, AIApi, DefaultApi, MCPApi, Configuration, getToken } from '../../api';
import type { AiAssistantVO, CreateAiAssistantCommand, UpdateAiAssistantCommand, KnowledgeBaseVO, WorkflowResponse, WorkflowSkillVO } from '../../api/generated/models';
import { toast, TruncateWithTooltip, ImageUploadArea } from '../../components/ui';

const aiApi = new AIApi(new Configuration(), '', apiClient);
const defaultApi = new DefaultApi(new Configuration(), '', apiClient);
const mcpApi = new MCPApi(new Configuration(), '', apiClient);

// 获取当前用户ID（雪花ID，运行时为字符串）
const getCurrentUserId = (): number => {
  const userInfoStr = localStorage.getItem('user_info');
  const userInfo = userInfoStr ? JSON.parse(userInfoStr) : null;
  const userId = userInfo?.id;
  // 雪花ID运行时为字符串，使用 as unknown as number 进行断言
  return userId as unknown as number;
};

// 状态配置
const STATUS_CONFIG: Record<string, { label: string; color: string }> = {
  DRAFT: { label: '草稿', color: 'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700' },
  PUBLISHED: { label: '已发布', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' },
  ARCHIVED: { label: '已归档', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800' },
};

// 分类选项
const CATEGORY_OPTIONS = [
  { value: '', label: '全部分类' },
  { value: '通用', label: '通用' },
  { value: '教育', label: '教育' },
  { value: '编程', label: '编程' },
  { value: '写作', label: '写作' },
  { value: '翻译', label: '翻译' },
  { value: '数学', label: '数学' },
  { value: '英语', label: '英语' },
  { value: '科学', label: '科学' },
];

// ======================== 表单弹窗组件 ========================
interface AssistantFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  assistant?: AiAssistantVO | null;
}

const AssistantFormModal: React.FC<AssistantFormModalProps> = ({ isOpen, onClose, onSuccess, assistant }) => {
  const isEdit = !!assistant;
  const [loading, setLoading] = useState(false);
  const [activeTab, setActiveTab] = useState<'basic' | 'prompt' | 'model'>('basic');
  const [avatarUploading, setAvatarUploading] = useState(false);
  const [aiAvatarGenerating, setAiAvatarGenerating] = useState(false);
  const [showAiAvatarPanel, setShowAiAvatarPanel] = useState(false);
  const [aiAvatarPrompt, setAiAvatarPrompt] = useState('');
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    avatarUrl: '',
    tags: '',
    category: '',
    systemPrompt: '',
    openingMessage: '',
    suggestedQuestions: '',
    modelName: '',
    temperature: '0.7',
    topP: '0.9',
    maxTokens: '2048',
  });

  useEffect(() => {
    if (assistant) {
      setFormData({
        name: assistant.name || '',
        description: assistant.description || '',
        avatarUrl: assistant.avatarUrl || '',
        tags: (assistant.tags || []).join(', '),
        category: assistant.category || '',
        systemPrompt: assistant.systemPrompt || '',
        openingMessage: assistant.openingMessage || '',
        suggestedQuestions: (assistant.suggestedQuestions || []).join('\n'),
        modelName: assistant.modelName || '',
        temperature: String(assistant.temperature ?? '0.7'),
        topP: String(assistant.topP ?? '0.9'),
        maxTokens: String(assistant.maxTokens ?? '2048'),
      });
    } else {
      setFormData({
        name: '',
        description: '',
        avatarUrl: '',
        tags: '',
        category: '',
        systemPrompt: '',
        openingMessage: '',
        suggestedQuestions: '',
        modelName: '',
        temperature: '0.7',
        topP: '0.9',
        maxTokens: '2048',
      });
    }
    setActiveTab('basic');
  }, [assistant, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!formData.name.trim()) {
      toast.warning('请输入助手名称');
      return;
    }

    setLoading(true);
    try {
      const tagsArr = formData.tags ? formData.tags.split(',').map(t => t.trim()).filter(Boolean) : undefined;
      const questionsArr = formData.suggestedQuestions ? formData.suggestedQuestions.split('\n').map(q => q.trim()).filter(Boolean) : undefined;

      if (isEdit && assistant?.id) {
        const updateData: UpdateAiAssistantCommand = {
          name: formData.name,
          description: formData.description || undefined,
          avatarUrl: formData.avatarUrl || undefined,
          tags: tagsArr,
          category: formData.category || undefined,
          systemPrompt: formData.systemPrompt || undefined,
          openingMessage: formData.openingMessage || undefined,
          suggestedQuestions: questionsArr,
          modelName: formData.modelName || undefined,
          temperature: formData.temperature ? Number(formData.temperature) : undefined,
          topP: formData.topP ? Number(formData.topP) : undefined,
          maxTokens: formData.maxTokens ? Number(formData.maxTokens) : undefined,
        };
        // assistant.id 运行时为字符串（雪花ID），不使用 Number() 转换
        const response = await aiApi.assistantUpdate({ id: assistant.id as unknown as number, updateAiAssistantCommand: updateData });
        if (response.data.code === 0) {
          toast.success('更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const createData: CreateAiAssistantCommand = {
          name: formData.name,
          description: formData.description || undefined,
          avatarUrl: formData.avatarUrl || undefined,
          tags: tagsArr,
          category: formData.category || undefined,
          systemPrompt: formData.systemPrompt || undefined,
          openingMessage: formData.openingMessage || undefined,
          suggestedQuestions: questionsArr,
          modelName: formData.modelName || undefined,
          temperature: formData.temperature ? Number(formData.temperature) : undefined,
          topP: formData.topP ? Number(formData.topP) : undefined,
          maxTokens: formData.maxTokens ? Number(formData.maxTokens) : undefined,
        };
        const userId = getCurrentUserId();
        const response = await aiApi.assistantCreate({ userId, createAiAssistantCommand: createData });
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

  const tabClasses = (tab: string) =>
    `px-4 py-2 text-sm font-medium rounded-lg transition-all ${
      activeTab === tab
        ? 'bg-brand-600 text-white shadow-sm'
        : 'text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
    }`;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2">
            <Bot size={20} className="text-brand-600" />
            {isEdit ? '编辑 AI 助手' : '新建 AI 助手'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Tabs */}
        <div className="px-6 pt-4 flex gap-2">
          <button className={tabClasses('basic')} onClick={() => setActiveTab('basic')}>基本信息</button>
          <button className={tabClasses('prompt')} onClick={() => setActiveTab('prompt')}>提示词配置</button>
          <button className={tabClasses('model')} onClick={() => setActiveTab('model')}>模型参数</button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto p-6 space-y-4">
          {activeTab === 'basic' && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">名称 *</label>
                <input
                  type="text"
                  value={formData.name}
                  onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="给助手起个名字"
                  maxLength={128}
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
                <textarea
                  value={formData.description}
                  onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                  placeholder="描述助手的功能和用途"
                  rows={3}
                  maxLength={2000}
                />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">分类</label>
                  <select
                    value={formData.category}
                    onChange={(e) => setFormData(prev => ({ ...prev, category: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
                  >
                    <option value="">选择分类</option>
                    {CATEGORY_OPTIONS.filter(c => c.value).map(c => (
                      <option key={c.value} value={c.value}>{c.label}</option>
                    ))}
                  </select>
                </div>
                <div>
                  <div className="flex items-center justify-between mb-1.5">
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">头像</label>
                    <button type="button" onClick={() => setShowAiAvatarPanel(v => !v)}
                      className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-bold transition-all ${
                        showAiAvatarPanel
                          ? 'bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400'
                          : 'bg-gray-100 text-gray-600 hover:bg-brand-50 hover:text-brand-600 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-brand-900/20 dark:hover:text-brand-400'
                      }`}>
                      <Sparkles size={14} />
                      AI 生成
                    </button>
                  </div>
                  <ImageUploadArea
                    value={formData.avatarUrl || ''}
                    onFileSelect={async (file) => {
                      if (!file.type.startsWith('image/')) { toast.warning('请选择图片文件'); return; }
                      if (file.size > 5 * 1024 * 1024) { toast.warning('图片不能超过 5MB'); return; }
                      setAvatarUploading(true);
                      try {
                        const fd = new FormData();
                        fd.append('file', file);
                        const res = await apiClient.post('/api/file/upload/assistant/avatar', fd, { headers: { 'Content-Type': 'multipart/form-data' } });
                        if (res.data?.code === 0 && res.data.data?.fileUrl) {
                          setFormData(prev => ({ ...prev, avatarUrl: res.data.data.fileUrl }));
                          toast.success('头像上传成功');
                        } else { toast.error(res.data?.message || '上传失败'); }
                      } catch { toast.error('上传失败'); }
                      finally { setAvatarUploading(false); }
                    }}
                    onChange={(url) => setFormData(prev => ({ ...prev, avatarUrl: url }))}
                    uploading={avatarUploading}
                    accept="image/*"
                    aspectRatio="aspect-video"
                    placeholder="点击上传头像"
                  />
                </div>
              </div>
              {/* AI 生成头像面板 */}
              {showAiAvatarPanel && (
                <div className="p-4 bg-gradient-to-br from-brand-50 to-indigo-50 dark:from-brand-900/10 dark:to-indigo-900/10 rounded-xl border border-brand-100 dark:border-brand-800/30 space-y-3">
                  <div className="flex items-center gap-2 text-sm font-medium text-brand-700 dark:text-brand-300">
                    <Sparkles size={14} />
                    AI 生成头像
                  </div>
                  <div className="flex gap-2">
                    <input
                      type="text"
                      value={aiAvatarPrompt}
                      onChange={(e) => setAiAvatarPrompt(e.target.value)}
                      className="flex-1 px-3 py-2 text-sm bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                      placeholder="描述头像风格，如：可爱的卡通数学老师，蓝色主题"
                    />
                    <button type="button" disabled={aiAvatarGenerating || !aiAvatarPrompt.trim()}
                      onClick={async () => {
                        setAiAvatarGenerating(true);
                        try {
                          const res = await aiApi.assistantGenerateAvatar({ generateAvatarRequest: { prompt: aiAvatarPrompt.trim() } });
                          if (res.data.code === 0 && res.data.data?.success) {
                            setFormData(prev => ({ ...prev, avatarUrl: res.data.data!.imageUrl || '' }));
                            toast.success('AI 头像生成成功');
                            setShowAiAvatarPanel(false);
                            setAiAvatarPrompt('');
                          } else {
                            toast.error(res.data.data?.errorMessage || res.data.message || 'AI 生成失败');
                          }
                        } catch (err: any) { toast.error(err?.response?.data?.message || 'AI 生成失败'); }
                        finally { setAiAvatarGenerating(false); }
                      }}
                      className="flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg bg-brand-600 hover:bg-brand-700 text-white transition-colors disabled:opacity-50 disabled:cursor-not-allowed whitespace-nowrap">
                      {aiAvatarGenerating ? <Loader2 size={14} className="animate-spin" /> : <ImageIcon size={14} />}
                      {aiAvatarGenerating ? '生成中...' : '生成'}
                    </button>
                  </div>
                  <p className="text-[11px] text-gray-500 dark:text-gray-400">提示：使用英文描述效果更好，AI 生成需要 10-30 秒</p>
                </div>
              )}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">标签</label>
                <input
                  type="text"
                  value={formData.tags}
                  onChange={(e) => setFormData(prev => ({ ...prev, tags: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="用逗号分隔，如: 教育, 数学, 辅导"
                />
              </div>
            </>
          )}

          {activeTab === 'prompt' && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">系统提示词</label>
                <textarea
                  value={formData.systemPrompt}
                  onChange={(e) => setFormData(prev => ({ ...prev, systemPrompt: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none font-mono text-sm"
                  placeholder="定义助手的角色、行为和限制..."
                  rows={6}
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">开场白</label>
                <textarea
                  value={formData.openingMessage}
                  onChange={(e) => setFormData(prev => ({ ...prev, openingMessage: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                  placeholder="用户打开对话时助手的第一句话"
                  rows={3}
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">推荐问题</label>
                <textarea
                  value={formData.suggestedQuestions}
                  onChange={(e) => setFormData(prev => ({ ...prev, suggestedQuestions: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                  placeholder="每行一个推荐问题&#10;如何学好数学？&#10;帮我写一篇作文"
                  rows={4}
                />
              </div>
            </>
          )}

          {activeTab === 'model' && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">模型名称</label>
                <input
                  type="text"
                  value={formData.modelName}
                  onChange={(e) => setFormData(prev => ({ ...prev, modelName: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="如: gpt-4o-mini, deepseek-chat"
                />
              </div>
              <div className="grid grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    Temperature
                    <span className="text-xs text-gray-400 ml-1">(0~2)</span>
                  </label>
                  <input
                    type="number"
                    step="0.1"
                    min="0"
                    max="2"
                    value={formData.temperature}
                    onChange={(e) => setFormData(prev => ({ ...prev, temperature: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    Top P
                    <span className="text-xs text-gray-400 ml-1">(0~1)</span>
                  </label>
                  <input
                    type="number"
                    step="0.1"
                    min="0"
                    max="1"
                    value={formData.topP}
                    onChange={(e) => setFormData(prev => ({ ...prev, topP: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    Max Tokens
                  </label>
                  <input
                    type="number"
                    step="256"
                    min="256"
                    max="128000"
                    value={formData.maxTokens}
                    onChange={(e) => setFormData(prev => ({ ...prev, maxTokens: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  />
                </div>
              </div>
              <div className="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-xl border border-blue-100 dark:border-blue-800/30">
                <p className="text-xs text-blue-600 dark:text-blue-400">
                  <strong>Temperature</strong> 控制输出随机性，值越高越有创意；<strong>Top P</strong> 控制采样范围；<strong>Max Tokens</strong> 限制回复长度。
                </p>
              </div>
            </>
          )}
        </form>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            取消
          </button>
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading && <Loader2 size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建助手'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ======================== 详情弹窗组件 ========================
interface AssistantDetailModalProps {
  isOpen: boolean;
  onClose: () => void;
  assistant: AiAssistantVO | null;
}

const AssistantDetailModal: React.FC<AssistantDetailModalProps> = ({ isOpen, onClose, assistant }) => {
  if (!isOpen || !assistant) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[85vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center shadow-lg shadow-brand-500/20">
              {assistant.avatarUrl ? (
                <img src={assistant.avatarUrl} alt="" className="w-full h-full rounded-xl object-cover" />
              ) : (
                <Bot size={20} className="text-white" />
              )}
            </div>
            <div>
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">{assistant.name}</h3>
              <div className="flex items-center gap-2 mt-0.5">
                <span className={`px-2 py-0.5 rounded-md text-[10px] font-bold border ${STATUS_CONFIG[assistant.status || 'DRAFT']?.color || STATUS_CONFIG.DRAFT.color}`}>
                  {STATUS_CONFIG[assistant.status || 'DRAFT']?.label || '草稿'}
                </span>
                {assistant.isPublic && (
                  <span className="flex items-center gap-1 text-[10px] text-green-600 dark:text-green-400">
                    <Globe size={10} /> 公开
                  </span>
                )}
              </div>
            </div>
          </div>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto p-6 space-y-5">
          {/* 描述 */}
          {assistant.description && (
            <div>
              <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">描述</h4>
              <p className="text-sm text-gray-600 dark:text-gray-300 leading-relaxed">{assistant.description}</p>
            </div>
          )}

          {/* 标签与分类 */}
          <div className="flex flex-wrap gap-4">
            {assistant.category && (
              <div>
                <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">分类</h4>
                <span className="px-3 py-1 bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 text-sm font-medium rounded-lg">{assistant.category}</span>
              </div>
            )}
            {assistant.tags && assistant.tags.length > 0 && (
              <div>
                <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">标签</h4>
                <div className="flex flex-wrap gap-1.5">
                  {assistant.tags.map((tag, i) => (
                    <span key={i} className="px-2.5 py-1 bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 text-xs font-medium rounded-lg">{tag}</span>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* 系统提示词 */}
          {assistant.systemPrompt && (
            <div>
              <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">系统提示词</h4>
              <div className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-gray-100 dark:border-gray-800">
                <pre className="text-sm text-gray-600 dark:text-gray-300 whitespace-pre-wrap font-mono leading-relaxed">{assistant.systemPrompt}</pre>
              </div>
            </div>
          )}

          {/* 开场白 */}
          {assistant.openingMessage && (
            <div>
              <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">开场白</h4>
              <p className="text-sm text-gray-600 dark:text-gray-300 leading-relaxed">{assistant.openingMessage}</p>
            </div>
          )}

          {/* 推荐问题 */}
          {assistant.suggestedQuestions && assistant.suggestedQuestions.length > 0 && (
            <div>
              <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">推荐问题</h4>
              <div className="space-y-1.5">
                {assistant.suggestedQuestions.map((q, i) => (
                  <div key={i} className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300">
                    <MessageSquare size={14} className="text-gray-400 flex-shrink-0" />
                    <span>{q}</span>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* 模型参数 */}
          <div>
            <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">模型参数</h4>
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
              <div className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl text-center">
                <p className="text-[10px] text-gray-400 uppercase font-bold mb-1">模型</p>
                <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.modelName || '默认'}</p>
              </div>
              <div className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl text-center">
                <p className="text-[10px] text-gray-400 uppercase font-bold mb-1">Temperature</p>
                <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.temperature ?? '-'}</p>
              </div>
              <div className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl text-center">
                <p className="text-[10px] text-gray-400 uppercase font-bold mb-1">Top P</p>
                <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.topP ?? '-'}</p>
              </div>
              <div className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl text-center">
                <p className="text-[10px] text-gray-400 uppercase font-bold mb-1">Max Tokens</p>
                <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.maxTokens ?? '-'}</p>
              </div>
            </div>
          </div>

          {/* 统计信息 */}
          <div>
            <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">统计信息</h4>
            <div className="grid grid-cols-3 gap-3">
              <div className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl text-center">
                <p className="text-[10px] text-gray-400 uppercase font-bold mb-1">使用次数</p>
                <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.usageCount ?? 0}</p>
              </div>
              <div className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl text-center">
                <p className="text-[10px] text-gray-400 uppercase font-bold mb-1">评分</p>
                <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.rating ? assistant.rating.toFixed(1) : '-'}</p>
              </div>
              <div className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl text-center">
                <p className="text-[10px] text-gray-400 uppercase font-bold mb-1">版本</p>
                <p className="text-sm font-bold text-gray-900 dark:text-white">v{assistant.version ?? 0}{assistant.publishedVersion ? ` (发布 v${assistant.publishedVersion})` : ''}</p>
              </div>
            </div>
          </div>

          {/* 知识库 */}
          {assistant.knowledgeBases && assistant.knowledgeBases.length > 0 && (
            <div>
              <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">关联知识库</h4>
              <div className="space-y-2">
                {assistant.knowledgeBases.map((kb) => (
                  <div key={kb.id} className="flex items-center gap-3 p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl">
                    <Brain size={16} className="text-brand-500 flex-shrink-0" />
                    <div>
                      <p className="text-sm font-medium text-gray-900 dark:text-white">{kb.name}</p>
                      {kb.description && <p className="text-xs text-gray-400 mt-0.5">{kb.description}</p>}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-end px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            关闭
          </button>
        </div>
      </div>
    </div>
  );
};

// ======================== 知识库绑定管理弹窗组件 ========================
interface KnowledgeBaseBindModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  assistant: AiAssistantVO | null;
}

const KnowledgeBaseBindModal: React.FC<KnowledgeBaseBindModalProps> = ({ isOpen, onClose, onSuccess, assistant }) => {
  const [allKbs, setAllKbs] = useState<KnowledgeBaseVO[]>([]);
  const [loading, setLoading] = useState(false);
  const [bindingId, setBindingId] = useState<number | null>(null);

  // 已绑定的知识库ID集合
  const boundIds = new Set(
    (assistant?.knowledgeBases || []).map(kb => String(kb.id))
  );

  // 加载当前用户的所有知识库
  useEffect(() => {
    if (!isOpen) return;
    const fetchKbs = async () => {
      setLoading(true);
      try {
        const userId = getCurrentUserId();
        const response = await defaultApi.kbListByCreator({ userId, page: 0, size: 100 });
        if (response.data.code === 0) {
          setAllKbs(response.data.data || []);
        }
      } catch (error: any) {
        toast.error(error?.response?.data?.message || '获取知识库列表失败');
      } finally {
        setLoading(false);
      }
    };
    fetchKbs();
  }, [isOpen]);

  const handleBind = async (kbId: number) => {
    if (!assistant?.id) return;
    setBindingId(kbId);
    try {
      const response = await aiApi.assistantBindKnowledgeBase({
        id: assistant.id as unknown as number,
        kbId: kbId as unknown as number,
      });
      if (response.data.code === 0) {
        toast.success('绑定成功');
        onSuccess();
      } else {
        toast.error(response.data.message || '绑定失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '绑定失败');
    } finally {
      setBindingId(null);
    }
  };

  const handleUnbind = async (kbId: number) => {
    if (!assistant?.id) return;
    setBindingId(kbId);
    try {
      const response = await aiApi.assistantUnbindKnowledgeBase({
        id: assistant.id as unknown as number,
        kbId: kbId as unknown as number,
      });
      if (response.data.code === 0) {
        toast.success('解绑成功');
        onSuccess();
      } else {
        toast.error(response.data.message || '解绑失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '解绑失败');
    } finally {
      setBindingId(null);
    }
  };

  if (!isOpen || !assistant) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[80vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2">
            <Database size={20} className="text-brand-600" />
            知识库管理
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* 当前助手信息 */}
        <div className="px-6 py-3 bg-gray-50/50 dark:bg-gray-800/30 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center shadow-sm">
              <Bot size={16} className="text-white" />
            </div>
            <div>
              <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.name}</p>
              <p className="text-[10px] text-gray-400">已绑定 {boundIds.size} 个知识库</p>
            </div>
          </div>
        </div>

        {/* 知识库列表 */}
        <div className="flex-1 overflow-y-auto p-4 space-y-2">
          {loading ? (
            <div className="flex items-center justify-center py-12">
              <Loader2 size={24} className="animate-spin text-brand-500" />
            </div>
          ) : allKbs.length === 0 ? (
            <div className="flex flex-col items-center py-12">
              <Database size={32} className="text-gray-300 dark:text-gray-600 mb-3" />
              <p className="text-sm text-gray-500 dark:text-gray-400">暂无可用知识库</p>
              <p className="text-xs text-gray-400 mt-1">请先在知识库管理中创建知识库</p>
            </div>
          ) : (
            allKbs.map((kb) => {
              const isBound = boundIds.has(String(kb.id));
              const isProcessing = bindingId !== null && String(bindingId) === String(kb.id);
              return (
                <div
                  key={kb.id}
                  className={`flex items-center justify-between p-3 rounded-xl border transition-all ${
                    isBound
                      ? 'bg-brand-50/50 dark:bg-brand-900/10 border-brand-200 dark:border-brand-800/40'
                      : 'bg-white dark:bg-gray-800/50 border-gray-100 dark:border-gray-700 hover:border-gray-200 dark:hover:border-gray-600'
                  }`}
                >
                  <div className="flex items-center gap-3 min-w-0 flex-1">
                    <div className={`w-9 h-9 rounded-lg flex items-center justify-center flex-shrink-0 ${
                      isBound
                        ? 'bg-brand-100 dark:bg-brand-900/30'
                        : 'bg-gray-100 dark:bg-gray-700'
                    }`}>
                      <Brain size={16} className={isBound ? 'text-brand-600 dark:text-brand-400' : 'text-gray-400'} />
                    </div>
                    <div className="min-w-0">
                      <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{kb.name}</p>
                      <div className="flex items-center gap-2 mt-0.5">
                        {kb.description && (
                          <span className="text-[10px] text-gray-400 truncate max-w-[160px]">{kb.description}</span>
                        )}
                        <span className="text-[10px] text-gray-400 flex-shrink-0">
                          {kb.documentCount ?? 0} 文档 · {kb.chunkCount ?? 0} 分块
                        </span>
                      </div>
                    </div>
                  </div>
                  <button
                    onClick={() => isBound ? handleUnbind(kb.id!) : handleBind(kb.id!)}
                    disabled={isProcessing}
                    className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium transition-all flex-shrink-0 ml-3 ${
                      isProcessing
                        ? 'opacity-50 cursor-not-allowed'
                        : isBound
                          ? 'bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 hover:bg-red-100 dark:hover:bg-red-900/30 border border-red-200 dark:border-red-800/40'
                          : 'bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 hover:bg-brand-100 dark:hover:bg-brand-900/30 border border-brand-200 dark:border-brand-800/40'
                    }`}
                  >
                    {isProcessing ? (
                      <Loader2 size={12} className="animate-spin" />
                    ) : isBound ? (
                      <><Unlink size={12} /> 解绑</>
                    ) : (
                      <><Link size={12} /> 绑定</>
                    )}
                  </button>
                </div>
              );
            })
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-between px-6 py-3 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <p className="text-xs text-gray-400">
            绑定知识库后，助手对话时会自动检索相关内容（RAG）
          </p>
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            完成
          </button>
        </div>
      </div>
    </div>
  );
};

// ======================== 工作流技能绑定管理弹窗组件 ========================
interface WorkflowSkillBindModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  assistant: AiAssistantVO | null;
}

const WorkflowSkillBindModal: React.FC<WorkflowSkillBindModalProps> = ({ isOpen, onClose, onSuccess, assistant }) => {
  const [allWorkflows, setAllWorkflows] = useState<WorkflowResponse[]>([]);
  const [boundSkills, setBoundSkills] = useState<WorkflowSkillVO[]>([]);
  const [loading, setLoading] = useState(false);
  const [bindingId, setBindingId] = useState<number | null>(null);
  const [expandedSkillId, setExpandedSkillId] = useState<number | null>(null);

  // 已绑定的工作流ID集合
  const boundIds = new Set(boundSkills.map(s => String(s.workflowId)));

  // 加载当前用户的所有工作流 + 已绑定的技能详情
  useEffect(() => {
    if (!isOpen || !assistant?.id) return;
    const fetchData = async () => {
      setLoading(true);
      try {
        const userId = getCurrentUserId();
        // 并行加载：所有工作流 + 已绑定技能详情
        const [workflowsRes, skillsRes] = await Promise.all([
          defaultApi.listByUser({ userId, page: 0, size: 100 }),
          aiApi.assistantGetWorkflowSkills({ id: assistant.id as unknown as number }),
        ]);
        if (workflowsRes.data.code === 0) {
          setAllWorkflows(workflowsRes.data.data || []);
        }
        if (skillsRes.data.code === 0) {
          setBoundSkills(skillsRes.data.data || []);
        }
      } catch (error: any) {
        toast.error(error?.response?.data?.message || '获取数据失败');
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [isOpen, assistant?.id]);

  const handleBind = async (workflowId: number) => {
    if (!assistant?.id) return;
    setBindingId(workflowId);
    try {
      const response = await aiApi.assistantBindWorkflow({
        id: assistant.id as unknown as number,
        workflowId: workflowId as unknown as number,
      });
      if (response.data.code === 0) {
        toast.success('绑定成功');
        // 重新加载技能详情
        const skillsRes = await aiApi.assistantGetWorkflowSkills({ id: assistant.id as unknown as number });
        if (skillsRes.data.code === 0) {
          setBoundSkills(skillsRes.data.data || []);
        }
        onSuccess();
      } else {
        toast.error(response.data.message || '绑定失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '绑定失败');
    } finally {
      setBindingId(null);
    }
  };

  const handleUnbind = async (workflowId: number) => {
    if (!assistant?.id) return;
    setBindingId(workflowId);
    try {
      const response = await aiApi.assistantUnbindWorkflow({
        id: assistant.id as unknown as number,
        workflowId: workflowId as unknown as number,
      });
      if (response.data.code === 0) {
        toast.success('解绑成功');
        setBoundSkills(prev => prev.filter(s => String(s.workflowId) !== String(workflowId)));
        onSuccess();
      } else {
        toast.error(response.data.message || '解绑失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '解绑失败');
    } finally {
      setBindingId(null);
    }
  };

  // 获取工作流对应的技能详情
  const getSkillDetail = (workflowId: number | undefined): WorkflowSkillVO | undefined => {
    if (!workflowId) return undefined;
    return boundSkills.find(s => String(s.workflowId) === String(workflowId));
  };

  if (!isOpen || !assistant) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[85vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2">
            <GitBranch size={20} className="text-purple-600" />
            工作流技能管理
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* 当前助手信息 */}
        <div className="px-6 py-3 bg-gray-50/50 dark:bg-gray-800/30 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center shadow-sm">
              <Bot size={16} className="text-white" />
            </div>
            <div>
              <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.name}</p>
              <p className="text-[10px] text-gray-400">已绑定 {boundIds.size} 个工作流技能</p>
            </div>
          </div>
        </div>

        {/* 工作流列表 */}
        <div className="flex-1 overflow-y-auto p-4 space-y-2">
          {loading ? (
            <div className="flex items-center justify-center py-12">
              <Loader2 size={24} className="animate-spin text-brand-500" />
            </div>
          ) : allWorkflows.length === 0 ? (
            <div className="flex flex-col items-center py-12">
              <GitBranch size={32} className="text-gray-300 dark:text-gray-600 mb-3" />
              <p className="text-sm text-gray-500 dark:text-gray-400">暂无可用工作流</p>
              <p className="text-xs text-gray-400 mt-1">请先在工作流管理中创建工作流</p>
            </div>
          ) : (
            allWorkflows.map((wf) => {
              const isBound = boundIds.has(String(wf.id));
              const isProcessing = bindingId !== null && String(bindingId) === String(wf.id);
              const skillDetail = getSkillDetail(wf.id);
              const isExpanded = expandedSkillId !== null && String(expandedSkillId) === String(wf.id);

              return (
                <div
                  key={wf.id}
                  className={`rounded-xl border transition-all ${
                    isBound
                      ? 'bg-purple-50/50 dark:bg-purple-900/10 border-purple-200 dark:border-purple-800/40'
                      : 'bg-white dark:bg-gray-800/50 border-gray-100 dark:border-gray-700 hover:border-gray-200 dark:hover:border-gray-600'
                  }`}
                >
                  {/* 工作流基本信息行 */}
                  <div className="flex items-center justify-between p-3">
                    <div className="flex items-center gap-3 min-w-0 flex-1">
                      <div className={`w-9 h-9 rounded-lg flex items-center justify-center flex-shrink-0 ${
                        isBound
                          ? 'bg-purple-100 dark:bg-purple-900/30'
                          : 'bg-gray-100 dark:bg-gray-700'
                      }`}>
                        <GitBranch size={16} className={isBound ? 'text-purple-600 dark:text-purple-400' : 'text-gray-400'} />
                      </div>
                      <div className="min-w-0 flex-1">
                        <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{wf.name}</p>
                        <div className="flex items-center gap-2 mt-0.5">
                          {wf.description && (
                            <span className="text-[10px] text-gray-400 truncate max-w-[200px]">{wf.description}</span>
                          )}
                          <span className={`text-[10px] px-1.5 py-0.5 rounded font-medium ${
                            wf.status === 'PUBLISHED'
                              ? 'bg-green-100 text-green-600 dark:bg-green-900/30 dark:text-green-400'
                              : wf.status === 'ARCHIVED'
                                ? 'bg-amber-100 text-amber-600 dark:bg-amber-900/30 dark:text-amber-400'
                                : 'bg-gray-100 text-gray-500 dark:bg-gray-800 dark:text-gray-400'
                          }`}>
                            {wf.status === 'PUBLISHED' ? '已发布' : wf.status === 'ARCHIVED' ? '已归档' : '草稿'}
                          </span>
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-2 flex-shrink-0 ml-3">
                      {/* 展开/收起技能详情按钮（仅已绑定的显示） */}
                      {isBound && skillDetail && (
                        <button
                          onClick={() => setExpandedSkillId(isExpanded ? null : (wf.id as number))}
                          className="p-1.5 text-gray-400 hover:text-purple-600 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-all"
                          title={isExpanded ? '收起详情' : '查看技能详情'}
                        >
                          {isExpanded ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
                        </button>
                      )}
                      <button
                        onClick={() => isBound ? handleUnbind(wf.id!) : handleBind(wf.id!)}
                        disabled={isProcessing}
                        className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium transition-all ${
                          isProcessing
                            ? 'opacity-50 cursor-not-allowed'
                            : isBound
                              ? 'bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 hover:bg-red-100 dark:hover:bg-red-900/30 border border-red-200 dark:border-red-800/40'
                              : 'bg-purple-50 dark:bg-purple-900/20 text-purple-600 dark:text-purple-400 hover:bg-purple-100 dark:hover:bg-purple-900/30 border border-purple-200 dark:border-purple-800/40'
                        }`}
                      >
                        {isProcessing ? (
                          <Loader2 size={12} className="animate-spin" />
                        ) : isBound ? (
                          <><Unlink size={12} /> 解绑</>
                        ) : (
                          <><Link size={12} /> 绑定</>
                        )}
                      </button>
                    </div>
                  </div>

                  {/* 技能详情展开区域 */}
                  {isBound && isExpanded && skillDetail && (
                    <div className="px-3 pb-3 pt-0 border-t border-purple-100 dark:border-purple-800/30 mt-0">
                      <div className="mt-3 space-y-3">
                        {/* 输入参数 */}
                        {skillDetail.inputParameters && skillDetail.inputParameters.length > 0 && (
                          <div>
                            <p className="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1.5">输入参数</p>
                            <div className="space-y-1">
                              {skillDetail.inputParameters.map((p, i) => (
                                <div key={i} className="flex items-start gap-2 text-xs bg-white dark:bg-gray-800/50 px-2 py-1.5 rounded-lg">
                                  <span className="font-mono font-bold text-purple-600 dark:text-purple-400">{p.name}</span>
                                  <span className="text-gray-400">({p.type || 'STRING'})</span>
                                  {p.required && <span className="text-red-500 text-[10px]">必填</span>}
                                  {p.description && <span className="text-gray-500 dark:text-gray-400 truncate flex-1">{p.description}</span>}
                                  {p.defaultValue && <span className="text-gray-400">默认: {p.defaultValue}</span>}
                                </div>
                              ))}
                            </div>
                          </div>
                        )}

                        {/* 输出变量 */}
                        {skillDetail.outputVariables && skillDetail.outputVariables.length > 0 && (
                          <div>
                            <p className="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1.5">输出变量</p>
                            <div className="space-y-1">
                              {skillDetail.outputVariables.map((o, i) => (
                                <div key={i} className="flex items-center gap-2 text-xs bg-white dark:bg-gray-800/50 px-2 py-1.5 rounded-lg">
                                  <span className="font-mono font-bold text-green-600 dark:text-green-400">{o.name}</span>
                                  {o.sourceVariable && <span className="text-gray-400">← {o.sourceVariable}</span>}
                                </div>
                              ))}
                            </div>
                          </div>
                        )}

                        {/* 无参数/输出时提示 */}
                        {(!skillDetail.inputParameters || skillDetail.inputParameters.length === 0) &&
                         (!skillDetail.outputVariables || skillDetail.outputVariables.length === 0) && (
                          <p className="text-xs text-gray-400 italic">该工作流未配置输入参数和输出变量</p>
                        )}
                      </div>
                    </div>
                  )}
                </div>
              );
            })
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-between px-6 py-3 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <p className="text-xs text-gray-400">
            绑定工作流后，AI 助手可自动识别并调用工作流技能
          </p>
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            完成
          </button>
        </div>
      </div>
    </div>
  );
};

// ======================== MCP 服务器绑定管理弹窗组件 ========================
interface McpServerBindModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  assistant: AiAssistantVO | null;
}

interface McpServerItem {
  id: number;
  name: string;
  description?: string;
  url?: string;
  configJson?: string;
  enabled?: boolean;
}

const McpServerBindModal: React.FC<McpServerBindModalProps> = ({ isOpen, onClose, onSuccess, assistant }) => {
  const [allServers, setAllServers] = useState<McpServerItem[]>([]);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());

  // 初始化已绑定的 ID
  useEffect(() => {
    if (!isOpen || !assistant) return;
    const boundIds = new Set<string>((assistant.mcpServerIds || []).map((id: number) => String(id)));
    setSelectedIds(boundIds);
  }, [isOpen, assistant]);

  // 加载所有 MCP 服务器
  useEffect(() => {
    if (!isOpen) return;
    const fetchServers = async () => {
      setLoading(true);
      try {
        const userId = getCurrentUserId();
        const res = await mcpApi.mcpServerListByCreator({ userId: userId as unknown as number });
        const data = res.data as any;
        if (data.code === 0) {
          setAllServers(data.data || []);
        }
      } catch (error: any) {
        toast.error(error?.response?.data?.message || '获取 MCP 服务器列表失败');
      } finally {
        setLoading(false);
      }
    };
    fetchServers();
  }, [isOpen]);

  const toggleServer = (serverId: number) => {
    setSelectedIds(prev => {
      const next = new Set(prev);
      const key = String(serverId);
      if (next.has(key)) {
        next.delete(key);
      } else {
        next.add(key);
      }
      return next;
    });
  };

  const handleSave = async () => {
    if (!assistant?.id) return;
    setSaving(true);
    try {
      // mcpServerIds 是雪花 ID，运行时为字符串，使用 as unknown as number 断言
      const mcpServerIds = Array.from(selectedIds).map(id => id as unknown as number);
      const res = await aiApi.assistantUpdate({
        id: assistant.id as unknown as number,
        updateAiAssistantCommand: { mcpServerIds },
      });
      if (res.data.code === 0) {
        toast.success('MCP 服务器绑定已更新');
        onSuccess();
        onClose();
      } else {
        toast.error(res.data.message || '更新失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '更新失败');
    } finally {
      setSaving(false);
    }
  };

  // 解析传输方式
  const getTransportInfo = (server: McpServerItem) => {
    try {
      let cfg = JSON.parse(server.configJson || '{}');
      if (cfg.mcpServers && typeof cfg.mcpServers === 'object') {
        const keys = Object.keys(cfg.mcpServers);
        if (keys.length > 0) cfg = cfg.mcpServers[keys[0]];
      }
      if (cfg.command) {
        return { type: 'stdio' as const, label: `${cfg.command} ${(cfg.args || []).join(' ')}` };
      }
      return { type: 'http' as const, label: server.url || cfg.url || '-' };
    } catch {
      return { type: 'http' as const, label: server.url || '-' };
    }
  };

  if (!isOpen || !assistant) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[80vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2">
            <Terminal size={20} className="text-emerald-600" />
            MCP 服务器绑定
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* 当前助手信息 */}
        <div className="px-6 py-3 bg-gray-50/50 dark:bg-gray-800/30 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center shadow-sm">
              <Bot size={16} className="text-white" />
            </div>
            <div>
              <p className="text-sm font-bold text-gray-900 dark:text-white">{assistant.name}</p>
              <p className="text-[10px] text-gray-400">已选择 {selectedIds.size} 个 MCP 服务器</p>
            </div>
          </div>
        </div>

        {/* MCP 服务器列表 */}
        <div className="flex-1 overflow-y-auto p-4 space-y-2">
          {loading ? (
            <div className="flex items-center justify-center py-12">
              <Loader2 size={24} className="animate-spin text-brand-500" />
            </div>
          ) : allServers.length === 0 ? (
            <div className="flex flex-col items-center py-12">
              <Terminal size={32} className="text-gray-300 dark:text-gray-600 mb-3" />
              <p className="text-sm text-gray-500 dark:text-gray-400">暂无可用 MCP 服务器</p>
              <p className="text-xs text-gray-400 mt-1">请先在 MCP 服务器管理中添加服务器</p>
            </div>
          ) : (
            allServers.map((server) => {
              const isSelected = selectedIds.has(String(server.id));
              const transport = getTransportInfo(server);
              return (
                <button
                  key={server.id}
                  type="button"
                  onClick={() => toggleServer(server.id)}
                  className={`w-full flex items-center justify-between p-3 rounded-xl border transition-all text-left ${
                    isSelected
                      ? 'bg-emerald-50/50 dark:bg-emerald-900/10 border-emerald-200 dark:border-emerald-800/40'
                      : 'bg-white dark:bg-gray-800/50 border-gray-100 dark:border-gray-700 hover:border-gray-200 dark:hover:border-gray-600'
                  }`}
                >
                  <div className="flex items-center gap-3 min-w-0 flex-1">
                    <div className={`w-9 h-9 rounded-lg flex items-center justify-center flex-shrink-0 ${
                      isSelected
                        ? 'bg-emerald-100 dark:bg-emerald-900/30'
                        : 'bg-gray-100 dark:bg-gray-700'
                    }`}>
                      <Terminal size={16} className={isSelected ? 'text-emerald-600 dark:text-emerald-400' : 'text-gray-400'} />
                    </div>
                    <div className="min-w-0">
                      <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{server.name}</p>
                      <div className="flex items-center gap-2 mt-0.5">
                        <span className={`text-[10px] px-1.5 py-0.5 rounded font-medium ${
                          transport.type === 'stdio'
                            ? 'bg-emerald-100 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-400'
                            : 'bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400'
                        }`}>
                          {transport.type === 'stdio' ? 'stdio' : 'HTTP'}
                        </span>
                        <span className="text-[10px] text-gray-400 truncate max-w-[200px] font-mono">{transport.label}</span>
                      </div>
                    </div>
                  </div>
                  <div className={`w-5 h-5 rounded-md border-2 flex items-center justify-center flex-shrink-0 ml-3 transition-all ${
                    isSelected
                      ? 'bg-emerald-500 border-emerald-500'
                      : 'border-gray-300 dark:border-gray-600'
                  }`}>
                    {isSelected && (
                      <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                        <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                      </svg>
                    )}
                  </div>
                </button>
              );
            })
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-between px-6 py-3 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <p className="text-xs text-gray-400">
            绑定 MCP 服务器后，助手对话时可调用外部工具
          </p>
          <div className="flex items-center gap-2">
            <button
              onClick={onClose}
              className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
            >
              取消
            </button>
            <button
              onClick={handleSave}
              disabled={saving}
              className="px-4 py-2 bg-emerald-600 text-white text-sm font-bold rounded-xl hover:bg-emerald-700 shadow-lg shadow-emerald-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
            >
              {saving && <Loader2 size={14} className="animate-spin" />}
              保存绑定
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

// ======================== 测试对话弹窗组件 ========================
interface ChatMessage {
  role: 'user' | 'assistant';
  content: string;
  isStreaming?: boolean;
}

interface TestChatModalProps {
  isOpen: boolean;
  onClose: () => void;
  assistant: AiAssistantVO | null;
}

const TestChatModal: React.FC<TestChatModalProps> = ({ isOpen, onClose, assistant }) => {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [streamingContent, setStreamingContent] = useState('');
  // 会话ID：由助手SSE接口自动创建并返回，后续消息复用同一会话（带记忆）
  const [sessionId, setSessionId] = useState<number | null>(null);
  // RAG 检索状态
  const [ragStatus, setRagStatus] = useState<'idle' | 'searching' | 'found' | 'not_found'>('idle');
  // RAG 引用来源
  const [ragReferences, setRagReferences] = useState<Array<{
    index: number; score: number; documentName?: string; contentPreview?: string;
  }>>([]);

  const messagesEndRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLTextAreaElement>(null);
  const abortControllerRef = useRef<AbortController | null>(null);

  // 打开时初始化欢迎消息
  useEffect(() => {
    if (isOpen && assistant) {
      const openingMsg = assistant.openingMessage || `你好！我是「${assistant.name}」，有什么可以帮你的？`;
      setMessages([{ role: 'assistant', content: openingMsg }]);
      setInput('');
      setStreamingContent('');
      setIsLoading(false);
      setSessionId(null);
      abortControllerRef.current?.abort();
      abortControllerRef.current = null;
      setTimeout(() => inputRef.current?.focus(), 300);
    }
  }, [isOpen, assistant]);

  // 关闭时终止流
  useEffect(() => {
    if (!isOpen) {
      abortControllerRef.current?.abort();
      abortControllerRef.current = null;
    }
  }, [isOpen]);

  // 自动滚动到底部
  const scrollToBottom = useCallback(() => {
    setTimeout(() => messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' }), 50);
  }, []);

  useEffect(() => { scrollToBottom(); }, [messages, streamingContent, scrollToBottom]);

  const sendMessage = async () => {
    const content = input.trim();
    if (!content || isLoading || !assistant?.id) return;

    setInput('');
    inputRef.current?.focus();

    const userMsg: ChatMessage = { role: 'user', content };
    setMessages(prev => [...prev, userMsg]);
    setIsLoading(true);
    setStreamingContent('');
    setRagStatus('idle');
    setRagReferences([]);

    // 使用助手专用 SSE 对话接口
    const baseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
    // assistant.id 运行时为字符串（雪花ID），直接拼入URL
    const url = `${baseUrl}/api/ai/assistants/${assistant.id}/chat/stream`;
    const token = getToken();

    const body: Record<string, unknown> = {
      message: content,
    };
    // 如果有已建立的会话ID，传入以复用（带记忆）
    if (sessionId) {
      body.sessionId = sessionId;
    }

    const controller = new AbortController();
    abortControllerRef.current = controller;
    let accumulated = '';
    let currentEvent = '';

    try {
      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
          ...(token ? { Authorization: `Bearer ${token}` } : {}),
        },
        body: JSON.stringify(body),
        signal: controller.signal,
      });

      if (!response.ok) throw new Error(`HTTP ${response.status}`);

      const reader = response.body?.getReader();
      if (!reader) throw new Error('No response body');

      const decoder = new TextDecoder();
      let buffer = '';
      let pendingDataLines: string[] = [];

      const dispatchAdminEvent = (eventType: string, data: string) => {
        if (data === '[DONE]' || eventType === 'done') return;

        if (eventType === 'session') {
          try {
            const sessionData = JSON.parse(data);
            if (sessionData.sessionId) {
              setSessionId(sessionData.sessionId as unknown as number);
            }
          } catch { /* ignore parse error */ }
          return;
        }

        if (eventType === 'rag_searching') {
          setRagStatus('searching');
          return;
        }

        if (eventType === 'rag_completed') {
          try {
            const ragData = JSON.parse(data);
            setRagStatus(ragData.found ? 'found' : 'not_found');
            if (ragData.found && ragData.references) {
              setRagReferences(ragData.references);
            }
          } catch {
            setRagStatus('not_found');
          }
          return;
        }

        if (eventType === 'error') {
          accumulated += `\n\n⚠️ ${data}`;
          setStreamingContent(accumulated);
          return;
        }

        if (eventType === 'image_generating' || eventType === 'video_generating') {
          try {
            const genData = JSON.parse(data);
            accumulated += `\n\n🎨 *正在生成${eventType === 'video_generating' ? '视频' : '图片'}：${genData.prompt}...*`;
            setStreamingContent(accumulated);
          } catch { /* ignore */ }
          return;
        }

        if (eventType === 'image_generated' || eventType === 'video_generated') {
          try {
            const genData = JSON.parse(data);
            const url = genData.url || genData.imageUrl;
            if (url) {
              accumulated += eventType === 'video_generated'
                ? `\n\n<video controls src="${url}" style="max-width:100%;border-radius:12px"></video>`
                : `\n\n![生成图片](${url})`;
              setStreamingContent(accumulated);
            }
          } catch { /* ignore */ }
          return;
        }

        // message 事件或未标记事件：累积文本token（可能含换行）
        try {
          const json = JSON.parse(data);
          const chunk = json.content ?? json.text ?? data;
          accumulated += String(chunk);
        } catch {
          accumulated += data;
        }
        setStreamingContent(accumulated);
      };

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const lines = buffer.split('\n');
        buffer = lines.pop() || '';

        for (const line of lines) {
          if (line.trim() === '') {
            if (pendingDataLines.length > 0) {
              dispatchAdminEvent(currentEvent, pendingDataLines.join('\n'));
              pendingDataLines = [];
            }
            currentEvent = '';
            continue;
          }
          if (line.startsWith('event:')) {
            currentEvent = line.slice(6).trim();
            continue;
          }
          if (line.startsWith('data:')) {
            const dc = line.charAt(5) === ' ' ? line.slice(6) : line.slice(5);
            pendingDataLines.push(dc);
            continue;
          }
        }
      }
      if (pendingDataLines.length > 0) {
        dispatchAdminEvent(currentEvent, pendingDataLines.join('\n'));
      }
    } catch (err: unknown) {
      if (err instanceof DOMException && err.name === 'AbortError') {
        if (accumulated) accumulated += '\n\n*[已停止]*';
      } else {
        console.error('SSE 请求失败:', err);
        if (!accumulated) accumulated = '抱歉，请求失败，请稍后重试。';
      }
    } finally {
      if (accumulated) {
        setMessages(prev => [...prev, { role: 'assistant', content: accumulated }]);
      }
      setStreamingContent('');
      setIsLoading(false);
      abortControllerRef.current = null;
    }
  };

  const cancelStream = () => { abortControllerRef.current?.abort(); };

  const clearMessages = () => {
    if (!assistant) return;
    const openingMsg = assistant.openingMessage || `你好！我是「${assistant.name}」，有什么可以帮你的？`;
    setMessages([{ role: 'assistant', content: openingMsg }]);
    setStreamingContent('');
    setSessionId(null);
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  };

  if (!isOpen || !assistant) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 flex flex-col" style={{ height: '80vh' }}>
        {/* Header */}
        <div className="flex items-center justify-between px-5 py-3 border-b border-gray-100 dark:border-gray-800 flex-shrink-0">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-xl bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center shadow-lg shadow-brand-500/20">
              {assistant.avatarUrl ? (
                <img src={assistant.avatarUrl} alt="" className="w-full h-full rounded-xl object-cover" />
              ) : (
                <Bot size={18} className="text-white" />
              )}
            </div>
            <div>
              <h3 className="text-sm font-bold text-gray-900 dark:text-white">{assistant.name}</h3>
              <p className="text-[10px] text-gray-400">
                助手对话{sessionId ? ' · 会话已建立' : ''} · {assistant.modelName || '默认模型'}
                {assistant.knowledgeBases && assistant.knowledgeBases.length > 0 && ` · RAG:${assistant.knowledgeBases.length}库`}
              </p>
            </div>
          </div>
          <div className="flex items-center gap-1">
            <button
              onClick={clearMessages}
              className="p-2 text-gray-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
              title="清空对话"
            >
              <Trash2 size={16} />
            </button>
            <button
              onClick={onClose}
              className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
            >
              <X size={18} />
            </button>
          </div>
        </div>

        {/* 提示条 */}
        {assistant.systemPrompt && (
          <div className="flex items-center gap-2 px-5 py-1.5 bg-brand-50 dark:bg-brand-900/10 border-b border-brand-100 dark:border-brand-800/30 flex-shrink-0">
            <Brain size={12} className="text-brand-500 flex-shrink-0" />
            <span className="text-[11px] text-gray-500 dark:text-gray-400 truncate">
              系统提示词已加载：{assistant.systemPrompt.slice(0, 60)}{assistant.systemPrompt.length > 60 ? '...' : ''}
            </span>
          </div>
        )}

        {/* 推荐问题 */}
        {assistant.suggestedQuestions && assistant.suggestedQuestions.length > 0 && messages.length <= 1 && (
          <div className="flex flex-wrap gap-2 px-5 py-3 border-b border-gray-100 dark:border-gray-800 flex-shrink-0">
            {assistant.suggestedQuestions.map((q, i) => (
              <button
                key={i}
                onClick={() => { setInput(q); setTimeout(() => inputRef.current?.focus(), 50); }}
                className="px-3 py-1.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-xs text-gray-600 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 rounded-lg border border-gray-100 dark:border-gray-700 hover:border-brand-200 dark:hover:border-brand-800 transition-all"
              >
                {q}
              </button>
            ))}
          </div>
        )}

        {/* 消息列表 */}
        <div className="flex-1 overflow-y-auto px-5 py-4 space-y-4 min-h-0">
          {messages.map((msg, index) => (
            <div key={index} className={`flex gap-3 ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
              {msg.role === 'assistant' && (
                <div className="w-7 h-7 rounded-lg bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center flex-shrink-0 mt-0.5">
                  <Bot size={14} className="text-white" />
                </div>
              )}
              <div className={`max-w-[75%] rounded-2xl px-4 py-2.5 text-sm leading-relaxed ${
                msg.role === 'user'
                  ? 'bg-brand-600 text-white rounded-tr-md'
                  : 'bg-gray-100 dark:bg-gray-800 text-gray-800 dark:text-gray-200 rounded-tl-md'
              }`}>
                {msg.role === 'assistant' ? (
                  <MarkdownRenderer
                    content={msg.content}
                    className="prose prose-sm dark:prose-invert max-w-none [&>p]:my-1 [&>ul]:my-1 [&>ol]:my-1 [&>pre]:my-2 [&>blockquote]:my-1"
                  />
                ) : (
                  <span className="whitespace-pre-wrap">{msg.content}</span>
                )}
              </div>
            </div>
          ))}
          {/* RAG 检索状态提示 + 引用来源 */}
          {ragStatus !== 'idle' && (isLoading || ragReferences.length > 0) && (
            <div className="px-3 py-2 mx-auto w-fit max-w-[85%]">
              {ragStatus === 'searching' && isLoading && (
                <div className="flex items-center gap-2 bg-amber-50 dark:bg-amber-900/20 text-amber-600 dark:text-amber-400 px-3 py-1.5 rounded-lg border border-amber-200 dark:border-amber-800/40 text-xs font-medium">
                  <Loader2 size={12} className="animate-spin" />
                  <Database size={12} />
                  <span>正在检索知识库...</span>
                </div>
              )}
              {ragStatus === 'found' && ragReferences.length > 0 && (
                <div className="bg-green-50 dark:bg-green-900/10 rounded-lg border border-green-200 dark:border-green-800/30 px-3 py-2">
                  <div className="flex items-center gap-1.5 text-xs font-medium text-green-600 dark:text-green-400 mb-1.5">
                    <Database size={11} />
                    <span>{isLoading ? '已检索到相关知识，正在生成回答...' : '引用来源'}</span>
                  </div>
                  <div className="space-y-1">
                    {ragReferences.map((ref, i) => (
                      <div key={i} className="flex items-start gap-1.5 text-[10px] text-green-700 dark:text-green-300/80">
                        <span className="bg-green-200 dark:bg-green-800/40 text-green-700 dark:text-green-300 px-1 py-0.5 rounded font-mono flex-shrink-0">
                          #{ref.index}
                        </span>
                        <div className="min-w-0">
                          <span className="font-medium">{ref.documentName || '未知文档'}</span>
                          <span className="text-green-500 dark:text-green-400/60 ml-1">
                            相关度 {(ref.score * 100).toFixed(0)}%
                          </span>
                          {ref.contentPreview && (
                            <p className="text-green-600/60 dark:text-green-400/40 truncate mt-0.5">
                              {ref.contentPreview}
                            </p>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}
              {ragStatus === 'not_found' && isLoading && (
                <div className="flex items-center gap-2 bg-gray-50 dark:bg-gray-800/50 text-gray-500 dark:text-gray-400 px-3 py-1.5 rounded-lg border border-gray-200 dark:border-gray-700 text-xs font-medium">
                  <Database size={12} />
                  <span>知识库中未找到相关内容，使用通用知识回答...</span>
                </div>
              )}
            </div>
          )}
          {streamingContent && (
            <div className="flex gap-3 justify-start">
              <div className="w-7 h-7 rounded-lg bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center flex-shrink-0 mt-0.5">
                <Bot size={14} className="text-white animate-pulse" />
              </div>
              <div className="max-w-[75%] rounded-2xl rounded-tl-md px-4 py-2.5 bg-gray-100 dark:bg-gray-800 text-sm text-gray-800 dark:text-gray-200 leading-relaxed">
                <MarkdownRenderer
                  content={streamingContent}
                  isStreaming
                  showCursor
                  className="prose prose-sm dark:prose-invert max-w-none [&>p]:my-1 [&>ul]:my-1 [&>ol]:my-1 [&>pre]:my-2 [&>blockquote]:my-1"
                />
              </div>
            </div>
          )}
          <div ref={messagesEndRef} />
        </div>

        {/* 输入区 */}
        <div className="flex-shrink-0 px-5 py-3 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-900/50">
          <div className="flex items-end gap-2">
            <div className="flex-1">
              <textarea
                ref={inputRef}
                value={input}
                onChange={(e) => setInput(e.target.value)}
                onKeyDown={handleKeyDown}
                placeholder="输入消息测试助手..."
                rows={1}
                className="w-full px-4 py-2.5 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 focus:border-brand-500 dark:focus:border-brand-500 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 outline-none resize-none transition-colors max-h-28"
                style={{ minHeight: '42px' }}
              />
            </div>
            {isLoading ? (
              <button
                onClick={cancelStream}
                className="w-10 h-10 flex items-center justify-center bg-red-50 dark:bg-red-900/20 text-red-500 border border-red-200 dark:border-red-800 rounded-xl hover:bg-red-100 dark:hover:bg-red-900/30 transition-colors flex-shrink-0"
                title="停止生成"
              >
                <Square size={16} />
              </button>
            ) : (
              <button
                onClick={sendMessage}
                disabled={!input.trim()}
                className="w-10 h-10 flex items-center justify-center bg-brand-600 hover:bg-brand-700 text-white rounded-xl shadow-md shadow-brand-600/20 disabled:opacity-50 disabled:cursor-not-allowed transition-all flex-shrink-0 active:scale-95"
              >
                <Send size={16} />
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

// ======================== 主页面组件 ========================
export const AiAssistantManagementPage: React.FC = () => {
  const [assistants, setAssistants] = useState<AiAssistantVO[]>([]);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [detailModalOpen, setDetailModalOpen] = useState(false);
  const [editingAssistant, setEditingAssistant] = useState<AiAssistantVO | null>(null);
  const [viewingAssistant, setViewingAssistant] = useState<AiAssistantVO | null>(null);
  const [testChatOpen, setTestChatOpen] = useState(false);
  const [testChatAssistant, setTestChatAssistant] = useState<AiAssistantVO | null>(null);
  const [kbBindOpen, setKbBindOpen] = useState(false);
  const [kbBindAssistant, setKbBindAssistant] = useState<AiAssistantVO | null>(null);
  const [wfBindOpen, setWfBindOpen] = useState(false);
  const [wfBindAssistant, setWfBindAssistant] = useState<AiAssistantVO | null>(null);
  const [mcpBindOpen, setMcpBindOpen] = useState(false);
  const [mcpBindAssistant, setMcpBindAssistant] = useState<AiAssistantVO | null>(null);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('');
  const [page, setPage] = useState(0);
  const [pageSize] = useState(20);

  const fetchAssistants = useCallback(async () => {
    setLoading(true);
    try {
      let response;
      if (searchKeyword.trim()) {
        response = await aiApi.assistantSearch({ keyword: searchKeyword, page, size: pageSize });
      } else {
        const userId = getCurrentUserId();
        response = await aiApi.assistantListByCreator({ userId, page, size: pageSize });
      }
      if (response.data.code === 0) {
        let list = response.data.data || [];
        // 前端筛选状态和分类
        if (statusFilter) {
          list = list.filter((a: AiAssistantVO) => a.status === statusFilter);
        }
        if (categoryFilter) {
          list = list.filter((a: AiAssistantVO) => a.category === categoryFilter);
        }
        setAssistants(list);
      } else {
        toast.error(response.data.message || '获取列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [searchKeyword, page, pageSize, statusFilter, categoryFilter]);

  useEffect(() => {
    fetchAssistants();
  }, [fetchAssistants]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(0);
    fetchAssistants();
  };

  const handleDelete = async (assistant: AiAssistantVO) => {
    if (!assistant.id) return;
    if (!window.confirm(`确定要删除助手「${assistant.name}」吗？此操作不可恢复。`)) return;

    try {
      const response = await aiApi.assistantDelete({ id: assistant.id as unknown as number });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchAssistants();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const handlePublish = async (assistant: AiAssistantVO) => {
    if (!assistant.id) return;
    try {
      const response = await aiApi.assistantPublish({ id: assistant.id as unknown as number });
      if (response.data.code === 0) {
        toast.success('发布成功');
        fetchAssistants();
      } else {
        toast.error(response.data.message || '发布失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const handleArchive = async (assistant: AiAssistantVO) => {
    if (!assistant.id) return;
    try {
      const response = await aiApi.assistantArchive({ id: assistant.id as unknown as number });
      if (response.data.code === 0) {
        toast.success('归档成功');
        fetchAssistants();
      } else {
        toast.error(response.data.message || '归档失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const handleTogglePublic = async (assistant: AiAssistantVO) => {
    if (!assistant.id) return;
    try {
      const response = await aiApi.assistantUpdate({
        id: assistant.id as unknown as number,
        updateAiAssistantCommand: { isPublic: !assistant.isPublic },
      });
      if (response.data.code === 0) {
        toast.success(assistant.isPublic ? '已设为私有' : '已设为公开');
        fetchAssistants();
      } else {
        toast.error(response.data.message || '操作失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const totalPages = Math.max(1, Math.ceil(assistants.length / pageSize));

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">AI 助手管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">创建和管理 AI 智能助手，配置提示词和模型参数</p>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => { setEditingAssistant(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>新建助手</span>
          </button>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text"
              placeholder="搜索助手名称、描述..."
              value={searchKeyword}
              onChange={(e) => setSearchKeyword(e.target.value)}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select
              value={statusFilter}
              onChange={(e) => { setStatusFilter(e.target.value); setPage(0); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="">所有状态</option>
              <option value="DRAFT">草稿</option>
              <option value="PUBLISHED">已发布</option>
              <option value="ARCHIVED">已归档</option>
            </select>
            <select
              value={categoryFilter}
              onChange={(e) => { setCategoryFilter(e.target.value); setPage(0); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              {CATEGORY_OPTIONS.map(c => (
                <option key={c.value} value={c.value}>{c.label}</option>
              ))}
            </select>
            <button
              type="button"
              onClick={() => fetchAssistants()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">助手信息</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-32">分类 / 标签</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-28">模型</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-24">状态</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-20">统计</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={6} className="px-6 py-8 h-20">
                      <div className="flex gap-4">
                        <div className="w-12 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : assistants.length > 0 ? (
                assistants.map((assistant) => (
                  <tr key={assistant.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    {/* 助手信息 */}
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-4">
                        <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-50 to-indigo-50 dark:from-gray-800 dark:to-gray-800 p-0.5 border border-gray-100 dark:border-gray-700 flex-shrink-0">
                          {assistant.avatarUrl ? (
                            <img src={assistant.avatarUrl} alt="" className="w-full h-full rounded-[10px] object-cover" />
                          ) : (
                            <div className="w-full h-full rounded-[10px] flex items-center justify-center bg-white dark:bg-gray-900">
                              <Bot size={20} className="text-brand-500" />
                            </div>
                          )}
                        </div>
                        <div className="min-w-0">
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                            {assistant.name}
                          </p>
                          {assistant.description && (
                            <TruncateWithTooltip
                              text={assistant.description}
                              maxWidth={200}
                              className="text-xs text-gray-500 dark:text-gray-400"
                            />
                          )}
                        </div>
                      </div>
                    </td>

                    {/* 分类/标签 */}
                    <td className="px-4 py-4">
                      <div className="space-y-1.5">
                        {assistant.category && (
                          <span className="inline-block px-2 py-0.5 bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 text-xs font-medium rounded-md">{assistant.category}</span>
                        )}
                        {assistant.tags && assistant.tags.length > 0 && (
                          <div className="flex flex-wrap gap-1">
                            {assistant.tags.slice(0, 3).map((tag, i) => (
                              <span key={i} className="inline-flex items-center gap-0.5 px-1.5 py-0.5 bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400 text-[10px] font-medium rounded">
                                <Tag size={8} />
                                {tag}
                              </span>
                            ))}
                            {assistant.tags.length > 3 && (
                              <span className="text-[10px] text-gray-400">+{assistant.tags.length - 3}</span>
                            )}
                          </div>
                        )}
                      </div>
                    </td>

                    {/* 模型 */}
                    <td className="px-4 py-4">
                      <div className="space-y-1">
                        <p className="text-sm font-medium text-gray-900 dark:text-white">{assistant.modelName || '默认'}</p>
                        <div className="flex items-center gap-2 text-[10px] text-gray-400">
                          <Thermometer size={10} />
                          <span>T:{assistant.temperature ?? '-'}</span>
                          <span>P:{assistant.topP ?? '-'}</span>
                        </div>
                      </div>
                    </td>

                    {/* 状态 */}
                    <td className="px-4 py-4">
                      <div className="flex flex-col gap-1.5">
                        <span className={`inline-block px-2.5 py-1 rounded-lg text-xs font-bold border w-fit ${STATUS_CONFIG[assistant.status || 'DRAFT']?.color || STATUS_CONFIG.DRAFT.color}`}>
                          {STATUS_CONFIG[assistant.status || 'DRAFT']?.label || '草稿'}
                        </span>
                        <span className="inline-flex items-center gap-1 text-[10px] text-gray-400">
                          {assistant.isPublic ? <><Globe size={10} className="text-green-500" /> 公开</> : <><Lock size={10} /> 私有</>}
                        </span>
                      </div>
                    </td>

                    {/* 统计 */}
                    <td className="px-4 py-4">
                      <div className="space-y-1">
                        <div className="flex items-center gap-1.5 text-sm text-gray-600 dark:text-gray-300">
                          <MessageSquare size={14} className="text-gray-400" />
                          <span>{assistant.usageCount ?? 0}</span>
                        </div>
                        {assistant.rating != null && assistant.rating > 0 && (
                          <div className="flex items-center gap-1.5 text-sm text-gray-600 dark:text-gray-300">
                            <Star size={14} className="text-amber-400" />
                            <span>{assistant.rating.toFixed(1)}</span>
                          </div>
                        )}
                      </div>
                    </td>

                    {/* 操作 */}
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button
                          onClick={() => { setTestChatAssistant(assistant); setTestChatOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                          title="测试对话"
                        >
                          <PlayCircle size={18} />
                        </button>
                        <button
                          onClick={() => { setViewingAssistant(assistant); setDetailModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                          title="查看详情"
                        >
                          <Eye size={18} />
                        </button>
                        <button
                          onClick={() => { setKbBindAssistant(assistant); setKbBindOpen(true); }}
                          className={`p-2 rounded-lg transition-all ${
                            assistant.knowledgeBases && assistant.knowledgeBases.length > 0
                              ? 'text-brand-500 hover:text-brand-700 hover:bg-brand-50 dark:hover:bg-brand-900/20'
                              : 'text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20'
                          }`}
                          title={`知识库 (${assistant.knowledgeBases?.length || 0})`}
                        >
                          <Database size={18} />
                        </button>
                        <button
                          onClick={() => { setWfBindAssistant(assistant); setWfBindOpen(true); }}
                          className="p-2 text-gray-400 hover:text-purple-600 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-all"
                          title="工作流技能"
                        >
                          <GitBranch size={18} />
                        </button>
                        <button
                          onClick={() => { setMcpBindAssistant(assistant); setMcpBindOpen(true); }}
                          className={`p-2 rounded-lg transition-all ${
                            assistant.mcpServerIds && assistant.mcpServerIds.length > 0
                              ? 'text-emerald-500 hover:text-emerald-700 hover:bg-emerald-50 dark:hover:bg-emerald-900/20'
                              : 'text-gray-400 hover:text-emerald-600 hover:bg-emerald-50 dark:hover:bg-emerald-900/20'
                          }`}
                          title={`MCP 服务器 (${assistant.mcpServerIds?.length || 0})`}
                        >
                          <Terminal size={18} />
                        </button>
                        <button
                          onClick={() => { setEditingAssistant(assistant); setModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                          title="编辑"
                        >
                          <Edit2 size={18} />
                        </button>
                        {assistant.status !== 'PUBLISHED' && (
                          <button
                            onClick={() => handlePublish(assistant)}
                            className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                            title="发布"
                          >
                            <Send size={18} />
                          </button>
                        )}
                        {assistant.status === 'PUBLISHED' && (
                          <button
                            onClick={() => handleArchive(assistant)}
                            className="p-2 text-gray-400 hover:text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-all"
                            title="归档"
                          >
                            <Archive size={18} />
                          </button>
                        )}
                        <button
                          onClick={() => handleTogglePublic(assistant)}
                          className={`p-2 rounded-lg transition-all ${assistant.isPublic ? 'text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20' : 'text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20'}`}
                          title={assistant.isPublic ? '设为私有' : '设为公开'}
                        >
                          {assistant.isPublic ? <Globe size={18} /> : <Lock size={18} />}
                        </button>
                        <button
                          onClick={() => handleDelete(assistant)}
                          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                          title="删除"
                        >
                          <Trash2 size={18} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <Bot size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无 AI 助手</p>
                      <p className="text-gray-400 text-sm mt-1">点击「新建助手」创建第一个 AI 助手</p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        {assistants.length > 0 && (
          <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              共 <span className="font-bold text-gray-900 dark:text-white">{assistants.length}</span> 个助手
            </p>
            <div className="flex items-center gap-2">
              <button
                disabled={page === 0 || loading}
                onClick={() => setPage(p => Math.max(0, p - 1))}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
              >
                <ChevronLeft size={18} />
              </button>
              <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
                {page + 1} / {totalPages}
              </span>
              <button
                disabled={page >= totalPages - 1 || loading}
                onClick={() => setPage(p => p + 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
              >
                <ChevronRight size={18} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* 表单弹窗 */}
      <AssistantFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingAssistant(null); }}
        onSuccess={fetchAssistants}
        assistant={editingAssistant}
      />

      {/* 详情弹窗 */}
      <AssistantDetailModal
        isOpen={detailModalOpen}
        onClose={() => { setDetailModalOpen(false); setViewingAssistant(null); }}
        assistant={viewingAssistant}
      />

      {/* 知识库绑定弹窗 */}
      <KnowledgeBaseBindModal
        isOpen={kbBindOpen}
        onClose={() => { setKbBindOpen(false); setKbBindAssistant(null); }}
        onSuccess={fetchAssistants}
        assistant={kbBindAssistant}
      />

      {/* 工作流技能绑定弹窗 */}
      <WorkflowSkillBindModal
        isOpen={wfBindOpen}
        onClose={() => { setWfBindOpen(false); setWfBindAssistant(null); }}
        onSuccess={fetchAssistants}
        assistant={wfBindAssistant}
      />

      {/* MCP 服务器绑定弹窗 */}
      <McpServerBindModal
        isOpen={mcpBindOpen}
        onClose={() => { setMcpBindOpen(false); setMcpBindAssistant(null); }}
        onSuccess={fetchAssistants}
        assistant={mcpBindAssistant}
      />

      {/* 测试对话弹窗 */}
      <TestChatModal
        isOpen={testChatOpen}
        onClose={() => { setTestChatOpen(false); setTestChatAssistant(null); }}
        assistant={testChatAssistant}
      />
    </div>
  );
};
