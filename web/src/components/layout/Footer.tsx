import React from 'react';
import { Twitter, Github, Linkedin, MessageCircle } from 'lucide-react';

export const Footer: React.FC = () => {
  return (
    <footer className="bg-white dark:bg-[#111827] border-t border-gray-200 dark:border-gray-800 pt-16 pb-8 transition-colors duration-300">
      <div className="max-w-7xl mx-auto px-4 md:px-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-12">
          {/* Brand Column */}
          <div className="space-y-4">
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center text-white font-bold">N</div>
              <span className="text-xl font-bold text-gray-900 dark:text-white">NovaCode</span>
            </div>
            <p className="text-gray-500 dark:text-gray-400 text-sm leading-relaxed">
              Empowering developers to master their craft through interactive learning and AI-assisted guidance.
            </p>
            <div className="flex gap-4 pt-2">
              <a href="#" className="text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
                <span className="sr-only">Twitter</span>
                <Twitter className="w-5 h-5" />
              </a>
              <a href="#" className="text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
                <span className="sr-only">GitHub</span>
                <Github className="w-5 h-5" />
              </a>
              <a href="#" className="text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
                <span className="sr-only">Discord</span>
                <MessageCircle className="w-5 h-5" />
              </a>
              <a href="#" className="text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
                <span className="sr-only">LinkedIn</span>
                <Linkedin className="w-5 h-5" />
              </a>
            </div>
          </div>

          {/* Links Column 1 */}
          <div>
            <h3 className="font-semibold text-gray-900 dark:text-white mb-4">Platform</h3>
            <ul className="space-y-3 text-sm text-gray-500 dark:text-gray-400">
              <li><a href="#" className="hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Browse Courses</a></li>
              <li><a href="#" className="hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Study Plans</a></li>
              <li><a href="#" className="hover:text-blue-600 dark:hover:text-blue-400 transition-colors">AI Assistant</a></li>
              <li><a href="#" className="hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Mock Interviews</a></li>
            </ul>
          </div>

          {/* Links Column 2 */}
          <div>
            <h3 className="font-semibold text-gray-900 dark:text-white mb-4">Company</h3>
            <ul className="space-y-3 text-sm text-gray-500 dark:text-gray-400">
              <li><a href="#" className="hover:text-blue-600 dark:hover:text-blue-400 transition-colors">About Us</a></li>
              <li><a href="#" className="hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Careers</a></li>
              <li><a href="#" className="hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Blog</a></li>
              <li><a href="#" className="hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Contact</a></li>
            </ul>
          </div>

          {/* Newsletter Column */}
          <div>
            <h3 className="font-semibold text-gray-900 dark:text-white mb-4">Stay Updated</h3>
            <p className="text-sm text-gray-500 dark:text-gray-400 mb-4">
              Subscribe to our newsletter for the latest updates and learning tips.
            </p>
            <div className="flex gap-2">
              <input 
                type="email" 
                placeholder="Enter your email" 
                className="flex-1 bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-blue-500 dark:text-white"
              />
              <button className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                Subscribe
              </button>
            </div>
          </div>
        </div>

        <div className="border-t border-gray-200 dark:border-gray-800 pt-8 flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-gray-500 dark:text-gray-400">
          <p>&copy; 2024 NovaCode Education. All rights reserved.</p>
          <div className="flex gap-6">
            <a href="#" className="hover:text-gray-900 dark:hover:text-white transition-colors">Privacy Policy</a>
            <a href="#" className="hover:text-gray-900 dark:hover:text-white transition-colors">Terms of Service</a>
            <a href="#" className="hover:text-gray-900 dark:hover:text-white transition-colors">Cookie Policy</a>
          </div>
        </div>
      </div>
    </footer>
  );
};
