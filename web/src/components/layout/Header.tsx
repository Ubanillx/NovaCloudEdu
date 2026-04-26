import React, { useState, useEffect, useRef } from 'react';
import {
  Sun, Moon, LogOut, ShieldCheck, User, Bell, MessageCircle,
  UsersRound, UserPlus, Megaphone, Inbox,
} from 'lucide-react';
import { Link, useNavigate } from 'react-router-dom';
import { useTheme } from '../../context/ThemeContext';
import { getToken, clearTokens } from '../../api';
import { useChat } from '../../context/ChatContext';
import type { NotificationEvent } from '../../api/chatTypes';
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

type NotificationView = {
  key: string;
  label: string;
  title: string;
  preview: string;
  targetPath: string;
  timestamp?: string;
  icon: React.ReactNode;
};

const asText = (value: unknown): string | undefined => {
  if (typeof value === 'string' && value.trim()) return value;
  if (typeof value === 'number') return String(value);
  return undefined;
};

const buildNotificationTarget = (event: NotificationEvent): string => {
  const data = event.data || {};
  if (event.type === 'NEW_PRIVATE_MESSAGE') {
    const params = new URLSearchParams({ tab: 'messages' });
    const senderId = asText(data.senderId);
    const senderName = asText(data.senderName);
    if (senderId) params.set('partnerId', senderId);
    if (senderName) params.set('partnerName', senderName);
    return `/chat?${params.toString()}`;
  }
  if (event.type === 'NEW_GROUP_MESSAGE') {
    const params = new URLSearchParams({ tab: 'messages' });
    const groupId = asText(data.groupId);
    const groupName = asText(data.groupName);
    if (groupId) params.set('groupId', groupId);
    if (groupName) params.set('groupName', groupName);
    return `/chat?${params.toString()}`;
  }
  return asText(data.targetPath) || '/chat';
};

const toNotificationView = (event: NotificationEvent, index: number): NotificationView | null => {
  if (event.type === 'UNREAD_COUNT_CHANGED') return null;
  const data = event.data || {};
  const channel = asText(data.channel);
  const title = asText(data.title);
  const preview = asText(data.preview) || asText(data.content);

  if (event.type === 'NEW_PRIVATE_MESSAGE') {
    return {
      key: `${event.type}-${asText(data.messageId) || event.timestamp || index}`,
      label: channel === 'PRIVATE_CHAT' ? '私聊' : '私聊消息',
      title: title || asText(data.senderName) || '新的私聊消息',
      preview: preview || '发来一条新消息',
      targetPath: buildNotificationTarget(event),
      timestamp: event.timestamp,
      icon: <MessageCircle size={16} />,
    };
  }

  if (event.type === 'NEW_GROUP_MESSAGE') {
    return {
      key: `${event.type}-${asText(data.groupId) || 'group'}-${asText(data.messageId) || event.timestamp || index}`,
      label: channel === 'GROUP_CHAT' ? '群聊' : '群消息',
      title: title || asText(data.groupName) || '新的群消息',
      preview: preview || `${asText(data.senderName) || '群成员'} 发来一条新消息`,
      targetPath: buildNotificationTarget(event),
      timestamp: event.timestamp,
      icon: <UsersRound size={16} />,
    };
  }

  if (event.type === 'FRIEND_REQUEST_RECEIVED' || event.type === 'FRIEND_REQUEST_HANDLED') {
    return {
      key: `${event.type}-${asText(data.requestId) || event.timestamp || index}`,
      label: '好友',
      title: title || '好友申请',
      preview: preview || (event.type === 'FRIEND_REQUEST_RECEIVED' ? `${asText(data.senderName) || '有人'} 请求添加你为好友` : '好友申请状态已更新'),
      targetPath: '/chat?tab=requests',
      timestamp: event.timestamp,
      icon: <UserPlus size={16} />,
    };
  }

  if (event.type.startsWith('GROUP_')) {
    return {
      key: `${event.type}-${asText(data.groupId) || event.timestamp || index}`,
      label: '群通知',
      title: title || asText(data.groupName) || '群聊通知',
      preview: preview || '群聊状态有更新',
      targetPath: buildNotificationTarget(event),
      timestamp: event.timestamp,
      icon: <UsersRound size={16} />,
    };
  }

  if (event.type === 'SYSTEM_NOTIFICATION') {
    return {
      key: `${event.type}-${event.timestamp || index}`,
      label: '系统',
      title: title || '系统通知',
      preview: preview || '你有一条系统通知',
      targetPath: buildNotificationTarget(event),
      timestamp: event.timestamp,
      icon: <Megaphone size={16} />,
    };
  }

  return {
    key: `${event.type}-${event.timestamp || index}`,
    label: '通知',
    title: title || '新通知',
    preview: preview || '有新的状态更新',
    targetPath: buildNotificationTarget(event),
    timestamp: event.timestamp,
    icon: <Inbox size={16} />,
  };
};

