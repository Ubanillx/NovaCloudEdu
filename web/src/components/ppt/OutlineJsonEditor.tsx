import React, { useState, useCallback } from 'react';
import {
  Plus, Trash2, ChevronDown, ChevronRight,
  RefreshCw, ArrowRight, Presentation,
} from 'lucide-react';

// ==================== Types ====================

export interface OutlinePage {
  title: string;
  bullets: string[];
}

export interface OutlineSection {
  type: 'cover' | 'toc' | 'chapter' | 'ending';
  title?: string;
  chapterTitle?: string;
  pages?: OutlinePage[];
}

export interface OutlineData {
  title: string;
  speaker: string;
  pageCount: number;
  sections: OutlineSection[];
}

interface OutlineJsonEditorProps {
  outlineJson: string;
  onSave: (json: string) => void;
  onConfirm: () => void;
  onRegenerate?: () => void;
  isLoading?: boolean;
}

// ==================== Helpers ====================

function parseOutline(json: string): OutlineData {
  try {
    const data = JSON.parse(json);
    return {
      title: data.title || '',
      speaker: data.speaker || '',
      pageCount: data.pageCount || 0,
      sections: Array.isArray(data.sections) ? data.sections : [],
    };
  } catch {
    return { title: '', speaker: '', pageCount: 0, sections: [] };
  }
}

function computePageCount(sections: OutlineSection[]): number {
  let count = 0;
  for (const s of sections) {
    if (s.type === 'chapter') {
      count += s.pages?.length || 0;
    } else {
      count++;
    }
  }
  return count;
}

// ==================== Sub-Components ====================

const EditableText: React.FC<{
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  className?: string;
}> = ({ value, onChange, placeholder, className = '' }) => (
  <input
    type="text"
    value={value}
    onChange={e => onChange(e.target.value)}
    placeholder={placeholder}
    className={`bg-transparent border-none outline-none w-full ${className}`}
    onClick={e => e.stopPropagation()}
  />
);

const BulletItem: React.FC<{
  text: string;
  onChange: (v: string) => void;
  onDelete: () => void;
}> = ({ text, onChange, onDelete }) => (
  <div className="group flex items-start gap-2 py-1.5 pl-8">
    <div className="flex-1 flex items-center gap-2 px-3 py-1.5 rounded-lg border border-transparent hover:border-gray-200 dark:hover:border-gray-700 transition-colors">
      <input
        type="text"
        value={text}
        onChange={e => onChange(e.target.value)}
        className="flex-1 bg-transparent border-none outline-none text-sm text-gray-700 dark:text-gray-300"
        placeholder="输入要点内容..."
      />
      <button
        onClick={onDelete}
        className="opacity-0 group-hover:opacity-100 p-0.5 text-gray-400 hover:text-red-500 transition-all"
      >
        <Trash2 size={13} />
      </button>
    </div>
  </div>
);

const PageItem: React.FC<{
  page: OutlinePage;
  pageIndex: number;
  onChange: (page: OutlinePage) => void;
  onDelete: () => void;
}> = ({ page, pageIndex, onChange, onDelete }) => {
  const updateBullet = (idx: number, val: string) => {
    const bullets = [...page.bullets];
    bullets[idx] = val;
    onChange({ ...page, bullets });
  };
  const deleteBullet = (idx: number) => {
    onChange({ ...page, bullets: page.bullets.filter((_, i) => i !== idx) });
  };
  const addBullet = () => {
    onChange({ ...page, bullets: [...page.bullets, ''] });
  };

  return (
    <div className="ml-6 group/page">
      <div className="flex items-center gap-2 py-1.5">
        <div className="flex-1 flex items-center gap-2 px-3 py-1.5 rounded-lg border border-transparent hover:border-gray-200 dark:hover:border-gray-700 transition-colors">
          <EditableText
            value={page.title}
            onChange={v => onChange({ ...page, title: v })}
            placeholder={`第 ${pageIndex + 1} 页标题`}
            className="text-sm font-medium text-gray-800 dark:text-gray-200"
          />
          <div className="flex items-center gap-1 opacity-0 group-hover/page:opacity-100 transition-opacity">
            <button
              onClick={addBullet}
              className="p-0.5 text-gray-400 hover:text-brand-500 transition-colors"
              title="添加要点"
            >
              <Plus size={14} />
            </button>
            <button
              onClick={onDelete}
              className="p-0.5 text-gray-400 hover:text-red-500 transition-colors"
              title="删除此页"
            >
              <Trash2 size={14} />
            </button>
          </div>
        </div>
      </div>
      {page.bullets.map((bullet, bi) => (
        <BulletItem
          key={bi}
          text={bullet}
          onChange={v => updateBullet(bi, v)}
          onDelete={() => deleteBullet(bi)}
        />
      ))}
    </div>
  );
};

