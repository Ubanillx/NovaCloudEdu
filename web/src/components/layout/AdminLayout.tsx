import React from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { 
  LayoutDashboard, 
  Users, 
  BookOpen, 
  Settings, 
  LogOut, 
  Home,
  Menu,
  Sun,
  Moon,
  PanelLeftClose,
  PanelLeftOpen,
  Globe,
  ListTodo,
  BookA,
  FileText,
  Megaphone,
  Image,
  MessageSquare,
  Newspaper,
  BrainCircuit,
  Bot,
  Workflow,
  Plug2,
  Presentation,
  Sparkles,
  Maximize,
  Minimize,
  ClipboardList,
  FileEdit,
  GraduationCap,
  School,
  MessagesSquare
} from 'lucide-react';
import { useTheme } from '../../context/ThemeContext';
import { clearTokens } from '../../api';
import logo from '../../assets/logo.svg';

interface AdminSiderProps {
  isCollapsed: boolean;
  isMobileOpen: boolean;
  setIsMobileOpen: (open: boolean) => void;
}

const AdminSider: React.FC<AdminSiderProps> = ({ 
  isCollapsed, 
  isMobileOpen, 
  setIsMobileOpen 
}) => {
  const location = useLocation();
  const navigate = useNavigate();
  const [showText, setShowText] = React.useState(!isCollapsed);

  React.useEffect(() => {
    let timer: any;
    if (!isCollapsed) {
      // 展开时：延迟显示文字（等 300ms 动画完成）
      timer = setTimeout(() => setShowText(true), 300);
    } else {
      // 折叠时：立即隐藏文字
      setShowText(false);
    }
    return () => clearTimeout(timer);
  }, [isCollapsed]);

  const menuItems = [
    { icon: LayoutDashboard, label: '仪表盘', path: '/admin' },
    { icon: Users, label: '用户管理', path: '/admin/users' },
    { icon: BookOpen, label: '课程管理', path: '/admin/courses' },
    { icon: GraduationCap, label: '教师管理', path: '/admin/teachers' },
    { icon: School, label: '班级管理', path: '/admin/classes' },
    { icon: MessagesSquare, label: '群聊管理', path: '/admin/groups' },
    { icon: BookA, label: '每日单词', path: '/admin/daily-words' },
    { icon: FileText, label: '每日美文', path: '/admin/daily-articles' },
    { icon: Megaphone, label: '公告管理', path: '/admin/announcements' },
    { icon: Image, label: '轮播图管理', path: '/admin/banners' },
    { icon: MessageSquare, label: '反馈管理', path: '/admin/feedbacks' },
    { icon: Newspaper, label: '帖子管理', path: '/admin/posts' },
    { icon: Bot, label: 'AI 助手管理', path: '/admin/ai-assistants' },
    { icon: BrainCircuit, label: '知识库管理', path: '/admin/knowledge-bases' },
    { icon: Workflow, label: '工作流管理', path: '/admin/workflows' },
    { icon: Plug2, label: 'MCP 服务器', path: '/admin/mcp-servers' },
    { icon: Presentation, label: 'PPT 模板', path: '/admin/ppt-templates' },
    { icon: Sparkles, label: 'PPT 生成助手', path: '/admin/ppt-generator' },
    { icon: ClipboardList, label: '题库管理', path: '/admin/questions' },
    { icon: FileEdit, label: '试卷管理', path: '/admin/exam-papers' },
    { icon: FileText, label: '试卷模板', path: '/admin/exam-templates' },
    { icon: Globe, label: '抓取配置', path: '/admin/scraper/config' },
    { icon: ListTodo, label: '抓取任务', path: '/admin/scraper/tasks' },
    { icon: Settings, label: '系统设置', path: '/admin/settings' },
  ];

  const handleLogout = () => {
    clearTokens();
    localStorage.removeItem('user_info');
    navigate('/login');
  };

  const siderClasses = `
    fixed inset-y-0 left-0 z-50 flex flex-col bg-white dark:bg-gray-900 border-r border-gray-200 dark:border-gray-800 transition-all duration-300 ease-in-out
    ${isCollapsed ? 'w-20' : 'w-64'}
    ${isMobileOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'}
  `;

  return (
    <>
      {/* Mobile Overlay */}
      {isMobileOpen && (
        <div 
          className="fixed inset-0 z-40 bg-black/50 lg:hidden backdrop-blur-sm transition-opacity"
          onClick={() => setIsMobileOpen(false)}
        />
      )}

      <aside className={siderClasses}>
        {/* Logo Section */}
        <div className="flex items-center justify-between h-20 px-6 transition-colors duration-300">
          <Link to="/admin" className="flex items-center gap-3 group overflow-hidden">
            <div className="w-10 h-10 flex-shrink-0 bg-white dark:bg-gray-800 rounded-xl flex items-center justify-center group-hover:scale-105 transition-all duration-300 overflow-hidden p-1.5">
              <img src={logo} alt="智云星课" className="w-full h-full object-contain" />
            </div>
            {showText && (
              <span className="font-bold text-xl tracking-tight text-gray-900 dark:text-white transition-opacity duration-300 animate-in fade-in whitespace-nowrap">
                管理后台
              </span>
            )}
          </Link>
        </div>

        {/* Navigation Menu */}
        <nav className="flex-1 px-3 py-6 space-y-1 overflow-y-auto custom-scrollbar">
          {menuItems.map((item) => {
            const isActive = location.pathname === item.path;
            return (
              <Link
                key={item.path}
                to={item.path}
                className={`
                  flex items-center gap-3 px-4 py-3.5 rounded-2xl font-medium transition-all duration-300 group
                  ${isActive 
                    ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' 
                    : 'text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 hover:text-brand-600 dark:hover:text-brand-400'}
                `}
                onClick={() => setIsMobileOpen(false)}
              >
                <item.icon size={22} className={`flex-shrink-0 ${isActive ? 'text-white' : 'group-hover:scale-110 transition-transform'}`} />
                {showText && (
                  <span className="transition-opacity duration-300 animate-in fade-in whitespace-nowrap overflow-hidden text-sm">
                    {item.label}
                  </span>
                )}
                {isActive && showText && (
                  <div className="ml-auto w-1.5 h-1.5 rounded-full bg-white shadow-sm flex-shrink-0" />
                )}
              </Link>
            );
          })}
        </nav>

        {/* Footer Actions */}
        <div className="p-4 space-y-2 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-900/50 transition-colors duration-300">
          <Link
            to="/"
            className="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-400 hover:bg-white dark:hover:bg-gray-800 hover:text-brand-600 dark:hover:text-brand-400 transition-all duration-300 border border-transparent hover:border-gray-200 dark:hover:border-gray-700"
          >
            <Home size={20} className="flex-shrink-0" />
            {showText && (
              <span className="transition-opacity duration-300 animate-in fade-in whitespace-nowrap overflow-hidden">
                返回前台
              </span>
            )}
          </Link>
          <button
            onClick={handleLogout}
            className="w-full flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 transition-all duration-300 border border-transparent hover:border-red-100 dark:hover:border-red-900/30"
          >
            <LogOut size={20} className="flex-shrink-0" />
            {showText && (
              <span className="transition-opacity duration-300 animate-in fade-in whitespace-nowrap overflow-hidden">
                退出登录
              </span>
            )}
          </button>
        </div>
      </aside>
    </>
  );
};

