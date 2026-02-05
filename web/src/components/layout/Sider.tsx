import React from 'react';
import { MockData } from '../../data/mock';

interface SiderProps {
  collapsed?: boolean;
}

export const Sider: React.FC<SiderProps> = ({ collapsed = false }) => {
  if (collapsed) return null;

  return (
    <aside className="w-64 bg-white dark:bg-[#111827] border-r border-gray-200 dark:border-gray-800 hidden lg:flex flex-col h-[calc(100vh-3.5rem)] sticky top-14 overflow-y-auto transition-colors duration-300">
      <div className="p-4 space-y-6">
        {/* Section 1: Categories */}
        <div>
          <h3 className="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase tracking-wider mb-2">探索领域</h3>
          <ul className="space-y-1">
            {[
              { name: '少儿编程', item: 'Coding' },
              { name: '趣味数学', item: 'Math' },
              { name: '人文艺术', item: 'Arts' },
              { name: '科学探索', item: 'Science' },
              { name: '英语口语', item: 'English' }
            ].map((item) => (
              <li key={item.item}>
                <a href="#" className="block px-3 py-2 text-sm text-gray-700 dark:text-gray-300 rounded-md hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400 transition-colors">
                  {item.name}
                </a>
              </li>
            ))}
          </ul>
        </div>

        {/* Section 2: AI Assistants */}
        <div>
          <h3 className="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase tracking-wider mb-2">AI 助手</h3>
          <ul className="space-y-1">
            {MockData.aiAssistants.map((assistant) => (
              <li key={assistant.id}>
                <a href="#" className="flex items-center gap-3 px-3 py-2 text-sm text-gray-700 dark:text-gray-300 rounded-md hover:bg-brand-50 dark:hover:bg-brand-900/30 hover:text-brand-600 dark:hover:text-brand-400 transition-colors group">
                  <div className="w-6 h-6 rounded-full bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400 flex items-center justify-center text-xs group-hover:bg-brand-200 dark:group-hover:bg-brand-800 transition-colors">
                    {assistant.name[0]}
                  </div>
                  <span className="truncate">{assistant.name}</span>
                </a>
              </li>
            ))}
          </ul>
        </div>
      </div>
    </aside>
  );
};
