import React, { useState, useEffect, useCallback } from 'react';
import {
  Search,
  Plus,
  Edit2,
  Trash2,
  Plug2,
  Power,
  PowerOff,
  TestTube,
  Wrench,
  X,
  RefreshCw,
  Check,
  Terminal,
  Globe,
  Loader2
} from 'lucide-react';
import { apiClient, Configuration, MCPApi } from '../../api';
import { toast } from '../../components/ui';

const mcpApi = new MCPApi(new Configuration(), '', apiClient);

interface McpServer {
  id: string;
  name: string;
  description: string;
  url: string;
  configJson: string;
  enabled: boolean;
  createTime: string;
  updateTime: string;
}

interface McpTool {
  name: string;
  description: string;
  inputSchema: any;
}

const DEFAULT_CONFIG = JSON.stringify({
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-example"],
  "env": {}
}, null, 2);

// ===== MCP 服务器表单弹窗 =====
interface McpFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  server?: McpServer | null;
}

const McpFormModal: React.FC<McpFormModalProps> = ({ isOpen, onClose, onSuccess, server }) => {
  const isEdit = !!server;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    url: '',
    configJson: DEFAULT_CONFIG,
  });
  const [configError, setConfigError] = useState('');

  useEffect(() => {
    if (server) {
      let prettyConfig = server.configJson || '{}';
      try { prettyConfig = JSON.stringify(JSON.parse(prettyConfig), null, 2); } catch { /* keep as-is */ }
      setFormData({
        name: server.name || '',
        description: server.description || '',
        url: server.url || '',
        configJson: prettyConfig,
      });
    } else {
      setFormData({ name: '', description: '', url: '', configJson: DEFAULT_CONFIG });
    }
    setConfigError('');
  }, [server, isOpen]);

  const validateConfig = (json: string): boolean => {
    try { JSON.parse(json); setConfigError(''); return true; }
    catch (e: any) { setConfigError('JSON 格式错误: ' + e.message); return false; }
  };

  const handleSubmit = async () => {
    if (!formData.name.trim()) { toast.warning('请输入名称'); return; }
    if (!validateConfig(formData.configJson)) return;

    const userInfoStr = localStorage.getItem('user_info');
    const userId = userInfoStr ? String(JSON.parse(userInfoStr)?.id ?? '') : '';
    setLoading(true);
    try {
      const body = { name: formData.name, description: formData.description, url: formData.url || '', configJson: formData.configJson };
      if (isEdit && server) {
        const res = await mcpApi.mcpServerUpdate({
          id: server.id as unknown as number,
          userId: userId as unknown as number,
          requestBody: body as unknown as { [key: string]: object },
        });
        if (res.data.code === 0) { toast.success('更新成功'); onSuccess(); onClose(); }
        else { toast.error(res.data.message || '更新失败'); }
      } else {
        const res = await mcpApi.mcpServerCreate({
          userId: userId as unknown as number,
          requestBody: body as unknown as { [key: string]: object },
        });
        if (res.data.code === 0) { toast.success('创建成功'); onSuccess(); onClose(); }
        else { toast.error(res.data.message || '创建失败'); }
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
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑 MCP 服务器' : '新建 MCP 服务器'}
          </h3>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <div className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">名称 *</label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="如：高德地图工具、天气查询"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
            <input
              type="text"
              value={formData.description}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="可选，简要说明此服务器的用途"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
              JSON 配置 <span className="text-xs text-gray-400 font-normal ml-1">Claude Code 风格</span>
            </label>
            <textarea
              value={formData.configJson}
              onChange={(e) => { setFormData(prev => ({ ...prev, configJson: e.target.value })); validateConfig(e.target.value); }}
              rows={6}
              spellCheck={false}
              className={`w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all font-mono text-sm resize-y ${
                configError ? 'border-red-400' : 'border-gray-200 dark:border-gray-700'
              }`}
            />
            {configError && <p className="text-xs text-red-500 mt-1">{configError}</p>}
            <p className="text-xs text-gray-400 mt-1.5">
              stdio 示例：<code className="bg-gray-100 dark:bg-gray-700 px-1 rounded text-xs">{'{"command": "npx", "args": ["-y", "@mcp/server"], "env": {}}'}</code>
            </p>
          </div>
        </div>

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
            {isEdit ? '保存修改' : '创建'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ===== 工具列表弹窗 =====
interface ToolsModalProps {
  isOpen: boolean;
  onClose: () => void;
  serverId: string;
}

const ToolsModal: React.FC<ToolsModalProps> = ({ isOpen, onClose, serverId }) => {
  const [tools, setTools] = useState<McpTool[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!isOpen || !serverId) return;
    setLoading(true);
    mcpApi.mcpServerListTools({ id: serverId as unknown as number })
      .then((res) => {
        const data = res.data as any;
        if (data.code === 0 && Array.isArray(data.data)) {
          setTools(data.data);
        }
      })
      .catch((e: any) => { toast.error('获取工具列表失败: ' + (e?.response?.data?.message || e.message)); })
      .finally(() => setLoading(false));
  }, [isOpen, serverId]);

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[70vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white flex items-center gap-2">
            <Wrench size={18} /> 可用工具列表
          </h3>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>
        <div className="p-6 overflow-y-auto flex-1">
          {loading ? (
            <div className="flex items-center justify-center py-10 text-gray-400">
              <RefreshCw size={20} className="animate-spin mr-2" /> 正在发现工具...
            </div>
          ) : tools.length === 0 ? (
            <div className="flex flex-col items-center py-10">
              <Wrench size={32} className="text-gray-300 mb-3" />
              <p className="text-gray-500 dark:text-gray-400 font-medium">此服务器未提供任何工具</p>
            </div>
          ) : (
            <div className="space-y-3">
              {tools.map((tool, idx) => (
                <div key={idx} className="p-3 rounded-xl border border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/30">
                  <div className="flex items-center gap-2">
                    <Wrench size={14} className="text-brand-500 flex-shrink-0" />
                    <span className="text-sm font-bold text-gray-900 dark:text-white font-mono">{tool.name}</span>
                  </div>
                  {tool.description && (
                    <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">{tool.description}</p>
                  )}
                  {tool.inputSchema?.properties && (
                    <div className="mt-2 flex flex-wrap gap-1">
                      {Object.keys(tool.inputSchema.properties).map((param) => (
                        <span key={param} className="px-1.5 py-0.5 text-[10px] font-mono bg-brand-50 dark:bg-brand-900/20 text-brand-700 dark:text-brand-300 rounded border border-brand-200 dark:border-brand-800">
                          {param}
                        </span>
                      ))}
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

// ===== 主页面 =====
export const McpServerManagementPage: React.FC = () => {
  const [servers, setServers] = useState<McpServer[]>([]);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingServer, setEditingServer] = useState<McpServer | null>(null);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [toolsModalOpen, setToolsModalOpen] = useState(false);
  const [toolsServerId, setToolsServerId] = useState('');
  const [testingId, setTestingId] = useState<string | null>(null);
  const [testResult, setTestResult] = useState<{ id: string; ok: boolean; msg: string } | null>(null);

  const getUserId = () => {
    const userInfoStr = localStorage.getItem('user_info');
    return userInfoStr ? String(JSON.parse(userInfoStr)?.id ?? '') : '';
  };

  const fetchServers = useCallback(async () => {
    const userId = getUserId();
    if (!userId) return;
    setLoading(true);
    try {
      const res = await mcpApi.mcpServerListByCreator({ userId: userId as unknown as number });
      const data = res.data as any;
      if (data.code === 0 && Array.isArray(data.data)) {
        setServers(data.data.map((s: any) => ({
          ...s,
          id: String(s.id),
          configJson: s.configJson || '{}',
        })));
      } else {
        toast.error(data.message || '获取列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { fetchServers(); }, [fetchServers]);

  const handleDelete = async (server: McpServer) => {
    if (!window.confirm(`确定要删除 "${server.name}" 吗？此操作不可恢复。`)) return;
    const userId = getUserId();
    try {
      const res = await mcpApi.mcpServerDelete({
        id: server.id as unknown as number,
        userId: userId as unknown as number,
      });
      if (res.data.code === 0) { toast.success('已删除'); fetchServers(); }
      else { toast.error(res.data.message || '删除失败'); }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    }
  };

  const handleToggleEnabled = async (server: McpServer) => {
    const userId = getUserId();
    try {
      const res = await mcpApi.mcpServerSetEnabled({
        id: server.id as unknown as number,
        userId: userId as unknown as number,
        enabled: !server.enabled,
      });
      if (res.data.code === 0) { toast.success(server.enabled ? '已禁用' : '已启用'); fetchServers(); }
      else { toast.error(res.data.message || '操作失败'); }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    }
  };

  const handleTestConnection = async (server: McpServer) => {
    setTestingId(server.id);
    setTestResult(null);
    try {
      const res = await mcpApi.mcpServerTestConnection({ id: server.id as unknown as number });
      const data = res.data as any;
      if (data.code === 0) {
        const info = data.data || {};
        setTestResult({ id: server.id, ok: true, msg: `连接成功 — ${info.name || ''} ${info.version || ''} (协议 ${info.protocolVersion || ''})` });
      } else {
        setTestResult({ id: server.id, ok: false, msg: data.message || '连接失败' });
      }
    } catch (e: any) {
      setTestResult({ id: server.id, ok: false, msg: e?.response?.data?.message || e.message || '连接失败' });
    } finally {
      setTestingId(null);
    }
  };

  const filteredServers = searchKeyword.trim()
    ? servers.filter((s) => s.name.toLowerCase().includes(searchKeyword.toLowerCase()) || (s.url || '').toLowerCase().includes(searchKeyword.toLowerCase()) || (s.configJson || '').toLowerCase().includes(searchKeyword.toLowerCase()))
    : servers;

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">MCP 服务器管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">配置 MCP 服务器（本地 stdio 或远程 HTTP），工作流 LLM 节点和 AI 助手可绑定使用</p>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => { setEditingServer(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>新建 MCP 服务器</span>
          </button>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <div className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text"
              placeholder="搜索名称或命令..."
              value={searchKeyword}
              onChange={(e) => setSearchKeyword(e.target.value)}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <button
              type="button"
              onClick={() => fetchServers()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </div>
      </div>

      {/* Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-8 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider min-w-[320px]">服务器信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">传输方式</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">连接测试</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 3 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={5} className="px-6 py-8 h-16">
                      <div className="flex gap-4">
                        <div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : filteredServers.length > 0 ? (
                filteredServers.map((server) => (
                  <tr key={server.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    {/* 服务器信息 */}
                    <td className="px-8 py-4 min-w-[320px]">
                      <div className="flex items-center gap-3">
                        <div className="w-10 h-10 rounded-xl bg-white dark:bg-gray-900 flex items-center justify-center border border-gray-200 dark:border-gray-700 shadow-sm">
                          <Plug2 size={18} className={server.enabled ? 'text-brand-500' : 'text-gray-400'} />
                        </div>
                        <div className="min-w-0 flex-1">
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors truncate">
                            {server.name || '未命名'}
                          </p>
                          <p className="text-xs text-gray-500 dark:text-gray-400 font-medium line-clamp-1">
                            {server.description || '暂无描述'}
                          </p>
                        </div>
                      </div>
                    </td>
                    {/* 传输方式 */}
                    <td className="px-6 py-4">
                      {(() => {
                        try {
                          let cfg = JSON.parse(server.configJson || '{}');
                          // 兼容嵌套 mcpServers 格式
                          if (cfg.mcpServers && typeof cfg.mcpServers === 'object') {
                            const keys = Object.keys(cfg.mcpServers);
                            if (keys.length > 0) cfg = cfg.mcpServers[keys[0]];
                          }
                          if (cfg.command) {
                            return (
                              <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300">
                                <Terminal size={14} className="text-emerald-500 flex-shrink-0" />
                                <span className="font-mono truncate max-w-[240px]">{cfg.command} {(cfg.args || []).join(' ')}</span>
                              </div>
                            );
                          }
                          return (
                            <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-300">
                              <Globe size={14} className="text-blue-500 flex-shrink-0" />
                              <span className="font-mono truncate max-w-[240px]">{server.url || cfg.url || '-'}</span>
                            </div>
                          );
                        } catch {
                          return <span className="text-xs text-gray-400">-</span>;
                        }
                      })()}
                    </td>
                    {/* 状态 */}
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className={`w-2 h-2 rounded-full ${server.enabled ? 'bg-green-500' : 'bg-orange-400'}`} />
                        <span className="text-sm font-medium text-gray-600 dark:text-gray-300">
                          {server.enabled ? '已启用' : '已禁用'}
                        </span>
                      </div>
                    </td>
                    {/* 连接测试 */}
                    <td className="px-6 py-4">
                      {testResult && String(testResult.id) === String(server.id) ? (
                        <div className={`inline-flex items-center gap-1 text-xs font-medium px-2.5 py-1 rounded-lg ${
                          testResult.ok
                            ? 'bg-green-50 dark:bg-green-900/20 text-green-700 dark:text-green-400'
                            : 'bg-red-50 dark:bg-red-900/20 text-red-700 dark:text-red-400'
                        }`}>
                          {testResult.ok ? <Check size={12} /> : <X size={12} />}
                          {testResult.ok ? '成功' : '失败'}
                        </div>
                      ) : (
                        <button
                          onClick={() => handleTestConnection(server)}
                          disabled={String(testingId) === String(server.id)}
                          className="inline-flex items-center gap-1 text-xs font-medium px-2.5 py-1 rounded-lg text-gray-500 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-all"
                        >
                          {String(testingId) === String(server.id)
                            ? <RefreshCw size={12} className="animate-spin" />
                            : <TestTube size={12} />
                          }
                          测试
                        </button>
                      )}
                    </td>
                    {/* 操作 */}
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <button
                          onClick={() => { setToolsServerId(server.id); setToolsModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                          title="查看工具"
                        >
                          <Wrench size={18} />
                        </button>
                        <button
                          onClick={() => handleToggleEnabled(server)}
                          className={`p-2 rounded-lg transition-all ${
                            server.enabled
                              ? 'text-gray-400 hover:text-orange-500 hover:bg-orange-50 dark:hover:bg-orange-900/20'
                              : 'text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20'
                          }`}
                          title={server.enabled ? '禁用' : '启用'}
                        >
                          {server.enabled ? <PowerOff size={18} /> : <Power size={18} />}
                        </button>
                        <button
                          onClick={() => { setEditingServer(server); setModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                          title="编辑"
                        >
                          <Edit2 size={18} />
                        </button>
                        <button
                          onClick={() => handleDelete(server)}
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
                  <td colSpan={5} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <Plug2 size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">
                        {searchKeyword ? '未找到匹配的 MCP 服务器' : '暂无 MCP 服务器，点击上方按钮新建'}
                      </p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* 底部统计 */}
        <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            共 <span className="font-bold text-gray-900 dark:text-white">{filteredServers.length}</span> 个 MCP 服务器
          </p>
        </div>
      </div>

      {/* 表单弹窗 */}
      <McpFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingServer(null); }}
        onSuccess={fetchServers}
        server={editingServer}
      />

      {/* 工具列表弹窗 */}
      <ToolsModal
        isOpen={toolsModalOpen}
        onClose={() => { setToolsModalOpen(false); setToolsServerId(''); }}
        serverId={toolsServerId}
      />
    </div>
  );
};
