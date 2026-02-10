import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { MockData } from '../../data/mock';
import { useSider } from '../../context/SiderContext';
import { LayoutGrid, MessageCircle, Bot, Code, Calculator, Palette, FlaskConical, Languages, ChevronsLeft, ChevronsRight } from 'lucide-react';

interface SiderProps {
  collapsed?: boolean;
}

/** 菜单项包装 */
const SiderTooltip: React.FC<{ label: string; show: boolean; children: React.ReactNode }> = ({ children }) => (
  <>{children}</>
);

const categoryIcons: Record<string, React.ElementType> = {
  Coding: Code,
  Math: Calculator,
  Arts: Palette,
  Science: FlaskConical,
  English: Languages,
};

export const Sider: React.FC<SiderProps> = ({ collapsed: propCollapsed = false }) => {
  const { siderHidden, siderCollapsed, setSiderCollapsed } = useSider();
  const navigate = useNavigate();
  const location = useLocation();
  const isCircleActive = location.pathname.startsWith('/circle');
  const isChatActive = location.pathname.startsWith('/chat');
  // 文字渐隐/渐显样式：折叠时同步渐隐，展开时延迟渐显
  const textFadeClass = `whitespace-nowrap overflow-hidden transition-opacity ${siderCollapsed ? 'opacity-0 w-0 duration-200' : 'opacity-100 duration-200 delay-200'}`;

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
          </ul>
        </div>

        {/* Section 1: Categories */}
        <div>
          <div className="h-px bg-gray-100 dark:bg-gray-800 mb-2" />
          <ul className="space-y-1">
            {[
              { name: '少儿编程', item: 'Coding' },
              { name: '趣味数学', item: 'Math' },
              { name: '人文艺术', item: 'Arts' },
              { name: '科学探索', item: 'Science' },
              { name: '英语口语', item: 'English' }
            ].map((cat) => {
              const Icon = categoryIcons[cat.item];
              return (
                <li key={cat.item}>
                  <SiderTooltip label={cat.name} show={isCollapsed}>
                    <a href="#" className={`flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm text-gray-700 dark:text-gray-300 rounded-lg hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400 transition-all duration-200`}>
                      <div className="w-7 h-7 rounded-lg flex-shrink-0 flex items-center justify-center bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400">
                        <Icon size={15} />
                      </div>
                      <span className={textFadeClass}>{cat.name}</span>
                    </a>
                  </SiderTooltip>
                </li>
              );
            })}
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
            {MockData.aiAssistants.slice(0, 3).map((assistant) => (
              <li key={assistant.id}>
                <SiderTooltip label={`${assistant.name}（即将上线）`} show={isCollapsed}>
                  <span className={`flex items-center ${isCollapsed ? 'justify-center px-0 gap-0' : 'gap-3 px-3'} py-2 text-sm text-gray-500 dark:text-gray-500 rounded-lg cursor-default`}>
                    <div className="w-7 h-7 rounded-full flex-shrink-0 bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400 flex items-center justify-center text-xs">
                      {assistant.name[0]}
                    </div>
                    <span className={textFadeClass}>{assistant.name}</span>
                    <span className={`text-[10px] text-gray-400 ${isCollapsed ? '' : 'ml-auto flex-shrink-0'} ${textFadeClass}`}>即将上线</span>
                  </span>
                </SiderTooltip>
              </li>
            ))}
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