export const AdminLayout: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [isCollapsed, setIsCollapsed] = React.useState(false);
  const [isMobileOpen, setIsMobileOpen] = React.useState(false);
  const [isFullscreen, setIsFullscreen] = React.useState(false);
  const [showExitBar, setShowExitBar] = React.useState(false);
  const exitBarTimer = React.useRef<ReturnType<typeof setTimeout> | null>(null);
  const { theme, toggleTheme } = useTheme();

  const toggleFullscreen = React.useCallback(async () => {
    try {
      if (!document.fullscreenElement) {
        await document.documentElement.requestFullscreen();
      } else {
        await document.exitFullscreen();
      }
    } catch {
      // ignore
    }
  }, []);

  React.useEffect(() => {
    const handleChange = () => {
      const fs = !!document.fullscreenElement;
      setIsFullscreen(fs);
      if (!fs) setShowExitBar(false);
    };
    document.addEventListener('fullscreenchange', handleChange);
    return () => document.removeEventListener('fullscreenchange', handleChange);
  }, []);

  React.useEffect(() => {
    if (!isFullscreen) return;
    const handleMouseMove = (e: MouseEvent) => {
      if (e.clientY <= 6) {
        setShowExitBar(true);
        if (exitBarTimer.current) clearTimeout(exitBarTimer.current);
      } else if (e.clientY > 60) {
        if (exitBarTimer.current) clearTimeout(exitBarTimer.current);
        exitBarTimer.current = setTimeout(() => setShowExitBar(false), 300);
      }
    };
    window.addEventListener('mousemove', handleMouseMove);
    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      if (exitBarTimer.current) clearTimeout(exitBarTimer.current);
    };
  }, [isFullscreen]);

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-950 text-gray-900 dark:text-gray-100 transition-colors duration-300">
      {!isFullscreen && (
        <AdminSider 
          isCollapsed={isCollapsed} 
          isMobileOpen={isMobileOpen}
          setIsMobileOpen={setIsMobileOpen}
        />
      )}
      
      <div className={`transition-all duration-300 ${isFullscreen ? '' : isCollapsed ? 'lg:pl-20' : 'lg:pl-64'}`}>
        {/* Header */}
        {!isFullscreen && (
          <header className="sticky top-0 z-30 flex items-center justify-between h-20 px-8 bg-white/80 dark:bg-gray-900/80 backdrop-blur-xl border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
            <div className="flex items-center gap-4">
              <button 
                className="p-2 -ml-2 text-gray-500 lg:hidden"
                onClick={() => setIsMobileOpen(true)}
              >
                <Menu size={24} />
              </button>
              
              {/* Collapse Toggle (Desktop) */}
              <button
                onClick={() => setIsCollapsed(!isCollapsed)}
                className="hidden lg:flex p-2 -ml-2 text-gray-500 hover:text-brand-600 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-xl transition-all"
                title={isCollapsed ? "展开菜单" : "折叠菜单"}
              >
                {isCollapsed ? <PanelLeftOpen size={22} /> : <PanelLeftClose size={22} />}
              </button>

              <div className="h-6 w-[1px] bg-gray-200 dark:bg-gray-700 mx-2 hidden sm:block transition-colors duration-300" />

              <div className="text-sm font-medium text-gray-400 hidden sm:block transition-colors duration-300">
                管理后台 / <span className="text-gray-900 dark:text-white transition-colors duration-300">仪表盘</span>
              </div>
            </div>

            <div className="flex items-center gap-4">
              {/* Fullscreen Toggle */}
              <button
                onClick={toggleFullscreen}
                className="p-2.5 rounded-xl bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:text-brand-600 transition-all hover:scale-105"
                title="进入全屏"
              >
                <Maximize size={20} />
              </button>

              {/* Theme Toggle */}
              <button
                onClick={toggleTheme}
                className="p-2.5 rounded-xl bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:text-brand-600 transition-all hover:scale-105"
              >
                {theme === 'dark' ? <Sun size={20} className="text-yellow-500" /> : <Moon size={20} className="text-brand-600" />}
              </button>
              
              <div className="h-8 w-[1px] bg-gray-200 dark:bg-gray-700 mx-2 transition-colors duration-300" />
              
              {/* User Profile */}
              <div className="flex items-center gap-3 pl-2 group cursor-pointer">
                <div className="text-right hidden sm:block">
                  <div className="text-sm font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors duration-300">管理员</div>
                  <div className="text-[10px] text-gray-400 font-medium uppercase tracking-wider">系统管理员</div>
                </div>
                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-500 to-indigo-600 p-0.5 shadow-lg shadow-brand-500/20 transition-all duration-300">
                  <div className="w-full h-full rounded-[10px] bg-white dark:bg-gray-800 flex items-center justify-center overflow-hidden transition-colors duration-300">
                    <Users size={20} className="text-brand-600" />
                  </div>
                </div>
              </div>
            </div>
          </header>
        )}

        {/* Fullscreen Exit Bar — appears when mouse near top edge */}
        {isFullscreen && (
          <div
            className="fixed top-0 left-0 right-0 z-50 h-14 flex items-start justify-center"
            onMouseEnter={() => {
              if (exitBarTimer.current) clearTimeout(exitBarTimer.current);
              setShowExitBar(true);
            }}
            onMouseLeave={() => {
              exitBarTimer.current = setTimeout(() => setShowExitBar(false), 400);
            }}
            style={{ pointerEvents: showExitBar ? 'auto' : 'none' }}
          >
            <button
              onClick={toggleFullscreen}
              className={`flex items-center gap-2 px-6 py-2 mt-2 rounded-full bg-white/90 dark:bg-gray-800/90 backdrop-blur-xl shadow-lg border border-gray-200 dark:border-gray-700 text-sm font-medium text-gray-700 dark:text-gray-200 hover:text-brand-600 dark:hover:text-brand-400 hover:shadow-xl transition-all duration-300 ease-in-out ${
                showExitBar
                  ? 'opacity-100 translate-y-0 pointer-events-auto'
                  : 'opacity-0 -translate-y-4 pointer-events-none'
              }`}
            >
              <Minimize size={16} />
              退出全屏
            </button>
          </div>
        )}

        {/* Content */}
        <main className={`max-w-[1600px] mx-auto ${isFullscreen ? 'p-4' : 'p-8'}`}>
          {children}
        </main>
      </div>
    </div>
  );
};
