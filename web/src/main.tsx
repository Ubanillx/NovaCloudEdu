import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter, Routes, Route, Navigate, useLocation } from 'react-router-dom'
import './index.css'
import App from './App.tsx'
import { ThemeProvider } from './context/ThemeContext.tsx'
import { LoginPage, RegisterPage } from './pages'
import { ProtectedRoute } from './components/ProtectedRoute'
import { AdminLayout } from './components/layout/AdminLayout'
import { UserManagementPage } from './pages/admin/UserManagementPage'
import { ScraperConfigPage } from './pages/admin/ScraperConfigPage'
import { ScraperTaskPage } from './pages/admin/ScraperTaskPage'
import { DailyWordManagementPage } from './pages/admin/DailyWordManagementPage'
import { DailyArticleManagementPage } from './pages/admin/DailyArticleManagementPage'
import { AnnouncementManagementPage } from './pages/admin/AnnouncementManagementPage'
import { BannerManagementPage } from './pages/admin/BannerManagementPage'
import { FeedbackManagementPage } from './pages/admin/FeedbackManagementPage'
import { PostManagementPage } from './pages/admin/PostManagementPage'
import { KnowledgeBaseManagementPage } from './pages/admin/KnowledgeBaseManagementPage'
import { AiAssistantManagementPage } from './pages/admin/AiAssistantManagementPage'
import { WorkflowManagementPage } from './pages/admin/WorkflowManagementPage'
import { WorkflowEditorPage } from './pages/admin/workflow/WorkflowEditorPage'
import { McpServerManagementPage } from './pages/admin/McpServerManagementPage'
import PptTemplateManagementPage from './pages/admin/PptTemplateManagementPage'
import PptGeneratorPage from './pages/admin/PptGeneratorPage'
import PptEditorPage from './pages/admin/PptEditorPage'
import { QuestionManagementPage } from './pages/admin/QuestionManagementPage'
import { ExamPaperManagementPage } from './pages/admin/ExamPaperManagementPage'
import { ExamTemplateManagementPage } from './pages/admin/ExamTemplateManagementPage'
import { CourseManagementPage } from './pages/admin/CourseManagementPage'
import { TeacherManagementPage } from './pages/admin/TeacherManagementPage'
import { ClassManagementPage } from './pages/admin/ClassManagementPage'
import { GroupManagementPage } from './pages/admin/GroupManagementPage'
import { getToken } from './api'
import { useEffect } from 'react'

// 路由切换时滚动到顶部
const ScrollToTop = () => {
  const { pathname } = useLocation();
  useEffect(() => {
    window.scrollTo(0, 0);
  }, [pathname]);
  return null;
};

// 初始重定向组件 - 仅在首次进入时根据角色分流
const InitialRedirect = () => {
  const token = getToken();
  if (!token) return <Navigate to="/login" replace />;
  
  const userInfoStr = localStorage.getItem('user_info');
  const userInfo = userInfoStr ? JSON.parse(userInfoStr) : null;
  const userRole = userInfo?.userRole || userInfo?.role;
  
  if (userRole?.toLowerCase() === 'admin') {
    return <Navigate to="/admin" replace />;
  }
  return <Navigate to="/" replace />;
};

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <ThemeProvider>
      <BrowserRouter>
        <ScrollToTop />
        <Routes>
          {/* 公开路由 */}
          <Route path="/login" element={<LoginPage />} />
          <Route path="/register" element={<RegisterPage />} />
          
          {/* 初始进入重定向 */}
          <Route path="/entry" element={<InitialRedirect />} />
          
          {/* 工作流编辑器 - 全屏画布，不套 AdminLayout */}
          <Route
            path="/admin/workflows/:id/edit"
            element={
              <ProtectedRoute requireAdmin>
                <WorkflowEditorPage />
              </ProtectedRoute>
            }
          />
          
          {/* PPT在线编辑器 - 全屏，不套 AdminLayout */}
          <Route
            path="/admin/ppt-editor"
            element={
              <ProtectedRoute requireAdmin>
                <PptEditorPage />
              </ProtectedRoute>
            }
          />
          
          {/* 管理员路由 */}
          <Route 
            path="/admin/*" 
            element={
              <ProtectedRoute requireAdmin>
                <AdminLayout>
                  <Routes>
                    <Route index element={<div className="text-2xl font-bold">欢迎进入管理后台</div>} />
                    <Route path="users" element={<UserManagementPage />} />
                    <Route path="courses" element={<CourseManagementPage />} />
                    <Route path="teachers" element={<TeacherManagementPage />} />
                    <Route path="classes" element={<ClassManagementPage />} />
                    <Route path="groups" element={<GroupManagementPage />} />
                    <Route path="scraper/config" element={<ScraperConfigPage />} />
                    <Route path="scraper/tasks" element={<ScraperTaskPage />} />
                    <Route path="daily-words" element={<DailyWordManagementPage />} />
                    <Route path="daily-articles" element={<DailyArticleManagementPage />} />
                    <Route path="announcements" element={<AnnouncementManagementPage />} />
                    <Route path="banners" element={<BannerManagementPage />} />
                    <Route path="feedbacks" element={<FeedbackManagementPage />} />
                    <Route path="posts" element={<PostManagementPage />} />
                    <Route path="ai-assistants" element={<AiAssistantManagementPage />} />
                    <Route path="knowledge-bases" element={<KnowledgeBaseManagementPage />} />
                    <Route path="workflows" element={<WorkflowManagementPage />} />
                    <Route path="mcp-servers" element={<McpServerManagementPage />} />
                    <Route path="ppt-templates" element={<PptTemplateManagementPage />} />
                    <Route path="ppt-generator" element={<PptGeneratorPage />} />
                    <Route path="questions" element={<QuestionManagementPage />} />
                    <Route path="exam-papers" element={<ExamPaperManagementPage />} />
                    <Route path="exam-templates" element={<ExamTemplateManagementPage />} />
                    <Route path="settings" element={<div className="p-8 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm"><h2 className="text-2xl font-bold">系统设置 (开发中...)</h2></div>} />
                  </Routes>
                </AdminLayout>
              </ProtectedRoute>
            } 
          />
          
          {/* 普通用户路由 - 管理员也可访问（主页为/） */}
          <Route 
            path="/*" 
            element={
              <ProtectedRoute>
                <App />
              </ProtectedRoute>
            } 
          />
        </Routes>
      </BrowserRouter>
    </ThemeProvider>
  </StrictMode>,
)
