import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import './index.css'
import App from './App.tsx'
import { ThemeProvider } from './context/ThemeContext.tsx'
import { LoginPage, RegisterPage } from './pages'
import { ProtectedRoute } from './components/ProtectedRoute'
import { AdminLayout } from './components/layout/AdminLayout'
import { UserManagementPage } from './pages/admin/UserManagementPage'
import { getToken } from './api'

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
  return <Navigate to="/home" replace />;
};

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <ThemeProvider>
      <BrowserRouter>
        <Routes>
          {/* 公开路由 */}
          <Route path="/login" element={<LoginPage />} />
          <Route path="/register" element={<RegisterPage />} />
          
          {/* 初始进入重定向 */}
          <Route path="/" element={<InitialRedirect />} />
          <Route path="/entry" element={<InitialRedirect />} />
          
          {/* 管理员路由 */}
          <Route 
            path="/admin/*" 
            element={
              <ProtectedRoute requireAdmin>
                <AdminLayout>
                  <Routes>
                    <Route index element={<div className="text-2xl font-bold">欢迎进入管理后台</div>} />
                    <Route path="users" element={<UserManagementPage />} />
                    <Route path="courses" element={<div className="p-8 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm"><h2 className="text-2xl font-bold">课程管理 (开发中...)</h2></div>} />
                    <Route path="settings" element={<div className="p-8 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm"><h2 className="text-2xl font-bold">系统设置 (开发中...)</h2></div>} />
                  </Routes>
                </AdminLayout>
              </ProtectedRoute>
            } 
          />
          
          {/* 普通用户路由 - 管理员也可访问 */}
          <Route 
            path="/home/*" 
            element={
              <ProtectedRoute>
                <App />
              </ProtectedRoute>
            } 
          />
          
          {/* 兜底重定向到初始分流 */}
          <Route path="/*" element={<Navigate to="/entry" replace />} />
        </Routes>
      </BrowserRouter>
    </ThemeProvider>
  </StrictMode>,
)