const ChapterSection: React.FC<{
  section: OutlineSection;
  sectionIndex: number;
  onChange: (s: OutlineSection) => void;
  onDelete: () => void;
}> = ({ section, sectionIndex, onChange, onDelete }) => {
  const [collapsed, setCollapsed] = useState(false);
  const pages = section.pages || [];

  const updatePage = (idx: number, page: OutlinePage) => {
    const newPages = [...pages];
    newPages[idx] = page;
    onChange({ ...section, pages: newPages });
  };
  const deletePage = (idx: number) => {
    onChange({ ...section, pages: pages.filter((_, i) => i !== idx) });
  };
  const addPage = () => {
    onChange({
      ...section,
      pages: [...pages, { title: '', bullets: [] }],
    });
  };

  return (
    <div className="group/chapter">
      <div
        className="flex items-center gap-2 py-2 cursor-pointer"
        onClick={() => setCollapsed(!collapsed)}
      >
        <div className="text-gray-400">
          {collapsed ? <ChevronRight size={16} /> : <ChevronDown size={16} />}
        </div>
        <span className="text-xs font-bold text-brand-600 dark:text-brand-400 whitespace-nowrap">
          第{sectionIndex}章
        </span>
        <div className="w-2 h-2 rounded-full bg-brand-500 flex-shrink-0" />
        <div className="flex-1" onClick={e => e.stopPropagation()}>
          <EditableText
            value={section.chapterTitle || ''}
            onChange={v => onChange({ ...section, chapterTitle: v })}
            placeholder="章节标题"
            className="text-sm font-semibold text-gray-900 dark:text-white"
          />
        </div>
        <div className="flex items-center gap-1 opacity-0 group-hover/chapter:opacity-100 transition-opacity">
          <button
            onClick={e => { e.stopPropagation(); addPage(); }}
            className="p-1 text-gray-400 hover:text-brand-500 transition-colors"
            title="添加内容页"
          >
            <Plus size={14} />
          </button>
          <button
            onClick={e => { e.stopPropagation(); onDelete(); }}
            className="p-1 text-gray-400 hover:text-red-500 transition-colors"
            title="删除章节"
          >
            <Trash2 size={14} />
          </button>
        </div>
      </div>
      {!collapsed && pages.map((page, pi) => (
        <PageItem
          key={pi}
          page={page}
          pageIndex={pi}
          onChange={p => updatePage(pi, p)}
          onDelete={() => deletePage(pi)}
        />
      ))}
    </div>
  );
};

// ==================== Main Component ====================

