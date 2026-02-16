import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { getToken } from '../api';

interface ProtectedRouteProps {
  children: React.ReactNode;
  requireAdmin?: boolean;
}

export const ProtectedRoute: React.FC<ProtectedRouteProps> = ({ 
  children, 
  requireAdmin = false 
}) => {
  const location = useLocation();
  const token = getToken();
  
  // 从 localStorage 获取用户信息
  const userInfoStr = localStorage.getItem('user_info');
  const userInfo = userInfoStr ? JSON.parse(userInfoStr) : null;
  const userRole = userInfo?.userRole || userInfo?.role;

  if (!token) {
    // 未登录，重定向到登录页
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  if (requireAdmin) {
    const role = userRole?.toLowerCase();
    if (role !== 'admin' && role !== 'teacher') {
      // 需要管理权限但用户既不是管理员也不是教师，重定向到首页
      return <Navigate to="/" replace />;
    }
  }

  return <>{children}</>;
};
