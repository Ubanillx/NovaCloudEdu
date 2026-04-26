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
  Database,
  FileText,
  Upload,
  Zap,
  ArrowLeft,
  File,
  AlertCircle,
  CheckCircle2,
  Clock,
  Loader2,
  Layers,
  Settings2,
  FileType,
  FileCode,
  BookOpen,
  Eye,
  Hash,
  type LucideIcon,
  SearchCheck,
  ChevronDown,
  ChevronUp,
  Sparkles,
  ToggleLeft,
  ToggleRight,
  SlidersHorizontal,
  Scissors,
  GitBranch,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type {
  KnowledgeBaseVO,
  KnowledgeDocumentVO,
  CreateKnowledgeBaseCommand,
  UpdateKnowledgeBaseCommand
} from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 获取当前用户ID（字符串形式，避免雪花ID精度丢失）
const getCurrentUserId = (): number => {
  const userInfoStr = localStorage.getItem('user_info');
  const userInfo = userInfoStr ? JSON.parse(userInfoStr) : null;
  // 运行时已是字符串，用 as unknown as number 满足TS类型
  return (userInfo?.id ?? '') as unknown as number;
};

// 状态配置
const KB_STATUS_MAP: Record<string, { label: string; color: string }> = {
  ACTIVE: { label: '活跃', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' },
  ARCHIVED: { label: '已归档', color: 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700' },
};

const DOC_STATUS_MAP: Record<string, { label: string; color: string; icon: React.ElementType }> = {
  PENDING: { label: '待处理', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800', icon: Clock },
  PROCESSING: { label: '处理中', color: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400 border-blue-200 dark:border-blue-800', icon: Loader2 },
  COMPLETED: { label: '已完成', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800', icon: CheckCircle2 },
  FAILED: { label: '失败', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800', icon: AlertCircle },
};

const FILE_TYPE_ICONS: Record<string, { icon: LucideIcon; color: string }> = {
  PDF: { icon: FileType, color: 'text-red-500' },
  TXT: { icon: FileText, color: 'text-gray-500' },
  DOCX: { icon: File, color: 'text-blue-500' },
  DOC: { icon: File, color: 'text-blue-500' },
  MD: { icon: FileCode, color: 'text-purple-500' },
  HTML: { icon: FileCode, color: 'text-orange-500' },
  EPUB: { icon: BookOpen, color: 'text-teal-500' },
};

// 切分策略配置
const CHUNK_STRATEGY_MAP: Record<string, { label: string; description: string; icon: LucideIcon }> = {
  SEMANTIC: { label: '语义切分', description: '综合标题+段落+embedding相似度+句法边界（推荐）', icon: Sparkles },
  PARAGRAPH: { label: '段落切分', description: '按段落边界切分，保持段落完整性', icon: FileText },
  TITLE: { label: '标题切分', description: '按Markdown标题层级切分', icon: Hash },
  SENTENCE: { label: '句法切分', description: '按句号/问号/感叹号等句法边界切分', icon: Scissors },
  FIXED: { label: '固定大小', description: '按固定字符数切分', icon: Layers },
};

// 检索模式配置
const RETRIEVAL_MODE_MAP: Record<string, { label: string; description: string; icon: LucideIcon }> = {
  VECTOR_ONLY: { label: '纯向量召回', description: '仅使用向量相似度检索', icon: Database },
  HYBRID: { label: '混合召回', description: '向量 + BM25 全文检索，RRF 融合', icon: Layers },
  HYBRID_RERANK: { label: '混合召回+Rerank', description: '混合召回 + Rerank 精排（推荐）', icon: Sparkles },
};

// Embedding 模型配置（前端静态，与后端 /embedding-models API 一致）
const EMBEDDING_MODELS = [
  { model: 'text-embedding-v4', label: 'text-embedding-v4 (Qwen3)', dimensions: [2048, 1536, 1024, 768, 512, 256, 128, 64], defaultDimension: 1024, recommended: true },
  { model: 'text-embedding-v3', label: 'text-embedding-v3', dimensions: [1024, 768, 512, 256, 128, 64], defaultDimension: 1024, recommended: false },
  { model: 'text-embedding-v2', label: 'text-embedding-v2', dimensions: [1536], defaultDimension: 1536, recommended: false },
  { model: 'text-embedding-v1', label: 'text-embedding-v1 (Legacy)', dimensions: [1536], defaultDimension: 1536, recommended: false },
];

// Rerank 模型配置
const RERANK_MODELS = [
  { model: 'qwen3-rerank', label: 'Qwen3 Rerank', desc: '500并发·4K上下文·100+语种', recommended: true },
  { model: 'gte-rerank-v2', label: 'GTE Rerank v2', desc: '30K并发·50+语种', recommended: false },
  { model: 'qwen3-vl-rerank', label: 'Qwen3 VL Rerank', desc: '100并发·8K上下文·多模态', recommended: false },
];

const FileTypeIcon: React.FC<{ fileType?: string; size?: number }> = ({ fileType, size = 18 }) => {
  const config = FILE_TYPE_ICONS[fileType || ''] || { icon: File, color: 'text-gray-400' };
  const Icon = config.icon;
  return <Icon size={size} className={config.color} />;
};

// 格式化时间
const formatDateTime = (dateStr?: string) => {
  if (!dateStr) return '-';
  return new Date(dateStr).toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
  });
};

// 格式化文件大小
const formatFileSize = (bytes?: number) => {
  if (!bytes || bytes === 0) return '-';
  const size = Number(bytes);
  if (size < 1024) return `${size} B`;
  if (size < 1024 * 1024) return `${(size / 1024).toFixed(1)} KB`;
  return `${(size / (1024 * 1024)).toFixed(1)} MB`;
};

// ==================== 知识库表单弹窗 ====================
interface KBFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  knowledgeBase?: KnowledgeBaseVO | null;
}

type KBFormData = CreateKnowledgeBaseCommand & { rerankModel?: string };

const KBFormModal: React.FC<KBFormModalProps> = ({ isOpen, onClose, onSuccess, knowledgeBase }) => {
  const isEdit = !!knowledgeBase;
  const [loading, setLoading] = useState(false);
  const [showAdvancedChunk, setShowAdvancedChunk] = useState(false);
  const [formData, setFormData] = useState<KBFormData>({
    name: '',
    description: '',
    embeddingModel: 'text-embedding-v4',
    embeddingDimension: 1024,
    chunkSize: 500,
    chunkOverlap: 50,
    chunkStrategy: 'SEMANTIC',
    parentChildMode: false,
    parentChunkSize: 1500,
    preserveMetadata: true,
    semanticThreshold: 0.5,
    retrievalMode: 'HYBRID_RERANK',
    enableQueryRewrite: false,
    useDynamicTopK: true,
    defaultTopK: 5,
    queryRewriteModelId: 'dashscope/qwen-turbo',
    rerankModel: 'qwen3-rerank',
  });

  useEffect(() => {
    if (knowledgeBase) {
      setFormData({
        name: knowledgeBase.name || '',
        description: knowledgeBase.description || '',
        embeddingModel: knowledgeBase.embeddingModel || 'text-embedding-v4',
        embeddingDimension: knowledgeBase.embeddingDimension || 1024,
        chunkSize: knowledgeBase.chunkSize || 500,
        chunkOverlap: knowledgeBase.chunkOverlap || 50,
        chunkStrategy: knowledgeBase.chunkStrategy || 'SEMANTIC',
        parentChildMode: knowledgeBase.parentChildMode ?? false,
        parentChunkSize: knowledgeBase.parentChunkSize || 1500,
        preserveMetadata: knowledgeBase.preserveMetadata ?? true,
        semanticThreshold: knowledgeBase.semanticThreshold ?? 0.5,
        retrievalMode: knowledgeBase.retrievalMode || 'HYBRID_RERANK',
        enableQueryRewrite: knowledgeBase.enableQueryRewrite ?? false,
        useDynamicTopK: knowledgeBase.useDynamicTopK ?? true,
        defaultTopK: knowledgeBase.defaultTopK ?? 5,
        queryRewriteModelId: knowledgeBase.queryRewriteModelId || 'dashscope/qwen-turbo',
        rerankModel: (knowledgeBase as any).rerankModel || 'qwen3-rerank',
      });
    } else {
      setFormData({ name: '', description: '', embeddingModel: 'text-embedding-v4', embeddingDimension: 1024, chunkSize: 500, chunkOverlap: 50, chunkStrategy: 'SEMANTIC', parentChildMode: false, parentChunkSize: 1500, preserveMetadata: true, semanticThreshold: 0.5, retrievalMode: 'HYBRID_RERANK', enableQueryRewrite: false, useDynamicTopK: true, defaultTopK: 5, queryRewriteModelId: 'dashscope/qwen-turbo', rerankModel: 'qwen3-rerank' });
    }
    setShowAdvancedChunk(false);
  }, [knowledgeBase, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.name.trim()) {
      toast.warning('请输入知识库名称');
      return;
    }

    setLoading(true);
    try {
      if (isEdit && knowledgeBase?.id) {
        const updateData: UpdateKnowledgeBaseCommand = {
          name: formData.name,
          description: formData.description,
          embeddingModel: formData.embeddingModel,
          embeddingDimension: formData.embeddingDimension,
          chunkSize: formData.chunkSize,
          chunkOverlap: formData.chunkOverlap,
          chunkStrategy: formData.chunkStrategy,
          parentChildMode: formData.parentChildMode,
          parentChunkSize: formData.parentChunkSize,
          preserveMetadata: formData.preserveMetadata,
          semanticThreshold: formData.semanticThreshold,
          retrievalMode: formData.retrievalMode,
          enableQueryRewrite: formData.enableQueryRewrite,
          useDynamicTopK: formData.useDynamicTopK,
          defaultTopK: formData.defaultTopK,
          queryRewriteModelId: formData.queryRewriteModelId,
        };
        const response = await api.kbUpdate({
          id: knowledgeBase.id,
          updateKnowledgeBaseCommand: updateData,
        });
        if (response.data.code === 0) {
          toast.success('更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const userId = getCurrentUserId();
        const response = await api.kbCreate({
          userId,
          createKnowledgeBaseCommand: formData,
        });
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

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑知识库' : '新建知识库'}
          </h3>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-5 overflow-y-auto max-h-[calc(90vh-140px)]">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">名称 *</label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入知识库名称"
              maxLength={128}
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
            <textarea
              value={formData.description}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              rows={3}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="请输入知识库描述"
              maxLength={2000}
            />
          </div>

          {/* Embedding 模型选择 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
              <span className="flex items-center gap-1.5"><Database size={14} className="text-brand-500" /> Embedding 模型</span>
            </label>
            <div className="space-y-2">
              <select
                value={formData.embeddingModel || 'text-embedding-v4'}
                onChange={(e) => {
                  const model = EMBEDDING_MODELS.find(m => m.model === e.target.value);
                  if (isEdit && knowledgeBase?.chunkCount && knowledgeBase.chunkCount > 0 && e.target.value !== knowledgeBase.embeddingModel) {
                    if (!window.confirm('当前知识库已有向量化数据，切换 Embedding 模型后需要重新向量化所有文档。确定要更改吗？')) {
                      return;
                    }
                  }
                  setFormData(prev => ({
                    ...prev,
                    embeddingModel: e.target.value,
                    embeddingDimension: model?.defaultDimension ?? 1024,
                  }));
                }}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 focus:ring-2 focus:ring-brand-500/20 transition-all"
              >
                {EMBEDDING_MODELS.map(m => (
                  <option key={m.model} value={m.model}>
                    {m.label}{m.recommended ? ' ★ 推荐' : ''}
                  </option>
                ))}
              </select>
              <div className="flex items-center gap-3">
                <label className="text-xs font-medium text-gray-500 dark:text-gray-400 whitespace-nowrap">向量维度</label>
                <select
                  value={formData.embeddingDimension || 1024}
                  onChange={(e) => setFormData(prev => ({ ...prev, embeddingDimension: Number(e.target.value) }))}
                  className="flex-1 px-3 py-1.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                >
                  {(EMBEDDING_MODELS.find(m => m.model === formData.embeddingModel)?.dimensions || [1024]).map(d => (
                    <option key={d} value={d}>{d}</option>
                  ))}
                </select>
                <span className="text-[10px] text-gray-400 whitespace-nowrap">维度越高精度越高，速度越慢</span>
              </div>
            </div>
          </div>

          {/* 切分策略选择 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">切分策略</label>
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
              {Object.entries(CHUNK_STRATEGY_MAP).map(([key, cfg]) => {
                const StratIcon = cfg.icon;
                const selected = formData.chunkStrategy === key;
                return (
                  <button
                    key={key}
                    type="button"
                    onClick={() => setFormData(prev => ({ ...prev, chunkStrategy: key }))}
                    className={`flex items-center gap-2 px-3 py-2.5 rounded-xl text-sm font-medium border transition-all text-left ${
                      selected
                        ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-500 text-brand-700 dark:text-brand-400 ring-1 ring-brand-500/20'
                        : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
                    }`}
                  >
                    <StratIcon size={16} className={selected ? 'text-brand-500' : 'text-gray-400'} />
                    <div className="min-w-0">
                      <div className="font-bold text-xs">{cfg.label}</div>
                    </div>
                  </button>
                );
              })}
            </div>
            {formData.chunkStrategy && CHUNK_STRATEGY_MAP[formData.chunkStrategy] && (
              <p className="text-xs text-gray-400 mt-1.5 pl-1">
                {CHUNK_STRATEGY_MAP[formData.chunkStrategy].description}
              </p>
            )}
          </div>

          {/* 语义切分：显示语义阈值 */}
          {formData.chunkStrategy === 'SEMANTIC' && (
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                语义相似度阈值 <span className="text-brand-500 font-bold">{formData.semanticThreshold}</span>
              </label>
              <input
                type="range"
                value={formData.semanticThreshold}
                onChange={(e) => setFormData(prev => ({ ...prev, semanticThreshold: parseFloat(e.target.value) }))}
                min={0.1}
                max={0.9}
                step={0.05}
                className="w-full h-2 bg-gray-200 dark:bg-gray-700 rounded-lg appearance-none cursor-pointer accent-brand-500"
              />
              <div className="flex justify-between text-[10px] text-gray-400 mt-0.5">
                <span>更粗粒度 (0.1)</span>
                <span>更细粒度 (0.9)</span>
              </div>
            </div>
          )}

          {/* 分块大小和重叠（所有策略均可配置，SEMANTIC策略作为最大分块大小） */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                {formData.chunkStrategy === 'SEMANTIC' ? '最大分块大小' : '分块大小'}
                <span className="text-xs text-gray-400 ml-1">(字符)</span>
              </label>
              <input
                type="number"
                value={formData.chunkSize}
                onChange={(e) => setFormData(prev => ({ ...prev, chunkSize: Number(e.target.value) || 500 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                min={100}
                max={5000}
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                分块重叠
                <span className="text-xs text-gray-400 ml-1">(字符)</span>
              </label>
              <input
                type="number"
                value={formData.chunkOverlap}
                onChange={(e) => setFormData(prev => ({ ...prev, chunkOverlap: Number(e.target.value) || 50 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                min={0}
                max={1000}
              />
            </div>
          </div>

          {/* 高级配置 */}
          <div>
            <button
              type="button"
              onClick={() => setShowAdvancedChunk(!showAdvancedChunk)}
              className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 transition-colors"
            >
              <SlidersHorizontal size={14} />
              <span>高级切分配置</span>
              {showAdvancedChunk ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
            </button>
            {showAdvancedChunk && (
              <div className="mt-3 space-y-4 pl-1">
                {/* 父子Chunk模式 */}
                <div className="flex items-center justify-between">
                  <div>
                    <div className="flex items-center gap-2 text-sm font-medium text-gray-700 dark:text-gray-300">
                      <GitBranch size={14} className="text-gray-400" />
                      父子Chunk模式
                    </div>
                    <p className="text-xs text-gray-400 mt-0.5">生成大块作为父chunk，小块作为子chunk，提升召回上下文</p>
                  </div>
                  <button
                    type="button"
                    onClick={() => setFormData(prev => ({ ...prev, parentChildMode: !prev.parentChildMode }))}
                    className="flex-shrink-0"
                  >
                    {formData.parentChildMode
                      ? <ToggleRight size={32} className="text-brand-500" />
                      : <ToggleLeft size={32} className="text-gray-300 dark:text-gray-600" />
                    }
                  </button>
                </div>

                {formData.parentChildMode && (
                  <div>
                    <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">父Chunk大小 (字符)</label>
                    <input
                      type="number"
                      value={formData.parentChunkSize}
                      onChange={(e) => setFormData(prev => ({ ...prev, parentChunkSize: Number(e.target.value) || 1500 }))}
                      className="w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                      min={500}
                      max={10000}
                    />
                  </div>
                )}

                {/* 保留元数据 */}
                <div className="flex items-center justify-between">
                  <div>
                    <div className="flex items-center gap-2 text-sm font-medium text-gray-700 dark:text-gray-300">
                      <Settings2 size={14} className="text-gray-400" />
                      保留元数据
                    </div>
                    <p className="text-xs text-gray-400 mt-0.5">保存文档名、章节标题等信息到分块元数据</p>
                  </div>
                  <button
                    type="button"
                    onClick={() => setFormData(prev => ({ ...prev, preserveMetadata: !prev.preserveMetadata }))}
                    className="flex-shrink-0"
                  >
                    {formData.preserveMetadata
                      ? <ToggleRight size={32} className="text-brand-500" />
                      : <ToggleLeft size={32} className="text-gray-300 dark:text-gray-600" />
                    }
                  </button>
                </div>
              </div>
            )}
          </div>

          {/* RAG 检索配置 */}
          <div className="space-y-3">
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">
              <span className="flex items-center gap-2"><SearchCheck size={16} className="text-accent-500" /> 检索模式</span>
            </label>
            <div className="grid grid-cols-3 gap-2">
              {Object.entries(RETRIEVAL_MODE_MAP).map(([key, config]) => {
                const Icon = config.icon;
                const selected = formData.retrievalMode === key;
                return (
                  <button
                    key={key}
                    type="button"
                    onClick={() => setFormData(prev => ({ ...prev, retrievalMode: key }))}
                    className={`relative p-3 rounded-xl border-2 transition-all text-left ${
                      selected
                        ? 'border-accent-500 bg-accent-50 dark:bg-accent-900/20 shadow-md shadow-accent-500/10'
                        : 'border-gray-200 dark:border-gray-700 hover:border-gray-300 dark:hover:border-gray-600'
                    }`}
                  >
                    <Icon size={18} className={selected ? 'text-accent-500' : 'text-gray-400'} />
                    <div className={`text-xs font-bold mt-1.5 ${selected ? 'text-accent-600 dark:text-accent-400' : 'text-gray-600 dark:text-gray-400'}`}>{config.label}</div>
                    <div className="text-[10px] text-gray-400 mt-0.5 leading-tight">{config.description}</div>
                  </button>
                );
              })}
            </div>

            {/* Rerank 模型选择（仅 HYBRID_RERANK 模式显示） */}
            {formData.retrievalMode === 'HYBRID_RERANK' && (
              <div className="mt-2 p-3 rounded-xl bg-accent-50/50 dark:bg-accent-900/10 border border-accent-200/50 dark:border-accent-800/30">
                <label className="block text-xs font-medium text-accent-700 dark:text-accent-400 mb-1.5">Rerank 精排模型</label>
                <select
                  value={formData.rerankModel || 'qwen3-rerank'}
                  onChange={(e) => setFormData(prev => ({ ...prev, rerankModel: e.target.value }))}
                  className="w-full px-3 py-1.5 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                >
                  {RERANK_MODELS.map(m => (
                    <option key={m.model} value={m.model}>
                      {m.label}{m.recommended ? ' (推荐)' : ''} — {m.desc}
                    </option>
                  ))}
                </select>
              </div>
            )}

            {/* Query 改写 & 动态 topK */}
            <div className="flex gap-4 mt-2">
              <div className="flex-1 flex items-center justify-between p-3 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700">
                <div>
                  <div className="flex items-center gap-1.5 text-xs font-medium text-gray-700 dark:text-gray-300">
                    <Sparkles size={12} className="text-amber-500" />
                    Query 改写
                  </div>
                  <p className="text-[10px] text-gray-400 mt-0.5">LLM 辅助改写查询</p>
                </div>
                <button
                  type="button"
                  onClick={() => setFormData(prev => ({ ...prev, enableQueryRewrite: !prev.enableQueryRewrite }))}
                  className="flex-shrink-0"
                >
                  {formData.enableQueryRewrite
                    ? <ToggleRight size={28} className="text-brand-500" />
                    : <ToggleLeft size={28} className="text-gray-300 dark:text-gray-600" />
                  }
                </button>
              </div>
              <div className="flex-1 p-3 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="flex items-center gap-1.5 text-xs font-medium text-gray-700 dark:text-gray-300">
                      <SlidersHorizontal size={12} className="text-blue-500" />
                      动态 TopK
                    </div>
                    <p className="text-[10px] text-gray-400 mt-0.5">根据查询自动调节</p>
                  </div>
                  <button
                    type="button"
                    onClick={() => setFormData(prev => ({ ...prev, useDynamicTopK: !prev.useDynamicTopK }))}
                    className="flex-shrink-0"
                  >
                    {formData.useDynamicTopK
                      ? <ToggleRight size={28} className="text-brand-500" />
                      : <ToggleLeft size={28} className="text-gray-300 dark:text-gray-600" />
                    }
                  </button>
                </div>
              </div>
            </div>

            {/* 手动 topK 输入（关闭动态 topK 时显示） */}
            {!formData.useDynamicTopK && (
              <div className="mt-2">
                <label className="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">
                  固定 TopK 召回数量
                </label>
                <div className="flex items-center gap-3">
                  <input
                    type="number"
                    value={formData.defaultTopK ?? 5}
                    onChange={(e) => {
                      const val = Math.max(1, Math.min(20, Number(e.target.value) || 5));
                      setFormData(prev => ({ ...prev, defaultTopK: val }));
                    }}
                    className="w-20 px-3 py-1.5 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all text-center"
                    min={1}
                    max={20}
                  />
                  <span className="text-xs text-gray-400">范围 1~20，推荐 3~10</span>
                </div>
              </div>
            )}

            {/* Query 改写 LLM 模型选择（启用 Query 改写时显示） */}
            {formData.enableQueryRewrite && (
              <div className="mt-2 p-3 rounded-xl bg-amber-50/50 dark:bg-amber-900/10 border border-amber-200/50 dark:border-amber-800/30">
                <label className="block text-xs font-medium text-amber-700 dark:text-amber-400 mb-1.5">Query 改写模型</label>
                <select
                  value={formData.queryRewriteModelId || 'dashscope/qwen-turbo'}
                  onChange={(e) => setFormData(prev => ({ ...prev, queryRewriteModelId: e.target.value }))}
                  className="w-full px-3 py-1.5 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                >
                  <option value="dashscope/qwen-turbo">qwen-turbo (Flash · 快速低成本)</option>
                  <option value="dashscope/qwen-plus">qwen-plus (Plus · 均衡)</option>
                  <option value="dashscope/qwen-max">qwen-max (Max · 深度思考)</option>
                </select>
                <p className="text-[10px] text-amber-600/60 dark:text-amber-400/50 mt-1">小任务推荐 turbo，复杂查询可选 plus/max</p>
              </div>
            )}
          </div>
        </form>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button type="button" onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
            取消
          </button>
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading && <Loader2 size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建知识库'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ==================== 添加文档弹窗（支持批量） ====================
interface FileItem {
  uid: string;
  name: string;
  fileType: string;
  fileUrl: string;
  fileSize: number;
  content: string;
  status: 'pending' | 'uploading' | 'ready' | 'submitting' | 'done' | 'error';
  errorMsg?: string;
}

interface AddDocumentModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  knowledgeBaseId: number;
}

let fileUidCounter = 0;

const AddDocumentModal: React.FC<AddDocumentModalProps> = ({ isOpen, onClose, onSuccess, knowledgeBaseId }) => {
  const [submitting, setSubmitting] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [fileItems, setFileItems] = useState<FileItem[]>([]);
  const [inputMode, setInputMode] = useState<'text' | 'file'>('file');
  const [textForm, setTextForm] = useState({ name: '', content: '' });

  useEffect(() => {
    if (isOpen) {
      setFileItems([]);
      setTextForm({ name: '', content: '' });
      setInputMode('file');
    }
  }, [isOpen]);

  const ALLOWED_TYPES = ['PDF', 'TXT', 'DOCX', 'DOC', 'MD', 'HTML', 'EPUB'];
  const MAX_SIZE = 20 * 1024 * 1024;

  // 处理多文件选择
  const handleFilesSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;

    const newItems: FileItem[] = [];

    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const ext = file.name.split('.').pop()?.toUpperCase() || 'TXT';

      if (!ALLOWED_TYPES.includes(ext)) {
        toast.error(`跳过不支持的文件: ${file.name} (.${ext})`);
        continue;
      }
      if (file.size > MAX_SIZE) {
        toast.error(`跳过过大的文件: ${file.name} (超过 20MB)`);
        continue;
      }

      const uid = `file_${++fileUidCounter}`;
      newItems.push({
        uid,
        name: file.name,
        fileType: ext,
        fileUrl: '',
        fileSize: file.size,
        content: '',
        status: 'uploading',
      });
    }

    setFileItems(prev => [...prev, ...newItems]);

    // 异步处理每个文件的内容读取/上传
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const ext = file.name.split('.').pop()?.toUpperCase() || 'TXT';
      if (!ALLOWED_TYPES.includes(ext) || file.size > MAX_SIZE) continue;

      const matchItem = newItems.find(it => it.name === file.name && it.fileType === ext);
      if (!matchItem) continue;

      try {
        if (['TXT', 'MD', 'HTML'].includes(ext)) {
          const text = await file.text();
          setFileItems(prev => prev.map(it =>
            it.uid === matchItem.uid ? { ...it, content: text, status: 'ready' } : it
          ));
        } else {
          const uploadFormData = new FormData();
          uploadFormData.append('file', file);

          const response = await apiClient.post('/api/file/upload/system/document', uploadFormData, {
            headers: { 'Content-Type': 'multipart/form-data' },
          });

          if (response.data?.code === 0 && response.data?.data?.fileUrl) {
            setFileItems(prev => prev.map(it =>
              it.uid === matchItem.uid ? { ...it, fileUrl: response.data.data.fileUrl, status: 'ready' } : it
            ));
          } else {
            setFileItems(prev => prev.map(it =>
              it.uid === matchItem.uid ? { ...it, status: 'error', errorMsg: response.data?.message || '上传失败' } : it
            ));
          }
        }
      } catch (error: any) {
        setFileItems(prev => prev.map(it =>
          it.uid === matchItem.uid ? { ...it, status: 'error', errorMsg: error?.response?.data?.message || '文件处理失败' } : it
        ));
      }
    }

    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  // 移除某个文件
  const removeFile = (uid: string) => {
    setFileItems(prev => prev.filter(it => it.uid !== uid));
  };

  // 提交所有文档
  const handleSubmit = async () => {
    if (inputMode === 'text') {
      // 单文本模式
      if (!textForm.name.trim()) { toast.warning('请输入文档名称'); return; }
      if (!textForm.content.trim()) { toast.warning('请输入文档内容'); return; }

      setSubmitting(true);
      try {
        const userId = getCurrentUserId();
        const response = await api.kbAddDocument({
          id: knowledgeBaseId,
          userId,
          requestBody: {
            name: textForm.name as unknown as object,
            fileType: 'TXT' as unknown as object,
            fileUrl: '' as unknown as object,
            fileSize: textForm.content.length as unknown as object,
            content: textForm.content as unknown as object,
          },
        });
        if (response.data.code === 0) {
          toast.success('文档添加成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '添加失败');
        }
      } catch (error: any) {
        toast.error(error?.response?.data?.message || '操作失败');
      } finally {
        setSubmitting(false);
      }
      return;
    }

    // 批量文件模式
    const readyItems = fileItems.filter(it => it.status === 'ready');
    if (readyItems.length === 0) {
      toast.warning('没有可提交的文件，请先选择文件');
      return;
    }

    setSubmitting(true);
    const userId = getCurrentUserId();
    let successCount = 0;
    let failCount = 0;

    for (const item of readyItems) {
      setFileItems(prev => prev.map(it =>
        it.uid === item.uid ? { ...it, status: 'submitting' } : it
      ));
      try {
        const response = await api.kbAddDocument({
          id: knowledgeBaseId,
          userId,
          requestBody: {
            name: item.name as unknown as object,
            fileType: item.fileType as unknown as object,
            fileUrl: (item.fileUrl || '') as unknown as object,
            fileSize: item.fileSize as unknown as object,
            content: (item.content || '') as unknown as object,
          },
        });
        if (response.data.code === 0) {
          successCount++;
          setFileItems(prev => prev.map(it =>
            it.uid === item.uid ? { ...it, status: 'done' } : it
          ));
        } else {
          failCount++;
          setFileItems(prev => prev.map(it =>
            it.uid === item.uid ? { ...it, status: 'error', errorMsg: response.data.message || '添加失败' } : it
          ));
        }
      } catch (error: any) {
        failCount++;
        setFileItems(prev => prev.map(it =>
          it.uid === item.uid ? { ...it, status: 'error', errorMsg: error?.response?.data?.message || '操作失败' } : it
        ));
      }
    }

    setSubmitting(false);

    if (failCount === 0) {
      toast.success(`全部 ${successCount} 个文档添加成功`);
      onSuccess();
      onClose();
    } else {
      toast.warning(`完成 ${successCount} 个，失败 ${failCount} 个`);
      onSuccess();
    }
  };

  const getFileStatusIcon = (item: FileItem) => {
    switch (item.status) {
      case 'uploading': return <Loader2 size={16} className="text-blue-500 animate-spin" />;
      case 'ready': return <CheckCircle2 size={16} className="text-green-500" />;
      case 'submitting': return <Loader2 size={16} className="text-brand-500 animate-spin" />;
      case 'done': return <CheckCircle2 size={16} className="text-green-600" />;
      case 'error': return <AlertCircle size={16} className="text-red-500" />;
      default: return <Clock size={16} className="text-gray-400" />;
    }
  };

  const getFileStatusText = (item: FileItem) => {
    switch (item.status) {
      case 'uploading': return '读取中...';
      case 'ready': return '就绪';
      case 'submitting': return '提交中...';
      case 'done': return '已完成';
      case 'error': return item.errorMsg || '失败';
      default: return '等待';
    }
  };

  const readyCount = fileItems.filter(it => it.status === 'ready').length;
  const totalCount = fileItems.length;

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">添加文档</h3>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Body */}
        <div className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-140px)]">
          {/* 输入方式切换 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">添加方式</label>
            <div className="flex gap-2">
              <button
                type="button"
                onClick={() => setInputMode('file')}
                className={`flex-1 px-4 py-2.5 rounded-xl text-sm font-medium border transition-all ${
                  inputMode === 'file'
                    ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-500 text-brand-700 dark:text-brand-400'
                    : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
                }`}
              >
                <Upload size={16} className="inline mr-2" />
                批量上传文件
              </button>
              <button
                type="button"
                onClick={() => setInputMode('text')}
                className={`flex-1 px-4 py-2.5 rounded-xl text-sm font-medium border transition-all ${
                  inputMode === 'text'
                    ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-500 text-brand-700 dark:text-brand-400'
                    : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
                }`}
              >
                <FileText size={16} className="inline mr-2" />
                直接输入文本
              </button>
            </div>
          </div>

          {inputMode === 'file' ? (
            <>
              {/* 文件选择区域 */}
              <div>
                <input
                  ref={fileInputRef}
                  type="file"
                  accept=".txt,.md,.html,.pdf,.docx,.doc,.epub"
                  onChange={handleFilesSelect}
                  className="hidden"
                  multiple
                />
                <div
                  onClick={() => !submitting && fileInputRef.current?.click()}
                  className={`border-2 border-dashed rounded-xl p-6 text-center transition-colors ${
                    submitting
                      ? 'border-gray-200 dark:border-gray-800 cursor-not-allowed opacity-50'
                      : 'border-gray-200 dark:border-gray-700 cursor-pointer hover:border-brand-500 dark:hover:border-brand-400'
                  }`}
                >
                  <div className="flex flex-col items-center gap-2">
                    <Upload size={28} className="text-gray-400" />
                    <p className="text-sm text-gray-500">点击选择文件（支持多选）</p>
                    <p className="text-xs text-gray-400">TXT, MD, HTML, PDF, DOCX, EPUB · 单文件最大 20MB</p>
                  </div>
                </div>
              </div>

              {/* 文件列表 */}
              {fileItems.length > 0 && (
                <div>
                  <div className="flex items-center justify-between mb-2">
                    <label className="text-sm font-medium text-gray-700 dark:text-gray-300">
                      文件列表
                      <span className="text-xs text-gray-400 ml-2">({readyCount} 就绪 / {totalCount} 总计)</span>
                    </label>
                    {fileItems.some(it => it.status === 'done') && (
                      <button
                        type="button"
                        onClick={() => setFileItems(prev => prev.filter(it => it.status !== 'done'))}
                        className="text-xs text-gray-400 hover:text-red-500 transition-colors"
                      >
                        清除已完成
                      </button>
                    )}
                  </div>
                  <div className="space-y-2 max-h-[280px] overflow-y-auto pr-1">
                    {fileItems.map((item) => (
                      <div
                        key={item.uid}
                        className={`flex items-center gap-3 px-4 py-3 rounded-xl border transition-all ${
                          item.status === 'done'
                            ? 'bg-green-50/50 dark:bg-green-900/10 border-green-200 dark:border-green-800/50'
                            : item.status === 'error'
                            ? 'bg-red-50/50 dark:bg-red-900/10 border-red-200 dark:border-red-800/50'
                            : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700'
                        }`}
                      >
                        <div className="w-8 h-8 rounded-lg bg-white dark:bg-gray-800 flex items-center justify-center flex-shrink-0 border border-gray-100 dark:border-gray-700">
                          <FileTypeIcon fileType={item.fileType} size={16} />
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{item.name}</p>
                          <div className="flex items-center gap-2 mt-0.5">
                            <span className="text-xs text-gray-400">{item.fileType} · {formatFileSize(item.fileSize)}</span>
                            <span className="text-xs flex items-center gap-1">
                              {getFileStatusIcon(item)}
                              <span className={
                                item.status === 'done' ? 'text-green-600' :
                                item.status === 'error' ? 'text-red-500' :
                                item.status === 'submitting' ? 'text-brand-500' :
                                'text-gray-500'
                              }>
                                {getFileStatusText(item)}
                              </span>
                            </span>
                          </div>
                        </div>
                        {(item.status === 'ready' || item.status === 'error' || item.status === 'pending') && !submitting && (
                          <button
                            type="button"
                            onClick={() => removeFile(item.uid)}
                            className="p-1.5 text-gray-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all flex-shrink-0"
                          >
                            <X size={14} />
                          </button>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </>
          ) : (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文档名称 *</label>
                <input
                  type="text"
                  value={textForm.name}
                  onChange={(e) => setTextForm(prev => ({ ...prev, name: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="请输入文档名称"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文档内容 *</label>
                <textarea
                  value={textForm.content}
                  onChange={(e) => setTextForm(prev => ({ ...prev, content: e.target.value }))}
                  rows={10}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none font-mono text-sm"
                  placeholder="请粘贴或输入文档内容..."
                />
                {textForm.content && (
                  <p className="text-xs text-gray-400 mt-1">{textForm.content.length} 字符</p>
                )}
              </div>
            </>
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-between px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <div className="text-xs text-gray-400">
            {inputMode === 'file' && totalCount > 0 && (
              <span>{readyCount} 个文件就绪</span>
            )}
          </div>
          <div className="flex items-center gap-3">
            <button type="button" onClick={onClose} disabled={submitting} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors disabled:opacity-50">
              取消
            </button>
            <button
              onClick={handleSubmit}
              disabled={submitting || (inputMode === 'file' && readyCount === 0) || (inputMode === 'text' && (!textForm.name.trim() || !textForm.content.trim()))}
              className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
            >
              {submitting && <Loader2 size={16} className="animate-spin" />}
              {inputMode === 'file'
                ? (submitting ? '提交中...' : `添加 ${readyCount} 个文档`)
                : (submitting ? '提交中...' : '添加文档')
              }
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

// ==================== 分块查看弹窗 ====================
interface ChunkViewerModalProps {
  isOpen: boolean;
  onClose: () => void;
  knowledgeBaseId: number;
  document: KnowledgeDocumentVO;
}

interface ChunkItem {
  id: number;
  knowledgeBaseId: number;
  documentId: number;
  content: string;
  chunkIndex: number;
  metadata: string;
  createTime: string;
  parentChunkId: number | null;
  isParentChunk: boolean;
  sectionTitle: string | null;
}

const ChunkViewerModal: React.FC<ChunkViewerModalProps> = ({ isOpen, onClose, knowledgeBaseId, document: doc }) => {
  const [chunks, setChunks] = useState<ChunkItem[]>([]);
  const [loading, setLoading] = useState(false);
  const [page, setPage] = useState(0);
  const [total, setTotal] = useState(0);
  const pageSize = 10;

  const fetchChunks = useCallback(async () => {
    if (!doc.id) return;
    setLoading(true);
    try {
      const response = await api.kbListChunks({
        id: knowledgeBaseId as unknown as number,
        docId: doc.id as unknown as number,
        page,
        size: pageSize,
      });
      if (response.data.code === 0) {
        setChunks((response.data as any).data?.chunks || []);
        setTotal((response.data as any).data?.total || 0);
      }
    } catch {
      toast.error('获取分块列表失败');
    } finally {
      setLoading(false);
    }
  }, [doc.id, knowledgeBaseId, page]);

  useEffect(() => {
    if (isOpen) {
      setPage(0);
    }
  }, [isOpen]);

  useEffect(() => {
    if (isOpen) fetchChunks();
  }, [isOpen, fetchChunks]);

  if (!isOpen) return null;

  const totalPages = Math.ceil(total / pageSize);

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-4xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-accent-50 dark:bg-accent-900/20 rounded-lg">
              <Layers size={20} className="text-accent-600 dark:text-accent-400" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-gray-900 dark:text-white">{doc.name}</h2>
              <p className="text-sm text-gray-500">共 {total} 个分块 · {doc.fileType} · {formatFileSize(doc.fileSize)}</p>
            </div>
          </div>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all">
            <X size={20} />
          </button>
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto p-6 space-y-3">
          {loading ? (
            Array.from({ length: 3 }).map((_, i) => (
              <div key={i} className="animate-pulse bg-gray-50 dark:bg-gray-800 rounded-xl p-4 space-y-2">
                <div className="h-4 bg-gray-200 dark:bg-gray-700 rounded w-1/4" />
                <div className="h-3 bg-gray-200 dark:bg-gray-700 rounded w-full" />
                <div className="h-3 bg-gray-200 dark:bg-gray-700 rounded w-3/4" />
              </div>
            ))
          ) : chunks.length > 0 ? (
            chunks.map((chunk) => (
              <div key={String(chunk.id)} className={`rounded-xl border overflow-hidden ${
                chunk.isParentChunk
                  ? 'border-brand-200 dark:border-brand-800 bg-brand-50/30 dark:bg-brand-900/10'
                  : 'bg-gray-50 dark:bg-gray-800/50 border-gray-100 dark:border-gray-700'
              }`}>
                <div className="flex items-center justify-between px-4 py-2 bg-gray-100/50 dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700">
                  <div className="flex items-center gap-2">
                    <Hash size={14} className="text-accent-500" />
                    <span className="text-xs font-bold text-gray-600 dark:text-gray-300">分块 {chunk.chunkIndex + 1}</span>
                    {chunk.isParentChunk && (
                      <span className="px-1.5 py-0.5 rounded text-[10px] font-bold bg-brand-100 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 border border-brand-200 dark:border-brand-800">父块</span>
                    )}
                    {chunk.parentChunkId && !chunk.isParentChunk && (
                      <span className="px-1.5 py-0.5 rounded text-[10px] font-bold bg-accent-100 dark:bg-accent-900/30 text-accent-600 dark:text-accent-400 border border-accent-200 dark:border-accent-800">子块</span>
                    )}
                    {chunk.sectionTitle && (
                      <span className="text-xs text-gray-500 dark:text-gray-400 truncate max-w-[200px]">{chunk.sectionTitle}</span>
                    )}
                  </div>
                  <span className="text-xs text-gray-400">{chunk.content.length} 字符</span>
                </div>
                <div className="p-4">
                  <pre className="text-sm text-gray-700 dark:text-gray-300 whitespace-pre-wrap break-words font-sans leading-relaxed max-h-48 overflow-y-auto">
                    {chunk.content}
                  </pre>
                </div>
              </div>
            ))
          ) : (
            <div className="text-center py-12">
              <Layers size={40} className="mx-auto text-gray-300 mb-3" />
              <p className="text-gray-500">暂无分块数据</p>
              <p className="text-gray-400 text-sm mt-1">请先对文档进行向量化处理</p>
            </div>
          )}
        </div>

        {/* Pagination Footer */}
        {total > 0 && (
          <div className="px-6 py-4 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
            <p className="text-sm text-gray-500">
              第 <span className="font-bold">{page + 1}</span> / {totalPages} 页，共 <span className="font-bold">{total}</span> 个分块
            </p>
            <div className="flex items-center gap-2">
              <button
                disabled={page === 0 || loading}
                onClick={() => setPage(p => p - 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronLeft size={16} />
              </button>
              <button
                disabled={page >= totalPages - 1 || loading}
                onClick={() => setPage(p => p + 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronRight size={16} />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

// ==================== 文档编辑弹窗 ====================
interface EditDocumentModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  knowledgeBaseId: number;
  document: KnowledgeDocumentVO;
}

const EditDocumentModal: React.FC<EditDocumentModalProps> = ({ isOpen, onClose, onSuccess, knowledgeBaseId, document: doc }) => {
  const [name, setName] = useState('');
  const [fileType, setFileType] = useState('');
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (isOpen && doc) {
      setName(doc.name || '');
      setFileType(doc.fileType || 'TXT');
    }
  }, [isOpen, doc]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!name.trim()) {
      toast.error('文档名称不能为空');
      return;
    }
    setSaving(true);
    try {
      const response = await api.kbUpdateDocument({
        id: knowledgeBaseId as unknown as number,
        docId: doc.id as unknown as number,
        requestBody: { name: name.trim(), fileType },
      });
      if (response.data.code === 0) {
        toast.success('更新成功');
        onSuccess();
        onClose();
      } else {
        toast.error(response.data.message || '更新失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally {
      setSaving(false);
    }
  };

  if (!isOpen) return null;

  const fileTypes = ['TXT', 'PDF', 'DOCX', 'DOC', 'MD', 'HTML', 'EPUB'];

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-brand-50 dark:bg-brand-900/20 rounded-lg">
              <Edit2 size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <h2 className="text-lg font-bold text-gray-900 dark:text-white">编辑文档信息</h2>
          </div>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all">
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文档名称</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入文档名称"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文件类型</label>
            <select
              value={fileType}
              onChange={(e) => setFileType(e.target.value)}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
            >
              {fileTypes.map(t => (
                <option key={t} value={t}>{t}</option>
              ))}
            </select>
          </div>
        </form>
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
            disabled={saving}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {saving && <Loader2 size={16} className="animate-spin" />}
            保存
          </button>
        </div>
      </div>
    </div>
  );
};

// ==================== 文档详情面板 ====================
interface DocumentPanelProps {
  knowledgeBase: KnowledgeBaseVO;
  onBack: () => void;
}

const DocumentPanel: React.FC<DocumentPanelProps> = ({ knowledgeBase, onBack }) => {
  const [documents, setDocuments] = useState<KnowledgeDocumentVO[]>([]);
  const [loading, setLoading] = useState(false);
  const [page, setPage] = useState(0);
  const [addModalOpen, setAddModalOpen] = useState(false);
  const [processingIds, setProcessingIds] = useState<Set<string>>(new Set());
  const [batchProcessing, setBatchProcessing] = useState(false);
  const [chunkViewDoc, setChunkViewDoc] = useState<KnowledgeDocumentVO | null>(null);
  const [editDoc, setEditDoc] = useState<KnowledgeDocumentVO | null>(null);
  const [chunkPreviewDoc, setChunkPreviewDoc] = useState<KnowledgeDocumentVO | null>(null);
  const [docStats, setDocStats] = useState<Record<string, number>>({ PENDING: 0, PROCESSING: 0, COMPLETED: 0, FAILED: 0 });

  const fetchDocStats = useCallback(async () => {
    if (!knowledgeBase.id) return;
    try {
      const response = await api.kbDocumentStats({ id: knowledgeBase.id as unknown as number });
      if (response.data.code === 0 && response.data.data) {
        setDocStats(response.data.data);
      }
    } catch { /* silent */ }
  }, [knowledgeBase.id]);

  const fetchDocuments = useCallback(async () => {
    if (!knowledgeBase.id) return;
    setLoading(true);
    try {
      const response = await api.kbListDocuments({ id: knowledgeBase.id, page, size: 20 });
      if (response.data.code === 0) {
        setDocuments(response.data.data || []);
      } else {
        toast.error(response.data.message || '获取文档列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [knowledgeBase.id, page]);

  useEffect(() => {
    fetchDocuments();
    fetchDocStats();
  }, [fetchDocuments, fetchDocStats]);

  const handleDeleteDocument = async (doc: KnowledgeDocumentVO) => {
    if (!doc.id || !knowledgeBase.id) return;
    if (!window.confirm(`确定要删除文档 "${doc.name}" 吗？此操作不可恢复。`)) return;

    try {
      const response = await api.kbDeleteDocument({ id: knowledgeBase.id, docId: doc.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchDocuments();
        fetchDocStats();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const handleProcessDocument = async (doc: KnowledgeDocumentVO) => {
    if (!doc.id || !knowledgeBase.id) return;
    const docIdStr = String(doc.id);
    setProcessingIds(prev => new Set(prev).add(docIdStr));
    try {
      const response = await api.kbProcessDocument({ id: knowledgeBase.id, docId: doc.id });
      if (response.data.code === 0) {
        toast.success('向量化成功');
        fetchDocuments();
        fetchDocStats();
      } else {
        toast.error(response.data.message || '向量化失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '向量化失败');
    } finally {
      setProcessingIds(prev => {
        const next = new Set(prev);
        next.delete(docIdStr);
        return next;
      });
    }
  };

  const handleBatchProcess = async () => {
    if (!knowledgeBase.id) return;
    setBatchProcessing(true);
    try {
      const response = await api.kbBatchProcessByKnowledgeBase({ id: knowledgeBase.id });
      if (response.data.code === 0) {
        const result = response.data.data;
        toast.success(`批量向量化完成: 成功 ${result?.successCount || 0} / 共 ${result?.total || 0}`);
        fetchDocuments();
        fetchDocStats();
      } else {
        toast.error(response.data.message || '批量向量化失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '批量向量化失败');
    } finally {
      setBatchProcessing(false);
    }
  };

  const getDocStatusBadge = (status?: string) => {
    const config = DOC_STATUS_MAP[status || ''] || DOC_STATUS_MAP.PENDING;
    const Icon = config.icon;
    return (
      <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs font-bold border ${config.color}`}>
        <Icon size={12} className={status === 'PROCESSING' ? 'animate-spin' : ''} />
        {config.label}
      </span>
    );
  };

  const pendingCount = (docStats.PENDING || 0) + (docStats.PROCESSING || 0);

  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      {/* Header with back button */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div className="flex items-center gap-4">
          <button
            onClick={onBack}
            aria-label="返回知识库列表"
            className="p-2 text-gray-500 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-xl transition-all"
          >
            <ArrowLeft size={22} />
          </button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">{knowledgeBase.name}</h1>
            <p className="text-gray-500 dark:text-gray-400 mt-1 text-sm">
              {knowledgeBase.description || '暂无描述'} · 
              <span className="ml-1">{knowledgeBase.embeddingModel}</span> · 
              <span className="ml-1">{CHUNK_STRATEGY_MAP[knowledgeBase.chunkStrategy || 'SEMANTIC']?.label || '语义切分'}</span> · 
              <span className="ml-1">分块 {knowledgeBase.chunkSize}/{knowledgeBase.chunkOverlap}</span>
              {knowledgeBase.parentChildMode && <span className="ml-1 text-brand-500">· 父子模式</span>}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          {pendingCount > 0 && (
            <button
              onClick={handleBatchProcess}
              disabled={batchProcessing}
              className="flex items-center gap-2 px-4 py-2 bg-amber-500 text-white rounded-xl text-sm font-bold hover:bg-amber-600 shadow-lg shadow-amber-500/20 transition-all active:scale-95 disabled:opacity-50"
            >
              {batchProcessing ? <Loader2 size={18} className="animate-spin" /> : <Zap size={18} />}
              <span>全部向量化 ({pendingCount})</span>
            </button>
          )}
          <button
            onClick={() => setAddModalOpen(true)}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>添加文档</span>
          </button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-brand-50 dark:bg-brand-900/20 rounded-lg">
              <FileText size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">{knowledgeBase.documentCount || 0}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">文档数</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-accent-50 dark:bg-accent-900/20 rounded-lg">
              <Layers size={20} className="text-accent-600 dark:text-accent-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">{knowledgeBase.chunkCount || 0}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">分块数</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-green-50 dark:bg-green-900/20 rounded-lg">
              <CheckCircle2 size={20} className="text-green-600 dark:text-green-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">
                {docStats.COMPLETED || 0}
              </p>
              <p className="text-xs text-gray-500 dark:text-gray-400">已向量化</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-amber-50 dark:bg-amber-900/20 rounded-lg">
              <Clock size={20} className="text-amber-600 dark:text-amber-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">{docStats.PENDING || 0}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">待处理</p>
            </div>
          </div>
        </div>
      </div>

      {/* Document Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">文档信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">类型</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">大小</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">分块数</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 3 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={6} className="px-6 py-6">
                      <div className="flex gap-4">
                        <div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-lg" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/5" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : documents.length > 0 ? (
                documents.map((doc) => {
                  const isProcessing = processingIds.has(String(doc.id));
                  return (
                    <tr key={String(doc.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 rounded-lg bg-gray-50 dark:bg-gray-800 flex items-center justify-center flex-shrink-0">
                            <FileTypeIcon fileType={doc.fileType || 'TXT'} />
                          </div>
                          <div className="min-w-0">
                            <p className="font-bold text-sm text-gray-900 dark:text-white truncate max-w-[200px]">{doc.name}</p>
                            <p className="text-xs text-gray-400 mt-0.5">{formatDateTime(doc.createTime)}</p>
                          </div>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-600 dark:text-gray-300 font-medium">{doc.fileType}</span>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-500">{formatFileSize(doc.fileSize)}</span>
                      </td>
                      <td className="px-6 py-4">
                        {getDocStatusBadge(doc.status)}
                        {doc.status === 'FAILED' && doc.errorMessage && (
                          <p className="text-xs text-red-500 mt-1 max-w-[160px] truncate" title={doc.errorMessage}>
                            {doc.errorMessage}
                          </p>
                        )}
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-600 dark:text-gray-300">{doc.chunkCount || 0}</span>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-1">
                          {doc.status === 'COMPLETED' && (doc.chunkCount ?? 0) > 0 && (
                            <button
                              onClick={() => setChunkViewDoc(doc)}
                              className="p-2 text-gray-400 hover:text-accent-600 hover:bg-accent-50 dark:hover:bg-accent-900/20 rounded-lg transition-all"
                              title="查看分块"
                            >
                              <Eye size={18} />
                            </button>
                          )}
                          <button
                            onClick={() => setChunkPreviewDoc(doc)}
                            className="p-2 text-gray-400 hover:text-accent-600 hover:bg-accent-50 dark:hover:bg-accent-900/20 rounded-lg transition-all"
                            title="预览切分"
                          >
                            <Scissors size={18} />
                          </button>
                          <button
                            onClick={() => setEditDoc(doc)}
                            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                            title="编辑"
                          >
                            <Edit2 size={18} />
                          </button>
                          {(doc.status === 'PENDING' || doc.status === 'FAILED') && (
                            <button
                              onClick={() => handleProcessDocument(doc)}
                              disabled={isProcessing}
                              className="p-2 text-gray-400 hover:text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-all disabled:opacity-50"
                              title="向量化"
                            >
                              {isProcessing ? <Loader2 size={18} className="animate-spin" /> : <Zap size={18} />}
                            </button>
                          )}
                          <button
                            onClick={() => handleDeleteDocument(doc)}
                            className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                            title="删除"
                          >
                            <Trash2 size={18} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })
              ) : (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <File size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无文档</p>
                      <p className="text-gray-400 text-sm mt-1">点击"添加文档"开始上传</p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            共 <span className="font-bold text-gray-900 dark:text-white">{documents.length}</span> 个文档
          </p>
          <div className="flex items-center gap-2">
            <button
              disabled={page === 0 || loading}
              onClick={() => setPage(p => p - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronLeft size={18} />
            </button>
            <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">{page + 1}</span>
            <button
              disabled={documents.length < 20 || loading}
              onClick={() => setPage(p => p + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* Add Document Modal */}
      <AddDocumentModal
        isOpen={addModalOpen}
        onClose={() => setAddModalOpen(false)}
        onSuccess={() => { fetchDocuments(); fetchDocStats(); }}
        knowledgeBaseId={knowledgeBase.id!}
      />

      {/* Chunk Viewer Modal */}
      {chunkViewDoc && (
        <ChunkViewerModal
          isOpen={!!chunkViewDoc}
          onClose={() => setChunkViewDoc(null)}
          knowledgeBaseId={knowledgeBase.id!}
          document={chunkViewDoc}
        />
      )}

      {/* Edit Document Modal */}
      {editDoc && (
        <EditDocumentModal
          isOpen={!!editDoc}
          onClose={() => setEditDoc(null)}
          onSuccess={fetchDocuments}
          knowledgeBaseId={knowledgeBase.id!}
          document={editDoc}
        />
      )}

      {/* Chunk Preview Modal */}
      {chunkPreviewDoc && (
        <ChunkPreviewModal
          isOpen={!!chunkPreviewDoc}
          onClose={() => setChunkPreviewDoc(null)}
          knowledgeBaseId={knowledgeBase.id!}
          document={chunkPreviewDoc}
        />
      )}
    </div>
  );
};

// ==================== 切分预览弹窗 ====================
interface PreviewChunkItem {
  index: number;
  content: string;
  charCount: number;
  isParent: boolean;
  parentIndex: number | null;
  sectionTitle: string | null;
}

interface ChunkPreviewResult {
  strategy: string;
  totalChunks: number;
  parentChunks: number;
  childChunks: number;
  avgChunkSize: number;
  chunks: PreviewChunkItem[];
}

interface ChunkPreviewModalProps {
  isOpen: boolean;
  onClose: () => void;
  knowledgeBaseId: number;
  document: KnowledgeDocumentVO;
}

const ChunkPreviewModal: React.FC<ChunkPreviewModalProps> = ({ isOpen, onClose, knowledgeBaseId, document: doc }) => {
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<ChunkPreviewResult | null>(null);
  const [strategy, setStrategy] = useState('SEMANTIC');
  const [chunkSize, setChunkSize] = useState(500);
  const [chunkOverlap, setChunkOverlap] = useState(50);
  const [parentChildMode, setParentChildMode] = useState(false);
  const [expandedChunks, setExpandedChunks] = useState<Set<number>>(new Set());

  useEffect(() => {
    if (!isOpen) {
      setResult(null);
      setExpandedChunks(new Set());
    }
  }, [isOpen]);

  const handlePreview = async () => {
    if (!doc.id) return;
    setLoading(true);
    setResult(null);
    try {
      const response = await api.kbPreviewDocumentChunking({
        id: knowledgeBaseId as unknown as number,
        docId: doc.id as unknown as number,
        requestBody: {
          strategy: strategy as unknown as object,
          chunkSize: chunkSize as unknown as object,
          chunkOverlap: chunkOverlap as unknown as object,
          parentChildMode: parentChildMode as unknown as object,
        },
      });
      if (response.data.code === 0) {
        setResult((response.data as any).data);
      } else {
        toast.error(response.data.message || '预览失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '预览请求失败');
    } finally {
      setLoading(false);
    }
  };

  const toggleChunk = (index: number) => {
    setExpandedChunks(prev => {
      const next = new Set(prev);
      if (next.has(index)) next.delete(index);
      else next.add(index);
      return next;
    });
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-4xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-white dark:bg-gray-900 flex items-center justify-center border border-gray-200 dark:border-gray-700 shadow-sm">
              <Scissors size={20} className="text-accent-600 dark:text-accent-400" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-gray-900 dark:text-white">切分预览</h2>
              <p className="text-sm text-gray-500 dark:text-gray-400 truncate max-w-[400px]">{doc.name}</p>
            </div>
          </div>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all">
            <X size={20} />
          </button>
        </div>

        {/* Config Bar */}
        <div className="p-4 border-b border-gray-100 dark:border-gray-800 space-y-3">
          <div className="flex flex-wrap items-end gap-3">
            <div className="flex-1 min-w-[140px]">
              <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">切分策略</label>
              <select
                value={strategy}
                onChange={(e) => setStrategy(e.target.value)}
                className="w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all cursor-pointer"
              >
                {Object.entries(CHUNK_STRATEGY_MAP).map(([key, cfg]) => (
                  <option key={key} value={key}>{cfg.label}</option>
                ))}
              </select>
            </div>
            <div className="w-24">
              <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">块大小</label>
              <input
                type="number"
                value={chunkSize}
                onChange={(e) => setChunkSize(Math.max(100, Number(e.target.value)))}
                className="w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                min={100}
                max={5000}
              />
            </div>
            <div className="w-24">
              <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">重叠</label>
              <input
                type="number"
                value={chunkOverlap}
                onChange={(e) => setChunkOverlap(Math.max(0, Number(e.target.value)))}
                className="w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                min={0}
                max={1000}
              />
            </div>
            <label className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-400 cursor-pointer select-none">
              <button type="button" onClick={() => setParentChildMode(!parentChildMode)} className="flex-shrink-0">
                {parentChildMode
                  ? <ToggleRight size={28} className="text-brand-500" />
                  : <ToggleLeft size={28} className="text-gray-300 dark:text-gray-600" />
                }
              </button>
              <span className="text-xs">父子模式</span>
            </label>
            <button
              onClick={handlePreview}
              disabled={loading}
              className="px-5 py-2 bg-brand-600 text-white rounded-lg text-sm font-bold hover:bg-brand-700 disabled:opacity-50 shadow-lg shadow-brand-600/20 transition-all active:scale-95 flex items-center gap-2"
            >
              {loading ? <Loader2 size={14} className="animate-spin" /> : <Eye size={14} />}
              {loading ? '预览中...' : '预览'}
            </button>
          </div>
        </div>

        {/* Results */}
        <div className="flex-1 overflow-y-auto p-6">
          {result ? (
            <div className="space-y-4">
              {/* Stats */}
              <div className="flex items-center gap-4 px-4 py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-gray-100 dark:border-gray-800 text-sm">
                <span className="text-gray-500">策略 <b className="text-gray-900 dark:text-white">{CHUNK_STRATEGY_MAP[result.strategy]?.label || result.strategy}</b></span>
                <span className="text-gray-500">总计 <b className="text-gray-900 dark:text-white">{result.totalChunks}</b> 块</span>
                {result.parentChunks > 0 && (
                  <>
                    <span className="text-gray-500">父块 <b className="text-brand-600 dark:text-brand-400">{result.parentChunks}</b></span>
                    <span className="text-gray-500">子块 <b className="text-accent-600 dark:text-accent-400">{result.childChunks}</b></span>
                  </>
                )}
                <span className="text-gray-500">平均 <b className="text-gray-900 dark:text-white">{result.avgChunkSize}</b> 字符</span>
              </div>

              {/* Chunk List */}
              <div className="space-y-2">
                {result.chunks.map((chunk) => {
                  const expanded = expandedChunks.has(chunk.index);
                  const isParent = chunk.isParent;
                  return (
                    <div
                      key={chunk.index}
                      className={`rounded-xl border overflow-hidden transition-colors ${
                        isParent
                          ? 'border-brand-200 dark:border-brand-800 bg-brand-50/30 dark:bg-brand-900/10'
                          : 'border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900'
                      }`}
                    >
                      <div
                        className="flex items-center justify-between px-4 py-2.5 cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors"
                        onClick={() => toggleChunk(chunk.index)}
                      >
                        <div className="flex items-center gap-2.5">
                          <span className={`w-7 h-7 flex items-center justify-center rounded-lg text-xs font-bold ${
                            isParent
                              ? 'bg-brand-100 dark:bg-brand-900/30 text-brand-600'
                              : 'bg-gray-100 dark:bg-gray-800 text-gray-500'
                          }`}>
                            {chunk.index + 1}
                          </span>
                          {isParent && (
                            <span className="px-1.5 py-0.5 rounded text-[10px] font-bold bg-brand-100 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 border border-brand-200 dark:border-brand-800">
                              父块
                            </span>
                          )}
                          {chunk.parentIndex !== null && !isParent && (
                            <span className="px-1.5 py-0.5 rounded text-[10px] font-bold bg-accent-100 dark:bg-accent-900/30 text-accent-600 dark:text-accent-400 border border-accent-200 dark:border-accent-800">
                              子块 → #{chunk.parentIndex + 1}
                            </span>
                          )}
                          {chunk.sectionTitle && (
                            <span className="text-xs text-gray-500 dark:text-gray-400 truncate max-w-[200px]">{chunk.sectionTitle}</span>
                          )}
                          <span className="text-xs text-gray-400">{chunk.charCount} 字符</span>
                        </div>
                        {expanded ? <ChevronUp size={14} className="text-gray-400" /> : <ChevronDown size={14} className="text-gray-400" />}
                      </div>
                      {expanded && (
                        <div className="px-4 pb-3 border-t border-gray-100 dark:border-gray-800">
                          <pre className="mt-2 text-sm text-gray-700 dark:text-gray-300 whitespace-pre-wrap font-sans leading-relaxed bg-gray-50 dark:bg-gray-800/30 rounded-lg p-3 max-h-48 overflow-y-auto">
                            {chunk.content}
                          </pre>
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </div>
          ) : !loading ? (
            <div className="text-center py-12">
              <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
                <Scissors size={28} className="text-gray-300" />
              </div>
              <p className="text-gray-500 font-medium">选择切分参数后点击预览</p>
              <p className="text-gray-400 text-sm mt-1">预览不同切分策略对文档的切分效果</p>
            </div>
          ) : null}
        </div>
      </div>
    </div>
  );
};

// ==================== 召回测试弹窗 ====================
interface RecallChunk {
  index: number;
  score: number;
  documentId: number;
  documentName: string | null;
  content: string;
  chunkIndex: number | null;
  metadata: Record<string, unknown> | null;
}

interface RecallTestResult {
  query: string;
  retrievalMode: string;
  enableQueryRewrite: boolean;
  useDynamicTopK: boolean;
  topK: number;
  defaultTopK: number;
  similarityThreshold: number;
  totalResults: number;
  searchTimeMs: number;
  chunks: RecallChunk[];
}

interface RecallTestModalProps {
  isOpen: boolean;
  onClose: () => void;
  knowledgeBase: KnowledgeBaseVO | null;
}

const RecallTestModal: React.FC<RecallTestModalProps> = ({ isOpen, onClose, knowledgeBase }) => {
  const [query, setQuery] = useState('');
  const [topK, setTopK] = useState(5);
  const [threshold, setThreshold] = useState(0.3);
  const [retrievalMode, setRetrievalMode] = useState('HYBRID_RERANK');
  const [enableQueryRewrite, setEnableQueryRewrite] = useState(false);
  const [useDynamicTopK, setUseDynamicTopK] = useState(true);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<RecallTestResult | null>(null);
  const [expandedChunks, setExpandedChunks] = useState<Set<number>>(new Set());
  const [showAdvanced, setShowAdvanced] = useState(false);

  useEffect(() => {
    if (isOpen && knowledgeBase) {
      setRetrievalMode(knowledgeBase.retrievalMode || 'HYBRID_RERANK');
      setEnableQueryRewrite(knowledgeBase.enableQueryRewrite ?? false);
      setUseDynamicTopK(knowledgeBase.useDynamicTopK ?? true);
      setTopK(knowledgeBase.defaultTopK ?? 5);
    }
    if (!isOpen) {
      setResult(null);
      setExpandedChunks(new Set());
    }
  }, [isOpen, knowledgeBase]);

  const handleTest = async () => {
    if (!knowledgeBase?.id || !query.trim()) return;
    setLoading(true);
    setResult(null);
    try {
      const response = await api.kbRecallTest({
        id: knowledgeBase.id as unknown as number,
        requestBody: {
          query: query.trim(),
          topK: useDynamicTopK ? undefined : topK,
          similarityThreshold: threshold,
          retrievalMode,
          enableQueryRewrite,
          useDynamicTopK,
          defaultTopK: topK,
        } as any,
      });
      if (response.data.code === 0) {
        setResult((response.data as any).data);
      } else {
        toast.error(response.data.message || '召回测试失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '召回测试请求失败');
    } finally {
      setLoading(false);
    }
  };

  const toggleChunk = (index: number) => {
    setExpandedChunks(prev => {
      const next = new Set(prev);
      if (next.has(index)) next.delete(index);
      else next.add(index);
      return next;
    });
  };

  const getScoreColor = (score: number) => {
    if (score >= 0.8) return 'text-green-600 bg-green-50 border-green-200 dark:text-green-400 dark:bg-green-900/20 dark:border-green-800';
    if (score >= 0.6) return 'text-blue-600 bg-blue-50 border-blue-200 dark:text-blue-400 dark:bg-blue-900/20 dark:border-blue-800';
    if (score >= 0.4) return 'text-amber-600 bg-amber-50 border-amber-200 dark:text-amber-400 dark:bg-amber-900/20 dark:border-amber-800';
    return 'text-red-600 bg-red-50 border-red-200 dark:text-red-400 dark:bg-red-900/20 dark:border-red-800';
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-white dark:bg-gray-900 flex items-center justify-center border border-gray-200 dark:border-gray-700 shadow-sm">
              <SearchCheck size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-gray-900 dark:text-white">召回测试</h2>
              <p className="text-sm text-gray-500 dark:text-gray-400">{knowledgeBase?.name}</p>
            </div>
          </div>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all">
            <X size={20} />
          </button>
        </div>

        {/* Query Input */}
        <div className="p-6 space-y-4 border-b border-gray-100 dark:border-gray-800">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">查询文本</label>
            <textarea
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="输入要测试的查询文本..."
              rows={3}
              className="w-full px-4 py-3 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none focus:border-brand-500/50 focus:ring-2 focus:ring-brand-500/20 transition-all resize-none"
              onKeyDown={(e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                  e.preventDefault();
                  handleTest();
                }
              }}
            />
          </div>

          {/* RAG Config */}
          <div className="space-y-3">
            {/* Retrieval Mode */}
            <div className="flex items-center gap-2">
              {Object.entries(RETRIEVAL_MODE_MAP).map(([key, cfg]) => {
                const Icon = cfg.icon;
                const sel = retrievalMode === key;
                return (
                  <button
                    key={key}
                    type="button"
                    onClick={() => setRetrievalMode(key)}
                    className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium border transition-all ${
                      sel
                        ? 'border-accent-500 bg-accent-50 dark:bg-accent-900/20 text-accent-700 dark:text-accent-400'
                        : 'border-gray-200 dark:border-gray-700 text-gray-500 hover:border-gray-300'
                    }`}
                  >
                    <Icon size={13} className={sel ? 'text-accent-500' : 'text-gray-400'} />
                    {cfg.label}
                  </button>
                );
              })}
            </div>

            {/* Toggles row */}
            <div className="flex items-center gap-4">
              <button
                type="button"
                onClick={() => setEnableQueryRewrite(!enableQueryRewrite)}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium border transition-all ${
                  enableQueryRewrite
                    ? 'border-amber-400 bg-amber-50 dark:bg-amber-900/20 text-amber-700 dark:text-amber-400'
                    : 'border-gray-200 dark:border-gray-700 text-gray-500 hover:border-gray-300'
                }`}
              >
                <Sparkles size={12} />
                Query 改写 {enableQueryRewrite ? '开' : '关'}
              </button>
              <button
                type="button"
                onClick={() => setUseDynamicTopK(!useDynamicTopK)}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium border transition-all ${
                  useDynamicTopK
                    ? 'border-blue-400 bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-400'
                    : 'border-gray-200 dark:border-gray-700 text-gray-500 hover:border-gray-300'
                }`}
              >
                <SlidersHorizontal size={12} />
                动态 TopK {useDynamicTopK ? '开' : '关'}
              </button>
            </div>

            {/* Advanced: topK + threshold */}
            <div>
              <button
                onClick={() => setShowAdvanced(!showAdvanced)}
                className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 transition-colors"
              >
                <Settings2 size={14} />
                <span>更多参数</span>
                {showAdvanced ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
              </button>
              {showAdvanced && (
                <div className="mt-3 grid grid-cols-2 gap-4">
                  {!useDynamicTopK && (
                    <div>
                      <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">固定 TopK</label>
                      <input
                        type="number"
                        value={topK}
                        onChange={(e) => setTopK(Math.max(1, Math.min(20, Number(e.target.value))))}
                        min={1}
                        max={20}
                        className="w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                      />
                    </div>
                  )}
                  <div>
                    <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">相似度阈值</label>
                    <input
                      type="number"
                      value={threshold}
                      onChange={(e) => setThreshold(Math.max(0, Math.min(1, Number(e.target.value))))}
                      min={0}
                      max={1}
                      step={0.05}
                      className="w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                    />
                  </div>
                </div>
              )}
            </div>
          </div>

          <button
            onClick={handleTest}
            disabled={loading || !query.trim()}
            className="w-full flex items-center justify-center gap-2 px-4 py-2.5 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-brand-600/20 transition-all active:scale-[0.98]"
          >
            {loading ? <Loader2 size={16} className="animate-spin" /> : <SearchCheck size={16} />}
            <span>{loading ? '检索中...' : '开始召回测试'}</span>
          </button>
        </div>

        {/* Results */}
        <div className="flex-1 overflow-y-auto p-6">
          {result ? (
            <div className="space-y-4">
              {/* Stats Bar */}
              <div className="px-4 py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-gray-100 dark:border-gray-800 space-y-1">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-4 text-sm">
                    <span className="text-gray-500">召回 <b className="text-gray-900 dark:text-white">{result.totalResults}</b> 条</span>
                    <span className="text-gray-500">耗时 <b className="text-gray-900 dark:text-white">{result.searchTimeMs}</b>ms</span>
                  </div>
                  <span className="text-xs text-gray-400">TopK={result.topK} · 阈值={result.similarityThreshold}</span>
                </div>
                <div className="flex items-center gap-2 flex-wrap">
                  <span className="px-2 py-0.5 rounded text-[10px] font-medium bg-accent-50 text-accent-600 dark:bg-accent-900/20 dark:text-accent-400 border border-accent-200 dark:border-accent-800">
                    {RETRIEVAL_MODE_MAP[result.retrievalMode]?.label || result.retrievalMode}
                  </span>
                  {result.enableQueryRewrite && (
                    <span className="px-2 py-0.5 rounded text-[10px] font-medium bg-amber-50 text-amber-600 dark:bg-amber-900/20 dark:text-amber-400 border border-amber-200 dark:border-amber-800">
                      Query 改写
                    </span>
                  )}
                  <span className="px-2 py-0.5 rounded text-[10px] font-medium bg-blue-50 text-blue-600 dark:bg-blue-900/20 dark:text-blue-400 border border-blue-200 dark:border-blue-800">
                    {result.useDynamicTopK ? '动态TopK' : `固定TopK=${result.defaultTopK}`}
                  </span>
                </div>
              </div>

              {/* Chunks */}
              {result.chunks.length > 0 ? (
                <div className="space-y-3">
                  {result.chunks.map((chunk) => {
                    const expanded = expandedChunks.has(chunk.index);
                    return (
                      <div
                        key={chunk.index}
                        className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-700 overflow-hidden hover:border-brand-300 dark:hover:border-brand-700 transition-colors"
                      >
                        {/* Chunk Header */}
                        <div
                          className="flex items-center justify-between px-4 py-3 cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors"
                          onClick={() => toggleChunk(chunk.index)}
                        >
                          <div className="flex items-center gap-3">
                            <span className="w-7 h-7 flex items-center justify-center rounded-lg bg-gray-100 dark:bg-gray-800 text-xs font-bold text-gray-500">
                              {chunk.index}
                            </span>
                            <span className={`px-2 py-0.5 rounded-md text-xs font-bold border ${getScoreColor(chunk.score)}`}>
                              {(chunk.score * 100).toFixed(1)}%
                            </span>
                            <span className="text-sm text-gray-500 dark:text-gray-400 truncate max-w-[300px]">
                              {chunk.documentName || `文档 #${String(chunk.documentId)}`}
                            </span>
                          </div>
                          {expanded ? <ChevronUp size={16} className="text-gray-400" /> : <ChevronDown size={16} className="text-gray-400" />}
                        </div>

                        {/* Chunk Content (expandable) */}
                        {expanded && (
                          <div className="px-4 pb-4 border-t border-gray-100 dark:border-gray-800">
                            <pre className="mt-3 text-sm text-gray-700 dark:text-gray-300 whitespace-pre-wrap font-sans leading-relaxed bg-gray-50 dark:bg-gray-800/30 rounded-lg p-4 max-h-64 overflow-y-auto">
                              {chunk.content}
                            </pre>
                            {chunk.metadata && Object.keys(chunk.metadata).length > 0 && (
                              <div className="mt-2 text-xs text-gray-400">
                                <span className="font-medium">元数据：</span>
                                {JSON.stringify(chunk.metadata)}
                              </div>
                            )}
                          </div>
                        )}
                      </div>
                    );
                  })}
                </div>
              ) : (
                <div className="text-center py-12">
                  <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
                    <Search size={28} className="text-gray-300" />
                  </div>
                  <p className="text-gray-500 font-medium">未找到相关内容</p>
                  <p className="text-gray-400 text-sm mt-1">尝试调整查询文本或降低相似度阈值</p>
                </div>
              )}
            </div>
          ) : !loading ? (
            <div className="text-center py-12">
              <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
                <SearchCheck size={28} className="text-gray-300" />
              </div>
              <p className="text-gray-500 font-medium">输入查询文本开始测试</p>
              <p className="text-gray-400 text-sm mt-1">测试多路召回 + RRF融合 + Rerank精排效果</p>
            </div>
          ) : null}
        </div>
      </div>
    </div>
  );
};

// ==================== 主页面 ====================
export const KnowledgeBaseManagementPage: React.FC = () => {
  const [knowledgeBases, setKnowledgeBases] = useState<KnowledgeBaseVO[]>([]);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingKB, setEditingKB] = useState<KnowledgeBaseVO | null>(null);
  const [selectedKB, setSelectedKB] = useState<KnowledgeBaseVO | null>(null);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [page, setPage] = useState(0);
  const [recallTestKB, setRecallTestKB] = useState<KnowledgeBaseVO | null>(null);

  const fetchKnowledgeBases = useCallback(async () => {
    setLoading(true);
    try {
      const userId = getCurrentUserId();
      let response;
      if (searchKeyword.trim()) {
        response = await api.kbSearch({ keyword: searchKeyword, userId, page, size: 20 });
      } else {
        response = await api.kbListByCreator({ userId, page, size: 20 });
      }
      if (response.data.code === 0) {
        setKnowledgeBases(response.data.data || []);
      } else {
        toast.error(response.data.message || '获取知识库列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [searchKeyword, page]);

  useEffect(() => {
    fetchKnowledgeBases();
  }, [fetchKnowledgeBases]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(0);
    fetchKnowledgeBases();
  };

  const handleDelete = async (kb: KnowledgeBaseVO) => {
    if (!kb.id) return;
    if (!window.confirm(`确定要删除知识库 "${kb.name}" 吗？\n将同时删除所有文档和向量数据，此操作不可恢复。`)) return;

    try {
      const response = await api.kbDelete({ id: kb.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchKnowledgeBases();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const getStatusBadge = (status?: string) => {
    const config = KB_STATUS_MAP[status || ''] || KB_STATUS_MAP.ACTIVE;
    return (
      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${config.color}`}>
        {config.label}
      </span>
    );
  };

  // 如果选中了某个知识库，显示文档面板
  if (selectedKB) {
    return (
      <DocumentPanel
        knowledgeBase={selectedKB}
        onBack={() => { setSelectedKB(null); fetchKnowledgeBases(); }}
      />
    );
  }

  return (
    <div className="space-y-6">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">知识库管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理AI知识库，上传文档并进行向量化处理</p>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => { setEditingKB(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>新建知识库</span>
          </button>
        </div>
      </div>

      {/* Search Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm">
        <form onSubmit={handleSearch} className="flex gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text"
              placeholder="搜索知识库名称..."
              value={searchKeyword}
              onChange={(e) => setSearchKeyword(e.target.value)}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <button
            type="button"
            onClick={() => fetchKnowledgeBases()}
            className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
          >
            <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
          </button>
        </form>
      </div>

      {/* Knowledge Base Grid */}
      {loading ? (
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 animate-pulse">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                <div className="flex-1 space-y-2">
                  <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-2/3" />
                  <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                </div>
              </div>
              <div className="space-y-2">
                <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-full" />
                <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-4/5" />
              </div>
            </div>
          ))}
        </div>
      ) : knowledgeBases.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5">
          {knowledgeBases.map((kb) => (
            <div
              key={String(kb.id)}
              className="group bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm cursor-pointer overflow-hidden"
              onClick={() => setSelectedKB(kb)}
            >
              {/* Card Header */}
              <div className="p-6 pb-4">
                <div className="flex items-start justify-between mb-3">
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 rounded-xl bg-white dark:bg-gray-900 flex items-center justify-center border border-gray-200 dark:border-gray-700 shadow-sm">
                      <Database size={22} className="text-brand-600 dark:text-brand-400" />
                    </div>
                    <div>
                      <h3 className="font-bold text-gray-900 dark:text-white line-clamp-1">
                        {kb.name}
                      </h3>
                      {getStatusBadge(kb.status)}
                    </div>
                  </div>
                  <div className="flex items-center gap-1" onClick={(e) => e.stopPropagation()}>
                    <button
                      onClick={() => setRecallTestKB(kb)}
                      className="p-1.5 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                      title="召回测试"
                    >
                      <SearchCheck size={16} />
                    </button>
                    <button
                      onClick={() => { setEditingKB(kb); setModalOpen(true); }}
                      className="p-1.5 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                      title="编辑"
                    >
                      <Edit2 size={16} />
                    </button>
                    <button
                      onClick={() => handleDelete(kb)}
                      className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                      title="删除"
                    >
                      <Trash2 size={16} />
                    </button>
                  </div>
                </div>
                <p className="text-sm text-gray-500 dark:text-gray-400 line-clamp-2 min-h-[40px]">
                  {kb.description || '暂无描述'}
                </p>
              </div>

              {/* Card Footer - Stats */}
              <div className="px-6 py-3 bg-gray-50/50 dark:bg-gray-800/30 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between text-xs text-gray-400">
                <div className="flex items-center gap-4">
                  <span className="flex items-center gap-1">
                    <FileText size={14} />
                    {kb.documentCount || 0} 文档
                  </span>
                  <span className="flex items-center gap-1">
                    <Layers size={14} />
                    {kb.chunkCount || 0} 分块
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  {kb.chunkStrategy && CHUNK_STRATEGY_MAP[kb.chunkStrategy] && (
                    <span className="flex items-center gap-1 px-1.5 py-0.5 rounded-md bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 border border-brand-100 dark:border-brand-800">
                      {React.createElement(CHUNK_STRATEGY_MAP[kb.chunkStrategy].icon, { size: 12 })}
                      {CHUNK_STRATEGY_MAP[kb.chunkStrategy].label}
                    </span>
                  )}
                  <span>{kb.chunkSize}/{kb.chunkOverlap}</span>
                </div>
              </div>

              {/* Card Footer - Time */}
              <div className="px-6 py-2.5 border-t border-gray-50 dark:border-gray-800/50 text-xs text-gray-400">
                创建于 {formatDateTime(kb.createTime)}
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-12 text-center">
          <div className="flex flex-col items-center">
            <div className="w-20 h-20 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
              <Database size={40} className="text-gray-300" />
            </div>
            <p className="text-gray-500 dark:text-gray-400 font-medium text-lg">暂无知识库</p>
            <p className="text-gray-400 text-sm mt-2">点击"新建知识库"开始创建</p>
          </div>
        </div>
      )}

      {/* Pagination */}
      {knowledgeBases.length > 0 && (
        <div className="flex items-center justify-center gap-2">
          <button
            disabled={page === 0 || loading}
            onClick={() => setPage(p => p - 1)}
            className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
          >
            <ChevronLeft size={18} />
          </button>
          <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">{page + 1}</span>
          <button
            disabled={knowledgeBases.length < 20 || loading}
            onClick={() => setPage(p => p + 1)}
            className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
          >
            <ChevronRight size={18} />
          </button>
        </div>
      )}

      {/* Knowledge Base Form Modal */}
      <KBFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingKB(null); }}
        onSuccess={fetchKnowledgeBases}
        knowledgeBase={editingKB}
      />

      {/* Recall Test Modal */}
      <RecallTestModal
        isOpen={!!recallTestKB}
        onClose={() => setRecallTestKB(null)}
        knowledgeBase={recallTestKB}
      />
    </div>
  );
};