const OutlineJsonEditor: React.FC<OutlineJsonEditorProps> = ({
  outlineJson,
  onSave,
  onConfirm,
  onRegenerate,
  isLoading,
}) => {
  const [outline, setOutline] = useState<OutlineData>(() => parseOutline(outlineJson));

  const pageCount = computePageCount(outline.sections);

  const updateAndSave = useCallback((newOutline: OutlineData) => {
    const updated = { ...newOutline, pageCount: computePageCount(newOutline.sections) };
    setOutline(updated);
    onSave(JSON.stringify(updated));
  }, [onSave]);

  const updateSection = (idx: number, section: OutlineSection) => {
    const sections = [...outline.sections];
    sections[idx] = section;
    updateAndSave({ ...outline, sections });
  };

  const deleteSection = (idx: number) => {
    updateAndSave({ ...outline, sections: outline.sections.filter((_, i) => i !== idx) });
  };

  const addChapter = () => {
    const newChapter: OutlineSection = {
      type: 'chapter',
      chapterTitle: '',
      pages: [{ title: '', bullets: [] }],
    };
    // Insert before ending if exists
    const sections = [...outline.sections];
    const endingIdx = sections.findIndex(s => s.type === 'ending');
    if (endingIdx >= 0) {
      sections.splice(endingIdx, 0, newChapter);
    } else {
      sections.push(newChapter);
    }
    updateAndSave({ ...outline, sections });
  };

  let chapterCounter = 0;

  return (
    <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
      {/* Header */}
      <div className="px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 rounded-lg bg-brand-500 flex items-center justify-center">
            <Presentation size={16} className="text-white" />
          </div>
          <p className="text-sm text-gray-500 dark:text-gray-400">
            请先确认大纲，可以直接点击进行编辑。
          </p>
        </div>
        <div className="flex items-center gap-3">
          {onRegenerate && (
            <button
              onClick={onRegenerate}
              disabled={isLoading}
              className="flex items-center gap-1.5 text-xs text-gray-500 hover:text-brand-500 transition-colors"
            >
              <RefreshCw size={13} className={isLoading ? 'animate-spin' : ''} />
              重新生成
            </button>
          )}
          <span className="text-xs text-gray-400">
            页数：<span className="font-bold text-gray-600 dark:text-gray-300">{pageCount}</span>
          </span>
        </div>
      </div>

      {/* Editor Body */}
      <div className="px-6 py-4 space-y-1 max-h-[60vh] overflow-y-auto custom-scrollbar">
        {outline.sections.map((section, si) => {
          if (section.type === 'cover') {
            return (
              <div key={si} className="flex items-center gap-3 py-2">
                <span className="text-xs font-bold text-brand-600 dark:text-brand-400 whitespace-nowrap">主标题</span>
                <div className="w-2 h-2 rounded-full bg-brand-500 flex-shrink-0" />
                <EditableText
                  value={section.title || outline.title}
                  onChange={v => {
                    updateSection(si, { ...section, title: v });
                    setOutline(prev => ({ ...prev, title: v }));
                  }}
                  placeholder="PPT 标题"
                  className="text-sm font-semibold text-gray-900 dark:text-white"
                />
              </div>
            );
          }
          if (section.type === 'toc') {
            return (
              <div key={si} className="flex items-center gap-3 py-2">
                <span className="text-xs font-bold text-gray-500 whitespace-nowrap">目录</span>
                <div className="w-2 h-2 rounded-full bg-gray-400 flex-shrink-0" />
                <EditableText
                  value={section.title || '目录'}
                  onChange={v => updateSection(si, { ...section, title: v })}
                  className="text-sm text-gray-600 dark:text-gray-400"
                />
              </div>
            );
          }
          if (section.type === 'chapter') {
            chapterCounter++;
            return (
              <ChapterSection
                key={si}
                section={section}
                sectionIndex={chapterCounter}
                onChange={s => updateSection(si, s)}
                onDelete={() => deleteSection(si)}
              />
            );
          }
          if (section.type === 'ending') {
            return (
              <div key={si} className="flex items-center gap-3 py-2">
                <span className="text-xs font-bold text-gray-500 whitespace-nowrap">结尾</span>
                <div className="w-2 h-2 rounded-full bg-gray-400 flex-shrink-0" />
                <EditableText
                  value={section.title || '谢谢观看'}
                  onChange={v => updateSection(si, { ...section, title: v })}
                  className="text-sm text-gray-600 dark:text-gray-400"
                />
              </div>
            );
          }
          return null;
        })}

        {/* Speaker row */}
        <div className="flex items-center gap-3 py-2">
          <span className="text-xs font-bold text-gray-500 whitespace-nowrap">演讲人</span>
          <div className="w-2 h-2 rounded-full bg-gray-400 flex-shrink-0" />
          <EditableText
            value={outline.speaker}
            onChange={v => updateAndSave({ ...outline, speaker: v })}
            placeholder="可选填"
            className="text-sm text-gray-500 dark:text-gray-400 italic"
          />
        </div>
      </div>

      {/* Footer Actions */}
      <div className="px-6 py-4 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
        <button
          onClick={addChapter}
          className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium text-brand-600 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/30 rounded-lg transition-colors"
        >
          <Plus size={14} />
          添加章节
        </button>
        <button
          onClick={onConfirm}
          disabled={isLoading}
          className="flex items-center gap-2 px-5 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-500/20 transition-all active:scale-95 disabled:opacity-50"
        >
          <ArrowRight size={16} />
          下一步
        </button>
      </div>
    </div>
  );
};

export default OutlineJsonEditor;
