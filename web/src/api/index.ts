/**
 * API 客户端入口文件
 * 从 OpenAPI Generator 生成的代码中导出 API 和模型
 * 包含认证和 Token 自动刷新功能
 */

import axios from 'axios';
import type { AxiosError, AxiosRequestConfig, InternalAxiosRequestConfig } from 'axios';
import JSONBig from 'json-bigint';

// 配置 json-bigint：将大整数转为字符串，避免精度丢失
const JSONBigString = JSONBig({ storeAsString: true });

// Token 存储 key
const TOKEN_KEY = 'auth_token';
const REFRESH_TOKEN_KEY = 'refresh_token';

// Token 刷新状态
let isRefreshing = false;
// 等待刷新完成的请求队列
let pendingRequests: Array<{
  resolve: (token: string) => void;
  reject: (error: unknown) => void;
}> = [];

// 登出回调
let onLogoutCallback: (() => void | Promise<void>) | null = null;

/**
 * 设置登出回调
 * 当 Token 刷新失败时会调用此回调
 */
export function setOnLogout(callback: () => void | Promise<void>) {
  onLogoutCallback = callback;
}

/**
 * 获取存储的 Token
 */
export function getToken(): string | null {
  return localStorage.getItem(TOKEN_KEY);
}

/**
 * 获取存储的 Refresh Token
 */
export function getRefreshToken(): string | null {
  return localStorage.getItem(REFRESH_TOKEN_KEY);
}

/**
 * 保存 Token 到本地存储
 */
export function saveTokens(token: string, refreshToken: string) {
  localStorage.setItem(TOKEN_KEY, token);
  localStorage.setItem(REFRESH_TOKEN_KEY, refreshToken);
}

/**
 * 清除所有 Token
 */
export function clearTokens() {
  localStorage.removeItem(TOKEN_KEY);
  localStorage.removeItem(REFRESH_TOKEN_KEY);
}

/**
 * 处理刷新失败
 */
async function handleRefreshFailed() {
  clearTokens();
  
  // 拒绝所有等待的请求
  pendingRequests.forEach(({ reject }) => {
    reject(new Error('Token refresh failed'));
  });
  pendingRequests = [];
  
  // 调用登出回调
  if (onLogoutCallback) {
    await onLogoutCallback();
  }
}

/**
 * 处理等待队列中的请求
 */
function processPendingRequests(newToken: string) {
  pendingRequests.forEach(({ resolve }) => {
    resolve(newToken);
  });
  pendingRequests = [];
}

/**
 * 刷新 Token
 */
async function refreshAccessToken(): Promise<string | null> {
  const refreshToken = getRefreshToken();
  
  if (!refreshToken) {
    return null;
  }
  
  try {
    // 使用独立的 axios 实例刷新 Token，避免触发拦截器
    const response = await axios.post(
      `${import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080'}/api/auth/refresh`,
      { refreshToken },
      {
        headers: {
          'Content-Type': 'application/json',
        },
        timeout: 10000,
      }
    );
    
    if (response.data?.code === 0 && response.data?.data) {
      const { token, refreshToken: newRefreshToken } = response.data.data;
      if (token && newRefreshToken) {
        saveTokens(token, newRefreshToken);
        return token;
      }
    }
    
    return null;
  } catch {
    return null;
  }
}

// 创建 axios 实例
export const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080',
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json',
  },
  // 自定义响应转换器，使用 json-bigint 解析响应，解决 Long 精度丢失问题
  transformResponse: [(data) => {
    if (typeof data === 'string') {
      try {
        return JSONBigString.parse(data);
      } catch {
        return data;
      }
    }
    return data;
  }],
});

// 请求拦截器 - 自动添加 Token
apiClient.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    const token = getToken();
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// 响应拦截器 - 处理 401 错误并自动刷新 Token
apiClient.interceptors.response.use(
  (response) => {
    return response;
  },
  async (error: AxiosError) => {
    const originalRequest = error.config as AxiosRequestConfig & { _retry?: boolean };
    
    // 只处理 401 未授权错误
    if (error.response?.status !== 401) {
      console.error('API Error:', error);
      return Promise.reject(error);
    }
    
    // 如果是刷新 Token 的请求本身失败，不再重试
    if (originalRequest.url?.includes('/api/auth/refresh')) {
      await handleRefreshFailed();
      return Promise.reject(error);
    }
    
    // 如果已经重试过，不再重试
    if (originalRequest._retry) {
      await handleRefreshFailed();
      return Promise.reject(error);
    }
    
    // 如果正在刷新，将请求加入队列等待
    if (isRefreshing) {
      return new Promise((resolve, reject) => {
        pendingRequests.push({
          resolve: (token: string) => {
            if (originalRequest.headers) {
              originalRequest.headers.Authorization = `Bearer ${token}`;
            }
            resolve(apiClient(originalRequest));
          },
          reject,
        });
      });
    }
    
    // 开始刷新 Token
    originalRequest._retry = true;
    isRefreshing = true;
    
    try {
      const newToken = await refreshAccessToken();
      
      if (newToken) {
        // 更新原始请求的 Authorization 头
        if (originalRequest.headers) {
          originalRequest.headers.Authorization = `Bearer ${newToken}`;
        }
        
        // 处理等待队列中的请求
        processPendingRequests(newToken);
        
        isRefreshing = false;
        
        // 重试原始请求
        return apiClient(originalRequest);
      }
      
      // 刷新失败
      await handleRefreshFailed();
      isRefreshing = false;
      return Promise.reject(error);
      
    } catch (refreshError) {
      await handleRefreshFailed();
      isRefreshing = false;
      return Promise.reject(refreshError);
    }
  }
);

// 导出生成的 API 和模型
export * from './generated/api';
export * from './generated/models';
export { Configuration } from './generated/configuration';
