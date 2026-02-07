import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import {
  ArrowLeft, Eye, Edit3, Tag, X, Send, Image, Bold, Italic,
  Heading1, Heading2, List, ListOrdered, Link, Code, Quote, PenSquare,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
// types used implicitly via API response
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

// Markdown 工具栏按钮配置
const TOOLBAR_ITEMS = [
  { icon: Bold, label: '粗体', prefix: '**', suffix: '**', placeholder: '粗体文本' },
  { icon: Italic, label: '斜体', prefix: '*', suffix: '*', placeholder: '斜体文本' },
  { icon: Heading1, label: '一级标题', prefix: '# ', suffix: '', placeholder: '标题' },
  { icon: Heading2, label: '二级标题', prefix: '## ', suffix: '', placeholder: '标题' },
  { icon: List, label: '无序列表', prefix: '- ', suffix: '', placeholder: '列表项' },
  { icon: ListOrdered, label: '有序列表', prefix: '1. ', suffix: '', placeholder: '列表项' },
  { icon: Quote, label: '引用', prefix: '> ', suffix: '', placeholder: '引用文本' },
  { icon: Code, label: '代码', prefix: '`', suffix: '`', placeholder: '代码' },
  { icon: Link, label: '链接', prefix: '[', suffix: '](url)', placeholder: '链接文本' },
  { icon: Image, label: '图片', prefix: '![', suffix: '](url)', placeholder: '图片描述' },
];

const PostEditPage: React.FC = () => {
  const { postId: postIdStr } = useParams<{ postId: string }>();
  const postId = postIdStr ? postIdStr as unknown as number : undefined; // 保持字符串原样，避免大整数精度丢失
  const isEdit = !!postId;
  const navigate = useNavigate();

  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [tags, setTags] = useState<string[]>([]);
  const [tagInput, setTagInput] = useState('');
  const [isPreview, setIsPreview] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [isLoadingPost, setIsLoadingPost] = useState(false);
  const contentRef = useRef<HTMLTextAreaElement>(null);

  // 编辑模式：加载已有帖子
  useEffect(() => {
    if (isEdit && postId) {
      setIsLoadingPost(true);
      api.getPostDetail({ postId })
        .then(res => {
          if (res.data?.code === 0 && res.data.data) {
            const data = res.data.data;
            setTitle(data.title || '');
            setContent(data.content || '');
            setTags(data.tags?.filter(t => t) || []);
          }
        })
        .catch(() => toast.error('加载帖子失败'))
        .finally(() => setIsLoadingPost(false));
    }
  }, [isEdit, postId]);

  const addTag = useCallback(() => {
    const tag = tagInput.trim();
    if (!tag) return;
    if (tags.includes(tag)) {
      toast.warning('标签已存在');
      return;
    }
    if (tags.length >= 5) {
      toast.warning('最多添加5个标签');
      return;
    }
    setTags(prev => [...prev, tag]);
    setTagInput('');
  }, [tagInput, tags]);

  const removeTag = (tag: string) => {
    setTags(prev => prev.filter(t => t !== tag));
  };

  const insertMarkdown = useCallback((prefix: string, suffix: string, placeholder: string) => {
    const textarea = contentRef.current;
    if (!textarea) return;

    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const selectedText = content.substring(start, end);
    const insertText = selectedText || placeholder;
    const newContent = content.substring(0, start) + prefix + insertText + suffix + content.substring(end);

    setContent(newContent);

    // 恢复光标位置
    requestAnimationFrame(() => {
      textarea.focus();
      const newCursorPos = start + prefix.length + insertText.length;
      textarea.setSelectionRange(
        selectedText ? newCursorPos + suffix.length : start + prefix.length,
        selectedText ? newCursorPos + suffix.length : start + prefix.length + placeholder.length
      );
    });
  }, [content]);

  const handleSubmit = useCallback(async () => {
    if (!title.trim()) {
      toast.warning('请输入标题');
      return;
    }
    if (!content.trim()) {
      toast.warning('请输入内容');
      return;
    }

    setIsLoading(true);
    try {
      if (isEdit && postId) {
        const res = await api.updatePost({
          postId,
          updatePostRequest: { title: title.trim(), content: content.trim(), tags },
        });
        if (res.data?.code === 0) {
          toast.success('更新成功');
          navigate(`/circle/post/${postId}`, { replace: true });
        }
      } else {
        const res = await api.createPost({
          createPostRequest: { title: title.trim(), content: content.trim(), tags, postType: 'normal' },
        });
        if (res.data?.code === 0) {
          toast.success('发布成功');
          navigate('/circle', { replace: true });
        }
      }
    } catch {
      toast.error('操作失败');
    } finally {
      setIsLoading(false);
    }
  }, [title, content, tags, isEdit, postId, navigate]);

  // 简单的 Markdown 预览渲染
  const renderMarkdownPreview = (md: string) => {
    let html = md
      .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
      .replace(/^### (.+)$/gm, '<h3 class="text-lg font-bold mt-4 mb-2">$1</h3>')
      .replace(/^## (.+)$/gm, '<h2 class="text-xl font-bold mt-5 mb-2">$1</h2>')
      .replace(/^# (.+)$/gm, '<h1 class="text-2xl font-bold mt-6 mb-3">$1</h1>')
      .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
      .replace(/\*(.+?)\*/g, '<em>$1</em>')
      .replace(/`(.+?)`/g, '<code class="px-1.5 py-0.5 bg-gray-100 dark:bg-gray-800 rounded text-sm font-mono text-brand-600 dark:text-brand-400">$1</code>')
      .replace(/^> (.+)$/gm, '<blockquote class="border-l-4 border-brand-300 dark:border-brand-600 pl-4 py-1 my-2 text-gray-600 dark:text-gray-400 italic">$1</blockquote>')
      .replace(/^- (.+)$/gm, '<li class="ml-4 list-disc">$1</li>')
      .replace(/^\d+\. (.+)$/gm, '<li class="ml-4 list-decimal">$1</li>')
      .replace(/!\[(.+?)\]\((.+?)\)/g, '<img src="$2" alt="$1" class="rounded-lg max-w-full my-2" />')
      .replace(/\[(.+?)\]\((.+?)\)/g, '<a href="$2" class="text-brand-600 dark:text-brand-400 underline" target="_blank">$1</a>')
      .replace(/\n/g, '<br/>');
    return html;
  };

  if (isLoadingPost) {
    return (
      <div className="max-w-5xl mx-auto animate-in fade-in duration-500 px-4 sm:px-0">
        <div className="bg-white dark:bg-gray-900 rounded-3xl border border-gray-100 dark:border-gray-800 p-8 animate-pulse">
          <div className="h-10 bg-gray-200 dark:bg-gray-700 rounded-xl w-1/2 mb-8" />
          <div className="h-80 bg-gray-50 dark:bg-gray-800 rounded-2xl" />
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-5xl mx-auto animate-in fade-in duration-500 pb-12 px-4 sm:px-0">
      {/* 返回按钮 */}
      <button
        onClick={() => navigate(-1)}
        className="flex items-center gap-2 text-sm font-bold text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 mb-8 transition-all group"
      >
        <div className="p-2 rounded-xl bg-white dark:bg-gray-900 border border-gray-100 dark:border-gray-800 group-hover:border-brand-100 shadow-sm transition-all">
          <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
        </div>
        返回上一页
      </button>

      {/* 编辑器卡片 */}
      <div className="bg-white dark:bg-gray-900 rounded-[2rem] border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
        {/* 头部 */}
        <div className="px-8 py-6 border-b border-gray-50 dark:border-gray-800/50 flex items-center justify-between bg-gray-50/30 dark:bg-gray-800/10">
          <h1 className="text-xl font-black text-gray-900 dark:text-white flex items-center gap-3">
            <div className="w-8 h-8 rounded-lg bg-brand-600 flex items-center justify-center shadow-lg shadow-brand-600/20">
              <PenSquare size={18} className="text-white" />
            </div>
            {isEdit ? '编辑帖子' : '发布新动态'}
          </h1>
          <div className="flex items-center gap-3">
            <button
              onClick={() => setIsPreview(!isPreview)}
              className={`flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-bold transition-all active:scale-95 ${
                isPreview
                  ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 border border-brand-100 dark:border-brand-800'
                  : 'bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-gray-50'
              }`}
            >
              {isPreview ? <Edit3 size={16} /> : <Eye size={16} />}
              {isPreview ? '返回编辑' : '效果预览'}
            </button>
            <button
              onClick={handleSubmit}
              disabled={isLoading}
              className="flex items-center gap-2 px-8 py-2 bg-brand-600 hover:bg-brand-500 disabled:bg-gray-200 dark:disabled:bg-gray-800 text-white text-sm font-bold rounded-xl transition-all shadow-md shadow-brand-600/20 active:scale-95"
            >
              <Send size={16} />
              {isLoading ? '正在提交...' : isEdit ? '保存修改' : '立即发布'}
            </button>
          </div>
        </div>

        {/* 标题输入 */}
        <div className="px-8 pt-8">
          <input
            type="text"
            value={title}
            onChange={e => setTitle(e.target.value)}
            placeholder="为你的动态起一个吸引人的标题吧..."
            maxLength={100}
            className="w-full text-3xl font-black text-gray-900 dark:text-white placeholder-gray-300 dark:placeholder-gray-700 bg-transparent border-none outline-none tracking-tight"
          />
        </div>

        {/* 标签区 */}
        <div className="px-8 py-4 flex items-center gap-3 flex-wrap">
          <div className="p-1.5 rounded-lg bg-gray-50 dark:bg-gray-800 text-gray-400">
            <Tag size={16} />
          </div>
          {tags.map(tag => (
            <span
              key={tag}
              className="inline-flex items-center gap-1.5 px-3 py-1 rounded-xl text-sm font-bold bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 border border-brand-100 dark:border-brand-800/50 group"
            >
              #{tag}
              <button onClick={() => removeTag(tag)} className="hover:text-rose-500 transition-colors">
                <X size={14} strokeWidth={3} />
              </button>
            </span>
          ))}
          {tags.length < 5 && (
            <div className="flex-1 min-w-[200px]">
              <input
                type="text"
                value={tagInput}
                onChange={e => setTagInput(e.target.value)}
                onKeyDown={e => {
                  if (e.key === 'Enter') { e.preventDefault(); addTag(); }
                }}
                placeholder="添加标签 (最多5个)，回车确认"
                className="w-full text-sm bg-transparent border-none outline-none text-gray-500 dark:text-gray-400 placeholder-gray-300 dark:placeholder-gray-700 font-medium"
              />
            </div>
          )}
        </div>

        {/* 工具栏 */}
        {!isPreview && (
          <div className="px-8 py-3 border-t border-b border-gray-50 dark:border-gray-800/50 flex items-center gap-1 overflow-x-auto no-scrollbar bg-gray-50/10">
            {TOOLBAR_ITEMS.map(item => {
              const Icon = item.icon;
              return (
                <button
                  key={item.label}
                  onClick={() => insertMarkdown(item.prefix, item.suffix, item.placeholder)}
                  className="p-2.5 rounded-xl text-gray-400 dark:text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-all flex-shrink-0 active:scale-90"
                  title={item.label}
                >
                  <Icon size={18} />
                </button>
              );
            })}
          </div>
        )}

        {/* 内容编辑/预览 */}
        <div className="px-8 py-6 min-h-[500px]">
          {isPreview ? (
            <div className="min-h-[480px]">
              {content.trim() ? (
                <div
                  className="prose dark:prose-invert max-w-none text-gray-700 dark:text-gray-300 text-lg leading-[1.8] font-medium opacity-90"
                  dangerouslySetInnerHTML={{ __html: renderMarkdownPreview(content) }}
                />
              ) : (
                <div className="flex flex-col items-center justify-center py-20 text-gray-300 dark:text-gray-700">
                  <Eye size={48} className="mb-4 opacity-20" />
                  <p className="text-base font-bold">暂无内容可预览</p>
                </div>
              )}
            </div>
          ) : (
            <textarea
              ref={contentRef}
              value={content}
              onChange={e => setContent(e.target.value)}
              placeholder="分享你的学习心得、疑问或是有趣的发现...&#10;&#10;支持标准的 Markdown 语法渲染"
              className="w-full min-h-[480px] bg-transparent border-none outline-none text-lg text-gray-900 dark:text-white placeholder-gray-200 dark:placeholder-gray-800 leading-relaxed resize-none font-medium custom-scrollbar"
            />
          )}
        </div>

        {/* 底部信息 */}
        <div className="px-8 py-4 border-t border-gray-50 dark:border-gray-800/50 flex items-center justify-between bg-gray-50/20 dark:bg-gray-800/5">
          <div className="flex items-center gap-4 text-xs font-bold text-gray-400 dark:text-gray-500">
            <span className="flex items-center gap-1.5">
              <div className="w-1.5 h-1.5 rounded-full bg-brand-500" />
              Markdown 模式已激活
            </span>
            <span>已输入 {content.length} 个字符</span>
          </div>
          <div className="text-[10px] uppercase tracking-widest font-black text-gray-300 dark:text-gray-700">
            NovaCloud Community Editor
          </div>
        </div>
      </div>
    </div>
  );
};

export default PostEditPage;
