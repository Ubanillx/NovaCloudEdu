import React from 'react';
import { Twitter, Github, Linkedin, MessageCircle } from 'lucide-react';
import logo from '../../assets/logo.svg';

export const Footer: React.FC = () => {
  return (
    <footer className="bg-white dark:bg-[#111827] border-t border-gray-200 dark:border-gray-800 pt-16 pb-8 transition-colors duration-300">
      <div className="max-w-7xl mx-auto px-4 md:px-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-12">
          {/* Brand Column */}
          <div className="space-y-4">
            <div className="flex items-center gap-2">
              <img src={logo} alt="智云星课" className="w-8 h-8 object-contain" />
              <span className="text-xl font-bold text-gray-900 dark:text-white">智云星课</span>
            </div>
            <p className="text-gray-500 dark:text-gray-400 text-sm leading-relaxed">
              为中小学生量身打造的 AI 智能学习空间，激发求知欲，点亮创造力。
            </p>
            <div className="flex gap-4 pt-2">
              <a href="#" className="text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors">
                <span className="sr-only">Twitter</span>
                <Twitter className="w-5 h-5" />
              </a>
              <a href="#" className="text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors">
                <span className="sr-only">GitHub</span>
                <Github className="w-5 h-5" />
              </a>
              <a href="#" className="text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors">
                <span className="sr-only">Discord</span>
                <MessageCircle className="w-5 h-5" />
              </a>
              <a href="#" className="text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors">
                <span className="sr-only">LinkedIn</span>
                <Linkedin className="w-5 h-5" />
              </a>
            </div>
          </div>

          {/* Links Column 1 */}
          <div>
            <h3 className="font-semibold text-gray-900 dark:text-white mb-4">平台</h3>
            <ul className="space-y-3 text-sm text-gray-500 dark:text-gray-400">
              <li><a href="#" className="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">浏览课程</a></li>
              <li><a href="#" className="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">学习计划</a></li>
              <li><a href="#" className="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">AI 助手</a></li>
              <li><a href="#" className="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">模拟面试</a></li>
            </ul>
          </div>

          {/* Links Column 2 */}
          <div>
            <h3 className="font-semibold text-gray-900 dark:text-white mb-4">公司</h3>
            <ul className="space-y-3 text-sm text-gray-500 dark:text-gray-400">
              <li><a href="#" className="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">关于我们</a></li>
              <li><a href="#" className="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">加入我们</a></li>
              <li><a href="#" className="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">博客</a></li>
              <li><a href="#" className="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">联系我们</a></li>
            </ul>
          </div>

          {/* Newsletter Column */}
          <div>
            <h3 className="font-semibold text-gray-900 dark:text-white mb-4">关注动态</h3>
            <p className="text-sm text-gray-500 dark:text-gray-400 mb-4">
              订阅我们的教育简报，获取最新的学习资讯和家教建议。
            </p>
            <div className="flex gap-2">
              <input 
                type="email" 
                placeholder="输入您的邮箱" 
                className="flex-1 bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-brand-500 dark:text-white"
              />
              <button className="bg-brand-600 hover:bg-brand-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                订阅
              </button>
            </div>
          </div>
        </div>

        <div className="border-t border-gray-200 dark:border-gray-800 pt-8 flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-gray-500 dark:text-gray-400">
          <p>&copy; 2024 智云星课. 保留所有权利。</p>
          <div className="flex gap-6">
            <a href="#" className="hover:text-gray-900 dark:hover:text-white transition-colors">隐私政策</a>
            <a href="#" className="hover:text-gray-900 dark:hover:text-white transition-colors">服务条款</a>
            <a href="#" className="hover:text-gray-900 dark:hover:text-white transition-colors">Cookie 政策</a>
          </div>
        </div>
      </div>
    </footer>
  );
};
