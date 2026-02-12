import React, { useState, useEffect, useCallback } from 'react';
import { X, Trash2, Settings2, Plus, GripVertical, Loader2, BookOpen, Sparkles, ChevronDown, ChevronRight, Eye, Image, Globe, Code2, Plug2 } from 'lucide-react';
import { useWorkflowStore } from '../store/useWorkflowStore';
import { NodeType, getNodeCategoryInfo } from '../types';
import { apiClient, DefaultApi, Configuration } from '../../../../api';

const api = new DefaultApi(new Configuration(), '', apiClient);

export const NodeConfigPanel: React.FC = () => {
  const selectedNodeId = useWorkflowStore((s) => s.selectedNodeId);
  const nodes = useWorkflowStore((s) => s.nodes);
  const selectNode = useWorkflowStore((s) => s.selectNode);
  const updateNodeLabel = useWorkflowStore((s) => s.updateNodeLabel);
  const updateNodeConfig = useWorkflowStore((s) => s.updateNodeConfig);
  const deleteNode = useWorkflowStore((s) => s.deleteNode);

  const node = nodes.find((n) => n.id === selectedNodeId);
  const nodeData = node?.data;
  const catInfo = nodeData ? getNodeCategoryInfo(nodeData.nodeType) : null;

  const [label, setLabel] = useState('');

  useEffect(() => {
    if (nodeData) setLabel(nodeData.label);
  }, [nodeData]);

  if (!node || !nodeData) return null;

  const handleLabelBlur = () => {
    if (label.trim() && label !== nodeData.label) {
      updateNodeLabel(node.id, label.trim());
    }
  };

  const handleDelete = () => {
    if (window.confirm(`确定删除节点「${nodeData.label}」？`)) {
      deleteNode(node.id);
    }
  };

  return (
    <div className="w-80 bg-white dark:bg-gray-900 border-l border-gray-100 dark:border-gray-800 flex flex-col h-full overflow-hidden shadow-sm animate-in slide-in-from-right-5 duration-200 transition-colors">
      {/* Header */}
      <div className="flex items-center justify-between px-4 py-3.5 border-b border-gray-100 dark:border-gray-800">
        <div className="flex items-center gap-2">
          <Settings2 size={16} className="text-brand-500" />
          <span className="text-sm font-bold text-gray-900 dark:text-white">节点配置</span>
        </div>
        <button onClick={() => selectNode(null)} className="p-1.5 text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
          <X size={16} />
        </button>
      </div>

      {/* Content */}
      <div className="flex-1 overflow-y-auto custom-scrollbar p-4 space-y-5">
        {/* 节点类型标签 */}
        <div className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg text-xs font-bold border ${catInfo?.category?.bgColor || 'bg-gray-50'} ${catInfo?.category?.darkBgColor || ''} ${catInfo?.category?.borderColor || 'border-gray-200'} ${catInfo?.category?.darkBorderColor || ''} ${catInfo?.category?.color || 'text-gray-500'}`}>
          {React.createElement(nodeData.icon, { size: 14 })}
          <span>{catInfo?.label || nodeData.nodeType}</span>
        </div>

        {/* 名称 */}
        <div>
          <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">节点名称</label>
          <input
            type="text"
            value={label}
            onChange={(e) => setLabel(e.target.value)}
            onBlur={handleLabelBlur}
            className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
          />
        </div>

        {/* 节点 ID */}
        <div>
          <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">节点 ID</label>
          <p className="text-xs text-gray-400 dark:text-gray-500 font-mono bg-gray-50 dark:bg-gray-800/50 px-4 py-2.5 rounded-xl border border-gray-200 dark:border-gray-700 select-all">{node.id}</p>
        </div>

        {/* 基于节点类型的配置区 */}
        <div className="border-t border-gray-100 dark:border-gray-800 pt-4">
          <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">参数配置</h4>
          {renderNodeConfig(nodeData.nodeType, nodeData.config, (cfg) => updateNodeConfig(node.id, cfg))}
        </div>
      </div>

      {/* Footer */}
      <div className="p-4 border-t border-gray-100 dark:border-gray-800">
        <button onClick={handleDelete} className="w-full flex items-center justify-center gap-2 px-4 py-2.5 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-xl text-sm font-bold hover:bg-red-100 dark:hover:bg-red-900/30 border border-red-200 dark:border-red-800 transition-all active:scale-95">
          <Trash2 size={16} />
          删除节点
        </button>
      </div>
    </div>
  );
};

// 根据不同节点类型渲染配置表单
function renderNodeConfig(
  nodeType: NodeType,
  config: Record<string, unknown>,
  onUpdate: (cfg: Record<string, unknown>) => void
) {
  switch (nodeType) {
    case NodeType.START:
      return <StartConfig config={config} onUpdate={onUpdate} />;
    case NodeType.END:
      return <EndConfig config={config} onUpdate={onUpdate} />;
    case NodeType.LLM:
      return <LLMConfig config={config} onUpdate={onUpdate} />;
    case NodeType.INTENT_RECOGNITION:
      return <IntentRecognitionConfig config={config} onUpdate={onUpdate} />;
    case NodeType.ENTITY_EXTRACTION:
      return <EntityExtractionConfig config={config} onUpdate={onUpdate} />;
    case NodeType.CONDITION:
      return <ConditionConfig config={config} onUpdate={onUpdate} />;
    case NodeType.SWITCH:
      return <SwitchConfig config={config} onUpdate={onUpdate} />;
    case NodeType.LOOP:
      return <LoopConfig config={config} onUpdate={onUpdate} />;
    case NodeType.PARALLEL:
      return <ParallelConfig config={config} onUpdate={onUpdate} />;
    case NodeType.MERGE:
      return <MergeConfig config={config} onUpdate={onUpdate} />;
    case NodeType.VARIABLE_SET:
      return <VariableSetConfig config={config} onUpdate={onUpdate} />;
    case NodeType.VARIABLE_GET:
      return <VariableGetConfig config={config} onUpdate={onUpdate} />;
    case NodeType.JSON_PARSE:
      return <JsonParseConfig config={config} onUpdate={onUpdate} />;
    case NodeType.HTTP_REQUEST:
      return <HttpRequestConfig config={config} onUpdate={onUpdate} />;
    case NodeType.CODE:
      return <CodeConfig config={config} onUpdate={onUpdate} />;
    case NodeType.TEMPLATE:
      return <TemplateConfig config={config} onUpdate={onUpdate} />;
    case NodeType.DATABASE_QUERY:
      return <DatabaseQueryConfig config={config} onUpdate={onUpdate} />;
    case NodeType.FILE_READ:
      return <FileReadConfig config={config} onUpdate={onUpdate} />;
    case NodeType.FILE_WRITE:
      return <FileWriteConfig config={config} onUpdate={onUpdate} />;
    default:
      return <GenericConfig config={config} onUpdate={onUpdate} />;
  }
}

// 通用配置字段组件
const ConfigField: React.FC<{ label: string; children: React.ReactNode }> = ({ label, children }) => (
  <div className="space-y-1.5">
    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">{label}</label>
    {children}
  </div>
);

// 统一自定义 Checkbox 组件（替代原生 <input type="checkbox">，样式与 LLM 节点一致）
const ConfigCheckbox: React.FC<{
  checked: boolean;
  onChange: (checked: boolean) => void;
  label: string;
  size?: 'sm' | 'md';
  className?: string;
}> = ({ checked, onChange, label, size = 'md', className = '' }) => {
  const boxSize = size === 'sm' ? 'w-3.5 h-3.5' : 'w-4 h-4';
  const iconSize = size === 'sm' ? 'w-2 h-2' : 'w-2.5 h-2.5';
  const textSize = size === 'sm' ? 'text-[10px]' : 'text-xs';
  return (
    <div onClick={() => onChange(!checked)} role="checkbox" aria-checked={checked}
      className={`flex items-center gap-2.5 cursor-pointer group ${className}`}>
      <div className={`flex-shrink-0 ${boxSize} rounded-md border-2 flex items-center justify-center transition-all ${
        checked
          ? 'bg-brand-500 border-brand-500 dark:bg-brand-600 dark:border-brand-600'
          : 'border-gray-300 dark:border-gray-600 group-hover:border-brand-300 dark:group-hover:border-brand-700'
      }`}>
        {checked && (
          <svg className={`${iconSize} text-white`} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3.5}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
          </svg>
        )}
      </div>
      <span className={`${textSize} text-gray-600 dark:text-gray-400 select-none`}>{label}</span>
    </div>
  );
};

const inputClass = 'w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all';
const selectClass = 'w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer';
const textareaClass = 'w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none font-mono';

// ===== 开始节点配置 =====
interface InputParam {
  name: string;
  type: string;
  description: string;
  required: boolean;
  defaultValue: string;
}

const PARAM_TYPES = [
  { value: 'STRING', label: 'String' },
  { value: 'NUMBER', label: 'Number' },
  { value: 'BOOLEAN', label: 'Boolean' },
  { value: 'OBJECT', label: 'Object' },
  { value: 'ARRAY', label: 'Array' },
];

const StartConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const params = ((config.inputParameters as InputParam[]) || []);

  const addParam = () => {
    const newParam: InputParam = { name: '', type: 'STRING', description: '', required: false, defaultValue: '' };
    onUpdate({ inputParameters: [...params, newParam] });
  };

  const updateParam = (index: number, field: keyof InputParam, value: unknown) => {
    const updated = params.map((p, i) => i === index ? { ...p, [field]: value } : p);
    onUpdate({ inputParameters: updated });
  };

  const removeParam = (index: number) => {
    onUpdate({ inputParameters: params.filter((_, i) => i !== index) });
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">输入参数</label>
        <button onClick={addParam} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
          <Plus size={14} /> 添加
        </button>
      </div>

      {params.length === 0 && (
        <p className="text-xs text-gray-400 dark:text-gray-500 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">暂无输入参数，点击"添加"定义参数</p>
      )}

      {params.map((param, idx) => (
        <div key={idx} className="p-3 bg-gray-50 dark:bg-gray-800/30 rounded-xl border border-gray-200 dark:border-gray-700 space-y-2.5">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-1.5">
              <GripVertical size={12} className="text-gray-300 dark:text-gray-600" />
              <span className="text-xs font-bold text-gray-500 dark:text-gray-400">参数 {idx + 1}</span>
            </div>
            <button onClick={() => removeParam(idx)} className="p-1 text-gray-400 hover:text-red-500 rounded transition-colors">
              <Trash2 size={13} />
            </button>
          </div>
          <div className="grid grid-cols-2 gap-2">
            <input
              type="text" placeholder="参数名" value={param.name}
              onChange={(e) => updateParam(idx, 'name', e.target.value)}
              className={inputClass}
            />
            <select value={param.type} onChange={(e) => updateParam(idx, 'type', e.target.value)} className={selectClass}>
              {PARAM_TYPES.map((t) => <option key={t.value} value={t.value}>{t.label}</option>)}
            </select>
          </div>
          <input
            type="text" placeholder="参数描述（可选）" value={param.description}
            onChange={(e) => updateParam(idx, 'description', e.target.value)}
            className={inputClass}
          />
          <div className="flex items-center gap-4">
            <ConfigCheckbox checked={param.required} onChange={(v) => updateParam(idx, 'required', v)} label="必填" size="sm" />
            <input
              type="text" placeholder="默认值" value={param.defaultValue || ''}
              onChange={(e) => updateParam(idx, 'defaultValue', e.target.value)}
              className={`${inputClass} flex-1`}
            />
          </div>
        </div>
      ))}

      <ConfigField label="校验输入">
        <ConfigCheckbox checked={(config.validateInput as boolean) || false}
          onChange={(v) => onUpdate({ validateInput: v })}
          label="执行时校验输入参数类型和必填" />
      </ConfigField>
    </div>
  );
};

// ===== 结束节点配置 =====
interface OutputVar {
  name: string;
  sourceVariable: string;
}

const EndConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();

  const vars = ((config.outputVariables as OutputVar[]) || []);

  const addVar = () => {
    onUpdate({ outputVariables: [...vars, { name: '', sourceVariable: '' }] });
  };

  const updateVar = (index: number, field: keyof OutputVar, value: string) => {
    const updated = vars.map((v, i) => i === index ? { ...v, [field]: value } : v);
    onUpdate({ outputVariables: updated });
  };

  const removeVar = (index: number) => {
    onUpdate({ outputVariables: vars.filter((_, i) => i !== index) });
  };

  // 快速添加上游变量（去重）
  const quickAdd = (varValue: string) => {
    const exists = vars.some((v) => v.sourceVariable === varValue);
    if (!exists) {
      onUpdate({ outputVariables: [...vars, { name: varValue, sourceVariable: varValue }] });
    }
  };

  // 一键添加全部
  const addAll = () => {
    const existing = new Set(vars.map((v) => v.sourceVariable));
    const newVars = upstreamVars
      .filter((v) => !existing.has(v.value))
      .map((v) => ({ name: v.value, sourceVariable: v.value }));
    if (newVars.length > 0) {
      onUpdate({ outputVariables: [...vars, ...newVars] });
    }
  };

  return (
    <div className="space-y-4">
      {/* 上游可用变量面板 */}
      {upstreamVars.length > 0 && (
        <div className="space-y-2">
          <div className="flex items-center justify-between">
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">可用上游变量</label>
            <button onClick={addAll} className="px-2 py-1 text-[10px] font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
              全部添加
            </button>
          </div>
          <div className="flex flex-wrap gap-1.5 p-3 bg-gray-50 dark:bg-gray-800/30 rounded-xl border border-gray-200 dark:border-gray-700 max-h-36 overflow-y-auto">
            {upstreamVars.map((v, i) => {
              const added = vars.some((ov) => ov.sourceVariable === v.value);
              return (
                <button key={i} onClick={() => !added && quickAdd(v.value)} disabled={added}
                  className={`px-2 py-1 text-[11px] rounded-lg border transition-all font-mono ${
                    added
                      ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-400 dark:text-brand-500 border-brand-200 dark:border-brand-800 opacity-60 cursor-default'
                      : 'bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border-gray-200 dark:border-gray-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 hover:border-brand-300 dark:hover:border-brand-700 hover:text-brand-600 dark:hover:text-brand-400 cursor-pointer'
                  }`}
                  title={`来自: ${v.from}`}>
                  {added ? '✓ ' : '+ '}{v.value}
                  <span className="ml-1 text-[9px] text-gray-400 font-normal">{v.from}</span>
                </button>
              );
            })}
          </div>
        </div>
      )}

      {/* 已选输出变量 */}
      <div className="flex items-center justify-between">
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">输出变量映射</label>
        <button onClick={addVar} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
          <Plus size={14} /> 手动添加
        </button>
      </div>

      {vars.length === 0 && (
        <p className="text-xs text-gray-400 dark:text-gray-500 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">
          未指定输出变量时，将<strong>透传所有上下文变量</strong>（包含起始节点参数和所有中间节点产出）
        </p>
      )}

      {vars.map((v, idx) => (
        <div key={idx} className="flex items-center gap-2">
          <input type="text" placeholder="输出名（API 返回字段名）" value={v.name} onChange={(e) => updateVar(idx, 'name', e.target.value)} className={`${inputClass} flex-1`} />
          <span className="text-xs text-gray-400 flex-shrink-0">&larr;</span>
          {upstreamVars.length > 0 ? (
            <select value={v.sourceVariable} onChange={(e) => updateVar(idx, 'sourceVariable', e.target.value)} className={`${selectClass} flex-1`}>
              <option value="">选择来源变量</option>
              {upstreamVars.map((uv, ui) => <option key={ui} value={uv.value}>{uv.label}</option>)}
              {v.sourceVariable && !upstreamVars.some((uv) => uv.value === v.sourceVariable) && (
                <option value={v.sourceVariable}>{v.sourceVariable} (自定义)</option>
              )}
            </select>
          ) : (
            <input type="text" placeholder="来源变量" value={v.sourceVariable} onChange={(e) => updateVar(idx, 'sourceVariable', e.target.value)} className={`${inputClass} flex-1`} />
          )}
          <button onClick={() => removeVar(idx)} className="p-1.5 text-gray-400 hover:text-red-500 rounded transition-colors flex-shrink-0">
            <Trash2 size={14} />
          </button>
        </div>
      ))}

      <p className="text-xs text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-800/50 rounded-lg px-3 py-2 border border-gray-200 dark:border-gray-700">
        结束节点可获取整条链路上所有节点产出的变量。点击上方变量快速添加，或手动指定映射。未配置时自动透传全部。
      </p>
    </div>
  );
};

// ===== LLM 配置 =====
interface ModelInfo {
  modelId: string;
  provider: string;
  model: string;
  type: string;
  enabled: boolean;
  isDefault: boolean;
  isDefaultVision: boolean;
}

interface KbInfo {
  id: string; // 雪花ID，运行时为string
  name: string;
  description?: string;
  documentCount?: number;
}

interface InputMapping {
  variableName: string;
  mappedKey: string;
}

// 可选 AI 能力定义
const AI_CAPABILITIES = [
  { key: 'vision', label: '视觉理解', icon: Eye, desc: '支持图片输入分析' },
  { key: 'text2image', label: '文生图', icon: Image, desc: '根据文本生成图片' },
  { key: 'webSearch', label: '联网搜索', icon: Globe, desc: '实时联网检索信息' },
  { key: 'codeInterpreter', label: '代码解释器', icon: Code2, desc: '运行代码并返回结果' },
] as const;

// 可折叠分区
const Section: React.FC<{ title: string; icon: React.ReactNode; defaultOpen?: boolean; children: React.ReactNode }> = ({ title, icon, defaultOpen = false, children }) => {
  const [open, setOpen] = useState(defaultOpen);
  return (
    <div className="border border-gray-200 dark:border-gray-700 rounded-xl overflow-hidden">
      <button onClick={() => setOpen(!open)} className="w-full flex items-center gap-2 px-3 py-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors text-left">
        {open ? <ChevronDown size={14} className="text-gray-400" /> : <ChevronRight size={14} className="text-gray-400" />}
        <span className="flex items-center gap-1.5 text-xs font-bold text-gray-700 dark:text-gray-300">{icon}{title}</span>
      </button>
      {open && <div className="p-3 space-y-3 border-t border-gray-200 dark:border-gray-700">{children}</div>}
    </div>
  );
};

const LLMConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const [models, setModels] = useState<ModelInfo[]>([]);
  const [loadingModels, setLoadingModels] = useState(true);
  const [knowledgeBases, setKnowledgeBases] = useState<KbInfo[]>([]);
  const [loadingKb, setLoadingKb] = useState(false);
  const [mcpServerList, setMcpServerList] = useState<Array<{ id: string; name: string; url: string; enabled: boolean }>>([]);
  const [loadingMcp, setLoadingMcp] = useState(false);
  const upstreamVars = useUpstreamVars();

  // 加载模型列表
  useEffect(() => {
    let cancelled = false;
    api.listAvailableModels().then((res) => {
      if (cancelled) return;
      const list = (res.data as any)?.data as ModelInfo[] | undefined;
      if (Array.isArray(list)) {
        setModels(list);
        if (!config.model) {
          const def = list.find((m) => m.isDefault);
          if (def) onUpdate({ model: def.modelId });
        }
      }
    }).catch(() => {}).finally(() => { if (!cancelled) setLoadingModels(false); });
    return () => { cancelled = true; };
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  // 加载知识库列表
  useEffect(() => {
    let cancelled = false;
    const userInfoStr = localStorage.getItem('user_info');
    const userId = userInfoStr ? String(JSON.parse(userInfoStr)?.id ?? '') : '';
    if (!userId) return;
    setLoadingKb(true);
    api.listByCreator({ userId: userId as unknown as number, page: 0, size: 100 }).then((res) => {
      if (cancelled) return;
      if (res.data.code === 0) {
        const list = (res.data.data || []) as unknown as KbInfo[];
        setKnowledgeBases(list);
      } else {
        console.warn('[LLMConfig] 获取知识库列表失败:', res.data.message);
      }
    }).catch((err) => {
      console.error('[LLMConfig] 知识库API调用异常:', err);
    }).finally(() => { if (!cancelled) setLoadingKb(false); });
    return () => { cancelled = true; };
  }, []);

  // 加载 MCP 服务器列表
  useEffect(() => {
    let cancelled = false;
    const userInfoStr = localStorage.getItem('user_info');
    const userId = userInfoStr ? String(JSON.parse(userInfoStr)?.id ?? '') : '';
    if (!userId) return;
    setLoadingMcp(true);
    apiClient.get(`/api/ai/mcp-servers?userId=${userId}`).then((res) => {
      if (cancelled) return;
      const data = res.data;
      if (data.code === 0 && Array.isArray(data.data)) {
        setMcpServerList(data.data.map((s: any) => ({ id: String(s.id), name: s.name, url: s.url, enabled: s.enabled })));
      }
    }).catch(() => {}).finally(() => { if (!cancelled) setLoadingMcp(false); });
    return () => { cancelled = true; };
  }, []);

  // 类型安全辅助
  const inputMappings = (config.inputMappings as InputMapping[]) || [];
  const knowledgeBaseIds = (config.knowledgeBaseIds as string[]) || [];
  const enabledCapabilities = (config.enabledCapabilities as string[]) || [];
  const mcpServerIds = (config.mcpServerIds as string[]) || [];

  const addMapping = () => onUpdate({ inputMappings: [...inputMappings, { variableName: '', mappedKey: '' }] });
  const updateMapping = (idx: number, field: keyof InputMapping, value: string) => {
    const updated = inputMappings.map((m, i) => i === idx ? { ...m, [field]: value } : m);
    onUpdate({ inputMappings: updated });
  };
  const removeMapping = (idx: number) => onUpdate({ inputMappings: inputMappings.filter((_, i) => i !== idx) });

  const toggleKb = useCallback((kbId: string) => {
    const current = (config.knowledgeBaseIds as string[]) || [];
    const exists = current.some((id) => String(id) === String(kbId));
    onUpdate({
      knowledgeBaseIds: exists
        ? current.filter((id) => String(id) !== String(kbId))
        : [...current, kbId],
    });
  }, [config.knowledgeBaseIds, onUpdate]);

  const toggleCapability = (cap: string) => {
    const exists = enabledCapabilities.includes(cap);
    onUpdate({
      enabledCapabilities: exists
        ? enabledCapabilities.filter((c) => c !== cap)
        : [...enabledCapabilities, cap],
    });
  };

  // 在提示词中插入变量占位符
  const insertVar = (field: 'systemPrompt' | 'userPromptTemplate', varName: string) => {
    const current = (config[field] as string) || '';
    onUpdate({ [field]: current + `{{${varName}}}` });
  };

  return (
    <div className="space-y-4">
      {/* ===== 模型选择 ===== */}
      <ConfigField label="模型">
        {loadingModels ? (
          <div className="flex items-center gap-2 text-xs text-gray-400 py-1.5">
            <Loader2 size={14} className="animate-spin" /> 加载模型列表…
          </div>
        ) : (
          <select value={(config.model as string) || ''} onChange={(e) => onUpdate({ model: e.target.value })} className={selectClass}>
            {models.length === 0 && <option value="">暂无可用模型</option>}
            {models.map((m) => (
              <option key={m.modelId} value={m.modelId}>
                {m.model} ({m.provider}){m.isDefault ? ' ★' : ''}
              </option>
            ))}
          </select>
        )}
      </ConfigField>

      {/* ===== 提示词配置 ===== */}
      <Section title="提示词配置" icon={<Sparkles size={13} />} defaultOpen={true}>
        <ConfigField label="系统提示词">
          <textarea value={(config.systemPrompt as string) || ''} onChange={(e) => onUpdate({ systemPrompt: e.target.value })} rows={3} placeholder="定义AI的角色和行为规则...&#10;支持 {{变量名}} 引用工作流变量" className={textareaClass} />
          {upstreamVars.length > 0 && (
            <div className="flex flex-wrap gap-1 mt-1.5">
              {upstreamVars.slice(0, 8).map((v, i) => (
                <button key={i} onClick={() => insertVar('systemPrompt', v.value)}
                  className="px-1.5 py-0.5 text-[10px] bg-violet-50 dark:bg-violet-900/20 text-violet-600 dark:text-violet-400 border border-violet-200 dark:border-violet-800 rounded-md hover:bg-violet-100 dark:hover:bg-violet-900/30 transition-colors font-mono"
                  title={`插入 {{${v.value}}} 到系统提示词`}>
                  +{v.value}
                </button>
              ))}
            </div>
          )}
        </ConfigField>
        <ConfigField label="用户提示词模板">
          <textarea value={(config.userPromptTemplate as string) || ''} onChange={(e) => onUpdate({ userPromptTemplate: e.target.value })} rows={3} placeholder="用户消息模板...&#10;使用 {{变量名}} 注入工作流数据" className={textareaClass} />
          {upstreamVars.length > 0 && (
            <div className="flex flex-wrap gap-1 mt-1.5">
              {upstreamVars.slice(0, 8).map((v, i) => (
                <button key={i} onClick={() => insertVar('userPromptTemplate', v.value)}
                  className="px-1.5 py-0.5 text-[10px] bg-violet-50 dark:bg-violet-900/20 text-violet-600 dark:text-violet-400 border border-violet-200 dark:border-violet-800 rounded-md hover:bg-violet-100 dark:hover:bg-violet-900/30 transition-colors font-mono"
                  title={`插入 {{${v.value}}} 到用户提示词`}>
                  +{v.value}
                </button>
              ))}
            </div>
          )}
        </ConfigField>
      </Section>

      {/* ===== 输入变量映射（从工作流导入） ===== */}
      <Section title="输入变量映射" icon={<Plus size={13} />}>
        <p className="text-[11px] text-gray-400 dark:text-gray-500 mb-2">
          将上游节点的输出变量映射为提示词中的 {'{{mappedKey}}'} 占位符
        </p>
        {inputMappings.map((m, idx) => (
          <div key={idx} className="flex items-center gap-1.5">
            {upstreamVars.length > 0 ? (
              <select value={m.variableName} onChange={(e) => updateMapping(idx, 'variableName', e.target.value)}
                className={`${selectClass} flex-1 !text-xs !py-1.5`}>
                <option value="">选择变量</option>
                {upstreamVars.map((v, i) => <option key={i} value={v.value}>{v.label}</option>)}
              </select>
            ) : (
              <input type="text" placeholder="变量名" value={m.variableName}
                onChange={(e) => updateMapping(idx, 'variableName', e.target.value)}
                className={`${inputClass} flex-1 !text-xs !py-1.5`} />
            )}
            <span className="text-[10px] text-gray-400 flex-shrink-0">&rarr;</span>
            <input type="text" placeholder="映射键名" value={m.mappedKey}
              onChange={(e) => updateMapping(idx, 'mappedKey', e.target.value)}
              className={`${inputClass} flex-1 !text-xs !py-1.5 font-mono`} />
            <button onClick={() => removeMapping(idx)} className="p-1 text-gray-400 hover:text-red-500 rounded transition-colors flex-shrink-0">
              <Trash2 size={12} />
            </button>
          </div>
        ))}
        <button onClick={addMapping} className="flex items-center gap-1 px-2 py-1.5 text-xs text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all w-full justify-center border border-dashed border-gray-200 dark:border-gray-700">
          <Plus size={12} /> 添加映射
        </button>
      </Section>

      {/* ===== 输出配置 ===== */}
      <ConfigField label="输出变量名">
        <input type="text" value={(config.outputVariable as string) || 'llmOutput'}
          onChange={(e) => onUpdate({ outputVariable: e.target.value })}
          placeholder="下游节点通过此变量名获取AI输出"
          className={`${inputClass} font-mono`} />
        <p className="text-[10px] text-gray-400 mt-0.5">下游节点通过 {'{{outputVariable}}'} 引用AI的回复</p>
      </ConfigField>

      {/* ===== 知识库配置 ===== */}
      <Section title="知识库 (RAG)" icon={<BookOpen size={13} />}>
        {loadingKb ? (
          <div className="flex items-center gap-2 text-xs text-gray-400 py-2">
            <Loader2 size={14} className="animate-spin" /> 加载知识库…
          </div>
        ) : knowledgeBases.length === 0 ? (
          <p className="text-xs text-gray-400 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-lg border border-dashed border-gray-200 dark:border-gray-700">
            暂无知识库，请先在知识库管理中创建
          </p>
        ) : (
          <div className="space-y-1.5 max-h-40 overflow-y-auto">
            {knowledgeBases.map((kb) => {
              const selected = knowledgeBaseIds.some((id) => String(id) === String(kb.id));
              return (
                <div key={String(kb.id)} onClick={() => toggleKb(String(kb.id))} role="checkbox" aria-checked={selected}
                  className={`flex items-center gap-2.5 p-2.5 rounded-xl border cursor-pointer transition-all group ${
                  selected
                    ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-300 dark:border-brand-700 shadow-sm shadow-brand-100 dark:shadow-brand-900/10'
                    : 'bg-white dark:bg-gray-800/30 border-gray-200 dark:border-gray-700 hover:border-brand-200 dark:hover:border-brand-800 hover:bg-brand-50/30 dark:hover:bg-brand-900/10'
                }`}>
                  <div className={`flex-shrink-0 w-4 h-4 rounded-md border-2 flex items-center justify-center transition-all ${
                    selected
                      ? 'bg-brand-500 border-brand-500 dark:bg-brand-600 dark:border-brand-600'
                      : 'border-gray-300 dark:border-gray-600 group-hover:border-brand-300 dark:group-hover:border-brand-700'
                  }`}>
                    {selected && (
                      <svg className="w-2.5 h-2.5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3.5}>
                        <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                      </svg>
                    )}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className={`text-xs font-medium truncate ${selected ? 'text-brand-700 dark:text-brand-300' : 'text-gray-800 dark:text-gray-200'}`}>{kb.name}</div>
                    {kb.description && <div className="text-[10px] text-gray-400 dark:text-gray-500 truncate mt-0.5">{kb.description}</div>}
                    {kb.documentCount != null && <div className="text-[10px] text-gray-400 dark:text-gray-500">{kb.documentCount} 篇文档</div>}
                  </div>
                </div>
              );
            })}
          </div>
        )}
        {knowledgeBaseIds.length > 0 && (
          <div className="grid grid-cols-2 gap-2 mt-2">
            <ConfigField label="检索数量 (Top K)">
              <input type="number" min="1" max="50" value={(config.ragTopK as number) ?? 5}
                onChange={(e) => onUpdate({ ragTopK: parseInt(e.target.value) })}
                className={`${inputClass} !text-xs !py-1.5`} />
            </ConfigField>
            <ConfigField label="相似度阈值">
              <input type="number" step="0.05" min="0" max="1" value={(config.ragThreshold as number) ?? 0.5}
                onChange={(e) => onUpdate({ ragThreshold: parseFloat(e.target.value) })}
                className={`${inputClass} !text-xs !py-1.5`} />
            </ConfigField>
          </div>
        )}
      </Section>

      {/* ===== 可选 AI 能力 ===== */}
      <Section title="AI 能力" icon={<Sparkles size={13} />}>
        <div className="grid grid-cols-2 gap-2">
          {AI_CAPABILITIES.map((cap) => {
            const active = enabledCapabilities.includes(cap.key);
            return (
              <button key={cap.key} onClick={() => toggleCapability(cap.key)}
                className={`flex items-center gap-2 p-2.5 rounded-xl border text-left transition-all ${
                  active
                    ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-300 dark:border-brand-700 text-brand-700 dark:text-brand-300'
                    : 'bg-gray-50 dark:bg-gray-800/30 border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:border-gray-300 dark:hover:border-gray-600'
                }`}>
                {React.createElement(cap.icon, { size: 14, className: active ? 'text-brand-500' : 'text-gray-400' })}
                <div>
                  <div className="text-[11px] font-bold">{cap.label}</div>
                  <div className="text-[9px] opacity-60">{cap.desc}</div>
                </div>
              </button>
            );
          })}
        </div>
      </Section>

      {/* ===== MCP 工具服务器（多选绑定） ===== */}
      <Section title="MCP 工具服务器" icon={<Plug2 size={13} />}>
        <p className="text-[11px] text-gray-400 dark:text-gray-500 mb-2">
          绑定已配置的 MCP 服务器，LLM 可自主调用其提供的工具。
          <a href="/admin/mcp-servers" target="_blank" className="text-brand-500 hover:underline ml-1">前往管理 →</a>
        </p>
        {loadingMcp ? (
          <div className="flex items-center gap-1.5 text-xs text-gray-400 py-2"><Loader2 size={12} className="animate-spin" /> 加载中...</div>
        ) : mcpServerList.length === 0 ? (
          <div className="text-[11px] text-gray-400 py-3 text-center border border-dashed border-gray-200 dark:border-gray-700 rounded-lg">
            暂无 MCP 服务器，<a href="/admin/mcp-servers" target="_blank" className="text-brand-500 hover:underline">去创建</a>
          </div>
        ) : (
          <div className="space-y-1.5">
            {mcpServerList.map((server) => {
              const selected = mcpServerIds.includes(String(server.id));
              return (
                <button key={server.id} onClick={() => {
                  const current = [...mcpServerIds];
                  const sid = String(server.id);
                  const updated = selected ? current.filter((id) => String(id) !== sid) : [...current, sid];
                  onUpdate({ mcpServerIds: updated });
                }} className={`w-full flex items-center gap-2.5 p-2.5 rounded-xl border transition-all text-left ${
                  selected
                    ? 'border-violet-400 dark:border-violet-600 bg-violet-50 dark:bg-violet-900/20'
                    : 'border-gray-200 dark:border-gray-700 hover:border-gray-300 dark:hover:border-gray-600'
                }`}>
                  <div className={`w-4 h-4 rounded-md border-2 flex items-center justify-center flex-shrink-0 transition-colors ${
                    selected ? 'bg-violet-500 border-violet-500' : 'border-gray-300 dark:border-gray-600'
                  }`}>
                    {selected && <span className="text-white text-[10px] font-bold">✓</span>}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="text-[11px] font-bold text-gray-700 dark:text-gray-300 truncate flex items-center gap-1">
                      <Plug2 size={10} /> {server.name || '未命名'}
                      {!server.enabled && <span className="text-[9px] text-orange-500">(已禁用)</span>}
                    </div>
                    <div className="text-[10px] text-gray-400 truncate font-mono">{server.url}</div>
                  </div>
                </button>
              );
            })}
          </div>
        )}
        {mcpServerIds.length > 0 && (
          <div className="p-2 bg-violet-50 dark:bg-violet-900/10 rounded-lg border border-violet-200 dark:border-violet-800/50 mt-1.5">
            <p className="text-[10px] text-violet-700 dark:text-violet-400 leading-relaxed">
              已绑定 <b>{mcpServerIds.length}</b> 个 MCP 服务器。启用后将使用同步模式调用模型，最多 10 轮工具调用。
            </p>
          </div>
        )}
      </Section>

      {/* ===== 模型参数 ===== */}
      <Section title="模型参数" icon={<Settings2 size={13} />}>
        <div className="grid grid-cols-3 gap-2">
          <ConfigField label="温度">
            <input type="number" step="0.1" min="0" max="2" value={(config.temperature as number) ?? 0.7}
              onChange={(e) => onUpdate({ temperature: parseFloat(e.target.value) })} className={`${inputClass} !text-xs !py-1.5`} />
          </ConfigField>
          <ConfigField label="Top P">
            <input type="number" step="0.05" min="0" max="1" value={(config.topP as number) ?? 0.9}
              onChange={(e) => onUpdate({ topP: parseFloat(e.target.value) })} className={`${inputClass} !text-xs !py-1.5`} />
          </ConfigField>
          <ConfigField label="Max Token">
            <input type="number" min="1" max="128000" value={(config.maxTokens as number) ?? 4096}
              onChange={(e) => onUpdate({ maxTokens: parseInt(e.target.value) })} className={`${inputClass} !text-xs !py-1.5`} />
          </ConfigField>
        </div>
      </Section>

      {/* ===== 高级配置 ===== */}
      <Section title="高级配置" icon={<Settings2 size={13} />}>
        <ConfigField label="JSON 输出解析">
          <ConfigCheckbox checked={(config.parseJsonOutput as boolean) || false}
            onChange={(v) => onUpdate({ parseJsonOutput: v })}
            label="自动解析AI输出中的JSON" />
        </ConfigField>
        {!!(config.parseJsonOutput) && (
          <ConfigField label="JSON Schema（可选）">
            <textarea value={(config.jsonSchema as string) || ''} onChange={(e) => onUpdate({ jsonSchema: e.target.value })}
              rows={2} placeholder='{"type":"object","properties":{...}}' className={`${textareaClass} !text-xs`} />
          </ConfigField>
        )}
        <ConfigField label="历史消息变量">
          <input type="text" value={(config.historyVariable as string) || ''}
            onChange={(e) => onUpdate({ historyVariable: e.target.value })}
            placeholder="多轮对话场景，指定历史消息变量名"
            className={`${inputClass} !text-xs font-mono`} />
        </ConfigField>
        {!!(config.historyVariable) && (
          <ConfigField label="保留历史条数">
            <input type="number" min="1" max="100" value={(config.historyLimit as number) ?? 10}
              onChange={(e) => onUpdate({ historyLimit: parseInt(e.target.value) })}
              className={`${inputClass} !text-xs`} />
          </ConfigField>
        )}
      </Section>
    </div>
  );
};

// ===== 意图识别配置 =====
interface IntentItem {
  name: string;
  description: string;
  examples: string[];
}

const IntentRecognitionConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const [models, setModels] = useState<ModelInfo[]>([]);
  const [loadingModels, setLoadingModels] = useState(true);
  const upstreamVars = useUpstreamVars();
  const [inputMode, setInputMode] = useState<'select' | 'manual'>(
    () => (config.inputVariable && upstreamVars.length === 0) ? 'manual' : 'select'
  );

  // 加载模型列表
  useEffect(() => {
    let cancelled = false;
    api.listAvailableModels().then((res) => {
      if (cancelled) return;
      const list = (res.data as any)?.data as ModelInfo[] | undefined;
      if (Array.isArray(list)) {
        // 过滤出文本模型（排除 vision 模型）
        const textModels = list.filter((m) => m.enabled && m.type !== 'vision');
        setModels(textModels);
        if (!config.model && textModels.length > 0) {
          const def = textModels.find((m) => m.isDefault) || textModels[0];
          onUpdate({ model: def.modelId });
        }
      }
    }).catch((e) => { console.error('加载模型失败', e); }).finally(() => { if (!cancelled) setLoadingModels(false); });
    return () => { cancelled = true; };
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  // 上游变量为空时自动切手动
  useEffect(() => {
    if (upstreamVars.length === 0 && inputMode === 'select') setInputMode('manual');
  }, [upstreamVars.length]); // eslint-disable-line react-hooks/exhaustive-deps

  const intents = (config.intents as IntentItem[]) || [];

  const addIntent = () => {
    onUpdate({ intents: [...intents, { name: '', description: '', examples: [] }] });
  };
  const removeIntent = (idx: number) => {
    onUpdate({ intents: intents.filter((_, i) => i !== idx) });
  };
  const updateIntent = (idx: number, field: string, value: unknown) => {
    const next = intents.map((item, i) => i === idx ? { ...item, [field]: value } : item);
    onUpdate({ intents: next });
  };

  return (
    <div className="space-y-4">
      {/* ===== 模型选择 ===== */}
      <ConfigField label="模型">
        {loadingModels ? (
          <div className="flex items-center gap-2 text-xs text-gray-400 py-1.5"><Loader2 size={14} className="animate-spin" /> 加载模型列表…</div>
        ) : (
          <select value={(config.model as string) || ''} onChange={(e) => onUpdate({ model: e.target.value })} className={selectClass}>
            {models.length === 0 && <option value="">暂无可用模型</option>}
            {models.map((m) => (
              <option key={m.modelId} value={m.modelId}>
                {m.model} ({m.provider}){m.isDefault ? ' ★' : ''}
              </option>
            ))}
          </select>
        )}
      </ConfigField>

      {/* ===== 模型参数 ===== */}
      <Section title="模型参数" icon={<Settings2 size={12} />} defaultOpen={false}>
        <ConfigField label="Temperature">
          <input type="number" step="0.05" min="0" max="2" value={(config.temperature as number) ?? 0.1}
            onChange={(e) => onUpdate({ temperature: parseFloat(e.target.value) })} className={`${inputClass} !text-xs`} />
          <p className="text-[10px] text-gray-400 mt-0.5">越低越稳定，推荐 0.1（分类任务）</p>
        </ConfigField>
        <ConfigField label="Top P">
          <input type="number" step="0.05" min="0" max="1" value={(config.topP as number) ?? 0.9}
            onChange={(e) => onUpdate({ topP: parseFloat(e.target.value) })} className={`${inputClass} !text-xs`} />
        </ConfigField>
        <ConfigField label="Max Tokens">
          <input type="number" step="100" min="50" max="4096" value={(config.maxTokens as number) ?? 500}
            onChange={(e) => onUpdate({ maxTokens: parseInt(e.target.value) })} className={`${inputClass} !text-xs`} />
          <p className="text-[10px] text-gray-400 mt-0.5">意图识别通常只需很少 token</p>
        </ConfigField>
      </Section>

      {/* ===== 输入变量 ===== */}
      <ConfigField label="输入变量">
        <div className="flex items-center gap-1 mb-1">
          <button onClick={() => setInputMode('select')}
            className={`text-[10px] px-2 py-0.5 rounded-full transition-colors ${inputMode === 'select' ? 'bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-300 font-bold' : 'text-gray-400 hover:text-gray-600'}`}>
            从上游选择
          </button>
          <button onClick={() => setInputMode('manual')}
            className={`text-[10px] px-2 py-0.5 rounded-full transition-colors ${inputMode === 'manual' ? 'bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-300 font-bold' : 'text-gray-400 hover:text-gray-600'}`}>
            手动输入
          </button>
        </div>
        {inputMode === 'select' ? (
          <select value={(config.inputVariable as string) || ''} onChange={(e) => onUpdate({ inputVariable: e.target.value })} className={selectClass}>
            <option value="">选择变量</option>
            {upstreamVars.map((v) => <option key={v.value} value={v.value}>{v.label}</option>)}
          </select>
        ) : (
          <input type="text" value={(config.inputVariable as string) || ''}
            onChange={(e) => onUpdate({ inputVariable: e.target.value })}
            placeholder="输入变量名（如 userInput）" className={inputClass} />
        )}
        <p className="text-[10px] text-gray-400 mt-1">待识别意图的文本变量，需要连接上游节点后才能选择</p>
      </ConfigField>

      {/* ===== 输出变量 ===== */}
      <ConfigField label="输出变量名">
        <input type="text" value={(config.outputVariable as string) || 'intentResult'}
          onChange={(e) => onUpdate({ outputVariable: e.target.value })}
          placeholder="intentResult" className={inputClass} />
      </ConfigField>

      {/* ===== 意图列表 ===== */}
      <div>
        <div className="flex items-center justify-between mb-2">
          <label className="text-xs font-medium text-gray-700 dark:text-gray-300">意图列表</label>
          <button onClick={addIntent} className="flex items-center gap-1 text-[10px] text-brand-600 dark:text-brand-400 hover:text-brand-700 dark:hover:text-brand-300 font-bold">
            <Plus size={12} /> 添加意图
          </button>
        </div>
        {intents.length === 0 && (
          <p className="text-xs text-gray-400 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-lg border border-dashed border-gray-200 dark:border-gray-700">
            请添加至少一个意图
          </p>
        )}
        <div className="space-y-2">
          {intents.map((intent, idx) => (
            <div key={idx} className="p-2.5 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/30 space-y-2">
              <div className="flex items-center gap-2">
                <input type="text" value={intent.name} onChange={(e) => updateIntent(idx, 'name', e.target.value)}
                  placeholder="意图名称（如 greeting）" className={`${inputClass} !text-xs !py-1.5 flex-1`} />
                <button onClick={() => removeIntent(idx)} className="p-1 text-gray-400 hover:text-red-500 transition-colors"><X size={14} /></button>
              </div>
              <input type="text" value={intent.description} onChange={(e) => updateIntent(idx, 'description', e.target.value)}
                placeholder="描述（如：用户打招呼问好）" className={`${inputClass} !text-xs !py-1.5`} />
              <input type="text"
                value={Array.isArray(intent.examples) ? intent.examples.join('、') : ''}
                onChange={(e) => updateIntent(idx, 'examples', e.target.value.split('、').map(s => s.trim()).filter(Boolean))}
                placeholder="示例短语（用顿号分隔，如：你好、嗨、早上好）" className={`${inputClass} !text-xs !py-1.5`} />
            </div>
          ))}
        </div>
      </div>

      {/* ===== 置信度阈值 ===== */}
      <ConfigField label="置信度阈值">
        <input type="number" step="0.05" min="0" max="1" value={(config.confidenceThreshold as number) ?? 0.6}
          onChange={(e) => onUpdate({ confidenceThreshold: parseFloat(e.target.value) })} className={inputClass} />
        <p className="text-[10px] text-gray-400 mt-1">低于此阈值的意图将回退为 UNKNOWN</p>
      </ConfigField>
    </div>
  );
};

// ===== 实体抽取配置 =====
interface EntityTypeItem {
  name: string;
  description: string;
  pattern: string;
  examples: string[];
  required: boolean;
}

const EXTRACTION_MODELS = [
  { value: 'LLM_BASED', label: 'LLM 抽取（推荐）', desc: '使用大语言模型智能抽取' },
  { value: 'RULE_BASED', label: '规则匹配', desc: '基于正则表达式匹配' },
];

const EntityExtractionConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();
  const [inputMode, setInputMode] = useState<'select' | 'manual'>(
    () => (config.inputVariable && upstreamVars.length === 0) ? 'manual' : 'select'
  );

  // 上游变量为空时自动切手动
  useEffect(() => {
    if (upstreamVars.length === 0 && inputMode === 'select') setInputMode('manual');
  }, [upstreamVars.length]); // eslint-disable-line react-hooks/exhaustive-deps

  const entityTypes = (config.entityTypes as EntityTypeItem[]) || [];
  const extractionModel = (config.extractionModel as string) || 'LLM_BASED';

  const addEntityType = () => {
    onUpdate({ entityTypes: [...entityTypes, { name: '', description: '', pattern: '', examples: [], required: false }] });
  };
  const removeEntityType = (idx: number) => {
    onUpdate({ entityTypes: entityTypes.filter((_, i) => i !== idx) });
  };
  const updateEntityType = (idx: number, field: string, value: unknown) => {
    const next = entityTypes.map((item, i) => i === idx ? { ...item, [field]: value } : item);
    onUpdate({ entityTypes: next });
  };

  return (
    <div className="space-y-4">
      {/* ===== 抽取模式 ===== */}
      <ConfigField label="抽取模式">
        <div className="grid grid-cols-2 gap-2">
          {EXTRACTION_MODELS.map((m) => {
            const active = extractionModel === m.value;
            return (
              <button key={m.value} onClick={() => onUpdate({ extractionModel: m.value })}
                className={`p-2.5 rounded-xl border text-left transition-all ${
                  active
                    ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-300 dark:border-brand-700 text-brand-700 dark:text-brand-300'
                    : 'bg-gray-50 dark:bg-gray-800/30 border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:border-gray-300 dark:hover:border-gray-600'
                }`}>
                <div className="text-[11px] font-bold">{m.label}</div>
                <div className="text-[9px] opacity-60 mt-0.5">{m.desc}</div>
              </button>
            );
          })}
        </div>
      </ConfigField>

      {/* ===== 输入变量 ===== */}
      <ConfigField label="输入变量">
        <div className="flex items-center gap-1 mb-1">
          <button onClick={() => setInputMode('select')}
            className={`text-[10px] px-2 py-0.5 rounded-full transition-colors ${inputMode === 'select' ? 'bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-300 font-bold' : 'text-gray-400 hover:text-gray-600'}`}>
            从上游选择
          </button>
          <button onClick={() => setInputMode('manual')}
            className={`text-[10px] px-2 py-0.5 rounded-full transition-colors ${inputMode === 'manual' ? 'bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-300 font-bold' : 'text-gray-400 hover:text-gray-600'}`}>
            手动输入
          </button>
        </div>
        {inputMode === 'select' ? (
          <select value={(config.inputVariable as string) || ''} onChange={(e) => onUpdate({ inputVariable: e.target.value })} className={selectClass}>
            <option value="">选择变量</option>
            {upstreamVars.map((v) => <option key={v.value} value={v.value}>{v.label}</option>)}
          </select>
        ) : (
          <input type="text" value={(config.inputVariable as string) || ''}
            onChange={(e) => onUpdate({ inputVariable: e.target.value })}
            placeholder="输入变量名（如 userInput）" className={inputClass} />
        )}
        <p className="text-[10px] text-gray-400 mt-1">待抽取实体的文本变量</p>
      </ConfigField>

      {/* ===== 输出变量 ===== */}
      <ConfigField label="输出变量名">
        <input type="text" value={(config.outputVariable as string) || 'entities'}
          onChange={(e) => onUpdate({ outputVariable: e.target.value })}
          placeholder="entities" className={inputClass} />
        <p className="text-[10px] text-gray-400 mt-0.5">抽取结果将存入此变量，同时自动生成 entityCount、entitiesByType</p>
      </ConfigField>

      {/* ===== 实体类型列表 ===== */}
      <div>
        <div className="flex items-center justify-between mb-2">
          <label className="text-xs font-medium text-gray-700 dark:text-gray-300">实体类型</label>
          <button onClick={addEntityType} className="flex items-center gap-1 text-[10px] text-brand-600 dark:text-brand-400 hover:text-brand-700 dark:hover:text-brand-300 font-bold">
            <Plus size={12} /> 添加类型
          </button>
        </div>
        {entityTypes.length === 0 && (
          <p className="text-xs text-gray-400 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-lg border border-dashed border-gray-200 dark:border-gray-700">
            请添加至少一个实体类型（如 人名、地点、电话号码）
          </p>
        )}
        <div className="space-y-2">
          {entityTypes.map((et, idx) => (
            <div key={idx} className="p-2.5 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/30 space-y-2">
              <div className="flex items-center gap-2">
                <input type="text" value={et.name} onChange={(e) => updateEntityType(idx, 'name', e.target.value)}
                  placeholder="类型名称（如 PERSON）" className={`${inputClass} !text-xs !py-1.5 flex-1`} />
                <ConfigCheckbox checked={et.required || false} onChange={(v) => updateEntityType(idx, 'required', v)} label="必需" size="sm" />
                <button onClick={() => removeEntityType(idx)} className="p-1 text-gray-400 hover:text-red-500 transition-colors"><X size={14} /></button>
              </div>
              <input type="text" value={et.description} onChange={(e) => updateEntityType(idx, 'description', e.target.value)}
                placeholder="描述（如：人名/姓名）" className={`${inputClass} !text-xs !py-1.5`} />
              {extractionModel === 'RULE_BASED' && (
                <input type="text" value={et.pattern || ''} onChange={(e) => updateEntityType(idx, 'pattern', e.target.value)}
                  placeholder="正则表达式（如 1[3-9]\d{9}）" className={`${inputClass} !text-xs !py-1.5 font-mono`} />
              )}
              <input type="text"
                value={Array.isArray(et.examples) ? et.examples.join('、') : ''}
                onChange={(e) => updateEntityType(idx, 'examples', e.target.value.split('、').map(s => s.trim()).filter(Boolean))}
                placeholder="示例值（用顿号分隔，如：张三、李四、王五）" className={`${inputClass} !text-xs !py-1.5`} />
            </div>
          ))}
        </div>
      </div>

      {/* ===== 高级选项 ===== */}
      <Section title="高级选项" icon={<Settings2 size={12} />}>
        <ConfigCheckbox checked={(config.mergeAdjacent as boolean) || false}
          onChange={(v) => onUpdate({ mergeAdjacent: v })}
          label="合并相邻同类实体" />
        <ConfigCheckbox checked={(config.includePosition as boolean) ?? true}
          onChange={(v) => onUpdate({ includePosition: v })}
          label="返回实体位置信息（start / end）" />
        {extractionModel === 'LLM_BASED' && (
          <ConfigField label="自定义提示词（可选）">
            <textarea value={(config.llmPrompt as string) || ''} onChange={(e) => onUpdate({ llmPrompt: e.target.value })}
              rows={3} placeholder="留空使用默认提示词。可自定义 LLM 实体抽取的系统提示词..." className={textareaClass} />
          </ConfigField>
        )}
      </Section>

      {/* ===== 说明 ===== */}
      <p className="text-xs text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-800/50 rounded-lg px-3 py-2 border border-gray-200 dark:border-gray-700">
        实体抽取节点从输入文本中识别并提取指定类型的实体。输出包含实体列表（type / value / start / end）、实体数量和按类型分组结果。
      </p>
    </div>
  );
};

// ===== 条件分支配置 =====
interface ConditionBranch {
  name: string;
  conditionType: 'VARIABLE_COMPARE' | 'EXPRESSION';
  variable: string;
  operator: string;
  compareValue: string;
  expression: string;
}

const OPERATORS = [
  { value: '==', label: '==', desc: 'equals' },
  { value: '!=', label: '!=', desc: 'not equals' },
  { value: '>', label: '>', desc: 'greater than' },
  { value: '>=', label: '>=', desc: 'greater or equal' },
  { value: '<', label: '<', desc: 'less than' },
  { value: '<=', label: '<=', desc: 'less or equal' },
  { value: 'contains', label: 'contains', desc: 'contains' },
  { value: 'startsWith', label: 'startsWith', desc: 'starts with' },
  { value: 'endsWith', label: 'endsWith', desc: 'ends with' },
  { value: 'isEmpty', label: 'isEmpty', desc: 'is empty' },
  { value: 'isNotEmpty', label: 'isNotEmpty', desc: 'is not empty' },
];

// 根据节点类型推断可能的输出变量
const NODE_OUTPUT_VARS: Record<string, string[]> = {
  START: [],
  LLM: ['response', 'llmOutput', 'model', 'tokensUsed', 'ragReferences', 'parsedOutput', 'toolCalls', 'toolCallCount'],
  TEMPLATE: ['renderedTemplate', 'templateOutput'],
  HTTP_REQUEST: ['statusCode', 'body', 'headers', 'jsonBody'],
  CODE: ['result', 'output'],
  INTENT_RECOGNITION: ['intentResult', 'confidence', 'allIntents', 'rawResponse'],
  ENTITY_EXTRACTION: ['entities', 'entityCount', 'entitiesByType'],
  CONDITION: ['conditionResult', 'branch', 'matchedBranch', 'matchedIndex'],
  SWITCH: ['switchValue', 'matchedBranch', 'branch', 'matchedIndex'],
  LOOP: ['loopResults', 'loopCount', 'loopCompleted'],
  PARALLEL: ['parallelCompleted', 'parallelCount', 'parallelErrors'],
  MERGE: ['merged', 'mergedCount'],
  VARIABLE_SET: [],
  DATABASE_QUERY: ['queryResult', 'rowCount', 'truncated'],
  JSON_PARSE: ['success', 'valid'],
};

// ===== 公共 hook: 发现当前节点所有上游变量 =====
// 修复：1) 排除自身（循环 loop-end 边导致自引用）
//       2) 按 value 去重（同名变量只保留最近上游的）
//       3) 收集 VARIABLE_SET 的 variables[] 数组
function useUpstreamVars() {
  const selectedNodeId = useWorkflowStore((s) => s.selectedNodeId);
  const nodes = useWorkflowStore((s) => s.nodes);
  const edges = useWorkflowStore((s) => s.edges);
  return React.useMemo(() => {
    if (!selectedNodeId) return [];
    const vars: { label: string; value: string; from: string }[] = [];
    const seen = new Set<string>(); // 按 value 去重

    // BFS 向上遍历，排除自身
    const visited = new Set<string>();
    const queue = [selectedNodeId];
    while (queue.length > 0) {
      const current = queue.shift()!;
      edges.filter((e) => e.target === current).forEach((edge) => {
        if (!visited.has(edge.source) && edge.source !== selectedNodeId) {
          visited.add(edge.source);
          queue.push(edge.source);
        }
      });
    }

    const addVar = (name: string, nodeName: string) => {
      if (!name || seen.has(name)) return;
      seen.add(name);
      vars.push({ label: `${nodeName}.${name}`, value: name, from: nodeName });
    };

    for (const nodeId of visited) {
      const node = nodes.find((n) => n.id === nodeId);
      if (!node) continue;
      const nt = node.data.nodeType;
      const nodeName = node.data.label;

      // START: inputParameters
      if (nt === NodeType.START) {
        ((node.data.config.inputParameters as Array<{ name: string }>) || []).forEach((p) => addVar(p.name, nodeName));
      }
      // 节点类型默认输出
      (NODE_OUTPUT_VARS[nt] || []).forEach((v) => addVar(v, nodeName));
      // 用户自定义 outputVariable / resultVariable
      const customOut = node.data.config.outputVariable as string;
      if (customOut) addVar(customOut, nodeName);
      const customResult = node.data.config.resultVariable as string;
      if (customResult) addVar(customResult, nodeName);
      // VARIABLE_SET: 收集 variables[] 数组 + 旧版 variableName
      if (nt === NodeType.VARIABLE_SET) {
        const variables = node.data.config.variables as Array<{ name: string }>;
        if (variables) variables.forEach((v) => addVar(v.name, nodeName));
        const varName = node.data.config.variableName as string;
        if (varName) addVar(varName, nodeName);
      }
      // CODE: 收集 outputVariables[] 数组中用户声明的输出变量
      if (nt === NodeType.CODE) {
        const codeOutputVars = node.data.config.outputVariables as Array<{ name: string }>;
        if (codeOutputVars) codeOutputVars.forEach((v) => { if (v.name) addVar(v.name, nodeName); });
      }
      // JSON_PARSE: 收集 extractions[] 中用户定义的 outputVariable
      if (nt === NodeType.JSON_PARSE) {
        const extractions = node.data.config.extractions as Array<{ outputVariable: string; fieldPath: string }>;
        if (extractions) {
          extractions.forEach((ext) => {
            if (ext.outputVariable) {
              addVar(ext.outputVariable, nodeName);
            } else if (ext.fieldPath) {
              // 自动推断：取 fieldPath 最后一段（去掉数组索引）
              const segments = ext.fieldPath.split('.');
              const last = segments[segments.length - 1].replace(/\[\d+]/g, '');
              if (last) addVar(last, nodeName);
            }
          });
        }
      }
      // PARALLEL: 根据合并策略收集分支结果变量
      if (nt === NodeType.PARALLEL) {
        const branches = node.data.config.branches as Array<{ name: string; resultVariable: string }>;
        const mergeStrategy = (node.data.config.mergeStrategy as string) || 'OBJECT';
        if (branches) {
          if (mergeStrategy === 'ARRAY') {
            addVar('parallelResults', nodeName);
          } else if (mergeStrategy === 'OBJECT') {
            branches.forEach((b) => {
              const key = b.resultVariable || b.name;
              if (key) addVar(key, nodeName);
            });
          }
        }
      }
    }
    return vars;
  }, [selectedNodeId, nodes, edges]);
}

/**
 * 条件分支配置面板
 *
 * === 后端执行流程 (ConditionNodeExecutor) ===
 * 1. 模式一（多条件分支列表）: config.conditions 非空时使用
 *    - 遍历 conditions[]，按 conditionType 评估：
 *      · EXPRESSION: 直接执行表达式（支持 ${变量名} 引用）
 *      · VARIABLE (默认): 取 variable 的运行时值，用 operator 与 compareValue 比较
 *    - 第一个匹配的条件 → output.branch = conditionName, output.matchedBranch = conditionName
 *    - 全部不匹配 → output.branch = "default", output.matchedBranch = "default"
 *
 * 2. 模式二（向后兼容单条件）: conditions 为空时使用
 *    - 取 config.variable / operator / value
 *    - 匹配 → output.branch = "true"  |  不匹配 → output.branch = "false"
 *
 * === 引擎路由 (DefaultWorkflowEngine.executeFromNode) ===
 * - 引擎遍历出边，精确匹配 edge.sourceHandle == output.branch 或 output.matchedBranch
 * - 如果 sourceHandle 为空且 branch=="true" → 走该边（兼容默认 Handle）
 * - 所有都不匹配 → 走 sourceHandle="default" 或空 Handle 的 fallback 边
 * - 完全无匹配边 → 抛 IllegalStateException（工作流中断！）
 *
 * ⚠ 重要：前端节点只有 2 个 Handle（默认 + "false"），多条件模式下所有匹配分支和
 *   "default" 都走默认 Handle，"false" Handle 仅在单条件模式(branch="false")下有效。
 *
 * === 边界条件（与后端对齐） ===
 * - config 为 null → 使用空 Map，走单条件模式（result=false）
 * - conditions 列表中某项 variable 和 compareValue 都为空 → 后端跳过该项（warn 日志）
 * - EXPRESSION 中引用的变量不存在 → 视为不匹配（不抛异常）
 * - 数值比较失败时回退到字符串字典序比较
 * - input 为 null → 视为空 Map，所有变量解析返回 null
 * - null 参与比较: null == null → true, null 与其他值 → false
 *
 * === 前端校验 ===
 * - conditions 为空 → 警告（至少需要一个分支）
 * - 部分条件未完整配置 → 警告（执行时视为不匹配）
 * - 分支名称为空 → 警告（路由依赖 matchedBranch）
 * - 分支名称重复 → 警告（路由不确定）
 */
const ConditionConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();

  const conditions = ((config.conditions as ConditionBranch[]) || []);

  const addBranch = () => {
    const newBranch: ConditionBranch = {
      name: `条件 ${conditions.length + 1}`,
      conditionType: 'VARIABLE_COMPARE',
      variable: '', operator: '==', compareValue: '', expression: '',
    };
    onUpdate({ conditions: [...conditions, newBranch] });
  };

  const updateBranch = (index: number, field: string, value: unknown) => {
    const updated = conditions.map((b, i) => i === index ? { ...b, [field]: value } : b);
    onUpdate({ conditions: updated });
  };

  const removeBranch = (index: number) => {
    onUpdate({ conditions: conditions.filter((_, i) => i !== index) });
  };

  // 向表达式末尾追加文本
  const appendToConditionExpr = (idx: number, text: string) => {
    const cur = conditions[idx]?.expression || '';
    updateBranch(idx, 'expression', cur + text);
  };

  const noValueOps = ['isEmpty', 'isNotEmpty'];

  // 实时校验
  const hasIncomplete = conditions.some((b) => {
    if (b.conditionType === 'EXPRESSION') return !b.expression || b.expression.trim() === '';
    return !b.variable || b.variable.trim() === '';
  });
  const hasDuplicateName = conditions.length > 1 &&
    new Set(conditions.map(b => b.name.trim()).filter(Boolean)).size < conditions.filter(b => b.name.trim()).length;
  const hasEmptyName = conditions.some(b => !b.name || b.name.trim() === '');

  return (
    <div className="space-y-4">
      {/* 校验警告 */}
      {conditions.length === 0 && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            <strong>未配置条件分支。</strong>条件节点至少需要一个分支，否则执行时会校验失败。
          </p>
        </div>
      )}
      {hasIncomplete && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            部分分支的条件未完整配置（缺少变量或表达式），执行时将视为不匹配。
          </p>
        </div>
      )}
      {hasEmptyName && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            部分分支名称为空，后端用分支名做出边路由（matchedBranch），名称为空可能导致路由失败。
          </p>
        </div>
      )}
      {hasDuplicateName && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            存在重复的分支名称，后端按 matchedBranch 做出边路由，重名会导致路由不确定。
          </p>
        </div>
      )}

      <div className="flex items-center justify-between">
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">条件分支</label>
        <button onClick={addBranch} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
          <Plus size={14} /> 添加分支
        </button>
      </div>

      {conditions.length === 0 && (
        <p className="text-xs text-gray-400 dark:text-gray-500 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">
          暂无条件分支，点击"添加分支"开始配置
        </p>
      )}

      {conditions.map((branch, idx) => (
        <div key={idx} className="p-3 bg-gray-50 dark:bg-gray-800/30 rounded-xl border border-gray-200 dark:border-gray-700 space-y-2.5">
          {/* 分支头部 */}
          <div className="flex items-center justify-between">
            <input
              type="text" value={branch.name} placeholder="分支名称"
              onChange={(e) => updateBranch(idx, 'name', e.target.value)}
              className="text-xs font-bold text-gray-600 dark:text-gray-300 bg-transparent border-none outline-none w-32 placeholder-gray-400"
            />
            <div className="flex items-center gap-1">
              {/* 模式切换 */}
              <button
                onClick={() => updateBranch(idx, 'conditionType', branch.conditionType === 'EXPRESSION' ? 'VARIABLE_COMPARE' : 'EXPRESSION')}
                className={`px-2 py-0.5 text-[10px] font-bold rounded-md transition-colors ${
                  branch.conditionType === 'EXPRESSION'
                    ? 'bg-amber-100 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400'
                    : 'bg-brand-100 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400'
                }`}
              >
                {branch.conditionType === 'EXPRESSION' ? '公式' : '可视化'}
              </button>
              <button onClick={() => removeBranch(idx)} className="p-1 text-gray-400 hover:text-red-500 rounded transition-colors">
                <Trash2 size={13} />
              </button>
            </div>
          </div>

          {branch.conditionType === 'EXPRESSION' ? (
            /* 表达式模式 */
            <div className="space-y-1.5">
              <textarea
                value={branch.expression} rows={2}
                onChange={(e) => updateBranch(idx, 'expression', e.target.value)}
                placeholder='例: ${score} > 80 或 ${status} == "active"'
                className={textareaClass}
              />
              {/* 变量快捷插入 */}
              {upstreamVars.length > 0 && (
                <div className="space-y-1">
                  <span className="text-[10px] text-gray-400 font-medium">插入变量:</span>
                  <div className="flex flex-wrap gap-1">
                    {upstreamVars.map((v, vi) => (
                      <button key={vi} onClick={() => appendToConditionExpr(idx, `\${${v.value}}`)}
                        className="px-1.5 py-0.5 text-[10px] bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded border border-brand-200 dark:border-brand-800 hover:bg-brand-100 dark:hover:bg-brand-900/40 transition-colors font-mono">
                        {v.label}
                      </button>
                    ))}
                  </div>
                </div>
              )}
              {/* 运算符快捷插入 */}
              <div className="space-y-1">
                <span className="text-[10px] text-gray-400 font-medium">运算符:</span>
                <div className="flex flex-wrap gap-1">
                  {SWITCH_EXPR_OPS.map((op) => (
                    <button key={op.value} onClick={() => appendToConditionExpr(idx, ` ${op.value} `)}
                      title={op.desc}
                      className="px-2 py-1 text-xs font-bold rounded-lg border transition-all bg-white dark:bg-gray-800 text-gray-500 dark:text-gray-400 border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-600 font-mono">
                      {op.label}
                    </button>
                  ))}
                </div>
              </div>
            </div>
          ) : (
            /* 可视化模式 */
            <div className="space-y-2">
              {/* 变量选择 */}
              <div className="relative">
                {upstreamVars.length > 0 ? (
                  <select
                    value={branch.variable}
                    onChange={(e) => updateBranch(idx, 'variable', e.target.value)}
                    className={selectClass}
                  >
                    <option value="">选择变量...</option>
                    {upstreamVars.map((v, vi) => (
                      <option key={vi} value={v.value}>{v.label}</option>
                    ))}
                  </select>
                ) : (
                  <input
                    type="text" value={branch.variable} placeholder="输入变量名"
                    onChange={(e) => updateBranch(idx, 'variable', e.target.value)}
                    className={inputClass}
                  />
                )}
              </div>

              {/* 运算符按钮 */}
              <div className="flex flex-wrap gap-1">
                {OPERATORS.map((op) => (
                  <button
                    key={op.value}
                    onClick={() => updateBranch(idx, 'operator', op.value)}
                    title={op.desc}
                    className={`px-2 py-1 text-xs font-bold rounded-lg border transition-all ${
                      branch.operator === op.value
                        ? 'bg-brand-600 text-white border-brand-600 shadow-sm'
                        : 'bg-white dark:bg-gray-800 text-gray-500 dark:text-gray-400 border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-600'
                    }`}
                  >
                    {op.label}
                  </button>
                ))}
              </div>

              {/* 比较值输入 */}
              {!noValueOps.includes(branch.operator) && (
                <input
                  type="text" value={branch.compareValue} placeholder="比较值"
                  onChange={(e) => updateBranch(idx, 'compareValue', e.target.value)}
                  className={inputClass}
                />
              )}
            </div>
          )}
        </div>
      ))}

      {conditions.length > 0 && (
        <p className="text-xs text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-800/50 rounded-lg px-3 py-2 border border-gray-200 dark:border-gray-700">
          按顺序匹配，首个满足条件的分支生效。所有条件不满足时走默认分支。
        </p>
      )}
    </div>
  );
};

// ===== 多路分支(Switch)配置 =====
interface SwitchCase {
  name: string;
  value: string;
  expression: string;
  matchMode: 'VALUE' | 'EXPRESSION';
}

const SWITCH_EXPR_OPS = OPERATORS.filter((o) => o.value !== 'isEmpty' && o.value !== 'isNotEmpty');

/**
 * 多路分支(Switch)配置面板
 *
 * === 后端执行流程 (SwitchNodeExecutor) ===
 * 1. 取 config.switchVariable 对应的运行时值 actualValue（null → 空字符串 ""）
 * 2. 遍历 config.cases[]，按 matchMode 评估：
 *    · EXPRESSION: 执行表达式（支持 ${变量名} 引用），独立于 switchVariable
 *    · MULTI_VALUE: 检查 case.values[] 是否包含 actualValue
 *    · VALUE (默认): 单值精确匹配 case.value == actualValue（均转字符串比较）
 * 3. 第一个匹配 → output.branch = caseName, output.matchedBranch = caseName
 * 4. 全部不匹配 → output.branch = "default", output.matchedBranch = "default"
 *
 * === 引擎路由 ===
 * - 与 ConditionNode 共用同一路由逻辑（精确匹配 sourceHandle → fallback）
 * - Switch 输出 branch 为 caseName 或 "default"，永远不会是 "false"
 *
 * ⚠ 重要：前端节点 Handle 只有默认 + "false"。Switch 的所有 Case（含 "default"）
 *   在引擎中都无法精确匹配 "false" Handle，全部走默认 Handle。
 *   "false" Handle 在 Switch 节点上实际不会被触发。
 *
 * === 边界条件（与后端对齐） ===
 * - config 为 null → switchVariable="", cases=空列表 → 走 default
 * - actualValue 为 null → 转为空字符串参与比较
 * - case.expression 中变量不存在 → 视为不匹配
 * - case.values 为 null → 跳过多值匹配
 * - case name 为空 → 后端自动生成 "case_N"，但建议前端填写
 *
 * === 前端校验 ===
 * - switchVariable 为空 → 警告 | cases 为空 → 警告
 * - 匹配值/表达式为空 → 警告（永不命中）
 * - Case 名称为空/重复 → 警告（路由问题）
 */
const SwitchConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();

  const cases = ((config.cases as SwitchCase[]) || []);

  const addCase = () => {
    onUpdate({ cases: [...cases, { name: `分支 ${cases.length + 1}`, value: '', expression: '', matchMode: 'VALUE' }] });
  };
  const updateCase = (i: number, field: string, val: unknown) => {
    onUpdate({ cases: cases.map((c, idx) => idx === i ? { ...c, [field]: val } : c) });
  };
  const removeCase = (i: number) => {
    onUpdate({ cases: cases.filter((_, idx) => idx !== i) });
  };

  // 向表达式末尾追加文本
  const appendToExpr = (idx: number, text: string) => {
    const cur = cases[idx]?.expression || '';
    updateCase(idx, 'expression', cur + text);
  };

  const switchVar = (config.switchVariable as string) || '';
  const hasEmptyValueCase = cases.some((c) => c.matchMode !== 'EXPRESSION' && (!c.value || c.value.trim() === ''));
  const hasEmptyExprCase = cases.some((c) => c.matchMode === 'EXPRESSION' && (!c.expression || c.expression.trim() === ''));
  const hasDuplicateCaseName = cases.length > 1 &&
    new Set(cases.map(c => c.name.trim()).filter(Boolean)).size < cases.filter(c => c.name.trim()).length;
  const hasEmptyCaseName = cases.some(c => !c.name || c.name.trim() === '');

  return (
    <div className="space-y-4">
      {/* 校验警告 */}
      {!switchVar && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            <strong>未设置判断变量。</strong>值匹配模式下必须指定判断变量，否则执行时会校验失败。
          </p>
        </div>
      )}
      {cases.length === 0 && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            <strong>未配置任何 Case 分支。</strong>所有请求将走默认分支。
          </p>
        </div>
      )}
      {hasEmptyValueCase && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            部分 Case 分支的匹配值为空，这些分支永远不会命中。
          </p>
        </div>
      )}
      {hasEmptyExprCase && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            部分 Case 分支的表达式为空，这些分支永远不会命中。
          </p>
        </div>
      )}
      {hasEmptyCaseName && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            部分 Case 名称为空，后端用 Case 名做出边路由（matchedBranch），名称为空可能导致路由失败。
          </p>
        </div>
      )}
      {hasDuplicateCaseName && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            存在重复的 Case 名称，后端按 matchedBranch 做出边路由，重名会导致路由不确定。
          </p>
        </div>
      )}

      <ConfigField label="判断变量">
        {upstreamVars.length > 0 ? (
          <select value={switchVar} onChange={(e) => onUpdate({ switchVariable: e.target.value })} className={selectClass}>
            <option value="">选择变量...</option>
            {upstreamVars.map((v, i) => <option key={i} value={v.value}>{v.label}</option>)}
          </select>
        ) : (
          <input type="text" value={switchVar} onChange={(e) => onUpdate({ switchVariable: e.target.value })} placeholder="输入变量名，如 status" className={inputClass} />
        )}
        <p className="text-[10px] text-gray-400 mt-1">值匹配模式下，此变量的值与每个 Case 的值比较</p>
      </ConfigField>

      <div className="flex items-center justify-between">
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Case 分支</label>
        <button onClick={addCase} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
          <Plus size={14} /> 添加
        </button>
      </div>

      {cases.length === 0 && (
        <p className="text-xs text-gray-400 dark:text-gray-500 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">暂无分支，点击"添加"配置</p>
      )}

      {cases.map((c, idx) => (
        <div key={idx} className="p-3 bg-gray-50 dark:bg-gray-800/30 rounded-xl border border-gray-200 dark:border-gray-700 space-y-2">
          <div className="flex items-center justify-between">
            <input type="text" value={c.name} onChange={(e) => updateCase(idx, 'name', e.target.value)} placeholder="分支名称" className="text-xs font-bold text-gray-600 dark:text-gray-300 bg-transparent border-none outline-none w-28 placeholder-gray-400" />
            <div className="flex items-center gap-1">
              <button onClick={() => {
                const newMode = c.matchMode === 'EXPRESSION' ? 'VALUE' : 'EXPRESSION';
                // 切换模式时清除对方字段，避免后端按优先级(expression > values > value)误判
                const updated = cases.map((cc, ci) => ci === idx
                  ? { ...cc, matchMode: newMode, ...(newMode === 'EXPRESSION' ? { value: '' } : { expression: '' }) }
                  : cc);
                onUpdate({ cases: updated });
              }}
                className={`px-2 py-0.5 text-[10px] font-bold rounded-md transition-colors ${c.matchMode === 'EXPRESSION' ? 'bg-amber-100 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400' : 'bg-brand-100 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400'}`}>
                {c.matchMode === 'EXPRESSION' ? '公式' : '值匹配'}
              </button>
              <button onClick={() => removeCase(idx)} className="p-1 text-gray-400 hover:text-red-500 rounded transition-colors"><Trash2 size={13} /></button>
            </div>
          </div>

          {c.matchMode === 'EXPRESSION' ? (
            <div className="space-y-1.5">
              <textarea value={c.expression} onChange={(e) => updateCase(idx, 'expression', e.target.value)} rows={2}
                placeholder='例: ${score} > 80 或 ${status} == "active"'
                className={textareaClass} />
              {/* 变量快捷插入 */}
              {upstreamVars.length > 0 && (
                <div className="space-y-1">
                  <span className="text-[10px] text-gray-400 font-medium">插入变量:</span>
                  <div className="flex flex-wrap gap-1">
                    {upstreamVars.map((v, vi) => (
                      <button key={vi} onClick={() => appendToExpr(idx, `\${${v.value}}`)}
                        className="px-1.5 py-0.5 text-[10px] bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded border border-brand-200 dark:border-brand-800 hover:bg-brand-100 dark:hover:bg-brand-900/40 transition-colors font-mono">
                        {v.label}
                      </button>
                    ))}
                  </div>
                </div>
              )}
              {/* 运算符快捷插入 */}
              <div className="space-y-1">
                <span className="text-[10px] text-gray-400 font-medium">运算符:</span>
                <div className="flex flex-wrap gap-1">
                  {SWITCH_EXPR_OPS.map((op) => (
                    <button key={op.value} onClick={() => appendToExpr(idx, ` ${op.value} `)}
                      title={op.desc}
                      className="px-2 py-1 text-xs font-bold rounded-lg border transition-all bg-white dark:bg-gray-800 text-gray-500 dark:text-gray-400 border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-600 font-mono">
                      {op.label}
                    </button>
                  ))}
                </div>
              </div>
            </div>
          ) : (
            <input type="text" value={c.value} onChange={(e) => updateCase(idx, 'value', e.target.value)} placeholder="匹配值（精确匹配判断变量的值）" className={inputClass} />
          )}
        </div>
      ))}

      {cases.length > 0 && (
        <p className="text-xs text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-800/50 rounded-lg px-3 py-2 border border-gray-200 dark:border-gray-700">
          <strong>值匹配</strong>：精确比较"判断变量"和 Case 值。<br/>
          <strong>公式模式</strong>：支持表达式如 <code className="bg-gray-200 dark:bg-gray-700 px-1 rounded text-[10px]">{'${score}'} {'>'} 80</code>，可使用上游任意变量。<br/>
          按顺序匹配，首个命中分支生效。无匹配走默认分支。
        </p>
      )}
    </div>
  );
};

// ===== 循环(Loop)配置 =====
const LOOP_TYPES = [
  { value: 'FOR_EACH', label: 'forEach' },
  { value: 'FOR_COUNT', label: 'for (count)' },
  { value: 'WHILE', label: 'while' },
];


/**
 * 循环节点配置面板
 *
 * === 后端执行模型 ===
 * LOOP 节点有两种执行模式：
 * 1. 容器模式（主要）: 当 LOOP 节点包含子节点时（children.nodes 非空），
 *    由 DefaultWorkflowEngine.executeLoopContainer() 处理：
 *    - 通过 sourceHandle="loop-start" 的边找到循环体入口节点
 *    - 每次迭代执行 executeFromNode(入口节点)，循环体走到 LOOP_END 或无出边时结束
 *    - 支持 _loopBreak 变量提前跳出
 *    - 迭代失败时记录 loopError 并终止循环（返回部分结果，不抛异常）
 *
 * 2. Fallback 模式: 无子节点时由 LoopNodeExecutor 直接处理（仅做变量模拟）
 *
 * === 循环类型 ===
 * - FOR_EACH: 遍历数组变量，每次迭代设置 itemVariable + indexVariable
 * - FOR_COUNT: 指定次数循环，每次迭代设置 counterVariable + indexVariable
 * - WHILE: 每次迭代前重新评估条件表达式，为 false 时终止
 *
 * === 引擎路由 ===
 * - 循环容器完成后，走 sourceHandle="output" 的出边到后续节点
 * - 循环体内部节点走内部连线 (LOOP_START → 子节点 → ... → LOOP_END)
 * - 引擎跳过 targetHandle="loop-end" 和 sourceHandle="loop-start" 的边
 *
 * === 输出变量 ===
 * - {resultVariable}: 每次迭代结果的数组
 * - loopCount: 实际执行的迭代次数
 * - loopCompleted: 是否全部完成 (true/false)
 * - loopError: 如果有错误，记录错误信息
 *
 * === 边界条件（与后端对齐） ===
 * - config 为 null → 默认值 (loopType=FOR_EACH, maxIterations=100)
 * - loopType 为 null → 默认 FOR_EACH
 * - FOR_EACH 数组变量为 null/非数组 → 视为空数组，循环 0 次
 * - FOR_COUNT loopCount ≤ 0 → 循环不执行
 * - 迭代次数超过 maxIterations → 截断并 warn
 * - maxIterations ≤ 0 → 后端修正为 100
 * - WHILE 条件为空/null → 视为 false，不执行（防止死循环）
 * - 空 itemVariable/indexVariable/counterVariable → 后端回退到默认值
 *
 * === 前端校验 ===
 * - FOR_EACH 数组变量为空 → 警告
 * - FOR_COUNT loopCount ≤ 0 → 警告
 * - WHILE 条件为空 → 警告
 * - loopCount / maxIterations 输入保护: Math.max(1, ...) 防止负数
 */
const LoopConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();
  const loopType = (config.loopType as string) || 'FOR_EACH';
  const whileCondRef = React.useRef<HTMLTextAreaElement>(null);

  const insertWhileVar = (varRef: string) => {
    const ta = whileCondRef.current;
    const cur = (config.whileCondition as string) || '';
    if (ta) {
      const start = ta.selectionStart;
      const end = ta.selectionEnd;
      const newVal = cur.slice(0, start) + varRef + cur.slice(end);
      onUpdate({ whileCondition: newVal });
      requestAnimationFrame(() => { ta.selectionStart = ta.selectionEnd = start + varRef.length; ta.focus(); });
    } else {
      onUpdate({ whileCondition: cur + varRef });
    }
  };

  return (
    <div className="space-y-3">
      {/* 容器提示 */}
      <div className="p-2.5 bg-amber-50 dark:bg-amber-900/10 rounded-lg border border-amber-200 dark:border-amber-800/50">
        <p className="text-[10px] text-amber-700 dark:text-amber-400 leading-relaxed">
          <b>容器模式：</b>从左侧工具栏拖拽节点放入循环容器内部，再从蓝色起始圆点连线到第一个节点，构建循环体。每次迭代会依次执行容器内的子工作流。
        </p>
      </div>
      <div className="p-2.5 bg-blue-50 dark:bg-blue-900/10 rounded-lg border border-blue-200 dark:border-blue-800/50">
        <p className="text-[10px] text-blue-700 dark:text-blue-400 leading-relaxed">
          <b>变量作用域：</b>循环体内的变量修改会直接写入全局上下文，下一轮迭代使用的是上一轮修改后的值。如需保留每轮独立结果，请使用"结果变量"收集。
        </p>
      </div>

      <ConfigField label="循环类型">
        <select value={loopType} onChange={(e) => onUpdate({ loopType: e.target.value })} className={selectClass}>
          {LOOP_TYPES.map((t) => <option key={t.value} value={t.value}>{t.label}</option>)}
        </select>
      </ConfigField>

      {loopType === 'FOR_EACH' && !((config.iterableVariable as string) || '').trim() && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            <strong>未指定数组变量。</strong>forEach 循环需要指定要遍历的数组变量，否则执行时将视为空数组，循环体不会执行。
          </p>
        </div>
      )}
      {loopType === 'WHILE' && !((config.whileCondition as string) || '').trim() && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            <strong>未设置循环条件。</strong>while 循环需要配置条件表达式，否则默认为 false，循环体不会执行。
          </p>
        </div>
      )}
      {loopType === 'FOR_COUNT' && config.loopCount != null && (config.loopCount as number) <= 0 && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            <strong>循环次数无效。</strong>循环次数必须大于 0，后端会跳过执行（loopCount &le; 0 时循环体不执行）。
          </p>
        </div>
      )}

      {loopType === 'FOR_EACH' && (
        <>
          <ConfigField label="Array Variable">
            {upstreamVars.length > 0 ? (
              <select value={(config.iterableVariable as string) || ''} onChange={(e) => onUpdate({ iterableVariable: e.target.value })} className={selectClass}>
                <option value="">选择变量...</option>
                {upstreamVars.map((v, i) => <option key={i} value={v.value}>{v.label}</option>)}
              </select>
            ) : (
              <input type="text" value={(config.iterableVariable as string) || ''} onChange={(e) => onUpdate({ iterableVariable: e.target.value })} placeholder="items" className={inputClass} />
            )}
          </ConfigField>
          <ConfigField label="当前元素变量名">
            <input type="text" value={(config.itemVariable as string) || 'item'} onChange={(e) => onUpdate({ itemVariable: e.target.value })} placeholder="item" className={inputClass} />
            <p className="text-[10px] text-gray-400 mt-1">循环体内部节点可通过此变量名访问当前元素</p>
          </ConfigField>
        </>
      )}

      {loopType === 'FOR_COUNT' && (
        <>
          <ConfigField label="循环次数">
            <input type="number" min="1" max="1000" value={(config.loopCount as number) ?? 1} onChange={(e) => onUpdate({ loopCount: Math.max(1, parseInt(e.target.value) || 1) })} className={inputClass} />
          </ConfigField>
          <ConfigField label="计数器变量名">
            <input type="text" value={(config.counterVariable as string) || (config.indexVariable as string) || 'index'} onChange={(e) => onUpdate({ counterVariable: e.target.value })} placeholder="index" className={inputClass} />
          </ConfigField>
        </>
      )}

      {loopType === 'WHILE' && (
        <>
          <ConfigField label="循环条件表达式">
            <textarea
              ref={whileCondRef}
              value={(config.whileCondition as string) || ''}
              onChange={(e) => onUpdate({ whileCondition: e.target.value })}
              rows={2}
              placeholder='例: ${retryCount} < 3'
              className={textareaClass}
            />
            {upstreamVars.length > 0 && (
              <div className="space-y-1 mt-1.5">
                <span className="text-[10px] text-gray-400 font-medium">插入变量:</span>
                <div className="flex flex-wrap gap-1">
                  {upstreamVars.map((v, vi) => (
                    <button key={vi} onClick={() => insertWhileVar(`\${${v.value}}`)}
                      className="px-1.5 py-0.5 text-[10px] bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded border border-brand-200 dark:border-brand-800 hover:bg-brand-100 dark:hover:bg-brand-900/40 transition-colors font-mono">
                      {v.label}
                    </button>
                  ))}
                </div>
              </div>
            )}
          </ConfigField>
          <p className="text-[10px] text-gray-400">变量用 <code className="bg-gray-200 dark:bg-gray-700 px-1 rounded">${'${变量名}'}</code> 引用，条件为 true 时继续循环</p>
        </>
      )}

      <ConfigField label="索引变量名">
        <input type="text" value={(config.indexVariable as string) || 'index'} onChange={(e) => onUpdate({ indexVariable: e.target.value })} placeholder="index" className={inputClass} />
      </ConfigField>

      <ConfigField label="最大迭代次数">
        <input type="number" min="1" max="1000" value={(config.maxIterations as number) ?? 100} onChange={(e) => onUpdate({ maxIterations: Math.max(1, Math.min(parseInt(e.target.value) || 100, 1000)) })} className={inputClass} />
        <p className="text-[10px] text-gray-400 mt-1">上限 1000，防止死循环耗尽资源</p>
      </ConfigField>

      <ConfigField label="结果变量名">
        <input type="text" value={(config.resultVariable as string) || 'loopResults'} onChange={(e) => onUpdate({ resultVariable: e.target.value })} placeholder="loopResults" className={inputClass} />
      </ConfigField>
    </div>
  );
};

// ===== 并行(Parallel)配置 =====
interface ParallelBranch {
  name: string;
  startNodeId: string;
  resultVariable: string;
  optional: boolean;
}

/**
 * 并行节点配置面板
 *
 * === 后端执行流程 (DefaultWorkflowEngine.executeParallelContainer) ===
 * 1. 读取 config.branches[]，过滤出有效分支（startNodeId 非空）
 * 2. 为每个分支创建独立的 WorkflowExecution 副本 (forkForBranch)，避免变量竞态
 * 3. 用 CompletableFuture + 线程池并行执行所有分支
 * 4. 根据 waitStrategy 等待分支完成：
 *    - ALL: 等待所有分支（超时则取消未完成分支）
 *    - ANY: 任一分支成功完成后取消其余
 *    - N_OF_M: 等待指定数量的分支成功 (requiredCount)
 * 5. failFast 检查: 非 optional 分支失败时抛异常
 * 6. 根据 mergeStrategy 合并结果：
 *    - OBJECT: 以 resultVariable 或 branchName 为 key 存入 output
 *    - ARRAY: 所有结果存入 parallelResults 数组
 *    - FIRST: 取第一个成功完成的分支结果
 *    - LAST: 取最后一个成功完成的分支结果
 *
 * === 引擎路由 ===
 * - 并行完成后，走普通出边（非 loop-start/loop-end）到后续节点
 * - 分支入口来自 config.branches[].startNodeId
 *
 * === 输出变量 ===
 * - 合并后的分支数据（取决于 mergeStrategy）
 * - parallelCount: 成功完成的分支数 | parallelErrors: 失败数
 * - parallelCompleted: 是否全部成功
 *
 * === 边界条件（与后端对齐） ===
 * - branches 为空/所有 startNodeId 未设置 → 跳过并行，返回警告
 * - 分支超时 → 标记 CANCELLED，中断分支线程
 * - requiredCount ≤ 0 → 后端修正为 1
 * - failFast + optional 分支失败 → 不触发 failFast
 * - 分支名重复 → OBJECT 策略下结果覆盖 | resultVariable 重复 → 同理
 *
 * === 前端校验 ===
 * - 无有效分支 → 警告 | 部分分支未选择入口 → 警告
 * - 分支名称为空/重复 → 警告 | resultVariable 重复 → 警告
 * - N_OF_M requiredCount > 分支数 → 警告
 * - timeout 输入保护: Math.max(1000, ...)
 */
const ParallelConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const selectedNodeId = useWorkflowStore((s) => s.selectedNodeId);
  const nodes = useWorkflowStore((s) => s.nodes);
  const branches = ((config.branches as ParallelBranch[]) || []);

  // 可选的分支入口节点：排除自身、START、END 节点
  const availableNodes = React.useMemo(() => {
    return nodes.filter((n) => {
      if (n.id === selectedNodeId) return false;
      const nt = n.data.nodeType;
      if (nt === NodeType.START || nt === NodeType.END || nt === NodeType.LOOP_START || nt === NodeType.LOOP_END) return false;
      return true;
    });
  }, [nodes, selectedNodeId]);

  // 校验：是否有有效分支
  const hasValidBranch = branches.some((b) => b.startNodeId && b.startNodeId.trim() !== '');
  const hasBranchMissingEntry = branches.length > 0 && branches.some((b) => !b.startNodeId || b.startNodeId.trim() === '');
  const hasDuplicateBranchName = branches.length > 1 &&
    new Set(branches.map(b => b.name.trim()).filter(Boolean)).size < branches.filter(b => b.name.trim()).length;
  const hasEmptyBranchName = branches.some(b => !b.name || b.name.trim() === '');
  const hasDuplicateResultVar = (() => { const vars = branches.map(b => b.resultVariable?.trim()).filter(Boolean); return vars.length > 1 && new Set(vars).size < vars.length; })();

  const addBranch = () => {
    onUpdate({ branches: [...branches, { name: `分支 ${branches.length + 1}`, startNodeId: '', resultVariable: '', optional: false }] });
  };
  const updateBranch = (i: number, field: string, val: unknown) => {
    onUpdate({ branches: branches.map((b, idx) => idx === i ? { ...b, [field]: val } : b) });
  };
  const removeBranch = (i: number) => {
    onUpdate({ branches: branches.filter((_, idx) => idx !== i) });
  };

  return (
    <div className="space-y-4">
      {/* 校验警告 */}
      {!hasValidBranch && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            <strong>未配置有效分支。</strong>并行节点需要至少添加一个分支并选择入口节点，否则执行时将跳过并行逻辑直接通过。
          </p>
        </div>
      )}
      {hasBranchMissingEntry && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            部分分支尚未选择入口节点，这些分支在执行时会被忽略。
          </p>
        </div>
      )}
      {hasEmptyBranchName && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            部分分支名称为空，后端用分支名标识并行分支结果，建议为每个分支设置有意义的名称。
          </p>
        </div>
      )}
      {hasDuplicateBranchName && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            存在重复的分支名称，后端用分支名标识并行分支结果，重名会导致结果覆盖。
          </p>
        </div>
      )}
      {hasDuplicateResultVar && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            多个分支使用了相同的结果变量名，后完成的分支会覆盖先完成分支的结果。
          </p>
        </div>
      )}

      <ConfigField label="等待策略">
        <select value={(config.waitStrategy as string) || 'ALL'} onChange={(e) => onUpdate({ waitStrategy: e.target.value })} className={selectClass}>
          <option value="ALL">等待全部完成</option>
          <option value="ANY">任一完成即可</option>
          <option value="N_OF_M">完成 N 个即可</option>
        </select>
      </ConfigField>

      {(config.waitStrategy as string) === 'N_OF_M' && (
        <>
          <ConfigField label="需完成数量">
            <input type="number" min="1" max={Math.max(branches.length, 1)} value={(config.requiredCount as number) ?? 1} onChange={(e) => onUpdate({ requiredCount: Math.min(parseInt(e.target.value) || 1, Math.max(branches.length, 1)) })} className={inputClass} />
          </ConfigField>
          {((config.requiredCount as number) ?? 1) > branches.length && branches.length > 0 && (
            <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
              <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
              <p className="text-xs text-amber-700 dark:text-amber-400">
                需完成数量 ({(config.requiredCount as number) ?? 1}) 超过分支数 ({branches.length})，可能导致等待超时。
              </p>
            </div>
          )}
        </>
      )}

      <ConfigField label="超时 (ms)">
        <input type="number" min="1000" step="1000" value={(config.timeout as number) ?? 60000} onChange={(e) => onUpdate({ timeout: Math.max(1000, parseInt(e.target.value) || 60000) })} className={inputClass} />
      </ConfigField>

      <ConfigField label="快速失败">
        <ConfigCheckbox checked={(config.failFast as boolean) || false}
          onChange={(v) => onUpdate({ failFast: v })}
          label="任一分支失败时终止其他分支" />
      </ConfigField>

      <div className="flex items-center justify-between">
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">并行分支</label>
        <button onClick={addBranch} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
          <Plus size={14} /> 添加
        </button>
      </div>

      {branches.length === 0 && (
        <p className="text-xs text-gray-400 dark:text-gray-500 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">
          暂无并行分支，添加分支并选择入口节点
        </p>
      )}

      {branches.map((b, idx) => (
        <div key={idx} className="p-3 bg-gray-50 dark:bg-gray-800/30 rounded-xl border border-gray-200 dark:border-gray-700 space-y-2">
          <div className="flex items-center justify-between">
            <input type="text" value={b.name} onChange={(e) => updateBranch(idx, 'name', e.target.value)} placeholder="分支名称" className="text-xs font-bold text-gray-600 dark:text-gray-300 bg-transparent border-none outline-none w-32 placeholder-gray-400" />
            <button onClick={() => removeBranch(idx)} className="p-1 text-gray-400 hover:text-red-500 rounded transition-colors"><Trash2 size={13} /></button>
          </div>
          <div>
            <label className="text-[10px] text-gray-400 dark:text-gray-500 mb-1 block">入口节点</label>
            <select value={b.startNodeId} onChange={(e) => updateBranch(idx, 'startNodeId', e.target.value)} className={selectClass}>
              <option value="">选择分支入口节点...</option>
              {availableNodes.map((n) => (
                <option key={n.id} value={n.id}>{n.data.label} ({n.data.nodeType})</option>
              ))}
            </select>
          </div>
          <input type="text" value={b.resultVariable} onChange={(e) => updateBranch(idx, 'resultVariable', e.target.value)} placeholder="结果变量名（如 branch1Result）" className={inputClass} />
          <ConfigCheckbox checked={b.optional} onChange={(v) => updateBranch(idx, 'optional', v)}
            label="可选分支（失败不影响整体）" />
        </div>
      ))}

      <ConfigField label="结果合并策略">
        <select value={(config.mergeStrategy as string) || 'OBJECT'} onChange={(e) => onUpdate({ mergeStrategy: e.target.value })} className={selectClass}>
          <option value="OBJECT">Merge to Object</option>
          <option value="ARRAY">Collect to Array</option>
          <option value="FIRST">First Result</option>
          <option value="LAST">Last Result</option>
        </select>
      </ConfigField>

      <div className="flex items-start gap-2 px-3 py-2.5 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl">
        <span className="text-red-500 mt-0.5 shrink-0">⚠</span>
        <p className="text-xs text-red-700 dark:text-red-400">
          <strong>竞态风险：</strong>并行分支共享变量上下文，多个分支同时修改同一变量会导致数据竞争。建议每个分支操作独立的变量（如 branch1Result、branch2Result），避免在并行分支中修改同一全局变量。
        </p>
      </div>

      <p className="text-xs text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-800/50 rounded-lg px-3 py-2 border border-gray-200 dark:border-gray-700">
        每个分支指定一个入口节点，引擎会从该节点开始并行执行其链路。未配置分支时，将使用出边连接的节点作为并行分支。
      </p>
    </div>
  );
};

/**
 * 合并(Merge)节点配置面板
 *
 * === 后端执行流程 (MergeNodeExecutor) ===
 * 1. 读取 config: mode(合并模式), sources(来源变量列表), outputVariable(输出变量名)
 * 2. 从执行上下文的 input（上游所有变量）中收集数据：
 *    - sources 非空: 只提取指定变量名对应的值
 *    - sources 为空: 合并所有输入变量（过滤 _ 前缀的内部变量）
 * 3. 根据 mode 合并:
 *    - "all": 将所有收集的 key-value 存入 outputVariable（Map 形式）
 *    - "first": 只取第一个非 null 的值
 *    - "last": 只取最后一个非 null 的值
 *    - 未知 mode → 回退到 "all"
 *
 * === 引擎路由 ===
 * - Merge 是普通节点，走标准出边路由（第一条满足条件的出边）
 * - 通常放在并行节点之后，用于汇聚多个分支的数据
 *
 * === 输出变量 ===
 * - {outputVariable}: 合并后的数据 (Map 或单值，取决于 mode)
 * - mergedKeys: 合并了哪些 key（仅 "all" 模式）
 * - mergeMode: 使用的合并模式
 *
 * === 边界条件（与后端对齐） ===
 * - config 为 null → 默认 mode="all", sources=空, outputVariable="merged"
 * - mode 为 null → 默认 "all"
 * - sources 为 null → 视为空列表，合并所有输入
 * - 源变量为 null → 跳过 (debug 日志)
 * - 以 _ 前缀的内部变量在全输入模式下自动过滤
 * - sources 有重复 → "all" 模式下后面的值覆盖前面的
 *
 * === 前端校验 ===
 * - 来源变量名为空 → 警告（会被忽略）
 * - 来源变量名重复 → 警告（覆盖问题）
 */
const MergeConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const sources = ((config.sources as string[]) || []);
  const hasDuplicateSource = (() => { const valid = sources.filter(s => s.trim()); return valid.length > 1 && new Set(valid).size < valid.length; })();

  const addSource = () => onUpdate({ sources: [...sources, ''] });
  const updateSource = (i: number, val: string) => onUpdate({ sources: sources.map((s, idx) => idx === i ? val : s) });
  const removeSource = (i: number) => onUpdate({ sources: sources.filter((_, idx) => idx !== i) });

  return (
    <div className="space-y-4">
      <ConfigField label="合并模式">
        <select value={(config.mode as string) || 'all'} onChange={(e) => onUpdate({ mode: e.target.value })} className={selectClass}>
          <option value="all">合并全部 (all)</option>
          <option value="first">取第一个非空 (first)</option>
          <option value="last">取最后一个非空 (last)</option>
        </select>
      </ConfigField>

      {/* 来源变量：指定后只合并这些变量（为空时合并所有输入） */}
      <div className="flex items-center justify-between">
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">来源变量</label>
        <button onClick={addSource} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
          <Plus size={14} /> 添加
        </button>
      </div>
      {sources.length === 0 && (
        <p className="text-xs text-gray-400 dark:text-gray-500 text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">
          暂无来源变量，将合并所有上游输入（过滤内部变量）
        </p>
      )}
      {sources.some((s) => !s.trim()) && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            部分来源变量名为空，这些条目会被忽略。
          </p>
        </div>
      )}
      {hasDuplicateSource && (
        <div className="flex items-start gap-2 px-3 py-2.5 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
          <span className="text-amber-500 mt-0.5 shrink-0">⚠</span>
          <p className="text-xs text-amber-700 dark:text-amber-400">
            存在重复的来源变量名，&ldquo;all&rdquo; 模式下后面的值会覆盖前面的值。
          </p>
        </div>
      )}
      {sources.map((s, idx) => (
        <div key={idx} className="flex items-center gap-2">
          <input type="text" value={s} onChange={(e) => updateSource(idx, e.target.value)} placeholder="变量名" className={`${inputClass} flex-1`} />
          <button onClick={() => removeSource(idx)} className="p-1.5 text-gray-400 hover:text-red-500 rounded transition-colors flex-shrink-0"><Trash2 size={14} /></button>
        </div>
      ))}

      <ConfigField label="输出变量名">
        <input type="text" value={(config.outputVariable as string) || 'merged'} onChange={(e) => onUpdate({ outputVariable: e.target.value })} placeholder="merged" className={inputClass} />
      </ConfigField>

      <p className="text-xs text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-800/50 rounded-lg px-3 py-2 border border-gray-200 dark:border-gray-700">
        合并节点将多个上游分支的数据汇聚为一个变量，供下游节点使用。
      </p>
    </div>
  );
};

// ===== HTTP 请求配置 =====
const HttpRequestConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => (
  <div className="space-y-3">
    <ConfigField label="请求方法">
      <select value={(config.method as string) || 'GET'} onChange={(e) => onUpdate({ method: e.target.value })} className={selectClass}>
        <option value="GET">GET</option>
        <option value="POST">POST</option>
        <option value="PUT">PUT</option>
        <option value="DELETE">DELETE</option>
      </select>
    </ConfigField>
    <ConfigField label="URL">
      <input type="text" value={(config.url as string) || ''} onChange={(e) => onUpdate({ url: e.target.value })} placeholder="https://api.example.com/..." className={inputClass} />
    </ConfigField>
    <ConfigField label="请求体 (JSON)">
      <textarea value={(config.body as string) || ''} onChange={(e) => onUpdate({ body: e.target.value })} rows={3} placeholder='{"key": "value"}' className={textareaClass} />
    </ConfigField>
  </div>
);

// ===== 设置变量配置 =====
const VAR_OPERATIONS = [
  { value: 'overwrite', label: '覆盖' },
  { value: 'clear', label: '清空' },
  { value: 'set', label: '设置' },
  { value: 'add', label: '+=' },
  { value: 'subtract', label: '-=' },
  { value: 'multiply', label: '*=' },
  { value: 'divide', label: '/=' },
];

const VariableSetConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();

  // 支持多变量赋值列表
  interface VarItem { name: string; value: string; sourceType: string; operation: string }
  const variables = (config.variables as VarItem[]) || [];

  // 兼容旧的单变量模式
  const legacySingle = !config.variables && (config.variableName as string);

  React.useEffect(() => {
    if (legacySingle) {
      onUpdate({ variables: [{ name: config.variableName as string, value: String(config.value ?? ''), sourceType: 'literal', operation: 'set' }], variableName: undefined, value: undefined });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const addVar = () => onUpdate({ variables: [...variables, { name: '', value: '', sourceType: 'literal', operation: 'set' }] });
  const updateVar = (i: number, field: string, val: string) => {
    const next = variables.map((v, idx) => idx === i ? { ...v, [field]: val } : v);
    // 切换操作类型时自动调整 sourceType
    if (field === 'operation') {
      if (val === 'overwrite') next[i] = { ...next[i], sourceType: 'variable' };
      else if (['add', 'subtract', 'multiply', 'divide', 'set', 'clear'].includes(val)) next[i] = { ...next[i], sourceType: 'literal' };
    }
    onUpdate({ variables: next });
    // 同步第一个变量到 variableName/value（后端兼容）
    if (i === 0 || next.length === 1) {
      const first = next[0];
      if (first) onUpdate({ variables: next, variableName: first.name, value: first.sourceType === 'variable' ? `\${${first.value}}` : first.value });
    }
  };
  const removeVar = (i: number) => {
    const next = variables.filter((_, idx) => idx !== i);
    onUpdate({ variables: next, variableName: next[0]?.name || '', value: next[0]?.value || '' });
  };

  const isArithmetic = (op: string) => ['add', 'subtract', 'multiply', 'divide'].includes(op);

  // 根据操作类型渲染值输入区域
  const renderValueArea = (v: VarItem, i: number) => {
    const op = v.operation || 'set';

    // 清空：不需要任何值
    if (op === 'clear') return null;

    // 运算：数字输入
    if (isArithmetic(op)) {
      return (
        <div>
          <label className="text-[10px] text-gray-400 dark:text-gray-500 mb-1 block">运算值</label>
          <input type="number" value={v.value} onChange={(e) => updateVar(i, 'value', e.target.value)}
            placeholder="输入数值" step="any"
            className={inputClass + ' !py-1.5'} />
        </div>
      );
    }

    // 覆盖：引用变量 / 固定值切换
    if (op === 'overwrite') {
      return (
        <div className="space-y-1.5">
          <div className="flex items-center gap-2">
            <label className="text-[10px] text-gray-400 dark:text-gray-500 flex-shrink-0">赋值来源</label>
            <div className="flex rounded-lg border border-gray-200 dark:border-gray-700 overflow-hidden text-[11px] font-medium">
              <button onClick={() => updateVar(i, 'sourceType', 'variable')}
                className={`px-2.5 py-1 transition-colors ${(v.sourceType || 'variable') === 'variable' ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
                引用变量
              </button>
              <button onClick={() => updateVar(i, 'sourceType', 'literal')}
                className={`px-2.5 py-1 transition-colors ${v.sourceType === 'literal' ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
                固定值
              </button>
            </div>
          </div>
          {(v.sourceType || 'variable') === 'variable' ? (
            upstreamVars.length > 0 ? (
              <select value={v.value} onChange={(e) => updateVar(i, 'value', e.target.value)} className={selectClass + ' !py-1.5'}>
                <option value="">选择来源变量...</option>
                {upstreamVars.map((uv, j) => <option key={j} value={uv.value}>{uv.label}</option>)}
              </select>
            ) : (
              <input type="text" value={v.value} onChange={(e) => updateVar(i, 'value', e.target.value)} placeholder="变量名" className={inputClass + ' !py-1.5'} />
            )
          ) : (
            <input type="text" value={v.value} onChange={(e) => updateVar(i, 'value', e.target.value)} placeholder="输入值" className={inputClass + ' !py-1.5'} />
          )}
        </div>
      );
    }

    // 设置(set)：固定值输入
    return (
      <div>
        <label className="text-[10px] text-gray-400 dark:text-gray-500 mb-1 block">值</label>
        <input type="text" value={v.value} onChange={(e) => updateVar(i, 'value', e.target.value)}
          placeholder="输入值（仅在变量不存在时赋值）"
          className={inputClass + ' !py-1.5'} />
      </div>
    );
  };

  return (
    <div className="space-y-3">
      <div className="flex items-center justify-between">
        <p className="text-sm font-medium text-gray-700 dark:text-gray-300">变量赋值</p>
        <button onClick={addVar} className="flex items-center gap-1 text-xs text-brand-500 hover:text-brand-600 font-medium transition-colors">
          <Plus size={12} /> 添加
        </button>
      </div>

      {variables.length === 0 && (
        <button onClick={addVar} className="w-full py-6 border-2 border-dashed border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-400 hover:text-brand-500 hover:border-brand-300 transition-all">
          + 添加变量赋值
        </button>
      )}

      {variables.map((v, i) => {
        const isCustomName = v.name !== '' && !upstreamVars.some((uv) => uv.value === v.name);
        return (
          <div key={i} className="p-3 bg-gray-50 dark:bg-gray-800/30 rounded-xl border border-gray-200 dark:border-gray-700 space-y-2">
            {/* 头部：序号 + 操作 + 删除 */}
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-1.5">
                <span className="text-[10px] text-gray-400 font-mono w-4 text-center">{i + 1}</span>
                <span className="text-[11px] font-medium text-gray-500 dark:text-gray-400">变量赋值</span>
              </div>
              <div className="flex items-center gap-1.5">
                <select value={v.operation || 'set'} onChange={(e) => updateVar(i, 'operation', e.target.value)}
                  className={selectClass + ' !w-20 !py-1 !px-2 text-[11px] font-medium'}>
                  {VAR_OPERATIONS.map((op) => <option key={op.value} value={op.value}>{op.label}</option>)}
                </select>
                <button onClick={() => removeVar(i)} className="p-1 text-gray-400 hover:text-red-500 transition-colors"><Trash2 size={14} /></button>
              </div>
            </div>

            {/* 变量名选择 */}
            <div>
              <label className="text-[10px] text-gray-400 dark:text-gray-500 mb-1 block">目标变量</label>
              {upstreamVars.length > 0 ? (
                <select value={isCustomName ? '__custom__' : v.name} onChange={(e) => { if (e.target.value !== '__custom__') updateVar(i, 'name', e.target.value); else updateVar(i, 'name', ''); }}
                  className={selectClass + ' !py-1.5'}>
                  <option value="" disabled>选择变量...</option>
                  {upstreamVars.map((uv, j) => <option key={j} value={uv.value}>{uv.label}</option>)}
                  <option value="__custom__">自定义变量名...</option>
                </select>
              ) : (
                <input type="text" value={v.name} onChange={(e) => updateVar(i, 'name', e.target.value)} placeholder="变量名" className={inputClass + ' !py-1.5'} />
              )}
              {upstreamVars.length > 0 && isCustomName && (
                <input type="text" value={v.name} onChange={(e) => updateVar(i, 'name', e.target.value)} placeholder="输入自定义变量名" className={inputClass + ' !py-1.5 mt-1.5'} />
              )}
            </div>

            {/* 值区域：根据操作类型渲染 */}
            {renderValueArea(v, i)}
          </div>
        );
      })}

      <div className="p-2.5 bg-blue-50 dark:bg-blue-900/10 rounded-lg border border-blue-200 dark:border-blue-800/50">
        <p className="text-[10px] text-blue-700 dark:text-blue-400 leading-relaxed">
          <b>操作说明：</b><br />
          <b>设置</b> = 仅在变量不存在时赋值&emsp;
          <b>覆盖</b> = 用变量或固定值替换&emsp;
          <b>清空</b> = 置为空<br />
          <b>+= -= *= /=</b> = 对数值进行四则运算
        </p>
      </div>
    </div>
  );
};

// ===== 获取变量配置 =====
const VariableGetConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();
  const [customInput, setCustomInput] = useState(false);

  return (
    <div className="space-y-3">
      <ConfigField label="变量名">
        {!customInput && upstreamVars.length > 0 ? (
          <div className="space-y-1.5">
            <select value={(config.variableName as string) || ''} onChange={(e) => onUpdate({ variableName: e.target.value })} className={selectClass}>
              <option value="">选择变量...</option>
              {upstreamVars.map((v, i) => <option key={i} value={v.value}>{v.label}</option>)}
            </select>
            <button onClick={() => setCustomInput(true)} className="text-[10px] text-brand-500 hover:text-brand-600 font-medium">手动输入 →</button>
          </div>
        ) : (
          <div className="space-y-1.5">
            <input type="text" value={(config.variableName as string) || ''} onChange={(e) => onUpdate({ variableName: e.target.value })} placeholder="输入变量名" className={inputClass} />
            {upstreamVars.length > 0 && (
              <button onClick={() => setCustomInput(false)} className="text-[10px] text-brand-500 hover:text-brand-600 font-medium">← 从列表选择</button>
            )}
          </div>
        )}
      </ConfigField>

      <ConfigField label="默认值（可选）">
        <input type="text" value={(config.defaultValue as string) || ''} onChange={(e) => onUpdate({ defaultValue: e.target.value })} placeholder="变量不存在时使用此值" className={inputClass} />
      </ConfigField>

      <ConfigField label="输出变量名">
        <input type="text" value={(config.outputVariable as string) || 'value'} onChange={(e) => onUpdate({ outputVariable: e.target.value })} placeholder="value" className={inputClass} />
        <p className="text-[10px] text-gray-400 mt-1">读取到的值会存入此变量，默认为 value</p>
      </ConfigField>

      <div className="p-2.5 bg-green-50 dark:bg-green-900/10 rounded-lg border border-green-200 dark:border-green-800/50">
        <p className="text-[10px] text-green-700 dark:text-green-400 leading-relaxed">
          <b>说明：</b>读取之前通过「设置变量」节点或其他节点产生的全局变量。
        </p>
      </div>
    </div>
  );
};

// ===== JSON 解析配置 =====
interface ExtractionItem {
  fieldPath: string;
  outputVariable: string;
  dataType: string;
  required: boolean;
  defaultValue: string;
}

const DATA_TYPES = [
  { value: 'STRING', label: 'String' },
  { value: 'INTEGER', label: 'Integer' },
  { value: 'DOUBLE', label: 'Double' },
  { value: 'BOOLEAN', label: 'Boolean' },
  { value: 'ARRAY', label: 'Array' },
  { value: 'OBJECT', label: 'Object' },
];

const JsonParseConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();
  const [customInput, setCustomInput] = useState(false);

  const parseMode = (config.parseMode as string) || 'EXTRACT';
  const inputVariable = (config.inputVariable as string) || '';
  const extractions = (config.extractions as ExtractionItem[]) || [];
  const errorStrategy = (config.errorStrategy as string) || 'ERROR';

  const addExtraction = () => {
    const newItem: ExtractionItem = { fieldPath: '', outputVariable: '', dataType: 'STRING', required: false, defaultValue: '' };
    onUpdate({ extractions: [...extractions, newItem] });
  };

  const updateExtraction = (index: number, field: string, value: unknown) => {
    const updated = extractions.map((e, i) => i === index ? { ...e, [field]: value } : e);
    onUpdate({ extractions: updated });
  };

  const removeExtraction = (index: number) => {
    onUpdate({ extractions: extractions.filter((_, i) => i !== index) });
  };

  return (
    <div className="space-y-3">
      <ConfigField label="解析模式">
        <select value={parseMode} onChange={(e) => onUpdate({ parseMode: e.target.value })} className={selectClass}>
          <option value="EXTRACT">提取字段 (Extract)</option>
          <option value="TRANSFORM">转换整体 (Transform)</option>
          <option value="VALIDATE">校验 JSON (Validate)</option>
        </select>
      </ConfigField>

      <ConfigField label="数据来源变量">
        {!customInput && upstreamVars.length > 0 ? (
          <div className="space-y-1.5">
            <select value={inputVariable} onChange={(e) => onUpdate({ inputVariable: e.target.value })} className={selectClass}>
              <option value="">选择变量...</option>
              {upstreamVars.map((v, i) => <option key={i} value={v.value}>{v.label}</option>)}
            </select>
            <button onClick={() => setCustomInput(true)} className="text-[10px] text-brand-500 hover:text-brand-600 font-medium">手动输入 →</button>
          </div>
        ) : (
          <div className="space-y-1.5">
            <input type="text" value={inputVariable} onChange={(e) => onUpdate({ inputVariable: e.target.value })} placeholder="http_1.jsonBody" className={inputClass} />
            {upstreamVars.length > 0 && (
              <button onClick={() => setCustomInput(false)} className="text-[10px] text-brand-500 hover:text-brand-600 font-medium">← 从列表选择</button>
            )}
          </div>
        )}
        <p className="text-[10px] text-gray-400 mt-1">支持点号路径引用，如 <code className="bg-gray-100 dark:bg-gray-800 px-1 rounded">http_1.jsonBody</code></p>
      </ConfigField>

      {/* EXTRACT 模式：字段提取列表 */}
      {parseMode === 'EXTRACT' && (
        <div className="space-y-2.5">
          <div className="flex items-center justify-between">
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">字段提取</label>
            <button onClick={addExtraction} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
              <Plus size={14} /> 添加
            </button>
          </div>

          {extractions.length === 0 && (
            <button onClick={addExtraction} className="w-full py-4 border-2 border-dashed border-gray-200 dark:border-gray-700 rounded-xl text-xs text-gray-400 hover:text-brand-500 hover:border-brand-300 transition-all">
              + 添加字段提取规则
            </button>
          )}

          {extractions.map((ext, idx) => (
            <div key={idx} className="p-3 bg-gray-50 dark:bg-gray-800/30 rounded-xl border border-gray-200 dark:border-gray-700 space-y-2">
              <div className="flex items-center justify-between">
                <span className="text-[10px] text-gray-400 font-mono">#{idx + 1}</span>
                <button onClick={() => removeExtraction(idx)} className="p-1 text-gray-400 hover:text-red-500 transition-colors"><Trash2 size={13} /></button>
              </div>

              {/* 字段路径 */}
              <div>
                <label className="text-[10px] text-gray-400 dark:text-gray-500 mb-1 block">字段路径</label>
                <input type="text" value={ext.fieldPath} onChange={(e) => updateExtraction(idx, 'fieldPath', e.target.value)} placeholder="data.user.name 或 items[0].title" className={inputClass + ' !py-1.5 !text-xs'} />
              </div>

              {/* 输出变量名 + 数据类型 */}
              <div className="grid grid-cols-2 gap-2">
                <div>
                  <label className="text-[10px] text-gray-400 dark:text-gray-500 mb-1 block">输出变量名</label>
                  <input type="text" value={ext.outputVariable} onChange={(e) => updateExtraction(idx, 'outputVariable', e.target.value)} placeholder="自动推断" className={inputClass + ' !py-1.5 !text-xs'} />
                </div>
                <div>
                  <label className="text-[10px] text-gray-400 dark:text-gray-500 mb-1 block">数据类型</label>
                  <select value={ext.dataType || 'STRING'} onChange={(e) => updateExtraction(idx, 'dataType', e.target.value)} className={selectClass + ' !py-1.5 !text-xs'}>
                    {DATA_TYPES.map((t) => <option key={t.value} value={t.value}>{t.label}</option>)}
                  </select>
                </div>
              </div>

              {/* 必填 + 默认值 */}
              <div className="flex items-center gap-3">
                <ConfigCheckbox checked={ext.required || false} onChange={(v) => updateExtraction(idx, 'required', v)} label="必填" size="sm" />
                <div className="flex-1">
                  <input type="text" value={ext.defaultValue || ''} onChange={(e) => updateExtraction(idx, 'defaultValue', e.target.value)} placeholder="默认值（可选）" className={inputClass + ' !py-1 !text-xs'} />
                </div>
              </div>
            </div>
          ))}

          {/* jsonPath 单值提取（可选） */}
          <ConfigField label="JSONPath 表达式（可选）">
            <input type="text" value={(config.jsonPath as string) || ''} onChange={(e) => onUpdate({ jsonPath: e.target.value })} placeholder="$.data.items[0].name" className={inputClass} />
            <p className="text-[10px] text-gray-400 mt-1">用于单值提取，结果存入下方输出变量</p>
          </ConfigField>
        </div>
      )}

      <ConfigField label="输出变量名">
        <input type="text" value={(config.outputVariable as string) || 'parsedJson'} onChange={(e) => onUpdate({ outputVariable: e.target.value })} placeholder="parsedJson" className={inputClass} />
        <p className="text-[10px] text-gray-400 mt-1">
          {parseMode === 'EXTRACT' ? '无 extractions 或 jsonPath 时整体输出到此变量' : parseMode === 'TRANSFORM' ? '解析后的对象存入此变量' : '验证结果 + 解析对象存入此变量'}
        </p>
      </ConfigField>

      <ConfigField label="错误处理策略">
        <select value={errorStrategy} onChange={(e) => onUpdate({ errorStrategy: e.target.value })} className={selectClass}>
          <option value="ERROR">报错中断 (Error)</option>
          <option value="DEFAULT_VALUE">使用默认值 (Default Value)</option>
          <option value="SKIP">跳过 (Skip)</option>
        </select>
      </ConfigField>

      {errorStrategy === 'DEFAULT_VALUE' && (
        <ConfigField label="全局默认值">
          <input type="text" value={(config.defaultValue as string) || ''} onChange={(e) => onUpdate({ defaultValue: e.target.value })} placeholder="解析失败时的兜底值" className={inputClass} />
        </ConfigField>
      )}

      <div className="p-2.5 bg-violet-50 dark:bg-violet-900/10 rounded-lg border border-violet-200 dark:border-violet-800/50">
        <p className="text-[10px] text-violet-700 dark:text-violet-400 leading-relaxed">
          {parseMode === 'EXTRACT' && <><b>提取模式：</b>从来源数据中按路径批量提取字段。支持数组索引如 <code className="bg-violet-100 dark:bg-violet-900/30 px-1 rounded">items[0].title</code>、多层嵌套如 <code className="bg-violet-100 dark:bg-violet-900/30 px-1 rounded">data.user.name</code></>}
          {parseMode === 'TRANSFORM' && <><b>转换模式：</b>将 JSON 字符串解析为对象并整体输出。</>}
          {parseMode === 'VALIDATE' && <><b>校验模式：</b>验证数据是否为有效 JSON，输出 <code className="bg-violet-100 dark:bg-violet-900/30 px-1 rounded">valid</code> 布尔值。</>}
        </p>
      </div>
    </div>
  );
};

// ===== 代码执行配置 =====
interface CodeInputVar { name: string; source: string; }
interface CodeOutputVar { name: string; type: string; }

const JS_TEMPLATE = `// ============================================
// JavaScript 代码节点
// ============================================
// 【输入】所有上游变量自动注入为全局变量，可直接使用
//   例: 上游有变量 "userInput"，这里直接写 userInput 即可
// 【输出】返回一个对象，其每个 key 都会写入工作流变量
// 【提示】也可以用 function main(args) 形式，args 是包含所有输入的对象
// ============================================

// 示例1: 简单文本处理
// const text = userInput || "默认文本";
// const wordCount = text.split(/\\s+/).length;
// return { summary: text.slice(0, 100), wordCount: wordCount };

// 示例2: JSON 数据转换
// const data = JSON.parse(rawData || "{}");
// const names = (data.items || []).map(item => item.name);
// return { names: names, total: names.length };

// 示例3: 条件判断
// const score = Number(inputScore) || 0;
// const level = score >= 90 ? "优秀" : score >= 60 ? "及格" : "不及格";
// return { level: level, passed: score >= 60 };

return { result: "hello", message: "请修改此代码" };`;

const PY_TEMPLATE = `# ============================================
# Python 代码节点（Docker 沙箱隔离执行）
# ============================================
# 【入口】必须定义 def main(args) 函数
# 【输入】args 是一个 dict，包含所有输入变量
#   例: args["userInput"] 或 args.get("userInput", "默认值")
# 【输出】返回一个 dict，其每个 key 都会写入工作流变量
# 【依赖】如需第三方库，在下方"Python 依赖"中填写（如 pandas==2.0.0）
# ============================================

def main(args):
    """
    args: dict — 包含所有输入变量
    返回值: dict — 其 key 会写入工作流变量
    """
    # 示例1: 读取输入变量
    # text = args.get("userInput", "默认文本")
    # word_count = len(text.split())
    # return {"summary": text[:100], "wordCount": word_count}

    # 示例2: 数据处理（可使用 pandas 等库）
    # import pandas as pd
    # data = args.get("rawData", [])
    # df = pd.DataFrame(data)
    # return {"avg": df["score"].mean(), "count": len(df)}

    # 示例3: 条件判断
    # score = args.get("score", 0)
    # level = "优秀" if score >= 90 else "及格" if score >= 60 else "不及格"
    # return {"level": level, "passed": score >= 60}

    return {"result": "hello", "message": "请修改此代码"}
`;

// JS/Python 内置标识符（识别输入变量时排除）
const JS_BUILTINS = new Set([
  'console','Math','JSON','Date','Array','Object','String','Number','Boolean',
  'RegExp','Error','Map','Set','Promise','parseInt','parseFloat','isNaN',
  'isFinite','undefined','null','true','false','NaN','Infinity',
  'encodeURI','decodeURI','encodeURIComponent','decodeURIComponent',
  'setTimeout','setInterval','clearTimeout','clearInterval',
  'var','let','const','function','return','if','else','for','while','do',
  'switch','case','break','continue','new','this','typeof','instanceof',
  'try','catch','finally','throw','class','import','export','default',
  'yield','async','await','of','in','delete','void',
]);

/** 从 JavaScript 代码中自动识别输入/输出变量 */
function detectJsVars(code: string): { inputs: string[]; outputs: string[] } {
  const outputs: string[] = [];
  const inputs: string[] = [];

  // 输出：匹配 return { key1: ..., key2: ... } 中的 key
  const returnObjRe = /return\s*\{([^}]*)\}/g;
  let m: RegExpExecArray | null;
  while ((m = returnObjRe.exec(code)) !== null) {
    const body = m[1];
    // 匹配 key: 或 key, 或 "key": 模式
    const keyRe = /(?:^|,|\n)\s*(['"]?)([a-zA-Z_$][\w$]*)\1\s*(?::|,|$)/g;
    let km: RegExpExecArray | null;
    while ((km = keyRe.exec(body)) !== null) {
      if (km[2] && !outputs.includes(km[2])) outputs.push(km[2]);
    }
    // 简写属性（ES6 shorthand）: return { foo, bar }
    const shorthandRe = /(?:^|,|\n)\s*([a-zA-Z_$][\w$]*)\s*(?:,|$)/g;
    let sm: RegExpExecArray | null;
    while ((sm = shorthandRe.exec(body)) !== null) {
      if (sm[1] && !outputs.includes(sm[1])) outputs.push(sm[1]);
    }
  }

  // 输入：提取所有标识符引用，排除内置关键字、局部声明、输出 key
  const localDefs = new Set<string>();
  // 收集 var/let/const/function 声明
  const declRe = /(?:var|let|const|function)\s+([a-zA-Z_$][\w$]*)/g;
  while ((m = declRe.exec(code)) !== null) localDefs.add(m[1]);
  // 收集箭头函数参数 (a, b) =>
  const arrowRe = /\(([^)]+)\)\s*=>/g;
  while ((m = arrowRe.exec(code)) !== null) {
    m[1].split(',').forEach(p => { const n = p.trim().split(/\s|=/)[0]; if (n) localDefs.add(n); });
  }

  // 提取所有标识符
  const idRe = /\b([a-zA-Z_$][\w$]*)\b/g;
  const seen = new Set<string>();
  while ((m = idRe.exec(code)) !== null) {
    const id = m[1];
    if (!seen.has(id) && !JS_BUILTINS.has(id) && !localDefs.has(id) && !outputs.includes(id)) {
      seen.add(id);
      inputs.push(id);
    }
  }

  return { inputs, outputs };
}

/** 从 Python 代码中自动识别输入/输出变量 */
function detectPyVars(code: string): { inputs: string[]; outputs: string[] } {
  const outputs: string[] = [];
  const inputs: string[] = [];

  // 输出：匹配 return {"key": ..., "key2": ...} 或 return {'key': ...}
  const returnDictRe = /return\s*\{([^}]*)\}/g;
  let m: RegExpExecArray | null;
  while ((m = returnDictRe.exec(code)) !== null) {
    const body = m[1];
    const keyRe = /['"]([a-zA-Z_][\w]*)['"]/g;
    let km: RegExpExecArray | null;
    while ((km = keyRe.exec(body)) !== null) {
      // 只取冒号前的 key
      const afterKey = body.substring(km.index + km[0].length).trimStart();
      if (afterKey.startsWith(':') && !outputs.includes(km[1])) {
        outputs.push(km[1]);
      }
    }
  }

  // 输入：匹配 args["key"] / args['key'] / args.get("key") / args.get('key')
  const argsAccessRe = /args\s*\[\s*['"]([a-zA-Z_][\w]*)['"]\s*\]/g;
  while ((m = argsAccessRe.exec(code)) !== null) {
    if (!inputs.includes(m[1])) inputs.push(m[1]);
  }
  const argsGetRe = /args\.get\s*\(\s*['"]([a-zA-Z_][\w]*)['"]\s*(?:,\s*[^)]*)?\)/g;
  while ((m = argsGetRe.exec(code)) !== null) {
    if (!inputs.includes(m[1])) inputs.push(m[1]);
  }

  return { inputs, outputs };
}

const CodeConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();
  const [showVars, setShowVars] = useState(false);
  const [showInputVars, setShowInputVars] = useState(true);
  const [showOutputVars, setShowOutputVars] = useState(true);

  const language = ((config.language as string) || 'JAVASCRIPT').toUpperCase();
  const isPython = language === 'PYTHON' || language === 'PY';
  const inputVars = ((config.inputVariables as CodeInputVar[]) || []);
  const outputVars = ((config.outputVariables as CodeOutputVar[]) || []);

  const handleLanguageChange = (lang: string) => {
    const currentCode = (config.code as string) || '';
    const trimmed = currentCode.trim();
    // 判断是否为默认/模板代码（特征检测，兼容新旧模板）
    const looksLikePyTemplate = /^(#|def main\(args\))/.test(trimmed) && trimmed.includes('return {"result"');
    const looksLikeJsTemplate = /^\/\//.test(trimmed) && trimmed.includes('return { result:');
    const isDefault = !trimmed || looksLikePyTemplate || looksLikeJsTemplate
      || currentCode === JS_TEMPLATE || currentCode === PY_TEMPLATE;
    const updates: Record<string, unknown> = { language: lang };
    if (isDefault) {
      updates.code = lang === 'PYTHON' ? PY_TEMPLATE : JS_TEMPLATE;
    }
    onUpdate(updates);
  };

  const addInputVar = () => onUpdate({ inputVariables: [...inputVars, { name: '', source: '' }] });
  const updateInputVar = (i: number, field: string, val: string) => onUpdate({ inputVariables: inputVars.map((v, idx) => idx === i ? { ...v, [field]: val } : v) });
  const removeInputVar = (i: number) => onUpdate({ inputVariables: inputVars.filter((_, idx) => idx !== i) });

  const addOutputVar = () => onUpdate({ outputVariables: [...outputVars, { name: '', type: 'string' }] });
  const updateOutputVar = (i: number, field: string, val: string) => onUpdate({ outputVariables: outputVars.map((v, idx) => idx === i ? { ...v, [field]: val } : v) });
  const removeOutputVar = (i: number) => onUpdate({ outputVariables: outputVars.filter((_, idx) => idx !== i) });

  // 自动识别代码中的变量
  const autoDetectVars = () => {
    const code = (config.code as string) || '';
    if (!code.trim()) return;
    const detected = isPython ? detectPyVars(code) : detectJsVars(code);
    const updates: Record<string, unknown> = {};

    // 合并输入变量（保留已有映射，追加新发现）
    if (detected.inputs.length > 0) {
      const existing = new Set(inputVars.map(v => v.name));
      const merged = [...inputVars];
      for (const name of detected.inputs) {
        if (!existing.has(name)) {
          // 尝试匹配上游变量
          const matchedUpstream = upstreamVars.find(uv => uv.value === name || uv.value.endsWith('.' + name));
          merged.push({ name, source: matchedUpstream?.value || '' });
        }
      }
      updates.inputVariables = merged;
    }

    // 合并输出变量（保留已有声明，追加新发现）
    if (detected.outputs.length > 0) {
      const existing = new Set(outputVars.map(v => v.name));
      const merged = [...outputVars];
      for (const name of detected.outputs) {
        if (!existing.has(name)) {
          merged.push({ name, type: 'any' });
        }
      }
      updates.outputVariables = merged;
    }

    if (Object.keys(updates).length > 0) onUpdate(updates);
  };

  return (
    <div className="space-y-3">
      {/* 语言选择 */}
      <ConfigField label="编程语言">
        <select value={language} onChange={(e) => handleLanguageChange(e.target.value)} className={selectClass}>
          <option value="JAVASCRIPT">JavaScript</option>
          <option value="PYTHON">Python</option>
        </select>
      </ConfigField>

      {/* Python Docker 提示 */}
      {isPython && (
        <div className="p-2.5 bg-blue-50 dark:bg-blue-900/10 rounded-lg border border-blue-200 dark:border-blue-800/50">
          <p className="text-[10px] text-blue-700 dark:text-blue-400 leading-relaxed">
            <b>Python 沙箱：</b>代码在 Docker 容器中隔离执行（<code className="bg-blue-100 dark:bg-blue-900/30 px-1 rounded">python:3.11-slim</code>），
            必须定义 <code className="bg-blue-100 dark:bg-blue-900/30 px-1 rounded">def main(args)</code> 函数作为入口。
            <code className="bg-blue-100 dark:bg-blue-900/30 px-1 rounded">args</code> 是包含所有输入变量的字典，返回值应为字典。
          </p>
        </div>
      )}

      {/* 代码编辑 */}
      <ConfigField label="代码">
        <textarea
          value={(config.code as string) || ''}
          onChange={(e) => onUpdate({ code: e.target.value })}
          rows={12}
          placeholder={isPython ? PY_TEMPLATE : JS_TEMPLATE}
          className={`${textareaClass} text-xs leading-relaxed`}
          spellCheck={false}
        />
      </ConfigField>

      {/* 自动识别按钮 */}
      <button onClick={autoDetectVars} className="w-full flex items-center justify-center gap-1.5 px-3 py-2 text-xs font-medium text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/30 border border-brand-200 dark:border-brand-800/50 rounded-xl transition-all">
        <Eye size={14} /> 从代码自动识别变量
      </button>

      {/* ===== 输入变量映射 ===== */}
      <div>
        <div className="flex items-center justify-between mb-2">
          <button onClick={() => setShowInputVars(!showInputVars)} className="flex items-center gap-1 text-xs font-medium text-gray-700 dark:text-gray-300">
            {showInputVars ? <ChevronDown size={14} /> : <ChevronRight size={14} />}
            输入变量 ({inputVars.length})
          </button>
          <button onClick={addInputVar} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
            <Plus size={14} /> 添加
          </button>
        </div>
        {showInputVars && (
          <div className="space-y-2">
            {inputVars.length === 0 && (
              <p className="text-[10px] text-gray-400 dark:text-gray-500 text-center py-2.5 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">
                未配置输入映射，将自动注入所有上游变量
              </p>
            )}
            {inputVars.map((v, idx) => (
              <div key={idx} className="p-2 bg-gray-50 dark:bg-gray-800/30 rounded-lg border border-gray-200 dark:border-gray-700 space-y-1.5">
                <div className="flex items-center gap-1.5">
                  <span className="text-[10px] text-gray-400 w-10 flex-shrink-0">来源</span>
                  {upstreamVars.length > 0 ? (
                    <select value={v.source} onChange={(e) => updateInputVar(idx, 'source', e.target.value)}
                      className={`${selectClass} flex-1 min-w-0 !text-xs !py-1.5`}>
                      <option value="">选择上游变量…</option>
                      {upstreamVars.map((uv, ui) => <option key={ui} value={uv.value}>{uv.label}</option>)}
                    </select>
                  ) : (
                    <input type="text" placeholder="来源变量名" value={v.source}
                      onChange={(e) => updateInputVar(idx, 'source', e.target.value)}
                      className={`${inputClass} flex-1 min-w-0 !text-xs !py-1.5`} />
                  )}
                  <button onClick={() => removeInputVar(idx)} className="p-1 text-gray-400 hover:text-red-500 rounded transition-colors flex-shrink-0">
                    <Trash2 size={13} />
                  </button>
                </div>
                <div className="flex items-center gap-1.5">
                  <span className="text-[10px] text-gray-400 w-10 flex-shrink-0">映射</span>
                  <input type="text" placeholder="脚本内变量名" value={v.name}
                    onChange={(e) => updateInputVar(idx, 'name', e.target.value)}
                    className={`${inputClass} flex-1 min-w-0 !text-xs !py-1.5 font-mono`} />
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* ===== 输出变量声明 ===== */}
      <div>
        <div className="flex items-center justify-between mb-2">
          <button onClick={() => setShowOutputVars(!showOutputVars)} className="flex items-center gap-1 text-xs font-medium text-gray-700 dark:text-gray-300">
            {showOutputVars ? <ChevronDown size={14} /> : <ChevronRight size={14} />}
            输出变量 ({outputVars.length})
          </button>
          <button onClick={addOutputVar} className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
            <Plus size={14} /> 添加
          </button>
        </div>
        {showOutputVars && (
          <div className="space-y-2">
            {outputVars.length === 0 && (
              <p className="text-[10px] text-gray-400 dark:text-gray-500 text-center py-2.5 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">
                未声明输出变量，脚本返回的所有 key 都会写入上下文
              </p>
            )}
            {outputVars.map((v, idx) => (
              <div key={idx} className="p-2 bg-gray-50 dark:bg-gray-800/30 rounded-lg border border-gray-200 dark:border-gray-700 space-y-1.5">
                <div className="flex items-center gap-1.5">
                  <span className="text-[10px] text-gray-400 w-10 flex-shrink-0">名称</span>
                  <input type="text" placeholder="输出变量名" value={v.name}
                    onChange={(e) => updateOutputVar(idx, 'name', e.target.value)}
                    className={`${inputClass} flex-1 min-w-0 !text-xs !py-1.5 font-mono`} />
                  <button onClick={() => removeOutputVar(idx)} className="p-1 text-gray-400 hover:text-red-500 rounded transition-colors flex-shrink-0">
                    <Trash2 size={13} />
                  </button>
                </div>
                <div className="flex items-center gap-1.5">
                  <span className="text-[10px] text-gray-400 w-10 flex-shrink-0">类型</span>
                  <select value={v.type || 'string'} onChange={(e) => updateOutputVar(idx, 'type', e.target.value)}
                    className={`${selectClass} flex-1 min-w-0 !text-xs !py-1.5`}>
                    <option value="string">String</option>
                    <option value="number">Number</option>
                    <option value="boolean">Boolean</option>
                    <option value="object">Object</option>
                    <option value="array">Array</option>
                    <option value="any">Any</option>
                  </select>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Python 依赖 */}
      {isPython && (
        <ConfigField label="Python 依赖 (requirements.txt)">
          <textarea
            value={(config.requirements as string) || ''}
            onChange={(e) => onUpdate({ requirements: e.target.value })}
            rows={3}
            placeholder="pandas==2.0.0&#10;numpy&#10;requests"
            className={`${textareaClass} text-xs`}
          />
          <p className="text-[10px] text-gray-400 mt-1">每行一个依赖，首次使用会自动安装并缓存</p>
        </ConfigField>
      )}

      {/* 可用上游变量 */}
      {upstreamVars.length > 0 && (
        <div>
          <button onClick={() => setShowVars(!showVars)} className="text-xs text-brand-500 hover:text-brand-600 font-medium transition-colors">
            {showVars ? '▼' : '▶'} 可用上游变量 ({upstreamVars.length})
          </button>
          {showVars && (
            <div className="mt-1.5 flex flex-wrap gap-1.5">
              {upstreamVars.map((v, i) => (
                <span key={i} className="px-2 py-0.5 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 text-[10px] font-mono rounded-md border border-blue-200 dark:border-blue-800">
                  {v.value}
                </span>
              ))}
            </div>
          )}
        </div>
      )}

      {/* 使用提示 */}
      <div className="p-2.5 bg-amber-50 dark:bg-amber-900/10 rounded-lg border border-amber-200 dark:border-amber-800/50">
        <p className="text-[10px] text-amber-700 dark:text-amber-400 leading-relaxed">
          {isPython ? (
            <>
              <b>Python 模式：</b>定义 <code className="bg-amber-100 dark:bg-amber-900/30 px-1 rounded">def main(args)</code>，
              通过 <code className="bg-amber-100 dark:bg-amber-900/30 px-1 rounded">args["变量名"]</code> 获取输入，返回字典作为输出。
              <br />示例: <code className="bg-amber-100 dark:bg-amber-900/30 px-1 rounded">return {'{'}"count": len(args["items"]){'}'}</code>
            </>
          ) : (
            <>
              <b>JavaScript 模式：</b>上游变量自动绑定为全局变量，直接使用变量名访问。返回对象的每个 key 会写入工作流上下文。
              <br />示例: <code className="bg-amber-100 dark:bg-amber-900/30 px-1 rounded">return {'{'} summary: text.slice(0, 100) {'}'}</code>
            </>
          )}
        </p>
      </div>
    </div>
  );
};

// ===== 模板渲染配置 =====
const TemplateConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();
  const textareaRef = React.useRef<HTMLTextAreaElement>(null);

  const insertVar = (varName: string) => {
    const ta = textareaRef.current;
    const tag = `{{${varName}}}`;
    if (ta) {
      const start = ta.selectionStart;
      const end = ta.selectionEnd;
      const cur = (config.template as string) || '';
      const newVal = cur.slice(0, start) + tag + cur.slice(end);
      onUpdate({ template: newVal });
      requestAnimationFrame(() => { ta.focus(); ta.setSelectionRange(start + tag.length, start + tag.length); });
    } else {
      onUpdate({ template: ((config.template as string) || '') + tag });
    }
  };

  return (
    <div className="space-y-3">
      <ConfigField label="模板内容">
        <textarea ref={textareaRef} value={(config.template as string) || ''} onChange={(e) => onUpdate({ template: e.target.value })} rows={6} placeholder={'尊敬的 {{name}}，\n\n您的查询结果如下：\n{{result}}'} className={textareaClass} />
      </ConfigField>

      {/* 变量快捷插入 */}
      {upstreamVars.length > 0 && (
        <div>
          <p className="text-[10px] text-gray-400 mb-1.5">点击插入变量：</p>
          <div className="flex flex-wrap gap-1.5">
            {upstreamVars.map((v, i) => (
              <button key={i} onClick={() => insertVar(v.value)} className="px-2 py-0.5 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 text-[10px] font-mono rounded-md border border-blue-200 dark:border-blue-800 hover:bg-blue-100 dark:hover:bg-blue-900/30 transition-colors cursor-pointer" title={`插入 {{${v.value}}}`}>
                {'{{'}
                {v.value}
                {'}}'}
              </button>
            ))}
          </div>
        </div>
      )}

      <ConfigField label="输出变量名">
        <input type="text" value={(config.outputVariable as string) || 'templateOutput'} onChange={(e) => onUpdate({ outputVariable: e.target.value })} placeholder="templateOutput" className={inputClass} />
        <p className="text-[10px] text-gray-400 mt-1">渲染结果存入此变量，同时也输出为 renderedTemplate</p>
      </ConfigField>

      <div className="p-2.5 bg-blue-50 dark:bg-blue-900/10 rounded-lg border border-blue-200 dark:border-blue-800/50">
        <p className="text-[10px] text-blue-700 dark:text-blue-400 leading-relaxed">
          <b>语法：</b>使用 <code className="bg-blue-100 dark:bg-blue-900/30 px-1 rounded">{'{{变量名}}'}</code> 引用变量。
          支持嵌套访问：<code className="bg-blue-100 dark:bg-blue-900/30 px-1 rounded">{'{{user.name}}'}</code>
        </p>
      </div>
    </div>
  );
};

// ===== 数据库查询配置 =====
interface DbTableInfo {
  name: string;
  comment: string | null;
  columns: DbColumnInfo[];
}
interface DbColumnInfo {
  name: string;
  dataType: string;
  nullable: boolean;
  comment: string | null;
  maxLength: number | null;
}
interface ParamMappingItem {
  placeholder: string;
  sourceVariable: string;
}

const DatabaseQueryConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();
  const [tables, setTables] = useState<DbTableInfo[]>([]);
  const [loading, setLoading] = useState(false);
  const [showColumns, setShowColumns] = useState(true);
  const [showParamHelp, setShowParamHelp] = useState(false);
  const sqlRef = React.useRef<HTMLTextAreaElement>(null);

  // 加载表元数据
  useEffect(() => {
    setLoading(true);
    api.listAllowedTables()
      .then((res) => {
        const data = (res.data as any)?.data as DbTableInfo[] | undefined;
        if (Array.isArray(data)) setTables(data);
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, []);

  const selectedTable = (config.selectedTable as string) || '';
  const currentTableInfo = tables.find((t) => t.name === selectedTable);
  const paramMapping = ((config.paramMapping as Record<string, string>) || {});

  // 将 paramMapping 对象转为数组便于编辑
  const paramList: ParamMappingItem[] = Object.entries(paramMapping).map(([k, v]) => ({ placeholder: k, sourceVariable: v }));

  const updateParamMapping = (list: ParamMappingItem[]) => {
    const obj: Record<string, string> = {};
    list.forEach((p) => { if (p.placeholder) obj[p.placeholder] = p.sourceVariable; });
    onUpdate({ paramMapping: obj });
  };

  // 选择表时自动生成 SELECT 模板
  const handleTableSelect = (tableName: string) => {
    onUpdate({ selectedTable: tableName });
    const tbl = tables.find((t) => t.name === tableName);
    if (tbl && !(config.sql as string)) {
      const cols = tbl.columns.slice(0, 10).map((c) => c.name).join(', ');
      onUpdate({ selectedTable: tableName, sql: `SELECT ${cols}\nFROM ${tableName}\nWHERE 1=1\nLIMIT 100` });
    }
  };

  // 插入字段名到 SQL
  const insertColumn = (colName: string) => {
    const ta = sqlRef.current;
    if (ta) {
      const start = ta.selectionStart;
      const end = ta.selectionEnd;
      const cur = (config.sql as string) || '';
      const newVal = cur.slice(0, start) + colName + cur.slice(end);
      onUpdate({ sql: newVal });
      requestAnimationFrame(() => { ta.focus(); ta.setSelectionRange(start + colName.length, start + colName.length); });
    } else {
      onUpdate({ sql: ((config.sql as string) || '') + colName });
    }
  };

  // 插入变量占位符到 SQL
  const insertVarPlaceholder = (varName: string) => {
    const ta = sqlRef.current;
    const tag = `{{${varName}}}`;
    if (ta) {
      const start = ta.selectionStart;
      const end = ta.selectionEnd;
      const cur = (config.sql as string) || '';
      const newVal = cur.slice(0, start) + tag + cur.slice(end);
      onUpdate({ sql: newVal });
      requestAnimationFrame(() => { ta.focus(); ta.setSelectionRange(start + tag.length, start + tag.length); });
    } else {
      onUpdate({ sql: ((config.sql as string) || '') + tag });
    }
  };

  return (
    <div className="space-y-4">
      {/* 表选择 */}
      <ConfigField label="查询表">
        {loading ? (
          <div className="flex items-center gap-2 py-2.5 px-4 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-gray-200 dark:border-gray-700">
            <Loader2 size={14} className="animate-spin text-brand-500" />
            <span className="text-xs text-gray-400">加载表信息...</span>
          </div>
        ) : (
          <select value={selectedTable} onChange={(e) => handleTableSelect(e.target.value)} className={selectClass}>
            <option value="">选择数据表...</option>
            {tables.map((t) => (
              <option key={t.name} value={t.name}>
                {t.name}{t.comment ? ` (${t.comment})` : ''}
              </option>
            ))}
          </select>
        )}
        <p className="text-[10px] text-gray-400 mt-1">仅展示安全白名单内的数据表</p>
      </ConfigField>

      {/* 字段列表 */}
      {currentTableInfo && currentTableInfo.columns.length > 0 && (
        <div>
          <button onClick={() => setShowColumns(!showColumns)} className="flex items-center gap-1.5 text-xs font-medium text-gray-600 dark:text-gray-400 hover:text-brand-500 transition-colors mb-1.5">
            {showColumns ? <ChevronDown size={14} /> : <ChevronRight size={14} />}
            表字段 ({currentTableInfo.columns.length})
          </button>
          {showColumns && (
            <div className="max-h-48 overflow-y-auto rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/30">
              <table className="w-full text-[11px]">
                <thead>
                  <tr className="border-b border-gray-200 dark:border-gray-700 bg-gray-100 dark:bg-gray-800/50">
                    <th className="px-2.5 py-1.5 text-left font-bold text-gray-500 dark:text-gray-400">字段</th>
                    <th className="px-2.5 py-1.5 text-left font-bold text-gray-500 dark:text-gray-400">类型</th>
                    <th className="px-2.5 py-1.5 text-left font-bold text-gray-500 dark:text-gray-400">备注</th>
                  </tr>
                </thead>
                <tbody>
                  {currentTableInfo.columns.map((col) => (
                    <tr key={col.name} className="border-b border-gray-100 dark:border-gray-700/50 hover:bg-brand-50 dark:hover:bg-brand-900/10 cursor-pointer transition-colors"
                      onClick={() => insertColumn(col.name)} title={`点击插入 ${col.name}`}>
                      <td className="px-2.5 py-1.5 font-mono text-brand-600 dark:text-brand-400 font-medium">{col.name}</td>
                      <td className="px-2.5 py-1.5 text-gray-500 dark:text-gray-400">
                        {col.dataType}{col.maxLength ? `(${col.maxLength})` : ''}
                        {col.nullable && <span className="ml-1 text-gray-300 dark:text-gray-600">?</span>}
                      </td>
                      <td className="px-2.5 py-1.5 text-gray-400 dark:text-gray-500 truncate max-w-[100px]">{col.comment || '-'}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}

      {/* SQL 编辑 */}
      <ConfigField label="SQL 查询语句">
        <textarea
          ref={sqlRef}
          value={(config.sql as string) || ''}
          onChange={(e) => onUpdate({ sql: e.target.value })}
          rows={6}
          placeholder={'SELECT id, user_name, created_at\nFROM user_info\nWHERE status = {{status}}\nLIMIT 100'}
          className={textareaClass}
        />
      </ConfigField>

      {/* 上游变量快捷插入 */}
      {upstreamVars.length > 0 && (
        <div>
          <p className="text-[10px] text-gray-400 mb-1.5">点击插入变量到 SQL：</p>
          <div className="flex flex-wrap gap-1.5">
            {upstreamVars.map((v, i) => (
              <button key={i} onClick={() => insertVarPlaceholder(v.value)}
                className="px-2 py-0.5 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 text-[10px] font-mono rounded-md border border-blue-200 dark:border-blue-800 hover:bg-blue-100 dark:hover:bg-blue-900/30 transition-colors cursor-pointer"
                title={`插入 {{${v.value}}}`}>
                {'{{'}
                {v.value}
                {'}}'}
              </button>
            ))}
          </div>
        </div>
      )}

      {/* 参数映射 */}
      <div className="border-t border-gray-100 dark:border-gray-800 pt-3 space-y-2.5">
        <div className="flex items-center justify-between">
          <label className="text-sm font-medium text-gray-700 dark:text-gray-300">参数映射</label>
          <button
            onClick={() => updateParamMapping([...paramList, { placeholder: '', sourceVariable: '' }])}
            className="flex items-center gap-1 px-2 py-1 text-xs font-bold text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
          >
            <Plus size={14} /> 添加
          </button>
        </div>

        {paramList.length === 0 && (
          <div className="text-center py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">
            <p className="text-[10px] text-gray-400 dark:text-gray-500">
              可直接在 SQL 中使用 <code className="bg-gray-100 dark:bg-gray-700 px-1 rounded">{'{{变量名}}'}</code> 引用上游变量
            </p>
          </div>
        )}

        {paramList.map((p, idx) => (
          <div key={idx} className="flex items-center gap-2">
            <input
              type="text" placeholder="SQL占位符名" value={p.placeholder}
              onChange={(e) => { const next = [...paramList]; next[idx] = { ...next[idx], placeholder: e.target.value }; updateParamMapping(next); }}
              className={`${inputClass} flex-1`}
            />
            <span className="text-xs text-gray-400 flex-shrink-0">←</span>
            {upstreamVars.length > 0 ? (
              <select
                value={p.sourceVariable}
                onChange={(e) => { const next = [...paramList]; next[idx] = { ...next[idx], sourceVariable: e.target.value }; updateParamMapping(next); }}
                className={`${selectClass} flex-1`}
              >
                <option value="">选择来源...</option>
                {upstreamVars.map((uv, j) => <option key={j} value={uv.value}>{uv.label}</option>)}
              </select>
            ) : (
              <input
                type="text" placeholder="来源变量名" value={p.sourceVariable}
                onChange={(e) => { const next = [...paramList]; next[idx] = { ...next[idx], sourceVariable: e.target.value }; updateParamMapping(next); }}
                className={`${inputClass} flex-1`}
              />
            )}
            <button
              onClick={() => { const next = paramList.filter((_, i) => i !== idx); updateParamMapping(next); }}
              className="p-1.5 text-gray-400 hover:text-red-500 rounded transition-colors flex-shrink-0"
            >
              <Trash2 size={14} />
            </button>
          </div>
        ))}
      </div>

      {/* 输出设置 */}
      <div className="border-t border-gray-100 dark:border-gray-800 pt-3 space-y-3">
        <ConfigField label="输出变量名">
          <input type="text" value={(config.outputVariable as string) || 'queryResult'} onChange={(e) => onUpdate({ outputVariable: e.target.value })} placeholder="queryResult" className={inputClass} />
          <p className="text-[10px] text-gray-400 mt-1">查询结果数组存入此变量，同时输出 rowCount 和 truncated</p>
        </ConfigField>

        <ConfigField label="最大返回行数">
          <input type="number" value={Number((config.maxRows as number) || 100)} onChange={(e) => onUpdate({ maxRows: Math.min(Math.max(1, Number(e.target.value) || 1), 1000) })} min={1} max={1000} className={inputClass} />
          <p className="text-[10px] text-gray-400 mt-1">范围 1-1000，默认 100</p>
        </ConfigField>
      </div>

      {/* 帮助提示 */}
      <div>
        <button onClick={() => setShowParamHelp(!showParamHelp)} className="text-xs text-brand-500 hover:text-brand-600 font-medium transition-colors">
          {showParamHelp ? '▼' : '▶'} 使用说明
        </button>
        {showParamHelp && (
          <div className="mt-2 p-2.5 bg-cyan-50 dark:bg-cyan-900/10 rounded-lg border border-cyan-200 dark:border-cyan-800/50">
            <p className="text-[10px] text-cyan-700 dark:text-cyan-400 leading-relaxed">
              <b>安全限制：</b>仅允许 SELECT 查询，禁止 INSERT/UPDATE/DELETE 等操作。系统会自动添加 LIMIT。<br /><br />
              <b>变量引用：</b>SQL 中使用 <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">{'{{变量名}}'}</code> 引用上游变量，字符串会自动转义防注入。<br /><br />
              <b>参数映射：</b>用 <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">{':占位符名'}</code> 写在 SQL 里，然后在参数映射中绑定来源变量。<br /><br />
              <b>输出：</b>结果为对象数组，同时输出 <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">rowCount</code>（行数）和 <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">truncated</code>（是否截断）。
            </p>
          </div>
        )}
      </div>
    </div>
  );
};

// ===== 文件读取配置 =====
const ENCODING_OPTIONS = [
  { value: 'UTF-8', label: 'UTF-8' },
  { value: 'GBK', label: 'GBK' },
  { value: 'GB2312', label: 'GB2312' },
  { value: 'ISO-8859-1', label: 'ISO-8859-1' },
  { value: 'ASCII', label: 'ASCII' },
];

const FileReadConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();

  // 切换来源模式：直接URL / 上游变量
  const hasUrlVar = !!(config.fileUrlVariable as string);
  const [useVariable, setUseVariable] = useState(hasUrlVar);

  const parseMode = ((config.parseMode as string) || 'PARSE').toUpperCase();

  return (
    <div className="space-y-4">
      {/* 解析模式 */}
      <div>
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">解析模式</label>
        <div className="flex rounded-xl border border-gray-200 dark:border-gray-700 overflow-hidden text-xs font-bold">
          <button onClick={() => onUpdate({ parseMode: 'URL_ONLY' })}
            className={`flex-1 px-2 py-2 transition-colors ${parseMode === 'URL_ONLY' ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
            仅传递URL
          </button>
          <button onClick={() => onUpdate({ parseMode: 'PARSE' })}
            className={`flex-1 px-2 py-2 transition-colors ${parseMode === 'PARSE' ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
            解析为文字
          </button>
          <button onClick={() => onUpdate({ parseMode: 'RAW_TEXT' })}
            className={`flex-1 px-2 py-2 transition-colors ${parseMode === 'RAW_TEXT' ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
            读取原始文本
          </button>
        </div>
        <p className="text-[10px] text-gray-400 mt-1.5">
          {parseMode === 'URL_ONLY' && '不下载文件，仅将 URL 传递给后续节点处理（适合图片、视频等）'}
          {parseMode === 'PARSE' && '自动识别文件类型并提取文字内容（支持 PDF/DOCX/TXT/MD/HTML/CSV/JSON 等）'}
          {parseMode === 'RAW_TEXT' && '通过 OSS 直接读取文件原始文本（适合纯文本文件，可指定编码）'}
        </p>
      </div>

      {/* 文件来源模式切换 */}
      <div>
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">文件来源</label>
        <div className="flex rounded-xl border border-gray-200 dark:border-gray-700 overflow-hidden text-xs font-bold">
          <button onClick={() => { setUseVariable(false); onUpdate({ fileUrlVariable: '' }); }}
            className={`flex-1 px-3 py-2 transition-colors ${!useVariable ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
            直接指定 URL
          </button>
          <button onClick={() => { setUseVariable(true); onUpdate({ fileUrl: '' }); }}
            className={`flex-1 px-3 py-2 transition-colors ${useVariable ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
            从上游变量获取
          </button>
        </div>
      </div>

      {/* URL / 变量选择 */}
      {useVariable ? (
        <ConfigField label="文件URL变量">
          {upstreamVars.length > 0 ? (
            <select value={(config.fileUrlVariable as string) || ''} onChange={(e) => onUpdate({ fileUrlVariable: e.target.value })} className={selectClass}>
              <option value="">选择包含文件URL的变量...</option>
              {upstreamVars.map((v, i) => <option key={i} value={v.value}>{v.label}</option>)}
            </select>
          ) : (
            <input type="text" value={(config.fileUrlVariable as string) || ''} onChange={(e) => onUpdate({ fileUrlVariable: e.target.value })}
              placeholder="输入包含文件URL的变量名" className={inputClass} />
          )}
          <p className="text-[10px] text-gray-400 mt-1">从上游节点的输出变量中获取文件 URL</p>
        </ConfigField>
      ) : (
        <ConfigField label="文件 URL">
          <input type="text" value={(config.fileUrl as string) || ''} onChange={(e) => onUpdate({ fileUrl: e.target.value })}
            placeholder="https://your-bucket.oss-cn-xxx.aliyuncs.com/path/file.pdf" className={inputClass} />
          <p className="text-[10px] text-gray-400 mt-1">文件的完整 URL（OSS 或任意可访问地址），支持 {'{{变量名}}'} 占位符</p>
        </ConfigField>
      )}

      {/* RAW_TEXT 模式下的编码选择 */}
      {parseMode === 'RAW_TEXT' && (
        <ConfigField label="文件编码">
          <select value={(config.encoding as string) || 'UTF-8'} onChange={(e) => onUpdate({ encoding: e.target.value })} className={selectClass}>
            {ENCODING_OPTIONS.map((e) => <option key={e.value} value={e.value}>{e.label}</option>)}
          </select>
        </ConfigField>
      )}

      {/* 输出变量名 */}
      <ConfigField label="输出变量名">
        <input type="text" value={(config.outputVariable as string) || 'fileContent'} onChange={(e) => onUpdate({ outputVariable: e.target.value })}
          placeholder="fileContent" className={`${inputClass} font-mono`} />
        <p className="text-[10px] text-gray-400 mt-1">
          {parseMode === 'URL_ONLY' ? '文件URL存入此变量' : '文件内容存入此变量'}
        </p>
      </ConfigField>

      {/* 提示 */}
      <div className="p-2.5 bg-cyan-50 dark:bg-cyan-900/10 rounded-lg border border-cyan-200 dark:border-cyan-800/50">
        <p className="text-[10px] text-cyan-700 dark:text-cyan-400 leading-relaxed">
          {parseMode === 'URL_ONLY' && (
            <>
              <b>仅传递URL：</b>不下载和解析文件，将URL传递给后续节点。<br />
              <b>适用场景：</b>图片传给 LLM 视觉模型、视频/音频传给处理节点等。<br />
              <b>输出：</b><code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileUrl</code>、
              <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileName</code>、
              <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileExtension</code>
            </>
          )}
          {parseMode === 'PARSE' && (
            <>
              <b>文档解析：</b>自动识别文件类型，提取文字内容。<br />
              <b>支持格式：</b>PDF、DOCX、TXT、MD、HTML、CSV、JSON、XML 等。<br />
              <b>输出：</b><code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">{'{{outputVariable}}'}</code>（提取的文字）、
              <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">documentType</code>、
              <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">title</code>、
              <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">pageCount</code>、
              <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileSize</code>
            </>
          )}
          {parseMode === 'RAW_TEXT' && (
            <>
              <b>原始文本读取：</b>通过 OSS 直接读取文件的原始文本内容。<br />
              <b>适用场景：</b>纯文本文件，需要保留原始格式和编码。<br />
              <b>输出：</b><code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">{'{{outputVariable}}'}</code>（原始文本）、
              <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileUrl</code>、
              <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileSize</code>
            </>
          )}
        </p>
      </div>
    </div>
  );
};

// ===== 文件写入配置 =====
const FileWriteConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config, onUpdate }) => {
  const upstreamVars = useUpstreamVars();

  // 切换内容来源：变量引用 / 直接输入
  const hasContentVar = !!(config.contentVariable as string);
  const [useVariable, setUseVariable] = useState(hasContentVar);

  return (
    <div className="space-y-4">
      {/* 内容来源模式切换 */}
      <div>
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">写入内容来源</label>
        <div className="flex rounded-xl border border-gray-200 dark:border-gray-700 overflow-hidden text-xs font-bold">
          <button onClick={() => { setUseVariable(true); onUpdate({ content: '' }); }}
            className={`flex-1 px-3 py-2 transition-colors ${useVariable ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
            从上游变量获取
          </button>
          <button onClick={() => { setUseVariable(false); onUpdate({ contentVariable: '' }); }}
            className={`flex-1 px-3 py-2 transition-colors ${!useVariable ? 'bg-brand-500 text-white' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'}`}>
            直接输入内容
          </button>
        </div>
      </div>

      {/* 内容来源 */}
      {useVariable ? (
        <ConfigField label="内容变量">
          {upstreamVars.length > 0 ? (
            <select value={(config.contentVariable as string) || ''} onChange={(e) => onUpdate({ contentVariable: e.target.value })} className={selectClass}>
              <option value="">选择包含文件内容的变量...</option>
              {upstreamVars.map((v, i) => <option key={i} value={v.value}>{v.label}</option>)}
            </select>
          ) : (
            <input type="text" value={(config.contentVariable as string) || ''} onChange={(e) => onUpdate({ contentVariable: e.target.value })}
              placeholder="输入包含写入内容的变量名" className={inputClass} />
          )}
          <p className="text-[10px] text-gray-400 mt-1">从上游节点的输出变量获取要写入的文本内容</p>
        </ConfigField>
      ) : (
        <ConfigField label="写入内容">
          <textarea value={(config.content as string) || ''} onChange={(e) => onUpdate({ content: e.target.value })}
            rows={5} placeholder={'直接输入文件内容...\n支持 {{变量名}} 引用上游变量'} className={textareaClass} />
          {upstreamVars.length > 0 && (
            <div className="flex flex-wrap gap-1 mt-1.5">
              {upstreamVars.slice(0, 8).map((v, i) => (
                <button key={i} onClick={() => onUpdate({ content: ((config.content as string) || '') + `{{${v.value}}}` })}
                  className="px-1.5 py-0.5 text-[10px] bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 border border-blue-200 dark:border-blue-800 rounded-md hover:bg-blue-100 dark:hover:bg-blue-900/30 transition-colors font-mono"
                  title={`插入 {{${v.value}}}`}>
                  +{v.value}
                </button>
              ))}
            </div>
          )}
        </ConfigField>
      )}

      {/* 文件名 */}
      <ConfigField label="文件名">
        <input type="text" value={(config.fileName as string) || 'output.txt'} onChange={(e) => onUpdate({ fileName: e.target.value })}
          placeholder="output.txt" className={inputClass} />
        <p className="text-[10px] text-gray-400 mt-1">输出文件的名称，支持 {'{{变量名}}'} 占位符</p>
      </ConfigField>

      {/* 编码 */}
      <ConfigField label="文件编码">
        <select value={(config.encoding as string) || 'UTF-8'} onChange={(e) => onUpdate({ encoding: e.target.value })} className={selectClass}>
          {ENCODING_OPTIONS.map((e) => <option key={e.value} value={e.value}>{e.label}</option>)}
        </select>
      </ConfigField>

      {/* 追加模式 */}
      <div className="space-y-2">
        <ConfigCheckbox checked={(config.append as boolean) || false}
          onChange={(v) => onUpdate({ append: v })}
          label="追加模式（将新内容追加到已有文件末尾）" />
        {(config.append as boolean) && (
          <ConfigField label="追加目标文件URL变量">
            {upstreamVars.length > 0 ? (
              <select value={(config.appendToUrlVariable as string) || ''} onChange={(e) => onUpdate({ appendToUrlVariable: e.target.value })} className={selectClass}>
                <option value="">选择包含已有文件URL的变量...</option>
                {upstreamVars.map((v, i) => <option key={i} value={v.value}>{v.label}</option>)}
              </select>
            ) : (
              <input type="text" value={(config.appendToUrlVariable as string) || ''} onChange={(e) => onUpdate({ appendToUrlVariable: e.target.value })}
                placeholder="包含已有文件URL的变量名" className={inputClass} />
            )}
            <p className="text-[10px] text-gray-400 mt-1">先读取该URL文件的内容，再追加新内容后上传</p>
          </ConfigField>
        )}
      </div>

      {/* 提示 */}
      <div className="p-2.5 bg-cyan-50 dark:bg-cyan-900/10 rounded-lg border border-cyan-200 dark:border-cyan-800/50">
        <p className="text-[10px] text-cyan-700 dark:text-cyan-400 leading-relaxed">
          <b>文件写入：</b>将文本内容上传到 OSS 对象存储，生成可访问的文件 URL。<br />
          <b>输出变量：</b><code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileUrl</code>（文件访问地址）、
          <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileName</code>、
          <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">fileSize</code>、
          <code className="bg-cyan-100 dark:bg-cyan-900/30 px-1 rounded">success</code><br />
          <b>追加模式：</b>需指定已有文件的 URL 变量，系统会先读取旧内容再拼接新内容上传。
        </p>
      </div>
    </div>
  );
};

// ===== 通用配置 =====
const GenericConfig: React.FC<{ config: Record<string, unknown>; onUpdate: (c: Record<string, unknown>) => void }> = ({ config }) => (
  <div className="text-center py-4">
    <p className="text-xs text-gray-400 dark:text-gray-500">
      {Object.keys(config).length > 0
        ? `${Object.keys(config).length} 个自定义配置项`
        : '此节点暂无可配置项'}
    </p>
  </div>
);
