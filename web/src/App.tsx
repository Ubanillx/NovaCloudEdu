import { Header, Footer, Sider, Content } from './components/layout';
import { MockData } from './data/mock';

function App() {
  return (
    <div className="min-h-screen flex flex-col bg-gray-50 dark:bg-gray-950 text-gray-900 dark:text-gray-100 font-sans transition-colors duration-300">
      <Header />
      
      <div className="flex flex-1 max-w-7xl mx-auto w-full">
        <Sider />
        
        <Content>
          <div className="flex flex-col lg:flex-row gap-8">
            {/* Main Content Area */}
            <div className="flex-1 space-y-8 min-w-0">
              {/* Bold Hero & Search Section (Adaptive Theme) */}
              <div className="relative rounded-3xl overflow-hidden bg-white dark:bg-gray-900 text-gray-900 dark:text-white shadow-xl dark:shadow-2xl border border-gray-100 dark:border-gray-800 min-h-[400px] flex items-center group [perspective:1000px] transition-colors duration-300">
                
                {/* Animated Background Gradients */}
                <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,rgba(var(--color-brand-100),0.5),rgba(255,255,255,0))] dark:bg-[radial-gradient(circle_at_50%_50%,rgba(var(--color-brand-900),0.3),rgba(15,23,42,0))]" />
                <div className="absolute -top-24 -right-24 w-96 h-96 bg-brand-100/50 dark:bg-brand-600/30 rounded-full blur-[80px] dark:blur-[100px] animate-pulse" />
                <div className="absolute -bottom-24 -left-24 w-96 h-96 bg-accent-100/50 dark:bg-accent-500/30 rounded-full blur-[80px] dark:blur-[100px] animate-pulse delay-1000" />
                
                {/* Floating 3D Elements */}
                <div className="absolute top-12 right-24 w-16 h-16 bg-gradient-to-br from-brand-400 to-highlight-500 dark:from-brand-500 dark:to-highlight-600 rounded-2xl rotate-12 shadow-xl shadow-brand-500/30 dark:shadow-brand-500/20 animate-[float_6s_ease-in-out_infinite] opacity-90 dark:opacity-80" />
                <div className="absolute bottom-20 left-20 w-12 h-12 bg-gradient-to-br from-accent-300 to-brand-400 dark:from-accent-400 dark:to-brand-500 rounded-full shadow-lg shadow-accent-400/30 dark:shadow-accent-500/20 animate-[float_8s_ease-in-out_infinite_reverse] opacity-80 dark:opacity-60" />
                <div className="absolute top-1/2 right-1/3 w-8 h-8 bg-brand-500/10 dark:bg-white/10 rounded-lg rotate-45 backdrop-blur-sm animate-[float_10s_ease-in-out_infinite] delay-500" />

                <div className="relative z-10 w-full px-8 md:px-16 py-12 flex flex-col items-center text-center">
                  <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand-50 dark:bg-brand-900/20 border border-brand-100 dark:border-gray-800 text-xs font-medium text-brand-600 dark:text-brand-300 mb-6 backdrop-blur-sm">
                    <span className="w-2 h-2 rounded-full bg-brand-500 dark:bg-brand-400 animate-pulse"></span>
                    智云星课
                  </div>
                  
                  <h1 className="text-4xl md:text-6xl font-black mb-6 tracking-tight text-gray-900 dark:text-white">
                    开启 <br className="hidden md:block" />
                    <span className="text-transparent bg-clip-text bg-gradient-to-r from-brand-600 to-accent-500 dark:from-brand-400 dark:to-accent-300">AI 学习新天地</span>
                  </h1>
                  
                  <p className="text-gray-500 dark:text-gray-400 text-lg md:text-xl mb-10 max-w-2xl leading-relaxed">
                    专为中小学生设计的智能学习伙伴。通过趣味 AI 互动、科学学习路径，发现你的无限潜能。
                  </p>
                  
                  {/* Glassmorphic Search Bar (Adaptive) */}
                  <div className="relative w-full max-w-2xl group/search">
                    <div className="absolute inset-0 bg-gradient-to-r from-brand-400 to-accent-400 dark:from-brand-500 dark:to-accent-500 rounded-2xl blur opacity-20 group-hover/search:opacity-30 dark:group-hover/search:opacity-40 transition-opacity duration-500"></div>
                    <div className="relative flex items-center bg-white dark:bg-gray-900 dark:backdrop-blur-xl border border-gray-100 dark:border-gray-800 rounded-2xl p-2 shadow-xl dark:shadow-2xl transition-all duration-300 group-focus-within/search:border-brand-200 dark:group-focus-within/search:border-brand-500/30 group-focus-within/search:ring-4 group-focus-within/search:ring-brand-50 dark:group-focus-within/search:ring-brand-500/10 group-focus-within/search:scale-[1.02]">
                      <div className="pl-4 pr-3 text-gray-400 group-focus-within/search:text-brand-500 dark:group-focus-within/search:text-brand-400 transition-colors">
                        <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                      </div>
                      <input 
                        type="text" 
                        placeholder="想探索什么新知识？" 
                        className="flex-1 bg-transparent border-none outline-none text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 h-12 text-lg"
                      />
                      <button className="bg-gray-900 dark:bg-brand-600 hover:bg-brand-600 dark:hover:bg-brand-500 text-white px-6 py-3 rounded-xl font-semibold transition-all shadow-lg shadow-gray-900/10 dark:shadow-brand-600/20 hover:shadow-brand-600/30 active:scale-95 flex items-center gap-2">
                        <span>探索</span>
                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path></svg>
                      </button>
                    </div>
                  </div>
                  
                  {/* Popular Tags */}
                  <div className="mt-8 flex flex-wrap justify-center gap-3 text-sm text-gray-500 dark:text-gray-400">
                    <span className="text-gray-400 dark:text-gray-500">大家都在找:</span>
                    {['少儿编程', '趣味数学', '英语口语', '科学小实验'].map(tag => (
                      <a key={tag} href="#" className="hover:text-brand-600 dark:hover:text-white hover:bg-brand-50 dark:hover:bg-brand-900/20 px-2 py-1 rounded transition-colors">{tag}</a>
                    ))}
                  </div>
                </div>
              </div>

              {/* Popular Courses Grid */}
              <div>
                <div className="flex items-center justify-between mb-6">
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">热门课程</h2>
                  <a href="#courses" className="text-brand-600 hover:text-brand-700 dark:text-brand-400 dark:hover:text-brand-300 text-sm font-medium flex items-center gap-1">
                    查看全部 <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7"></path></svg>
                  </a>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                  {MockData.courses.map((course) => (
                    <div key={course.id} className="group bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 overflow-hidden hover:shadow-lg transition-all duration-300 cursor-pointer">
                      <div className="relative aspect-video overflow-hidden">
                        <img 
                          src={course.cover} 
                          alt={course.title} 
                          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                        />
                        <div className="absolute top-2 right-2 bg-white/90 dark:bg-gray-900/90 dark:text-white px-2 py-1 rounded text-xs font-semibold backdrop-blur-sm">
                          {course.tag}
                        </div>
                      </div>
                      <div className="p-4">
                        <h3 className="font-semibold text-lg mb-2 line-clamp-1 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors text-gray-900 dark:text-white">{course.title}</h3>
                        <p className="text-gray-500 dark:text-gray-400 text-sm mb-4 line-clamp-2 h-10">{course.brief}</p>
                        <div className="flex items-center justify-between text-xs text-gray-400 dark:text-gray-500">
                          <div className="flex items-center gap-1">
                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
                            {course.studentsCount} 位学员
                          </div>
                          <span className="text-brand-600 bg-brand-50 dark:bg-brand-900/30 dark:text-brand-400 px-2 py-1 rounded">开始学习</span>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Articles List */}
              <div>
                <div className="flex items-center justify-between mb-6">
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">精选文章</h2>
                  <a href="#articles" className="text-brand-600 hover:text-brand-700 dark:text-brand-400 dark:hover:text-brand-300 text-sm font-medium flex items-center gap-1">
                    查看全部 <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7"></path></svg>
                  </a>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  {MockData.articles.map((article) => (
                    <div key={article.id} className="flex gap-4 bg-white dark:bg-gray-900 p-4 rounded-xl border border-gray-200 dark:border-gray-800 hover:border-brand-300 dark:hover:border-brand-700 transition-colors cursor-pointer group">
                       <div className="w-24 h-24 flex-shrink-0 rounded-lg overflow-hidden">
                        <img src={article.cover} alt={article.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"/>
                      </div>
                      <div className="flex flex-col justify-between py-1">
                        <div>
                          <div className="flex items-center gap-2 mb-2">
                            <span className="text-xs font-semibold text-brand-600 bg-brand-50 dark:bg-brand-900/30 dark:text-brand-400 px-2 py-0.5 rounded">{article.category}</span>
                            <span className="text-xs text-gray-400 dark:text-gray-500">{article.readTime} 分钟阅读</span>
                          </div>
                          <h3 className="font-bold text-lg mb-2 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors line-clamp-2 text-gray-900 dark:text-white">{article.title}</h3>
                          <p className="text-sm text-gray-500 dark:text-gray-400 line-clamp-2">{article.brief}</p>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            {/* Right Sidebar */}
            <div className="w-full lg:w-80 space-y-8 flex-shrink-0">
               {/* Learning Status Widget */}
              <div className="bg-white dark:bg-gray-900 p-6 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm">
                 <h3 className="font-bold text-lg mb-4 flex items-center gap-2 text-gray-900 dark:text-white">
                   <span className="w-1 h-6 bg-brand-600 rounded-full"></span>
                   学习状态
                 </h3>
                 <div className="grid grid-cols-2 gap-4 mb-6">
                   <div className="bg-brand-50 dark:bg-brand-900/20 p-4 rounded-xl text-center">
                      <div className="text-2xl font-bold text-brand-600 dark:text-brand-400 mb-1">{MockData.userStats.streak}</div>
                      <div className="text-xs text-gray-500 dark:text-gray-400 font-medium">连续学习</div>
                   </div>
                   <div className="bg-warning-bg dark:bg-warning-dark/20 p-4 rounded-xl text-center">
                      <div className="text-2xl font-bold text-warning dark:text-warning-dark mb-1">{MockData.userStats.totalHours}h</div>
                      <div className="text-xs text-gray-500 dark:text-gray-400 font-medium">累计学时</div>
                   </div>
                 </div>
                 
                 <div className="space-y-4">
                   <div>
                     <div className="flex justify-between text-sm mb-2">
                       <span className="text-gray-600 dark:text-gray-300">等级 5</span>
                       <span className="font-bold text-brand-600 dark:text-brand-400">{MockData.userStats.points}/3000 XP</span>
                     </div>
                     <div className="h-2 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
                       <div className="h-full bg-brand-600 dark:bg-brand-500 rounded-full" style={{ width: '82%' }}></div>
                     </div>
                   </div>
                   
                   <div className="pt-4 border-t border-gray-100 dark:border-gray-800">
                     <div className="flex items-center justify-between text-sm">
                       <span className="text-gray-500 dark:text-gray-400">已完成课程</span>
                       <span className="font-bold text-gray-900 dark:text-white">{MockData.userStats.completedCourses}</span>
                     </div>
                   </div>
                 </div>
              </div>

               {/* Notice Board */}
               <div className="bg-white dark:bg-gray-900 p-6 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="font-bold text-lg flex items-center gap-2 text-gray-900 dark:text-white">
                    <span className="w-1 h-6 bg-warning rounded-full"></span>
                    最新公告
                  </h3>
                  <a href="#" className="text-xs text-gray-400 hover:text-brand-600 dark:hover:text-brand-400">更多</a>
                </div>
                <div className="space-y-4">
                  {MockData.notices.map((notice) => (
                    <div key={notice.id} className="pb-4 border-b border-gray-100 dark:border-gray-800 last:border-0 last:pb-0">
                      <div className="flex gap-3">
                        <div className="w-8 h-8 rounded-full bg-warning-bg dark:bg-warning-dark/20 text-warning dark:text-warning-dark flex items-center justify-center flex-shrink-0">
                          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
                        </div>
                        <div>
                          <p className="text-sm font-medium text-gray-800 dark:text-gray-200 leading-tight mb-1 hover:text-brand-600 dark:hover:text-brand-400 cursor-pointer transition-colors">{notice.title}</p>
                          <span className="text-xs text-gray-400 dark:text-gray-500">{(notice as any).time}</span>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Daily Word (Moved to Sidebar) */}
              <div className="bg-gradient-to-br from-brand-600 to-accent-600 p-6 rounded-xl text-white shadow-md relative overflow-hidden">
                <div className="absolute top-0 right-0 p-4 opacity-10">
                   <svg className="w-24 h-24" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"></path></svg>
                </div>
                <h3 className="text-xs font-semibold text-brand-100 uppercase tracking-wider mb-2">每日单词</h3>
                <h2 className="text-2xl font-bold mb-1">{MockData.dailyWord.word}</h2>
                <div className="text-sm text-brand-100 font-mono mb-4">{MockData.dailyWord.phonetic}</div>
                <p className="text-white/90 text-sm mb-3">{MockData.dailyWord.translation}</p>
                <div className="bg-white/10 p-3 rounded-lg backdrop-blur-sm">
                  <p className="text-xs text-brand-50 italic">"{MockData.dailyWord.example}"</p>
                </div>
              </div>
            </div>
          </div>
        </Content>
      </div>
      
      <Footer />
    </div>
  );
}

export default App;
