import React, { useState, useEffect, useCallback } from 'react';
import {
  FolderPlus, FileText, Trash2, Upload, Loader2,
  ChevronRight, Plus, X, FolderOpen,
} from 'lucide-react';
import { apiClient } from '../../api';

// ==================== Types ====================

interface PptProject {
  id: string;
  name: string;
  description?: string;
  createTime: string;
  updateTime: string;
}

interface PptProjectDocument {
  id: string;
  fileName: string;
  fileUrl: string;
  fileType?: string;
  fileSize: number;
  hasContent: boolean;
  createTime: string;
}

interface PptProjectPanelProps {
  selectedProjectId: string | null;
  onSelectProject: (projectId: string | null) => void;
  onProjectNameChange?: (name: string) => void;
}

// ==================== Component ====================

const PptProjectPanel: React.FC<PptProjectPanelProps> = ({
  selectedProjectId,
  onSelectProject,
  onProjectNameChange,
}) => {
  const [projects, setProjects] = useState<PptProject[]>([]);
  const [documents, setDocuments] = useState<PptProjectDocument[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [newProjectName, setNewProjectName] = useState('');
  const [newProjectDesc, setNewProjectDesc] = useState('');
  const [isCreating, setIsCreating] = useState(false);
  const [isUploading, setIsUploading] = useState(false);
  const [expandedProject, setExpandedProject] = useState<string | null>(null);

  // Load projects
  const loadProjects = useCallback(async () => {
    setIsLoading(true);
    try {
      const res = await apiClient.get('/api/ppt/projects');
      if (res.data?.code === 0 && Array.isArray(res.data.data)) {
        setProjects(res.data.data.map((p: Record<string, unknown>) => ({
          id: String(p.id),
          name: p.name as string || '',
          description: p.description as string || '',
          createTime: p.createTime as string || '',
          updateTime: p.updateTime as string || '',
        })));
      }
    } catch (e) {
      console.error('加载PPT项目列表失败:', e);
    } finally {
      setIsLoading(false);
    }
  }, []);

  useEffect(() => { loadProjects(); }, [loadProjects]);

  // Load documents for a project
  const loadDocuments = useCallback(async (projectId: string) => {
    try {
      const res = await apiClient.get(`/api/ppt/projects/${projectId}`);
      if (res.data?.code === 0 && res.data.data?.documents) {
        setDocuments(res.data.data.documents.map((d: Record<string, unknown>) => ({
          id: String(d.id),
          fileName: d.fileName as string || '',
          fileUrl: d.fileUrl as string || '',
          fileType: d.fileType as string || '',
          fileSize: Number(d.fileSize) || 0,
          hasContent: !!d.hasContent,
          createTime: d.createTime as string || '',
        })));
      }
    } catch (e) {
      console.error('加载项目文档失败:', e);
    }
  }, []);

  // Create project
  const handleCreateProject = async () => {
    if (!newProjectName.trim()) return;
    setIsCreating(true);
    try {
      const res = await apiClient.post('/api/ppt/projects', {
        name: newProjectName.trim(),
        description: newProjectDesc.trim() || undefined,
      });
      if (res.data?.code === 0) {
        setShowCreateForm(false);
        setNewProjectName('');
        setNewProjectDesc('');
        await loadProjects();
        const newId = String(res.data.data?.id);
        if (newId) {
          onSelectProject(newId);
          onProjectNameChange?.(newProjectName.trim());
          setExpandedProject(newId);
        }
      }
    } catch (e) {
      console.error('创建PPT项目失败:', e);
    } finally {
      setIsCreating(false);
    }
  };

  // Delete project
  const handleDeleteProject = async (projectId: string, e: React.MouseEvent) => {
    e.stopPropagation();
    if (!confirm('确定删除此项目？')) return;
    try {
      await apiClient.delete(`/api/ppt/projects/${projectId}`);
      if (selectedProjectId === projectId) onSelectProject(null);
      await loadProjects();
    } catch (err) {
      console.error('删除项目失败:', err);
    }
  };

  // Upload multiple documents
  const handleUploadDocuments = async (projectId: string, files: FileList) => {
    setIsUploading(true);
    try {
      for (const file of Array.from(files)) {
        const formData = new FormData();
        formData.append('file', file);
        const uploadRes = await apiClient.post('/api/file/upload/general', formData, {
          headers: { 'Content-Type': 'multipart/form-data' },
        });
        if (uploadRes.data?.code === 0 && uploadRes.data.data?.fileUrl) {
          await apiClient.post(`/api/ppt/projects/${projectId}/documents`, {
            fileName: file.name,
            fileUrl: uploadRes.data.data.fileUrl,
            fileType: file.name.split('.').pop()?.toLowerCase() || '',
            fileSize: file.size,
          });
        }
      }
      await loadDocuments(projectId);
    } catch (e) {
      console.error('上传文档失败:', e);
    } finally {
      setIsUploading(false);
    }
  };

  // Delete document
  const handleDeleteDocument = async (projectId: string, documentId: string) => {
    try {
      await apiClient.delete(`/api/ppt/projects/${projectId}/documents/${documentId}`);
      await loadDocuments(projectId);
    } catch (e) {
      console.error('删除文档失败:', e);
    }
  };

  const handleToggleProject = (projectId: string) => {
    if (expandedProject === projectId) {
      setExpandedProject(null);
    } else {
      setExpandedProject(projectId);
      loadDocuments(projectId);
    }
  };

  const handleSelectProject = (projectId: string) => {
    if (selectedProjectId === projectId) {
      onSelectProject(null);
      onProjectNameChange?.('');
    } else {
      onSelectProject(projectId);
      const proj = projects.find(p => p.id === projectId);
      onProjectNameChange?.(proj?.name || '');
    }
  };

  const formatFileSize = (bytes: number) => {
    if (bytes < 1024) return bytes + ' B';
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
    return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
  };

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <div className="flex items-center justify-between">
          <h3 className="text-sm font-semibold text-gray-900 dark:text-white flex items-center gap-1.5">
            <FolderOpen size={14} className="text-brand-500" />
            项目文档
          </h3>
          <button
            onClick={() => setShowCreateForm(true)}
            className="p-1.5 rounded-lg bg-brand-500 hover:bg-brand-600 text-white transition-colors shadow-sm"
            title="新建项目"
          >
            <Plus size={14} />
          </button>
        </div>
        {selectedProjectId && (
          <div className="mt-2 flex items-center gap-1.5 px-2 py-1 bg-brand-50 dark:bg-brand-900/20 rounded-md">
            <FolderOpen size={12} className="text-brand-500" />
            <span className="text-[11px] text-brand-600 dark:text-brand-400 truncate">
              已关联: {projects.find(p => p.id === selectedProjectId)?.name || '未知项目'}
            </span>
            <button onClick={() => onSelectProject(null)} className="ml-auto">
              <X size={12} className="text-brand-400 hover:text-brand-600" />
            </button>
          </div>
        )}
      </div>

      {/* Create Form */}
      {showCreateForm && (
        <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800 space-y-2 bg-gray-50/50 dark:bg-gray-900/30">
          <input
            type="text"
            value={newProjectName}
            onChange={e => setNewProjectName(e.target.value)}
            placeholder="项目名称"
            className="w-full px-3 py-1.5 text-sm bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg focus:outline-none focus:ring-1 focus:ring-brand-500"
            autoFocus
          />
          <input
            type="text"
            value={newProjectDesc}
            onChange={e => setNewProjectDesc(e.target.value)}
            placeholder="项目描述（可选）"
            className="w-full px-3 py-1.5 text-sm bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg focus:outline-none focus:ring-1 focus:ring-brand-500"
          />
          <div className="flex gap-2">
            <button
              onClick={handleCreateProject}
              disabled={!newProjectName.trim() || isCreating}
              className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium bg-brand-500 text-white rounded-lg hover:bg-brand-600 disabled:opacity-50 transition-colors"
            >
              {isCreating ? <Loader2 size={12} className="animate-spin" /> : <FolderPlus size={12} />}
              创建
            </button>
            <button
              onClick={() => { setShowCreateForm(false); setNewProjectName(''); setNewProjectDesc(''); }}
              className="px-3 py-1.5 text-xs text-gray-500 hover:text-gray-700 dark:hover:text-gray-300"
            >
              取消
            </button>
          </div>
        </div>
      )}

      {/* Project List */}
      <div className="flex-1 overflow-y-auto custom-scrollbar">
        {isLoading ? (
          <div className="flex items-center justify-center py-8 text-gray-400">
            <Loader2 size={20} className="animate-spin" />
          </div>
        ) : projects.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-8 text-gray-400">
            <FolderOpen size={28} className="mb-2 opacity-40" />
            <p className="text-xs">暂无项目</p>
            <p className="text-[10px] mt-1">创建项目并上传文档，AI 将参考文档内容生成 PPT</p>
          </div>
        ) : (
          <div className="p-2 space-y-0.5">
            {projects.map(project => {
              const isSelected = selectedProjectId === project.id;
              const isExpanded = expandedProject === project.id;
              return (
                <div key={project.id}>
                  <div
                    className={`group flex items-center gap-2 px-3 py-2 rounded-lg cursor-pointer transition-all ${
                      isSelected
                        ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300 shadow-sm'
                        : 'text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800/50'
                    }`}
                    onClick={() => handleSelectProject(project.id)}
                  >
                    <button
                      onClick={(e) => { e.stopPropagation(); handleToggleProject(project.id); }}
                      className="text-gray-400"
                    >
                      <ChevronRight size={14} className={`transition-transform ${isExpanded ? 'rotate-90' : ''}`} />
                    </button>
                    <FolderOpen size={14} className={`flex-shrink-0 ${isSelected ? 'text-brand-500' : 'text-gray-400'}`} />
                    <span className="text-sm truncate flex-1">{project.name}</span>
                    <button
                      onClick={(e) => handleDeleteProject(project.id, e)}
                      className="p-0.5 rounded opacity-0 group-hover:opacity-100 text-gray-400 hover:text-red-500 transition-all"
                    >
                      <Trash2 size={12} />
                    </button>
                  </div>

                  {/* Expanded: document list */}
                  {isExpanded && (
                    <div className="ml-7 mt-1 space-y-1">
                      {documents.map(doc => (
                        <div key={doc.id} className="group/doc flex items-center gap-2 px-2 py-1.5 rounded-md hover:bg-gray-100 dark:hover:bg-gray-800/50 transition-colors">
                          <FileText size={12} className="text-gray-400 flex-shrink-0" />
                          <span className="text-[11px] text-gray-600 dark:text-gray-400 truncate flex-1">{doc.fileName}</span>
                          <span className="text-[10px] text-gray-400 flex-shrink-0">{formatFileSize(doc.fileSize)}</span>
                          <button
                            onClick={() => handleDeleteDocument(project.id, doc.id)}
                            className="p-0.5 opacity-0 group-hover/doc:opacity-100 text-gray-400 hover:text-red-500 transition-all"
                          >
                            <Trash2 size={10} />
                          </button>
                        </div>
                      ))}

                      {/* Upload button */}
                      <label className="flex items-center gap-2 px-2 py-1.5 rounded-md hover:bg-gray-100 dark:hover:bg-gray-800/50 cursor-pointer transition-colors">
                        {isUploading ? (
                          <Loader2 size={12} className="text-brand-500 animate-spin" />
                        ) : (
                          <Upload size={12} className="text-brand-500" />
                        )}
                        <span className="text-[11px] text-brand-600 dark:text-brand-400">
                          {isUploading ? '上传中...' : '上传文档'}
                        </span>
                        <input
                          type="file"
                          className="hidden"
                          accept=".pdf,.docx,.txt,.md,.pptx,.jpg,.jpeg,.png,.gif,.webp,.svg,.bmp"
                          multiple
                          onChange={e => {
                            const files = e.target.files;
                            if (files && files.length > 0) handleUploadDocuments(project.id, files);
                            e.target.value = '';
                          }}
                          disabled={isUploading}
                        />
                      </label>
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
};

export default PptProjectPanel;
