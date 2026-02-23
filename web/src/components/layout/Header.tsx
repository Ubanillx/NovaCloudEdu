import React, { useState, useEffect, useRef } from 'react';
import { Sun, Moon, LogOut, ShieldCheck, User, Bell } from 'lucide-react';
import { Link, useNavigate } from 'react-router-dom';
import { useTheme } from '../../context/ThemeContext';
import { getToken, clearTokens } from '../../api';
import { useChat } from '../../context/ChatContext';
import logo from '../../assets/logo.svg';

// 用户信息类型
interface UserInfo {
  id: number;
  userAccount: string;
  userName?: string;
  userAvatar?: string;
  userRole?: string;
  role?: string;
}

const USER_INFO_KEY = 'user_info';

// ============ 通知铃铛组件 ============

const NotificationBell: React.FC = () => {
  const navigate = useNavigate();
  const { totalUnread } = useChat();

  return (
    <button
      onClick={() => navigate('/chat')}
      className="relative p-2 rounded-full text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors"
      aria-label="消息通知"
    >
      <Bell className="w-5 h-5" />
      {totalUnread > 0 && (
        <span className="absolute -top-0.5 -right-0.5 inline-flex items-center justify-center min-w-[18px] h-[18px] px-1 text-[10px] font-bold text-white bg-rose-500 rounded-full ring-2 ring-white dark:ring-gray-900 animate-in zoom-in duration-200">
          {totalUnread > 99 ? '99+' : totalUnread}
        </span>
      )}
    </button>
  );
};

export const Header: React.FC = () => {
  const { theme, toggleTheme } = useTheme();
  const navigate = useNavigate();
  const [userInfo, setUserInfo] = useState<UserInfo | null>(null);
  const [showDropdown, setShowDropdown] = useState(false);
  const [headerSearch, setHeaderSearch] = useState('');
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (getToken()) {
      const stored = localStorage.getItem(USER_INFO_KEY);
      if (stored) {
        try {
          setUserInfo(JSON.parse(stored));
        } catch {
          // ignore
        }
      }
    }
  }, []);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setShowDropdown(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleLogout = () => {
    clearTokens();
    localStorage.removeItem(USER_INFO_KEY);
    setUserInfo(null);
    setShowDropdown(false);
    navigate('/login');
  };

  const userRole = userInfo?.userRole || userInfo?.role;

  return (
    <header className="h-14 bg-white dark:bg-[#111827] border-b border-gray-200 dark:border-gray-800 flex items-center px-4 sticky top-0 z-50 transition-colors duration-300">
      {/* Logo Area */}
      <div className="flex items-center mr-8">
        <Link to="/" className="flex items-center gap-2">
          <img src={logo} alt="智云星课" className="w-8 h-8 object-contain" />
          <span className="text-lg font-semibold hidden md:block text-gray-800 dark:text-gray-100">智云星课</span>
        </Link>
      </div>

      {/* Navigation 已迁移至侧边栏，预留空间对齐右侧操作区 */}
      <div className="flex-1" />

      {/* Right Actions */}
      <div className="flex items-center gap-4 ml-auto">
        {/* Expanding Search Bar */}
        <div className="relative flex items-center justify-end">
          <input
            type="text"
            placeholder="搜索..."
            value={headerSearch}
            onChange={e => setHeaderSearch(e.target.value)}
            onKeyDown={e => {
              if (e.key === 'Enter' && headerSearch.trim()) {
                navigate(`/search?q=${encodeURIComponent(headerSearch.trim())}`);
                setHeaderSearch('');
                (e.target as HTMLInputElement).blur();
              }
            }}
            className="peer w-9 hover:w-48 focus:w-64 h-9 bg-transparent hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 pl-9 pr-4 rounded-full border border-transparent focus:border-gray-200 dark:focus:border-gray-600 outline-none text-sm transition-all duration-300 ease-in-out cursor-pointer focus:cursor-text placeholder-transparent focus:placeholder-gray-400 dark:text-gray-200"
          />
          <div className="absolute left-0 top-1/2 -translate-y-1/2 p-2 pointer-events-none text-gray-600 dark:text-gray-300">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <circle cx="11" cy="11" r="8"></circle>
              <path d="m21 21-4.3-4.3"></path>
            </svg>
          </div>
        </div>
        
        {/* Theme Toggle */}
        <button 
          onClick={toggleTheme}
          className="p-2 rounded-full text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors"
          aria-label="Toggle theme"
        >
          {theme === 'dark' ? <Sun className="w-5 h-5" /> : <Moon className="w-5 h-5" />}
        </button>

        {/* Notification Bell */}
        {userInfo && <NotificationBell />}

        {/* User Area */}
        {userInfo ? (
          <div className="relative" ref={dropdownRef}>
            <div 
              onClick={() => setShowDropdown(!showDropdown)}
              className="flex items-center gap-2 cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700 p-1 pr-2 rounded-full transition-colors"
            >
              {userInfo.userAvatar ? (
                <img 
                  src={userInfo.userAvatar} 
                  alt={userInfo.userName || userInfo.userAccount}
                  className="w-8 h-8 rounded-full object-cover"
                />
              ) : (
                <div className="w-8 h-8 bg-gradient-to-tr from-brand-500 to-cyan-500 rounded-full flex items-center justify-center text-white font-bold text-xs">
                  {(userInfo.userName || userInfo.userAccount || 'U').charAt(0).toUpperCase()}
                </div>
              )}
              <span className="text-xs text-gray-700 dark:text-gray-200 hidden sm:block max-w-20 truncate">
                {userInfo.userName || userInfo.userAccount}
              </span>
            </div>

            {/* Dropdown Menu */}
            {showDropdown && (
              <div className="absolute right-0 top-full mt-2 w-48 bg-white dark:bg-gray-800 rounded-xl shadow-lg border border-gray-200 dark:border-gray-700 py-2 z-50">
                <div className="px-4 py-2 border-b border-gray-100 dark:border-gray-700">
                  <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                    {userInfo.userName || userInfo.userAccount}
                  </p>
                  <p className="text-xs text-gray-500 dark:text-gray-400 truncate">
                    {userInfo.userAccount}
                  </p>
                </div>

                {(userRole?.toLowerCase() === 'admin' || userRole?.toLowerCase() === 'teacher') && (
                  <button
                    onClick={() => {
                      setShowDropdown(false);
                      navigate('/admin');
                    }}
                    className="w-full px-4 py-2 text-left text-sm text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 flex items-center gap-2 transition-colors font-semibold"
                  >
                    <ShieldCheck size={16} />
                    管理后台
                  </button>
                )}

                <button
                  onClick={() => {
                    setShowDropdown(false);
                    navigate('/profile');
                  }}
                  className="w-full px-4 py-2 text-left text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700 flex items-center gap-2 transition-colors"
                >
                  <User size={16} />
                  个人中心
                </button>

                <div className="my-1 border-t border-gray-100 dark:border-gray-700" />

                <button
                  onClick={handleLogout}
                  className="w-full px-4 py-2 text-left text-sm text-red-600 dark:text-red-400 hover:bg-gray-100 dark:hover:bg-gray-700 flex items-center gap-2 transition-colors"
                >
                  <LogOut size={16} />
                  退出登录
                </button>
              </div>
            )}
          </div>
        ) : (
          <Link
            to="/login"
            className="px-4 py-2 bg-brand-600 hover:bg-brand-700 text-white text-sm font-medium rounded-lg transition-colors"
          >
            登录
          </Link>
        )}
      </div>
    </header>
  );
};
