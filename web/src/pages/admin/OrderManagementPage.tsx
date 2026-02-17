import React, { useState, useEffect, useCallback } from 'react';
import {
  ShoppingCart, ChevronLeft, ChevronRight, RefreshCw,
  Loader2, CheckCircle, XCircle, Clock, RotateCcw,
  DollarSign, CreditCard, Search, Calendar,
  User, Crown, BookOpen,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { OrderResponse } from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

const STATUS_MAP: Record<number, string> = { 0: '未支付', 1: '已支付', 2: '已过期', 3: '已退款/已取消' };
const ORDER_TYPE_MAP: Record<string, { label: string; color: string }> = {
  COURSE: { label: '课程', color: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400' },
  MEMBERSHIP: { label: '会员', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400' },
};
const STATUS_COLORS: Record<number, string> = {
  0: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400 border-yellow-200 dark:border-yellow-800',
  1: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800',
  2: 'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700',
  3: 'bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800',
};
const PAYMENT_METHOD_MAP: Record<number, string> = { 0: '手动确认', 1: '支付宝', 2: '微信支付', 3: '银联支付' };

const formatDateTime = (s?: string) => {
  if (!s) return '—';
  const d = new Date(s);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')} ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`;
};

export const OrderManagementPage: React.FC = () => {
  const [orders, setOrders] = useState<OrderResponse[]>([]);
  const [stats, setStats] = useState<{ unpaidCount: number; paidCount: number; expiredCount: number; refundedCount: number }>({ unpaidCount: 0, paidCount: 0, expiredCount: 0, refundedCount: 0 });
  const [loading, setLoading] = useState(true);
  const [statusFilter, setStatusFilter] = useState<number | null>(null);
  const [page, setPage] = useState(1);
  const [actionLoading, setActionLoading] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState('');

  const fetchOrders = useCallback(async () => {
    setLoading(true);
    try {
      // 如果有搜索词，尝试匹配订单号或用户ID
      const params: any = { status: statusFilter ?? undefined, page, size: 15 };
      const res = await api.listOrders(params);
      if (res.data.code === 0) {
        let data = res.data.data || [];
        if (searchQuery.trim()) {
          const q = searchQuery.toLowerCase();
          data = data.filter(o => 
            (o.orderNo?.toLowerCase().includes(q)) || 
            (String(o.userId).includes(q))
          );
        }
        setOrders(data);
      }
    } catch { /* silent */ }
    finally { setLoading(false); }
  }, [statusFilter, page, searchQuery]);

  const fetchStats = useCallback(async () => {
    try {
      const res = await api.getStatistics();
      if (res.data.code === 0 && res.data.data) {
        const d = res.data.data as any;
        setStats({
          unpaidCount: d.unpaidCount ?? 0,
          paidCount: d.paidCount ?? 0,
          expiredCount: d.expiredCount ?? 0,
          refundedCount: d.refundedCount ?? 0,
        });
      }
    } catch { /* silent */ }
  }, []);

  useEffect(() => { fetchOrders(); fetchStats(); }, [fetchOrders, fetchStats]);

  const handleConfirmPayment = async (orderNo: string, orderType?: string) => {
    setActionLoading(orderNo);
    try {
      let res;
      if (orderType === 'MEMBERSHIP') {
        res = await api.confirmPayment1({ orderNo });
      } else {
        res = await api.confirmPayment({ confirmPaymentRequest: { orderNo, paymentMethod: 0 } });
      }
      if (res.data.code === 0) { toast.success('确认收款成功'); fetchOrders(); fetchStats(); }
      else toast.error(res.data.message || '操作失败');
    } catch (e: any) { toast.error(e?.response?.data?.message || '操作失败'); }
    finally { setActionLoading(null); }
  };

  const handleRefund = async (orderNo: string) => {
    if (!confirm('确认退款？此操作不可撤销。')) return;
    setActionLoading(orderNo);
    try {
      const res = await api.refund({ orderNo });
      if (res.data.code === 0) { toast.success('退款成功'); fetchOrders(); fetchStats(); }
      else toast.error(res.data.message || '操作失败');
    } catch (e: any) { toast.error(e?.response?.data?.message || '操作失败'); }
    finally { setActionLoading(null); }
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white flex items-center gap-3">
            <ShoppingCart size={28} className="text-brand-500" /> 订单管理
          </h1>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">管理课程购买订单、会员订单、确认收款与退款</p>
        </div>
        <button 
          onClick={() => { fetchOrders(); fetchStats(); }} 
          className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
        >
          <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
        </button>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        {[
          { label: '待支付', count: stats.unpaidCount, icon: Clock, color: 'text-yellow-500', bg: 'bg-yellow-50 dark:bg-yellow-900/10' },
          { label: '已支付', count: stats.paidCount, icon: CheckCircle, color: 'text-green-500', bg: 'bg-green-50 dark:bg-green-900/10' },
          { label: '已过期', count: stats.expiredCount, icon: XCircle, color: 'text-gray-400', bg: 'bg-gray-50 dark:bg-gray-800/50' },
          { label: '已退款', count: stats.refundedCount, icon: RotateCcw, color: 'text-red-500', bg: 'bg-red-50 dark:bg-red-900/10' },
        ].map(({ label, count, icon: Icon, color, bg }) => (
          <div key={label} className={`${bg} rounded-2xl border border-gray-100 dark:border-gray-800 p-5 shadow-sm transition-all hover:shadow-md`}>
            <div className="flex items-center justify-between">
              <div className={`p-2 rounded-xl bg-white dark:bg-gray-900 shadow-sm ${color}`}>
                <Icon size={22} />
              </div>
              <span className="text-2xl font-black text-gray-900 dark:text-white">{count}</span>
            </div>
            <div className="text-xs text-gray-500 dark:text-gray-400 mt-3 font-bold uppercase tracking-wider">{label}</div>
          </div>
        ))}
      </div>

      {/* Filters & Search */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <div className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input 
              type="text" 
              placeholder="搜索订单号、用户 ID..." 
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-2">
            <button
              onClick={() => { setStatusFilter(null); setPage(1); }}
              className={`px-4 py-2 text-sm font-bold rounded-xl transition-all ${statusFilter === null ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-700 border border-transparent'}`}
            >
              全部
            </button>
            {[
              { label: '待支付', value: 0 },
              { label: '已支付', value: 1 },
              { label: '已过期', value: 2 },
              { label: '已退款', value: 3 },
            ].map(({ label, value }) => (
              <button
                key={value}
                onClick={() => { setStatusFilter(value); setPage(1); }}
                className={`px-4 py-2 text-sm font-bold rounded-xl transition-all ${statusFilter === value ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' : 'bg-gray-50 dark:bg-gray-800 text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-700 border border-transparent'}`}
              >
                {label}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                {['订单信息', '金额/方式', '状态', '时间轨迹', '操作'].map(h => (
                  <th key={h} className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">{h}</th>
                ))}
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={5} className="px-6 py-6 h-24">
                      <div className="flex gap-4">
                        <div className="w-12 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : orders.length === 0 ? (
                <tr>
                  <td colSpan={5} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <ShoppingCart size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">未找到相关订单</p>
                    </div>
                  </td>
                </tr>
              ) : orders.map(o => (
                <tr key={String(o.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-4">
                      <div className={`w-12 h-12 rounded-xl bg-gradient-to-br p-0.5 border flex items-center justify-center ${
                        (o as any).orderType === 'MEMBERSHIP'
                          ? 'from-amber-50 to-amber-100 dark:from-amber-900/20 dark:to-amber-900/10 border-amber-200 dark:border-amber-800'
                          : 'from-gray-50 to-gray-100 dark:from-gray-800 dark:to-gray-800 border-gray-100 dark:border-gray-700'
                      }`}>
                        {(o as any).orderType === 'MEMBERSHIP'
                          ? <Crown size={20} className="text-amber-500" />
                          : <BookOpen size={20} className="text-gray-400" />}
                      </div>
                      <div>
                        <div className="flex items-center gap-2">
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                            {o.orderNo || '—'}
                          </p>
                          {(o as any).orderType && ORDER_TYPE_MAP[(o as any).orderType] && (
                            <span className={`px-1.5 py-0.5 rounded text-[10px] font-bold ${ORDER_TYPE_MAP[(o as any).orderType].color}`}>
                              {ORDER_TYPE_MAP[(o as any).orderType].label}
                            </span>
                          )}
                        </div>
                        <div className="flex items-center gap-2 mt-0.5">
                          <User size={12} className="text-gray-400" />
                          <span className="text-xs text-gray-500 font-mono">{String(o.userId ?? '—')}</span>
                          {(o as any).productName ? (
                            <><span className="text-gray-300">|</span><span className="text-xs text-gray-500">{(o as any).productName}</span></>
                          ) : o.courseId ? (
                            <><span className="text-gray-300">|</span><span className="text-xs text-gray-500">课程 ID: {String(o.courseId)}</span></>
                          ) : null}
                        </div>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <div className="space-y-1">
                      <div className="flex items-center gap-1 text-sm font-bold text-gray-900 dark:text-white">
                        <DollarSign size={14} className="text-brand-500" />
                        <span>{o.price ?? 0}</span>
                      </div>
                      <div className="flex items-center gap-1.5 text-xs text-gray-500">
                        <CreditCard size={12} />
                        <span>{o.paymentMethod !== undefined ? PAYMENT_METHOD_MAP[o.paymentMethod] || o.paymentMethodDesc || '—' : '—'}</span>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${STATUS_COLORS[o.status ?? 0]}`}>
                      {STATUS_MAP[o.status ?? 0]}
                    </span>
                  </td>
                  <td className="px-6 py-4">
                    <div className="space-y-1 text-xs text-gray-500">
                      <div className="flex items-center gap-2">
                        <Calendar size={12} />
                        <span>创建: {formatDateTime(o.createTime)}</span>
                      </div>
                      {o.paymentTime && (
                        <div className="flex items-center gap-2 text-green-600 dark:text-green-400">
                          <CheckCircle size={12} />
                          <span>支付: {formatDateTime(o.paymentTime)}</span>
                        </div>
                      )}
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                      {o.status === 0 && o.orderNo && (
                        <button
                          onClick={() => handleConfirmPayment(o.orderNo!, (o as any).orderType)}
                          disabled={actionLoading === o.orderNo}
                          className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-bold text-green-700 bg-green-50 dark:bg-green-900/20 dark:text-green-400 border border-green-100 dark:border-green-800 rounded-lg hover:bg-green-100 transition-all"
                        >
                          {actionLoading === o.orderNo ? <Loader2 size={14} className="animate-spin" /> : <CreditCard size={14} />}
                          确认支付
                        </button>
                      )}
                      {o.status === 1 && o.orderNo && (
                        <button
                          onClick={() => handleRefund(o.orderNo!)}
                          disabled={actionLoading === o.orderNo}
                          className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-bold text-red-700 bg-red-50 dark:bg-red-900/20 dark:text-red-400 border border-red-100 dark:border-red-800 rounded-lg hover:bg-red-100 transition-all"
                        >
                          {actionLoading === o.orderNo ? <Loader2 size={14} className="animate-spin" /> : <RotateCcw size={14} />}
                          退款
                        </button>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
          <p className="text-sm text-gray-500 dark:text-gray-400 font-medium">
            显示第 <span className="text-gray-900 dark:text-white font-bold">{orders.length}</span> 条结果 · 第 <span className="text-gray-900 dark:text-white font-bold">{page}</span> 页
          </p>
          <div className="flex items-center gap-2">
            <button 
              onClick={() => setPage(Math.max(1, page - 1))} 
              disabled={page <= 1} 
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all shadow-sm"
            >
              <ChevronLeft size={18} />
            </button>
            <button 
              onClick={() => setPage(page + 1)} 
              disabled={orders.length < 15} 
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all shadow-sm"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default OrderManagementPage;