const formatNotificationTime = (dateStr?: string) => {
  if (!dateStr) return '';
  const time = new Date(dateStr);
  if (Number.isNaN(time.getTime())) return '';
  const diff = Date.now() - time.getTime();
  const minutes = Math.floor(diff / 60000);
  if (minutes < 1) return '刚刚';
  if (minutes < 60) return `${minutes}分钟前`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours}小时前`;
  return `${time.getMonth() + 1}月${time.getDate()}日`;
};

const NotificationBell: React.FC = () => {
  const navigate = useNavigate();
  const { totalUnread, notifications, clearNotifications } = useChat();
  const [open, setOpen] = useState(false);
  const bellRef = useRef<HTMLDivElement>(null);

  const items = notifications
    .map(toNotificationView)
    .filter((item): item is NotificationView => item !== null)
    .slice(0, 8);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (bellRef.current && !bellRef.current.contains(event.target as Node)) {
        setOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  return (
    <div className="relative" ref={bellRef}>
      <button
        onClick={() => setOpen((value) => !value)}
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

      {open && (
        <div className="absolute right-0 top-full mt-3 w-[360px] max-w-[calc(100vw-2rem)] overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-2xl shadow-gray-900/10 dark:border-gray-800 dark:bg-gray-900 dark:shadow-black/30 z-50 animate-in fade-in slide-in-from-top-2 duration-200">
          <div className="flex items-center justify-between px-4 py-3 border-b border-gray-100 dark:border-gray-800">
            <div>
              <h3 className="text-sm font-semibold text-gray-900 dark:text-white">通知</h3>
              <p className="text-xs text-gray-400">{totalUnread > 0 ? `${totalUnread} 条未读` : '暂无未读'}</p>
            </div>
            {items.length > 0 && (
              <button
                onClick={clearNotifications}
                className="text-xs font-medium text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 transition-colors"
              >
                清空
              </button>
            )}
          </div>

          <div className="max-h-[420px] overflow-y-auto">
            {items.length === 0 ? (
              <div className="px-5 py-8 text-center">
                <div className="mx-auto mb-3 flex h-11 w-11 items-center justify-center rounded-2xl bg-gray-100 text-gray-400 dark:bg-gray-800">
                  <Inbox size={20} />
                </div>
                <p className="text-sm font-medium text-gray-700 dark:text-gray-200">暂无新通知</p>
                <p className="mt-1 text-xs text-gray-400">私聊、群聊和申请会显示在这里</p>
                <button
                  onClick={() => { setOpen(false); navigate('/chat'); }}
                  className="mt-4 px-3 py-2 text-xs font-medium text-brand-600 bg-brand-50 hover:bg-brand-100 dark:bg-brand-900/20 dark:text-brand-300 dark:hover:bg-brand-900/30 rounded-lg transition-colors"
                >
                  前往消息中心
                </button>
              </div>
            ) : (
              <div className="divide-y divide-gray-100 dark:divide-gray-800">
                {items.map((item) => (
                  <button
                    key={item.key}
                    onClick={() => {
                      setOpen(false);
                      navigate(item.targetPath);
                    }}
                    className="w-full flex gap-3 px-4 py-3 text-left hover:bg-gray-50 dark:hover:bg-gray-800/70 transition-colors"
                  >
                    <span className="mt-0.5 flex h-9 w-9 flex-shrink-0 items-center justify-center rounded-xl bg-brand-50 text-brand-600 dark:bg-brand-900/25 dark:text-brand-300">
                      {item.icon}
                    </span>
                    <span className="min-w-0 flex-1">
                      <span className="flex items-center gap-2">
                        <span className="text-[11px] font-semibold text-brand-600 dark:text-brand-300 bg-brand-50 dark:bg-brand-900/20 px-1.5 py-0.5 rounded">
                          {item.label}
                        </span>
                        <span className="text-[11px] text-gray-400">{formatNotificationTime(item.timestamp)}</span>
                      </span>
                      <span className="mt-1 block text-sm font-medium text-gray-900 dark:text-white truncate">
                        {item.title}
                      </span>
                      <span className="mt-0.5 block text-xs text-gray-500 dark:text-gray-400 line-clamp-2">
                        {item.preview}
                      </span>
                    </span>
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>
      )}
    </div>
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
