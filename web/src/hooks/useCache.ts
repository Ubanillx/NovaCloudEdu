import { useState, useEffect, useCallback } from 'react';

interface CacheEntry<T> {
  data: T;
  timestamp: number;
  expiry: number;
}

const CACHE_PREFIX = 'nova_cache_';

/**
 * 从 localStorage 获取缓存数据
 */
function getCacheItem<T>(key: string): T | null {
  try {
    const raw = localStorage.getItem(CACHE_PREFIX + key);
    if (!raw) return null;
    const entry: CacheEntry<T> = JSON.parse(raw);
    if (Date.now() > entry.timestamp + entry.expiry) {
      localStorage.removeItem(CACHE_PREFIX + key);
      return null;
    }
    return entry.data;
  } catch {
    return null;
  }
}

/**
 * 写入缓存
 * @param key 缓存 key
 * @param data 数据
 * @param expiryMs 过期时间（毫秒），默认 30 分钟
 */
function setCacheItem<T>(key: string, data: T, expiryMs: number = 30 * 60 * 1000): void {
  try {
    const entry: CacheEntry<T> = {
      data,
      timestamp: Date.now(),
      expiry: expiryMs,
    };
    localStorage.setItem(CACHE_PREFIX + key, JSON.stringify(entry));
  } catch {
    // localStorage 满或不可用，静默处理
  }
}

/**
 * 清除指定前缀的缓存
 */
export function clearCacheByPrefix(prefix: string): void {
  const fullPrefix = CACHE_PREFIX + prefix;
  const keysToRemove: string[] = [];
  for (let i = 0; i < localStorage.length; i++) {
    const key = localStorage.key(i);
    if (key?.startsWith(fullPrefix)) {
      keysToRemove.push(key);
    }
  }
  keysToRemove.forEach((k) => localStorage.removeItem(k));
}

interface UseCacheOptions<T> {
  /** 缓存 key */
  cacheKey: string;
  /** 数据获取函数 */
  fetcher: () => Promise<T>;
  /** 缓存过期时间（毫秒），默认 30 分钟 */
  expiryMs?: number;
  /** 是否启用缓存，默认 true */
  enabled?: boolean;
}

interface UseCacheReturn<T> {
  data: T | null;
  loading: boolean;
  error: string | null;
  refresh: () => Promise<void>;
  fromCache: boolean;
}

/**
 * 带本地缓存的数据获取 Hook
 * - 优先从 localStorage 读取缓存
 * - 缓存未命中或已过期时请求 API
 * - 请求成功后自动更新缓存
 */
export function useCache<T>({
  cacheKey,
  fetcher,
  expiryMs = 30 * 60 * 1000,
  enabled = true,
}: UseCacheOptions<T>): UseCacheReturn<T> {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [fromCache, setFromCache] = useState(false);

  const fetchData = useCallback(
    async (skipCache = false) => {
      if (!enabled) {
        setLoading(false);
        return;
      }

      // 尝试读取缓存
      if (!skipCache) {
        const cached = getCacheItem<T>(cacheKey);
        if (cached !== null) {
          setData(cached);
          setFromCache(true);
          setLoading(false);
          setError(null);
          return;
        }
      }

      setLoading(true);
      setFromCache(false);
      setError(null);

      try {
        const result = await fetcher();
        setData(result);
        setCacheItem(cacheKey, result, expiryMs);
      } catch {
        setError('数据加载失败');
      } finally {
        setLoading(false);
      }
    },
    [cacheKey, fetcher, expiryMs, enabled],
  );

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const refresh = useCallback(async () => {
    await fetchData(true);
  }, [fetchData]);

  return { data, loading, error, refresh, fromCache };
}
