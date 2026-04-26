import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { EditorContent, useEditor, type Editor } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';
import ImageExtension from '@tiptap/extension-image';
import LinkExtension from '@tiptap/extension-link';
import Placeholder from '@tiptap/extension-placeholder';
import {
  ArrowLeft, Tag, X, Send, Image, Bold, Italic, Heading1, Heading2,
  List, ListOrdered, Link, Code, Quote, PenSquare, Undo2, Redo2,
  Paperclip, Loader2,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import toast from '../components/ui/Toast';
import { POST_TYPE_OPTIONS, getPostTypeLabel } from '../constants/postTypes';

const api = new DefaultApi(new Configuration(), '', apiClient);

type ToolbarButton = {
  label: string;
  icon: React.ElementType;
  isActive?: (editor: Editor) => boolean;
  onClick: (editor: Editor) => void;
};

const TOOLBAR_ITEMS: ToolbarButton[] = [
  { icon: Bold, label: '粗体', isActive: editor => editor.isActive('bold'), onClick: editor => editor.chain().focus().toggleBold().run() },
  { icon: Italic, label: '斜体', isActive: editor => editor.isActive('italic'), onClick: editor => editor.chain().focus().toggleItalic().run() },
  { icon: Heading1, label: '一级标题', isActive: editor => editor.isActive('heading', { level: 1 }), onClick: editor => editor.chain().focus().toggleHeading({ level: 1 }).run() },
  { icon: Heading2, label: '二级标题', isActive: editor => editor.isActive('heading', { level: 2 }), onClick: editor => editor.chain().focus().toggleHeading({ level: 2 }).run() },
  { icon: List, label: '无序列表', isActive: editor => editor.isActive('bulletList'), onClick: editor => editor.chain().focus().toggleBulletList().run() },
  { icon: ListOrdered, label: '有序列表', isActive: editor => editor.isActive('orderedList'), onClick: editor => editor.chain().focus().toggleOrderedList().run() },
  { icon: Quote, label: '引用', isActive: editor => editor.isActive('blockquote'), onClick: editor => editor.chain().focus().toggleBlockquote().run() },
  { icon: Code, label: '代码块', isActive: editor => editor.isActive('codeBlock'), onClick: editor => editor.chain().focus().toggleCodeBlock().run() },
];

const escapeHtml = (value: string) =>
  value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');

const uploadCommunityFile = async (file: File) => {
  const formData = new FormData();
  formData.append('file', file);
  const res = await apiClient.post('/api/file/upload/general', formData, {
    headers: { 'Content-Type': 'multipart/form-data' },
  });

  if ((res.data?.code === 0 || res.data?.code === 200) && res.data?.data?.fileUrl) {
    return res.data.data.fileUrl as string;
  }
  throw new Error(res.data?.message || '上传失败');
};

const PostEditPage: React.FC = () => {
  const { postId: postIdStr } = useParams<{ postId: string }>();
  const postId = postIdStr ? postIdStr as unknown as number : undefined;
  const isEdit = !!postId;
  const navigate = useNavigate();

  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [postType, setPostType] = useState('');
  const [tags, setTags] = useState<string[]>([]);
  const [tagInput, setTagInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [isLoadingPost, setIsLoadingPost] = useState(false);
  const [isUploading, setIsUploading] = useState(false);
  const imageInputRef = useRef<HTMLInputElement>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const editor = useEditor({
    extensions: [
      StarterKit.configure({
        heading: { levels: [1, 2, 3] },
      }),
      ImageExtension.configure({
        inline: false,
        allowBase64: false,
        HTMLAttributes: {
          class: 'community-content-image',
        },
      }),
      LinkExtension.configure({
        openOnClick: false,
        autolink: true,
        linkOnPaste: true,
        HTMLAttributes: {
          class: 'community-content-link',
          rel: 'noopener noreferrer',
          target: '_blank',
        },
      }),
      Placeholder.configure({
        placeholder: '分享你的学习心得、疑问或有趣发现。支持标题、列表、引用、图片和附件。',
      }),
    ],
    content,
    editorProps: {
      attributes: {
        class: 'community-editor-content min-h-[480px] focus:outline-none',
      },
    },
    onUpdate: ({ editor }) => {
      setContent(editor.getHTML());
    },
  });

  useEffect(() => {
    if (isEdit && postId) {
      setIsLoadingPost(true);
      api.getPostDetail({ postId })
        .then(res => {
          if (res.data?.code === 0 && res.data.data) {
            const data = res.data.data;
            const nextContent = data.content || '';
            setTitle(data.title || '');
            setContent(nextContent);
            setPostType(data.postType || '');
            setTags(data.tags?.filter(t => t) || []);
            editor?.commands.setContent(nextContent);
          }
        })
        .catch(() => toast.error('加载帖子失败'))
        .finally(() => setIsLoadingPost(false));
    }
  }, [editor, isEdit, postId]);

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

  const handleSetLink = useCallback(() => {
    if (!editor) return;
    const previousUrl = editor.getAttributes('link').href as string | undefined;
    const url = window.prompt('请输入链接地址', previousUrl || 'https://');
    if (url === null) return;
    if (!url.trim()) {
      editor.chain().focus().extendMarkRange('link').unsetLink().run();
      return;
    }
    editor.chain().focus().extendMarkRange('link').setLink({ href: url.trim() }).run();
  }, [editor]);

  const handleImageUpload = useCallback(async (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (!file || !editor) return;
    if (!file.type.startsWith('image/')) {
      toast.warning('请选择图片文件');
      return;
    }

    setIsUploading(true);
    try {
      const url = await uploadCommunityFile(file);
      editor.chain().focus().setImage({ src: url, alt: file.name }).run();
      toast.success('图片已插入');
    } catch {
      toast.error('图片上传失败');
    } finally {
      setIsUploading(false);
    }
  }, [editor]);

  const handleAttachmentUpload = useCallback(async (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (!file || !editor) return;

    setIsUploading(true);
    try {
      const url = await uploadCommunityFile(file);
      const safeName = escapeHtml(file.name);
      const safeUrl = escapeHtml(url);
      editor.chain().focus().insertContent(
        `<p><a href="${safeUrl}" target="_blank" rel="noopener noreferrer">${safeName}</a></p>`
      ).run();
      toast.success('附件已插入');
    } catch {
      toast.error('附件上传失败');
    } finally {
      setIsUploading(false);
    }
  }, [editor]);

  const handleSubmit = useCallback(async () => {
    if (!editor) return;
    const html = editor.getHTML();
    const text = editor.getText().trim();
    if (!title.trim()) {
      toast.warning('请输入标题');
      return;
    }
    if (!postType) {
      toast.warning('请选择帖子类型');
      return;
    }
    if (!text && !html.includes('<img')) {
      toast.warning('请输入内容');
      return;
    }

    setIsLoading(true);
    try {
      if (isEdit && postId) {
        const res = await api.updatePost({
          postId,
          updatePostRequest: { title: title.trim(), content: html, tags, postType },
        });
        if (res.data?.code === 0) {
          toast.success('更新成功');
          navigate(`/circle/post/${postId}`, { replace: true });
        }
      } else {
        const res = await api.createPost({
          createPostRequest: { title: title.trim(), content: html, tags, postType },
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
  }, [editor, title, postType, tags, isEdit, postId, navigate]);

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
      <button
        onClick={() => navigate(-1)}
        className="flex items-center gap-2 text-sm font-bold text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 mb-8 transition-all group"
      >
        <div className="p-2 rounded-xl bg-white dark:bg-gray-900 border border-gray-100 dark:border-gray-800 group-hover:border-brand-100 shadow-sm transition-all">
          <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
        </div>
        返回上一页
      </button>

      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
        <div className="px-5 sm:px-8 py-5 border-b border-gray-50 dark:border-gray-800/50 flex flex-col sm:flex-row sm:items-center justify-between gap-4 bg-gray-50/30 dark:bg-gray-800/10">
          <h1 className="text-xl font-black text-gray-900 dark:text-white flex items-center gap-3">
            <div className="w-8 h-8 rounded-lg bg-brand-600 flex items-center justify-center shadow-sm">
              <PenSquare size={18} className="text-white" />
            </div>
            {isEdit ? '编辑帖子' : '发布新动态'}
          </h1>
          <button
            onClick={handleSubmit}
            disabled={isLoading || isUploading || !editor}
            className="flex items-center justify-center gap-2 px-7 py-2.5 bg-brand-600 hover:bg-brand-500 disabled:bg-gray-200 dark:disabled:bg-gray-800 text-white text-sm font-bold rounded-xl transition-all shadow-sm active:scale-[0.98]"
          >
            {isLoading ? <Loader2 size={16} className="animate-spin" /> : <Send size={16} />}
            {isLoading ? '正在提交...' : isEdit ? '保存修改' : '立即发布'}
          </button>
        </div>

        <div className="px-5 sm:px-8 pt-7">
          <input
            type="text"
            value={title}
            onChange={e => setTitle(e.target.value)}
            placeholder="为你的动态起一个清晰的标题"
            maxLength={100}
            className="w-full text-2xl sm:text-3xl font-black text-gray-900 dark:text-white placeholder-gray-300 dark:placeholder-gray-700 bg-transparent border-none outline-none tracking-tight"
          />
        </div>

        <div className="px-5 sm:px-8 pt-5">
          <label className="mb-2 block text-sm font-bold text-gray-700 dark:text-gray-300">
            帖子类型 <span className="text-rose-500">*</span>
          </label>
          <select
            value={postType}
            onChange={e => setPostType(e.target.value)}
            required
            className="w-full rounded-xl border border-gray-100 bg-gray-50/80 px-4 py-3 text-sm font-semibold text-gray-700 outline-none transition-all focus:border-brand-400 focus:bg-white dark:border-gray-800 dark:bg-gray-800/50 dark:text-gray-200 dark:focus:border-brand-500"
          >
            <option value="">请选择帖子类型</option>
            {POST_TYPE_OPTIONS.map(option => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
          {postType && (
            <p className="mt-2 text-xs font-medium text-gray-400 dark:text-gray-500">
              当前选择：{getPostTypeLabel(postType)}
            </p>
          )}
        </div>

        <div className="px-5 sm:px-8 py-4 flex items-center gap-3 flex-wrap">
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
                placeholder="添加标签，回车确认"
                className="w-full text-sm bg-transparent border-none outline-none text-gray-500 dark:text-gray-400 placeholder-gray-300 dark:placeholder-gray-700 font-medium"
              />
            </div>
          )}
        </div>

        <div className="px-3 sm:px-6 py-3 border-y border-gray-50 dark:border-gray-800/50 flex items-center gap-1.5 overflow-x-auto no-scrollbar bg-gray-50/10">
          {TOOLBAR_ITEMS.map(item => {
            const Icon = item.icon;
            const active = !!editor && item.isActive?.(editor);
            return (
              <button
                key={item.label}
                onClick={() => editor && item.onClick(editor)}
                disabled={!editor}
                className={`p-2.5 rounded-xl transition-all flex-shrink-0 active:scale-95 disabled:opacity-50 ${
                  active
                    ? 'bg-brand-600 text-white'
                    : 'text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20'
                }`}
                title={item.label}
              >
                <Icon size={18} />
              </button>
            );
          })}
          <div className="w-px h-7 bg-gray-100 dark:bg-gray-800 mx-1 flex-shrink-0" />
          <button
            onClick={handleSetLink}
            disabled={!editor}
            className={`p-2.5 rounded-xl transition-all flex-shrink-0 active:scale-95 disabled:opacity-50 ${
              editor?.isActive('link')
                ? 'bg-brand-600 text-white'
                : 'text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20'
            }`}
            title="链接"
          >
            <Link size={18} />
          </button>
          <button
            onClick={() => imageInputRef.current?.click()}
            disabled={!editor || isUploading}
            className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-all flex-shrink-0 active:scale-95 disabled:opacity-50"
            title="上传图片"
          >
            {isUploading ? <Loader2 size={18} className="animate-spin" /> : <Image size={18} />}
          </button>
          <button
            onClick={() => fileInputRef.current?.click()}
            disabled={!editor || isUploading}
            className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-all flex-shrink-0 active:scale-95 disabled:opacity-50"
            title="上传附件"
          >
            <Paperclip size={18} />
          </button>
          <div className="w-px h-7 bg-gray-100 dark:bg-gray-800 mx-1 flex-shrink-0" />
          <button
            onClick={() => editor?.chain().focus().undo().run()}
            disabled={!editor || !editor.can().undo()}
            className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-all flex-shrink-0 active:scale-95 disabled:opacity-50"
            title="撤销"
          >
            <Undo2 size={18} />
          </button>
          <button
            onClick={() => editor?.chain().focus().redo().run()}
            disabled={!editor || !editor.can().redo()}
            className="p-2.5 rounded-xl text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-all flex-shrink-0 active:scale-95 disabled:opacity-50"
            title="重做"
          >
            <Redo2 size={18} />
          </button>
          <input ref={imageInputRef} type="file" accept="image/*" className="hidden" onChange={handleImageUpload} />
          <input ref={fileInputRef} type="file" className="hidden" onChange={handleAttachmentUpload} />
        </div>

        <div className="px-5 sm:px-8 py-6 min-h-[500px]">
          <EditorContent editor={editor} />
        </div>

        <div className="px-5 sm:px-8 py-4 border-t border-gray-50 dark:border-gray-800/50 flex flex-col sm:flex-row sm:items-center justify-between gap-2 bg-gray-50/20 dark:bg-gray-800/5">
          <div className="flex items-center gap-4 text-xs font-bold text-gray-400 dark:text-gray-500">
            <span className="flex items-center gap-1.5">
              <div className="w-1.5 h-1.5 rounded-full bg-brand-500" />
              富文本编辑器
            </span>
            <span>已输入 {editor?.getText().length || 0} 个字符</span>
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
