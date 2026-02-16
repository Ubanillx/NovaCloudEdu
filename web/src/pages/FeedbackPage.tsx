import React, { useMemo, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, Send, MessageSquare, Upload, X, FileText, Loader2 } from 'lucide-react';
import { apiClient, Configuration, DefaultApi } from '../api';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const FEEDBACK_TYPES = [
  { value: 'suggestion', label: '功能建议' },
  { value: 'bug', label: 'Bug 反馈' },
  { value: 'question', label: '问题咨询' },
  { value: 'complaint', label: '投诉建议' },
  { value: 'other', label: '其他' },
] as const;

type FeedbackType = (typeof FEEDBACK_TYPES)[number]['value'];

interface FeedbackFormState {
  feedbackType: FeedbackType;
  title: string;
  content: string;
  attachment: string;
}

const FeedbackPage: React.FC = () => {
  const navigate = useNavigate();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [submitting, setSubmitting] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [form, setForm] = useState<FeedbackFormState>({
    feedbackType: FEEDBACK_TYPES[0].value,
    title: '',
    content: '',
    attachment: '',
  });

  const contentCount = useMemo(() => form.content.trim().length, [form.content]);

  // 处理文件选择
  const handleFileSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // 验证文件类型
    const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
    if (!allowedTypes.includes(file.type) && !file.name.match(/\.(jpg|jpeg|png|gif|pdf|doc|docx)$/i)) {
      toast.warning('请上传图片、PDF 或 Word 文档');
      return;
    }

    // 验证文件大小 (10MB)
    if (file.size > 10 * 1024 * 1024) {
      toast.warning('文件大小不能超过 10MB');
      return;
    }

    setUploading(true);
    try {
      const fd = new FormData();
      fd.append('file', file);
      const res = await apiClient.post('/api/file/upload/feedback/attachment', fd, {
        headers: { 'Content-Type': 'multipart/form-data' },
      });
      if (res.data?.code === 0 && res.data.data?.fileUrl) {
        setForm((prev) => ({ ...prev, attachment: res.data.data.fileUrl }));
        toast.success('文件上传成功');
      } else {
        toast.error(res.data?.message || '上传失败');
      }
    } catch {
      toast.error('上传失败，请稍后重试');
    } finally {
      setUploading(false);
      if (fileInputRef.current) fileInputRef.current.value = '';
    }
  };

  // 清除已上传文件
  const handleClearFile = () => {
    setForm((prev) => ({ ...prev, attachment: '' }));
    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (submitting) return;

    if (!form.content.trim()) {
      toast.warning('请填写反馈内容');
      return;
    }

    setSubmitting(true);
    try {
      const res = await api.createFeedback({
        createFeedbackRequest: {
          feedbackType: form.feedbackType,
          title: form.title.trim() || undefined,
          content: form.content.trim(),
          attachment: form.attachment.trim() || undefined,
        },
      });

      if (res.data.code === 0) {
        toast.success('反馈提交成功，感谢你的建议！');
        setForm({
          feedbackType: FEEDBACK_TYPES[0].value,
          title: '',
          content: '',
          attachment: '',
        });
      } else {
        toast.error(res.data.message || '反馈提交失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '反馈提交失败，请稍后重试');
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 py-6 sm:py-8">
      <button
        type="button"
        onClick={() => navigate(-1)}
        className="mb-4 inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand-600 dark:text-gray-400 dark:hover:text-brand-400 transition-colors"
      >
        <ArrowLeft className="w-4 h-4" /> 返回
      </button>

      <div className="rounded-2xl border border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-900 shadow-sm overflow-hidden">
        <div className="px-6 py-5 border-b border-gray-100 dark:border-gray-800 bg-gray-50 dark:bg-gray-800/50">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-brand-100 dark:bg-brand-900/50 flex items-center justify-center">
              <MessageSquare className="w-5 h-5 text-brand-600 dark:text-brand-400" />
            </div>
            <div>
              <h1 className="text-xl font-bold text-gray-900 dark:text-white">联系我们</h1>
              <p className="text-sm text-gray-500 dark:text-gray-400">提交你的建议、问题或 Bug，我们会尽快处理。</p>
            </div>
          </div>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-5">
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <label className="block">
              <span className="block text-sm mb-2 text-gray-700 dark:text-gray-300">反馈类型</span>
              <select
                value={form.feedbackType}
                onChange={(e) => setForm((prev) => ({ ...prev, feedbackType: e.target.value as FeedbackType }))}
                className="w-full h-11 rounded-lg border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 text-sm text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500"
              >
                {FEEDBACK_TYPES.map((item) => (
                  <option key={item.value} value={item.value}>
                    {item.label}
                  </option>
                ))}
              </select>
            </label>

            <label className="block">
              <span className="block text-sm mb-2 text-gray-700 dark:text-gray-300">标题（可选）</span>
              <input
                value={form.title}
                onChange={(e) => setForm((prev) => ({ ...prev, title: e.target.value }))}
                maxLength={80}
                placeholder="一句话概括问题"
                className="w-full h-11 rounded-lg border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 text-sm text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500"
              />
            </label>
          </div>

          <label className="block">
            <span className="block text-sm mb-2 text-gray-700 dark:text-gray-300">反馈内容</span>
            <textarea
              value={form.content}
              onChange={(e) => setForm((prev) => ({ ...prev, content: e.target.value }))}
              rows={8}
              maxLength={2000}
              placeholder="请详细描述你遇到的问题或建议..."
              className="w-full rounded-lg border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-2.5 text-sm text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 resize-y"
            />
            <div className="mt-1 text-xs text-right text-gray-400 dark:text-gray-500">{contentCount}/2000</div>
          </label>

          {/* 附件上传 */}
          <div className="block">
            <span className="block text-sm mb-2 text-gray-700 dark:text-gray-300">附件（可选）</span>
            <input
              ref={fileInputRef}
              type="file"
              accept=".jpg,.jpeg,.png,.gif,.pdf,.doc,.docx"
              onChange={handleFileSelect}
              className="hidden"
            />
            {form.attachment ? (
              <div className="flex items-center gap-3 p-3 rounded-lg border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800">
                <FileText className="w-5 h-5 text-brand-600 dark:text-brand-400" />
                <span className="flex-1 text-sm text-gray-700 dark:text-gray-300 truncate">{form.attachment.split('/').pop()}</span>
                <button
                  type="button"
                  onClick={handleClearFile}
                  className="p-1.5 rounded-md text-gray-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors"
                >
                  <X className="w-4 h-4" />
                </button>
              </div>
            ) : (
              <button
                type="button"
                onClick={() => fileInputRef.current?.click()}
                disabled={uploading}
                className="w-full h-24 rounded-lg border-2 border-dashed border-gray-300 dark:border-gray-600 hover:border-brand-400 dark:hover:border-brand-500 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors flex flex-col items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {uploading ? (
                  <>
                    <Loader2 className="w-6 h-6 text-brand-600 dark:text-brand-400 animate-spin" />
                    <span className="text-sm text-gray-500 dark:text-gray-400">上传中...</span>
                  </>
                ) : (
                  <>
                    <Upload className="w-6 h-6 text-gray-400 dark:text-gray-500" />
                    <span className="text-sm text-gray-500 dark:text-gray-400">点击上传图片、PDF 或 Word 文档（最大 10MB）</span>
                  </>
                )}
              </button>
            )}
          </div>

          <div className="pt-1 flex items-center justify-end">
            <button
              type="submit"
              disabled={submitting}
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 h-11 px-5 rounded-lg bg-brand-600 hover:bg-brand-700 disabled:bg-brand-400 disabled:cursor-not-allowed text-white text-sm font-medium transition-colors"
            >
              <Send className="w-4 h-4" />
              {submitting ? '提交中...' : '提交反馈'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default FeedbackPage;
