import React, { useEffect, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  ArrowLeft,
  Plus,
  Sparkles,
  Trash2,
  Loader2,
  Bot,
  History,
  MessageSquarePlus,
  ArrowDown,
  FolderOpen,
  X,
  PanelLeftClose,
  PanelLeftOpen,
} from 'lucide-react';
import { usePptChat } from '../../hooks/usePptChat';
import type { PptSessionSummary } from '../../hooks/usePptChat';
import PptChatMessageComponent from '../../components/ppt/PptChatMessage';
import PptPreviewPanel from '../../components/ppt/PptPreviewPanel';
import AgentTaskPanel from '../../components/ppt/AgentTaskPanel';
import PptChatInput from '../../components/ppt/PptChatInput';
import { useTextToSpeech } from '../../hooks/useTextToSpeech';
import { TemplateSelector } from '../../components/ppt/TemplateSelector';
import PptProjectPanel from '../../components/ppt/PptProjectPanel';

// ============ 会话时间格式化 ============

const formatSessionTime = (dateStr?: string) => {
  if (!dateStr) return '';
  const now = new Date();
  const time = new Date(dateStr);
  const diff = now.getTime() - time.getTime();
  const minutes = Math.floor(diff / 60000);
  if (minutes < 1) return '刚刚';
  if (minutes < 60) return `${minutes}分钟前`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours}小时前`;
  const days = Math.floor(hours / 24);
  if (days < 7) return `${days}天前`;
  return `${time.getMonth() + 1}/${time.getDate()}`;
};

// ============ 会话侧边栏 ============

interface SessionSidebarProps {
  sessions: PptSessionSummary[];
  currentSessionId: string | null;
  isLoading: boolean;
  onSelect: (sessionId: string) => void;
  onDelete: (sessionId: string) => void;
  onNew: () => void;
}

const SessionSidebar: React.FC<SessionSidebarProps> = ({
  sessions, currentSessionId, isLoading, onSelect, onDelete, onNew,
}) => {
  const [deletingId, setDeletingId] = React.useState<string | null>(null);

  const handleDelete = async (e: React.MouseEvent, sessionId: string) => {
    e.stopPropagation();
    setDeletingId(sessionId);
    onDelete(sessionId);
    setDeletingId(null);
  };

  return (
    <div className="flex-1 flex flex-col bg-gray-50/50 dark:bg-gray-900/30 overflow-hidden">
      {/* 头部 */}
      <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <div className="flex items-center justify-between">
          <h3 className="text-sm font-semibold text-gray-900 dark:text-white">PPT 会话</h3>
          <button
            onClick={onNew}
            className="p-1.5 rounded-lg bg-brand-500 hover:bg-brand-600 text-white transition-colors shadow-sm"
            title="新建对话"
          >
            <Plus size={14} />
          </button>
        </div>
      </div>

      {/* 会话列表 */}
      <div className="flex-1 overflow-y-auto custom-scrollbar">
        <div className="p-2">
          <p className="px-2 py-1 text-xs font-medium text-gray-400 dark:text-gray-500 flex items-center gap-1">
            <History size={12} />
            生成历史
          </p>
          {isLoading ? (
            <div className="flex items-center justify-center py-8 text-gray-400">
              <Loader2 size={20} className="animate-spin" />
            </div>
          ) : sessions.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-8 text-gray-400">
              <MessageSquarePlus size={28} className="mb-2 opacity-40" />
              <p className="text-xs">暂无会话</p>
            </div>
          ) : (
            <div className="space-y-0.5 mt-1">
              {sessions.map(session => {
                const isActive = String(session.id) === String(currentSessionId);
                return (
                  <div
                    key={String(session.id)}
                    onClick={() => onSelect(session.id)}
                    className={`group flex items-center gap-2 px-3 py-2.5 rounded-lg cursor-pointer transition-all ${
                      isActive
                        ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300 shadow-sm'
                        : 'text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800/50'
                    }`}
                  >
                    <Sparkles size={14} className={`flex-shrink-0 ${isActive ? 'text-brand-500' : 'text-gray-400'}`} />
                    <div className="flex-1 min-w-0">
                      <p className="text-sm truncate font-medium">
                        {session.topic || '新会话'}
                      </p>
                      <p className="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">
                        {formatSessionTime(session.updateTime || session.createTime)}
                      </p>
                    </div>
                    <button
                      onClick={(e) => handleDelete(e, session.id)}
                      className={`p-1 rounded opacity-0 group-hover:opacity-100 transition-opacity ${
                        deletingId === session.id
                          ? 'opacity-100'
                          : 'hover:bg-red-50 dark:hover:bg-red-900/20 text-gray-400 hover:text-red-500'
                      }`}
                      title="删除"
                    >
                      {deletingId === session.id
                        ? <Loader2 size={13} className="animate-spin text-red-500" />
                        : <Trash2 size={13} />
                      }
                    </button>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

// ============ 主页面 ============

const PptGeneratorPage: React.FC = () => {
  const navigate = useNavigate();
  const chat = usePptChat();
  const tts = useTextToSpeech();
  const [selectedProjectId, setSelectedProjectId] = React.useState<string | null>(null);
  const [selectedProjectName, setSelectedProjectName] = React.useState<string>('');
  const [sidebarCollapsed, setSidebarCollapsed] = React.useState(false);
  const messagesContainerRef = useRef<HTMLDivElement>(null);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const [showScrollBtn, setShowScrollBtn] = React.useState(false);
  const [templateSelectorOpen, setTemplateSelectorOpen] = React.useState(false);
  const hasInitRef = useRef(false);

  // 初始化加载会话列表
  useEffect(() => {
    if (!hasInitRef.current) {
      hasInitRef.current = true;
      chat.loadSessions();
    }
  }, [chat.loadSessions]);

  // 自动弹出模板选择
  useEffect(() => {
    if (chat.showTemplateSelector) {
      setTemplateSelectorOpen(true);
    }
  }, [chat.showTemplateSelector]);

  // 自动滚动：追踪用户是否手动上滑，避免流式输出时抢夺滚动控制
  const userScrolledUpRef = useRef(false);
  const isAutoScrollingRef = useRef(false);

  const scrollToBottom = useCallback(() => {
    const container = messagesContainerRef.current;
    if (container) {
      isAutoScrollingRef.current = true;
      container.scrollTo({ top: container.scrollHeight, behavior: 'smooth' });
      // smooth scroll 完成后重置标志
      setTimeout(() => { isAutoScrollingRef.current = false; }, 400);
    }
  }, []);

  // 只在用户没有主动上滑时自动滚动
  useEffect(() => {
    if (!userScrolledUpRef.current) {
      scrollToBottom();
    }
  }, [chat.messages, scrollToBottom]);

  // 滚动检测：区分用户手动滚动和程序自动滚动
  useEffect(() => {
    const container = messagesContainerRef.current;
    if (!container) return;
    const handleScroll = () => {
      const { scrollTop, scrollHeight, clientHeight } = container;
      const distanceFromBottom = scrollHeight - scrollTop - clientHeight;
      setShowScrollBtn(distanceFromBottom > 100);
      // 忽略由程序触发的滚动
      if (isAutoScrollingRef.current) return;
      // 用户滑离底部 > 80px 视为主动上滑
      userScrolledUpRef.current = distanceFromBottom > 80;
    };
    container.addEventListener('scroll', handleScroll);
    return () => container.removeEventListener('scroll', handleScroll);
  }, []);

  const handleTemplateSelect = (templateId?: string, templateUrl?: string) => {
    setTemplateSelectorOpen(false);
    chat.selectTemplate(templateId, templateUrl);
  };

  const handleDeleteSession = useCallback(async (sessionId: string) => {
    await chat.deleteSession(sessionId);
    chat.loadSessions();
  }, [chat]);

  return (
    <div className="space-y-4 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <button
            onClick={() => navigate('/admin/ppt-templates')}
            className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
          >
            <ArrowLeft size={20} />
          </button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white flex items-center gap-2">
              <Sparkles className="w-6 h-6 text-brand-500" />
              PPT 生成助手
            </h1>
            <p className="text-gray-500 dark:text-gray-400 mt-0.5 text-sm">对话式 AI 生成演示文稿</p>
          </div>
        </div>
      </div>

      {/* Main Layout: Sidebar + Chat + Preview */}
      <div
        className="flex bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300"
        style={{ height: 'calc(100vh - 180px)' }}
      >
        {/* 左侧：会话列表 + 项目文档（可折叠） */}
        <div className={`flex-shrink-0 flex flex-col border-r border-gray-100 dark:border-gray-800 transition-all duration-300 ${sidebarCollapsed ? 'w-0 overflow-hidden border-r-0' : 'w-64'}`}>
          {/* 上半：会话列表 */}
          <div className="flex-1 min-h-0 overflow-hidden">
            <SessionSidebar
              sessions={chat.sessions}
              currentSessionId={chat.currentSessionId}
              isLoading={chat.isLoadingSessions}
              onSelect={(id) => chat.openSession(id)}
              onDelete={handleDeleteSession}
              onNew={chat.startNewSession}
            />
          </div>
          {/* 下半：项目文档 */}
          <div className="h-[45%] border-t border-gray-100 dark:border-gray-800 overflow-hidden">
            <PptProjectPanel
              selectedProjectId={selectedProjectId}
              onSelectProject={(id) => {
                setSelectedProjectId(id);
                if (!id) setSelectedProjectName('');
              }}
              onProjectNameChange={setSelectedProjectName}
            />
          </div>
        </div>

        {/* 中间对话区 */}
        <div className="flex-1 flex flex-col min-w-0 transition-all duration-500">
          {/* 对话头部 */}
          <div className="flex items-center justify-between px-5 py-3 border-b border-gray-200/60 dark:border-gray-700/40 bg-white/80 dark:bg-gray-900/80 backdrop-blur-sm">
            <div className="flex items-center gap-2.5 min-w-0">
              <button
                onClick={() => setSidebarCollapsed(prev => !prev)}
                className="p-1.5 rounded-lg text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
                title={sidebarCollapsed ? '展开侧边栏' : '收起侧边栏'}
              >
                {sidebarCollapsed ? <PanelLeftOpen size={16} /> : <PanelLeftClose size={16} />}
              </button>
              <div className="w-8 h-8 rounded-lg bg-brand-500 flex items-center justify-center shadow-sm">
                <Bot size={16} className="text-white" />
              </div>
              <div className="min-w-0">
                <h3 className="text-sm font-bold text-gray-800 dark:text-gray-200 truncate">
                  {chat.pptState.intentTopic || 'PPT 生成助手'}
                </h3>
                <p className="text-[11px] text-gray-400">AI 驱动的演示文稿生成</p>
              </div>
            </div>
            <button
              onClick={chat.startNewSession}
              className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/40 rounded-lg transition-colors"
              title="新对话"
            >
              <Plus size={14} />
              新对话
            </button>
          </div>

          {/* 消息列表 */}
          <div ref={messagesContainerRef} className="flex-1 overflow-y-auto custom-scrollbar relative">
            {chat.messages.length === 0 ? (
              /* 空状态 */
              <div className="flex items-center justify-center h-full">
                <div className="text-center px-8 max-w-lg">
                  <div className="w-20 h-20 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-brand-500 to-highlight-500 flex items-center justify-center shadow-lg shadow-brand-500/20">
                    <Sparkles size={40} className="text-white" />
                  </div>
                  <h2 className="text-xl font-bold text-gray-800 dark:text-gray-200 mb-2">
                    PPT 生成助手
                  </h2>
                  <p className="text-gray-400 text-sm mb-2">告诉我你想做什么 PPT，我来帮你完成</p>
                  <p className="text-gray-400/70 text-xs">
                    {selectedProjectId
                      ? <span className="inline-flex items-center gap-1 text-brand-500"><FolderOpen size={12} /> 已关联项目「{selectedProjectName}」，AI 将参考项目文档生成内容</span>
                      : '可在左侧「项目文档」中选择一个项目，AI 会参考其中的文档内容'
                    }
                  </p>
                </div>
              </div>
            ) : (
              <div className="max-w-3xl mx-auto px-4 py-6 space-y-5">
                {chat.messages.map((msg, index) => (
                  <PptChatMessageComponent
                    key={msg.id}
                    message={msg}
                    messageIndex={index}
                    tts={tts}
                    onConfirmOutline={chat.confirmOutline}
                    onReviseOutline={chat.reviseOutline}
                    onUpdateOutline={chat.updateOutline}
                    outlineJson={chat.pptState.outlineJson}
                    isGenerating={chat.isGenerating}
                  />
                ))}
                <div ref={messagesEndRef} />
              </div>
            )}

            {/* 滚动到底部按钮 */}
            {showScrollBtn && (
              <button
                onClick={() => { userScrolledUpRef.current = false; scrollToBottom(); }}
                className="absolute bottom-4 right-4 p-2 rounded-full bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 shadow-lg hover:shadow-xl transition-all text-gray-500 hover:text-brand-500"
              >
                <ArrowDown size={18} />
              </button>
            )}
          </div>

          {/* 项目关联提示 + 输入区域 */}
          {selectedProjectId && (
            <div className="px-4 pt-2 flex items-center gap-1.5 text-[11px] text-brand-600 dark:text-brand-400 bg-brand-50/50 dark:bg-brand-900/10 border-t border-brand-100 dark:border-brand-800/30">
              <FolderOpen size={12} />
              <span className="truncate">已关联项目: {selectedProjectName || '未命名'}</span>
              <button onClick={() => { setSelectedProjectId(null); setSelectedProjectName(''); }} className="ml-auto p-0.5 rounded hover:bg-brand-100 dark:hover:bg-brand-800/40">
                <X size={12} />
              </button>
            </div>
          )}
          <PptChatInput
            onSend={(content) => chat.sendMessage(content, selectedProjectId)}
            isGenerating={chat.isGenerating}
            onAbort={chat.abort}
            disabled={false}
            showQuickPrompts={chat.messages.length === 0}
          />
        </div>

        {/* 右侧面板区：Agent任务 + PPT缩略图 */}
        {(chat.showPreview || chat.pptState.agentTasks.length > 0) && (
          <div className="w-60 flex-shrink-0 border-l border-gray-100 dark:border-gray-800 bg-gray-50/30 dark:bg-gray-800/20 transition-all duration-500 animate-in slide-in-from-right duration-500 flex flex-col">
            {/* Agent 任务面板 */}
            {chat.pptState.agentTasks.length > 0 && (
              <div className={`${chat.showPreview ? 'max-h-[50%]' : 'flex-1'} overflow-hidden flex flex-col`}>
                <AgentTaskPanel
                  tasks={chat.pptState.agentTasks}
                  summary={chat.pptState.agentTaskSummary}
                  evaluationResult={chat.pptState.evaluationResult}
                  repairProgress={chat.pptState.repairProgress}
                />
              </div>
            )}
            {/* PPT 缩略图面板 */}
            {chat.showPreview && (
              <div className={`${chat.pptState.agentTasks.length > 0 ? 'border-t border-gray-100 dark:border-gray-800' : ''} flex-1 overflow-hidden`}>
                <PptPreviewPanel
                  slides={chat.pptState.generatedSlides}
                  selectedIndex={chat.pptState.selectedSlideIndex}
                  onSelectSlide={chat.setSelectedSlide}
                  totalSlides={chat.pptState.totalSlides}
                  isGenerating={chat.pptState.phase === 'generating_slides'}
                />
              </div>
            )}
          </div>
        )}
      </div>

      {/* 模板选择 Modal */}
      {templateSelectorOpen && (
        <TemplateSelector
          onSelect={handleTemplateSelect}
          onSkip={(styleHint: string) => {
            setTemplateSelectorOpen(false);
            chat.skipTemplate(styleHint);
          }}
          onClose={() => setTemplateSelectorOpen(false)}
        />
      )}
    </div>
  );
};

export default PptGeneratorPage;
