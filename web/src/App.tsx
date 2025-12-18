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
                <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,rgba(219,234,254,0.5),rgba(255,255,255,0))] dark:bg-[radial-gradient(circle_at_50%_50%,rgba(76,29,149,0.3),rgba(15,23,42,0))]" />
                <div className="absolute -top-24 -right-24 w-96 h-96 bg-blue-100/50 dark:bg-blue-600/30 rounded-full blur-[80px] dark:blur-[100px] animate-pulse" />
                <div className="absolute -bottom-24 -left-24 w-96 h-96 bg-cyan-100/50 dark:bg-cyan-500/30 rounded-full blur-[80px] dark:blur-[100px] animate-pulse delay-1000" />
                
                {/* Floating 3D Elements */}
                <div className="absolute top-12 right-24 w-16 h-16 bg-gradient-to-br from-blue-400 to-indigo-500 dark:from-blue-500 dark:to-indigo-600 rounded-2xl rotate-12 shadow-xl shadow-blue-500/30 dark:shadow-blue-500/20 animate-[float_6s_ease-in-out_infinite] opacity-90 dark:opacity-80" />
                <div className="absolute bottom-20 left-20 w-12 h-12 bg-gradient-to-br from-cyan-300 to-blue-400 dark:from-cyan-400 dark:to-blue-500 rounded-full shadow-lg shadow-cyan-400/30 dark:shadow-cyan-500/20 animate-[float_8s_ease-in-out_infinite_reverse] opacity-80 dark:opacity-60" />
                <div className="absolute top-1/2 right-1/3 w-8 h-8 bg-blue-500/10 dark:bg-white/10 rounded-lg rotate-45 backdrop-blur-sm animate-[float_10s_ease-in-out_infinite] delay-500" />

                <div className="relative z-10 w-full px-8 md:px-16 py-12 flex flex-col items-center text-center">
                  <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-50 dark:bg-blue-900/20 border border-blue-100 dark:border-gray-800 text-xs font-medium text-blue-600 dark:text-blue-300 mb-6 backdrop-blur-sm">
                    <span className="w-2 h-2 rounded-full bg-blue-500 dark:bg-blue-400 animate-pulse"></span>
                    NovaCloud Education 2.0
                  </div>
                  
                  <h1 className="text-4xl md:text-6xl font-black mb-6 tracking-tight text-gray-900 dark:text-white">
                    Master the Future of <br className="hidden md:block" />
                    <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-cyan-500 dark:from-blue-400 dark:to-cyan-300">Digital Innovation</span>
                  </h1>
                  
                  <p className="text-gray-500 dark:text-gray-400 text-lg md:text-xl mb-10 max-w-2xl leading-relaxed">
                    Unlock your potential with industry-leading courses, interactive AI mentorship, and a global community of developers.
                  </p>
                  
                  {/* Glassmorphic Search Bar (Adaptive) */}
                  <div className="relative w-full max-w-2xl group/search">
                    <div className="absolute inset-0 bg-gradient-to-r from-blue-400 to-cyan-400 dark:from-blue-500 dark:to-cyan-500 rounded-2xl blur opacity-20 group-hover/search:opacity-30 dark:group-hover/search:opacity-40 transition-opacity duration-500"></div>
                    <div className="relative flex items-center bg-white dark:bg-gray-900 dark:backdrop-blur-xl border border-gray-100 dark:border-gray-800 rounded-2xl p-2 shadow-xl dark:shadow-2xl transition-all duration-300 group-focus-within/search:border-blue-200 dark:group-focus-within/search:border-blue-500/30 group-focus-within/search:ring-4 group-focus-within/search:ring-blue-50 dark:group-focus-within/search:ring-blue-500/10 group-focus-within/search:scale-[1.02]">
                      <div className="pl-4 pr-3 text-gray-400 group-focus-within/search:text-blue-500 dark:group-focus-within/search:text-blue-400 transition-colors">
                        <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                      </div>
                      <input 
                        type="text" 
                        placeholder="What do you want to learn today?" 
                        className="flex-1 bg-transparent border-none outline-none text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 h-12 text-lg"
                      />
                      <button className="bg-gray-900 dark:bg-blue-600 hover:bg-blue-600 dark:hover:bg-blue-500 text-white px-6 py-3 rounded-xl font-semibold transition-all shadow-lg shadow-gray-900/10 dark:shadow-blue-600/20 hover:shadow-blue-600/30 active:scale-95 flex items-center gap-2">
                        <span>Search</span>
                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path></svg>
                      </button>
                    </div>
                  </div>
                  
                  {/* Popular Tags */}
                  <div className="mt-8 flex flex-wrap justify-center gap-3 text-sm text-gray-500 dark:text-gray-400">
                    <span className="text-gray-400 dark:text-gray-500">Popular:</span>
                    {['React', 'Python', 'AI Agents', 'System Design'].map(tag => (
                      <a key={tag} href="#" className="hover:text-blue-600 dark:hover:text-white hover:bg-blue-50 dark:hover:bg-blue-900/20 px-2 py-1 rounded transition-colors">{tag}</a>
                    ))}
                  </div>
                </div>
              </div>

              {/* Popular Courses Grid */}
              <div>
                <div className="flex items-center justify-between mb-6">
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Popular Courses</h2>
                  <a href="#courses" className="text-blue-600 hover:text-blue-700 dark:text-blue-400 dark:hover:text-blue-300 text-sm font-medium flex items-center gap-1">
                    View All <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7"></path></svg>
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
                        <h3 className="font-semibold text-lg mb-2 line-clamp-1 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors text-gray-900 dark:text-white">{course.title}</h3>
                        <p className="text-gray-500 dark:text-gray-400 text-sm mb-4 line-clamp-2 h-10">{course.brief}</p>
                        <div className="flex items-center justify-between text-xs text-gray-400 dark:text-gray-500">
                          <div className="flex items-center gap-1">
                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
                            {course.studentsCount} students
                          </div>
                          <span className="text-blue-600 bg-blue-50 dark:bg-blue-900/30 dark:text-blue-400 px-2 py-1 rounded">Start Learning</span>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Articles List */}
              <div>
                <div className="flex items-center justify-between mb-6">
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Featured Articles</h2>
                  <a href="#articles" className="text-blue-600 hover:text-blue-700 dark:text-blue-400 dark:hover:text-blue-300 text-sm font-medium flex items-center gap-1">
                    View All <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7"></path></svg>
                  </a>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  {MockData.articles.map((article) => (
                    <div key={article.id} className="flex gap-4 bg-white dark:bg-gray-900 p-4 rounded-xl border border-gray-200 dark:border-gray-800 hover:border-blue-300 dark:hover:border-blue-700 transition-colors cursor-pointer group">
                       <div className="w-24 h-24 flex-shrink-0 rounded-lg overflow-hidden">
                        <img src={article.cover} alt={article.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"/>
                      </div>
                      <div className="flex flex-col justify-between py-1">
                        <div>
                          <div className="flex items-center gap-2 mb-2">
                            <span className="text-xs font-semibold text-blue-600 bg-blue-50 dark:bg-blue-900/30 dark:text-blue-400 px-2 py-0.5 rounded">{article.category}</span>
                            <span className="text-xs text-gray-400 dark:text-gray-500">{article.readTime} min read</span>
                          </div>
                          <h3 className="font-bold text-lg mb-2 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors line-clamp-2 text-gray-900 dark:text-white">{article.title}</h3>
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
                   <span className="w-1 h-6 bg-blue-600 rounded-full"></span>
                   Learning Status
                 </h3>
                 <div className="grid grid-cols-2 gap-4 mb-6">
                   <div className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-xl text-center">
                      <div className="text-2xl font-bold text-blue-600 dark:text-blue-400 mb-1">{MockData.userStats.streak}</div>
                      <div className="text-xs text-gray-500 dark:text-gray-400 font-medium">Day Streak</div>
                   </div>
                   <div className="bg-orange-50 dark:bg-orange-900/20 p-4 rounded-xl text-center">
                      <div className="text-2xl font-bold text-orange-600 dark:text-orange-400 mb-1">{MockData.userStats.totalHours}h</div>
                      <div className="text-xs text-gray-500 dark:text-gray-400 font-medium">Study Time</div>
                   </div>
                 </div>
                 
                 <div className="space-y-4">
                   <div>
                     <div className="flex justify-between text-sm mb-2">
                       <span className="text-gray-600 dark:text-gray-300">Level 5</span>
                       <span className="font-bold text-blue-600 dark:text-blue-400">{MockData.userStats.points}/3000 XP</span>
                     </div>
                     <div className="h-2 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
                       <div className="h-full bg-blue-600 dark:bg-blue-500 rounded-full" style={{ width: '82%' }}></div>
                     </div>
                   </div>
                   
                   <div className="pt-4 border-t border-gray-100 dark:border-gray-800">
                     <div className="flex items-center justify-between text-sm">
                       <span className="text-gray-500 dark:text-gray-400">Completed Courses</span>
                       <span className="font-bold text-gray-900 dark:text-white">{MockData.userStats.completedCourses}</span>
                     </div>
                   </div>
                 </div>
              </div>

               {/* Notice Board */}
               <div className="bg-white dark:bg-gray-900 p-6 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="font-bold text-lg flex items-center gap-2 text-gray-900 dark:text-white">
                    <span className="w-1 h-6 bg-orange-500 rounded-full"></span>
                    Announcements
                  </h3>
                  <a href="#" className="text-xs text-gray-400 hover:text-blue-600 dark:hover:text-blue-400">More</a>
                </div>
                <div className="space-y-4">
                  {MockData.notices.map((notice) => (
                    <div key={notice.id} className="pb-4 border-b border-gray-100 dark:border-gray-800 last:border-0 last:pb-0">
                      <div className="flex gap-3">
                        <div className="w-8 h-8 rounded-full bg-orange-50 dark:bg-orange-900/20 text-orange-600 dark:text-orange-400 flex items-center justify-center flex-shrink-0">
                          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
                        </div>
                        <div>
                          <p className="text-sm font-medium text-gray-800 dark:text-gray-200 leading-tight mb-1 hover:text-blue-600 dark:hover:text-blue-400 cursor-pointer transition-colors">{notice.title}</p>
                          <span className="text-xs text-gray-400 dark:text-gray-500">{(notice as any).time}</span>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Daily Word (Moved to Sidebar) */}
              <div className="bg-gradient-to-br from-blue-600 to-cyan-600 p-6 rounded-xl text-white shadow-md relative overflow-hidden">
                <div className="absolute top-0 right-0 p-4 opacity-10">
                   <svg className="w-24 h-24" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"></path></svg>
                </div>
                <h3 className="text-xs font-semibold text-blue-100 uppercase tracking-wider mb-2">Daily Word</h3>
                <h2 className="text-2xl font-bold mb-1">{MockData.dailyWord.word}</h2>
                <div className="text-sm text-blue-100 font-mono mb-4">{MockData.dailyWord.phonetic}</div>
                <p className="text-white/90 text-sm mb-3">{MockData.dailyWord.translation}</p>
                <div className="bg-white/10 p-3 rounded-lg backdrop-blur-sm">
                  <p className="text-xs text-blue-50 italic">"{MockData.dailyWord.example}"</p>
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
