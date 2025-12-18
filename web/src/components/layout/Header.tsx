import React from 'react';
import { Sun, Moon } from 'lucide-react';
import { useTheme } from '../../context/ThemeContext';

export const Header: React.FC = () => {
  const { theme, toggleTheme } = useTheme();

  return (
    <header className="h-14 bg-white dark:bg-[#111827] border-b border-gray-200 dark:border-gray-800 flex items-center px-4 sticky top-0 z-50 transition-colors duration-300">
      {/* Logo Area */}
      <div className="flex items-center mr-8">
        <a href="/" className="flex items-center gap-2">
          <div className="w-8 h-8 bg-blue-600 dark:bg-white rounded-lg flex items-center justify-center transition-colors duration-300">
            <span className="text-white dark:text-black font-bold">N</span>
          </div>
          <span className="text-lg font-semibold hidden md:block text-gray-800 dark:text-gray-100">NovaCode</span>
        </a>
      </div>

      {/* Navigation */}
      <nav className="hidden md:flex flex-1 items-center gap-6">
        {['Home', 'Courses', 'Circle', 'Chat'].map((item) => (
          <a
            key={item}
            href={`#${item.toLowerCase()}`}
            className="text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors text-sm font-medium"
          >
            {item}
          </a>
        ))}
      </nav>

      {/* Right Actions */}
      <div className="flex items-center gap-4 ml-auto">
        {/* Expanding Search Bar */}
        <div className="relative flex items-center justify-end">
          <input
            type="text"
            placeholder="Search..."
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

        <div className="flex items-center gap-2 cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700 p-1 pr-2 rounded-full transition-colors">
          <div className="w-8 h-8 bg-gradient-to-tr from-blue-500 to-cyan-500 rounded-full flex items-center justify-center text-white font-bold text-xs">
            U
          </div>
          <span className="text-xs text-gray-700 dark:text-gray-200 hidden sm:block">User</span>
        </div>
      </div>
    </header>
  );
};
