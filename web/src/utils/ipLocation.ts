import { apiClient, Configuration, IPApi } from '../api';

const ipApi = new IPApi(new Configuration(), '', apiClient);

export const IP_REGION_STORAGE_KEY = 'circle_ip_region_cache';

export const isPrivateIp = (ip: string) => {
  if (/^(127\.|10\.|192\.168\.)/.test(ip)) return true;

  const match172 = /^172\.(\d{1,3})\./.exec(ip);
  if (match172) {
    const second = Number(match172[1]);
    return second >= 16 && second <= 31;
  }

  return /^(fc|fd)[0-9a-f]{2}:/i.test(ip) || /^fe80:/i.test(ip);
};

export const getLocalIpRegionText = (ipAddress?: string) => {
  const ip = ipAddress?.trim();
  if (!ip) return '';
  if (ip === '::1' || ip === '0:0:0:0:0:0:0:1' || ip === '127.0.0.1' || ip === 'localhost') {
    return '本机';
  }
  if (isPrivateIp(ip)) return '内网';
  return '';
};

export const loadStoredIpRegionCache = () => {
  if (typeof sessionStorage === 'undefined') return {};
  try {
    return JSON.parse(sessionStorage.getItem(IP_REGION_STORAGE_KEY) || '{}') as Record<string, string>;
  } catch {
    return {};
  }
};

export const saveStoredIpRegionCache = (cache: Record<string, string>) => {
  if (typeof sessionStorage === 'undefined') return;
  sessionStorage.setItem(IP_REGION_STORAGE_KEY, JSON.stringify(cache));
};

export const lookupIpRegions = async (ips: string[]) => {
  const uniqueIps = Array.from(new Set(ips.map(ip => ip.trim()).filter(Boolean)));
  if (uniqueIps.length === 0) return {};

  const response = await ipApi.lookupBatch({ batchIpLocationRequest: { ips: uniqueIps } });
  const data = response.data?.data || {};
  return uniqueIps.reduce<Record<string, string>>((result, ip) => {
    result[ip] = data[ip]?.display || '未知地区';
    return result;
  }, {});
};
