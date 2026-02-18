import React, { useEffect, useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useSider } from '../../context/SiderContext';
import { AIApi, Configuration, apiClient } from '../../api';
import type { AiAssistantVO } from '../../api/generated/models';
import { LayoutGrid, MessageCircle, Bot, ChevronsLeft, ChevronsRight, Home, BookOpen, GraduationCap, PenTool } from 'lucide-react';

interface SiderProps {
  collapsed?: boolean;
}

/** 菜单项包装 */
const SiderTooltip: React.FC<{ label: string; show: boolean; children: React.ReactNode }> = ({ children }) => (
  <>{children}</>
);

export const Sider: React.FC<SiderProps> = ({ collapsed: propCollapsed = false }) => {
  const { siderHidden, siderCollapsed, setSiderCollapsed } = useSider();
  const navigate = useNavigate();
  const location = useLocation();
  const isHomeActive = location.pathname === '/';
  const isCircleActive = location.pathname.startsWith('/circle');
  const isChatActive = location.pathname.startsWith('/chat');
  const isAiChatActive = location.pathname.startsWith('/ai-chat');
  const isEbookActive = location.pathname.startsWith('/ebooks');
  const isCoursesActive = location.pathname === '/courses';
  const isGradingActive = location.pathname.startsWith('/grading');
  const activeAssistantId = isAiChatActive ? location.pathname.split('/ai-chat/')[1]?.split('/')[0] : undefined;
  // 文字渐隐/渐显样式：折叠时同步渐隐，展开时延迟渐显
  const textFadeClass = `whitespace-nowrap overflow-hidden transition-opacity ${siderCollapsed ? 'opacity-0 w-0 duration-200' : 'opacity-100 duration-200 delay-200'}`;

  const [aiList, setAiList] = useState<AiAssistantVO[]>([]);
  const [aiLoading, setAiLoading] = useState(false);

  // 拉取公开智慧体列表（取前6个）
  useEffect(() => {
    let mounted = true;
    const api = new AIApi(new Configuration(), '', apiClient);
    setAiLoading(true);
    api.assistantListPublic({ page: 0, size: 6 })
      .then(res => {
        if (!mounted) return;
        if (res.data?.code === 0 && Array.isArray(res.data.data)) {
          setAiList(res.data.data);
        }
      })
      .catch(err => {
        console.error('获取智慧体失败', err);
      })
      .finally(() => { if (mounted) setAiLoading(false); });
    return () => { mounted = false; };
  }, []);

  if (propCollapsed) return null;

  const isCollapsed = siderCollapsed;

  return (
    <aside className={`bg-white dark:bg-[#111827] border-r border-gray-200 dark:border-gray-800 hidden lg:flex flex-col h-[calc(100vh-3.5rem)] sticky top-14 transition-all duration-300 ease-in-out ${siderHidden ? 'w-0 opacity-0 overflow-hidden border-r-0' : isCollapsed ? 'w-[68px] opacity-100' : 'w-64 opacity-100'}`}>
      {/* 滚动内容区 */}
      <div className="flex-1 overflow-y-auto overflow-x-hidden p-3 space-y-5">
        {/* Section 0: Quick Links */}
        <div>
          <div className="h-px bg-gray-100 dark:bg-gray-800 mb-2" />
          <ul className="space-y-1">
            <li>
              <SiderTooltip label="首页" show={isCollapsed}>
                <button
                  onClick={() => navigate('/')}
                  className={`w-full flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm rounded-lg transition-all duration-200 ${
                    isHomeActive
                      ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
                      : 'text-gray-700 dark:text-gray-300 hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400'
                  }`}
                >
                  <div className={`w-7 h-7 rounded-lg flex-shrink-0 flex items-center justify-center transition-colors ${
                    isHomeActive
                      ? 'bg-brand-500 text-white shadow-sm'
                      : 'bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400'
                  }`}>
                    <Home size={15} />
                  </div>
                  <span className={textFadeClass}>首页</span>
                </button>
              </SiderTooltip>
            </li>
            <li>
              <SiderTooltip label="圈子" show={isCollapsed}>
                <button
                  onClick={() => navigate('/circle')}
                  className={`w-full flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm rounded-lg transition-all duration-200 ${
                    isCircleActive
                      ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
                      : 'text-gray-700 dark:text-gray-300 hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400'
                  }`}
                >
                  <div className={`w-7 h-7 rounded-lg flex-shrink-0 flex items-center justify-center transition-colors ${
                    isCircleActive
                      ? 'bg-brand-500 text-white shadow-sm'
                      : 'bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400'
                  }`}>
                    <LayoutGrid size={15} />
                  </div>
                  <span className={textFadeClass}>圈子</span>
                </button>
              </SiderTooltip>
            </li>
            <li>
              <SiderTooltip label="聊天" show={isCollapsed}>
                <button
                  onClick={() => navigate('/chat')}
                  className={`w-full flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm rounded-lg transition-all duration-200 ${
                    isChatActive
                      ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
                      : 'text-gray-700 dark:text-gray-300 hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400'
                  }`}
                >
                  <div className={`w-7 h-7 rounded-lg flex-shrink-0 flex items-center justify-center transition-colors ${
                    isChatActive
                      ? 'bg-brand-500 text-white shadow-sm'
                      : 'bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400'
                  }`}>
                    <MessageCircle size={15} />
                  </div>
                  <span className={textFadeClass}>聊天</span>
                </button>
              </SiderTooltip>
            </li>
            <li>
              <SiderTooltip label="电子书" show={isCollapsed}>
                <button
                  onClick={() => navigate('/ebooks')}
                  className={`w-full flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm rounded-lg transition-all duration-200 ${
                    isEbookActive
                      ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
                      : 'text-gray-700 dark:text-gray-300 hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400'
                  }`}
                >
                  <div className={`w-7 h-7 rounded-lg flex-shrink-0 flex items-center justify-center transition-colors ${
                    isEbookActive
                      ? 'bg-brand-500 text-white shadow-sm'
                      : 'bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400'
                  }`}>
                    <BookOpen size={15} />
                  </div>
                  <span className={textFadeClass}>电子书</span>
                </button>
              </SiderTooltip>
            </li>
            <li>
              <SiderTooltip label="课程" show={isCollapsed}>
                <button
                  onClick={() => navigate('/courses')}
                  className={`w-full flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm rounded-lg transition-all duration-200 ${
                    isCoursesActive
                      ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
                      : 'text-gray-700 dark:text-gray-300 hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400'
                  }`}
                >
                  <div className={`w-7 h-7 rounded-lg flex-shrink-0 flex items-center justify-center transition-colors ${
                    isCoursesActive
                      ? 'bg-brand-500 text-white shadow-sm'
                      : 'bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400'
                  }`}>
                    <GraduationCap size={15} />
                  </div>
                  <span className={textFadeClass}>课程</span>
                </button>
              </SiderTooltip>
            </li>
            <li>
              <SiderTooltip label="智能批改" show={isCollapsed}>
                <button
                  onClick={() => navigate('/grading')}
                  className={`w-full flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm rounded-lg transition-all duration-200 ${
                    isGradingActive
                      ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
                      : 'text-gray-700 dark:text-gray-300 hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400'
                  }`}
                >
                  <div className={`w-7 h-7 rounded-lg flex-shrink-0 flex items-center justify-center transition-colors ${
                    isGradingActive
                      ? 'bg-brand-500 text-white shadow-sm'
                      : 'bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400'
                  }`}>
                    <PenTool size={15} />
                  </div>
                  <span className={textFadeClass}>智能批改</span>
                </button>
              </SiderTooltip>
            </li>
          </ul>
        </div>

        {/* Section 2: 智慧体中心 */}
        <div>
          <div className="h-px bg-gray-100 dark:bg-gray-800 mb-2" />
          <ul className="space-y-1">
            <li>
              <SiderTooltip label="智慧体中心" show={isCollapsed}>
                <button
                  onClick={() => navigate('/chat?tab=intelligence')}
                  className={`w-full flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm text-gray-700 dark:text-gray-300 rounded-lg hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400 transition-all duration-200 group`}
                >
                  <div className="w-7 h-7 rounded-lg flex-shrink-0 bg-brand-500 text-white flex items-center justify-center shadow-sm">
                    <Bot size={15} />
                  </div>
                  <span className={`font-medium ${textFadeClass}`}>智慧体中心</span>
                </button>
              </SiderTooltip>
            </li>
            {aiLoading
              ? Array.from({ length: 3 }).map((_, idx) => (
                  <li key={idx}>
                    <span className={`flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm rounded-lg`}>
                      <div className="w-7 h-7 rounded-full flex-shrink-0 bg-gray-100 dark:bg-gray-800 animate-pulse" />
                      {!isCollapsed && (
                        <div className="flex-1 space-y-2">
                          <div className="h-3 w-20 bg-gray-100 dark:bg-gray-800 rounded animate-pulse" />
                          <div className="h-2 w-14 bg-gray-100 dark:bg-gray-800 rounded animate-pulse" />
                        </div>
                      )}
                    </span>
                  </li>
                ))
              : aiList.map((assistant) => {
                  const isOnline = assistant?.status === 'ONLINE' || assistant?.status === 'PUBLISHED';
                  const isThisActive = String(assistant?.id) === activeAssistantId;
                  return (
                    <li key={assistant?.id}>
                      <SiderTooltip label={assistant?.name || '加载中...'} show={isCollapsed}>
                        <button
                          onClick={() => navigate(`/ai-chat/${String(assistant?.id)}`)}
                          className={`w-full flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm rounded-lg transition-all duration-200 ${
                            isThisActive
                              ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
                              : 'text-gray-600 dark:text-gray-400 hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400'
                          }`}
                        >
                          <div className={`w-7 h-7 rounded-full flex-shrink-0 flex items-center justify-center text-xs transition-colors ${
                            isThisActive
                              ? 'bg-brand-500 text-white shadow-sm'
                              : 'bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400'
                          }`}>
                            {assistant?.name ? assistant.name[0] : '…'}
                          </div>
                          <span className={textFadeClass}>{assistant?.name || '加载中...'}</span>
                          {isOnline && (
                            <span className={`flex items-center gap-1 text-[10px] ${isCollapsed ? '' : 'ml-auto flex-shrink-0'} ${textFadeClass} text-emerald-500`}>
                              <span className="inline-block w-1.5 h-1.5 rounded-full bg-emerald-500" />
                              在线
                            </span>
                          )}
                        </button>
                      </SiderTooltip>
                    </li>
                  );
                })}
          </ul>
        </div>
      </div>

      {/* 折叠切换按钮 */}
      <div className="border-t border-gray-100 dark:border-gray-800 p-2 flex justify-center">
        <button
          onClick={() => setSiderCollapsed(!isCollapsed)}
          className="w-9 h-9 rounded-lg flex items-center justify-center text-gray-400 dark:text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-gray-600 dark:hover:text-gray-300 transition-all duration-200"
          title={isCollapsed ? '展开侧边栏' : '折叠侧边栏'}
        >
          {isCollapsed ? <ChevronsRight size={18} /> : <ChevronsLeft size={18} />}
        </button>
      </div>
    </aside>
  );
};
