import type { HTMLReactParserOptions, Element } from 'html-react-parser';
import type { ReaderTheme, ReaderFontFamily } from '../../stores/useReaderSettingsStore';

// ─── 阅读主题 CSS 变量 ──────────────────────────────────────────────────────────

export type ThemeVars = { bg: string; text: string; sidebar: string; border: string; muted: string; card: string; accent: string };

export const THEMES: Record<ReaderTheme, ThemeVars> = {
  light:  { bg: '#ffffff', text: '#111827', sidebar: '#f9fafb', border: '#f3f4f6', muted: '#6b7280', card: '#f3f4f6', accent: '#2563eb' },
  warm:   { bg: '#faf5e8', text: '#3d3322', sidebar: '#f5edd8', border: '#e6d5b8', muted: '#8b7355', card: '#f0e6d0', accent: '#92400e' },
  dark:   { bg: '#0f172a', text: '#e2e8f0', sidebar: '#1e293b', border: '#334155', muted: '#94a3b8', card: '#1e293b', accent: '#38bdf8' },
  green:  { bg: '#f0fdf4', text: '#166534', sidebar: '#dcfce7', border: '#bbf7d0', muted: '#15803d', card: '#dcfce7', accent: '#16a34a' },
};

export const FONT_FAMILIES: Record<ReaderFontFamily, string> = {
  serif: '"Noto Serif SC", "Source Han Serif SC", "STSong", Georgia, serif',
  sans:  '"Noto Sans SC", "Source Han Sans SC", "PingFang SC", "Microsoft YaHei", sans-serif',
  mono:  '"JetBrains Mono", "Fira Code", "Source Code Pro", monospace',
};

// ─── html-react-parser 选项 ─────────────────────────────────────────────────────

export const parserOptions: HTMLReactParserOptions = {
  replace: (domNode) => {
    if (domNode.type === 'tag') {
      const el = domNode as Element;
      if (el.name === 'a' && el.attribs) {
        el.attribs.target = '_blank';
        el.attribs.rel = 'noopener noreferrer';
      }
      if (el.name === 'img' && el.attribs) {
        el.attribs.loading = 'lazy';
        el.attribs.style = 'max-width:100%;height:auto;border-radius:8px;';
      }
    }
    return undefined;
  },
};

// ─── 知识点类型颜色 ─────────────────────────────────────────────────────────────

export const KP_COLORS: Record<string, string> = {
  CONCEPT:   'bg-blue-100 text-blue-700 border-blue-200',
  TERM:      'bg-purple-100 text-purple-700 border-purple-200',
  FORMULA:   'bg-amber-100 text-amber-700 border-amber-200',
  PRINCIPLE: 'bg-emerald-100 text-emerald-700 border-emerald-200',
  METHOD:    'bg-rose-100 text-rose-700 border-rose-200',
};

export const KP_LABELS: Record<string, string> = {
  CONCEPT: '概念', TERM: '术语', FORMULA: '公式', PRINCIPLE: '原理', METHOD: '方法',
};

// ─── AI 面板 Tab 类型 ────────────────────────────────────────────────────────────

export type AiTab = 'summary' | 'knowledge' | 'chat' | 'quiz';

// ─── 悬浮面板通用样式 ────────────────────────────────────────────────────────────

export const floatingPanelStyle = (bg: string, border: string) => ({
  background: `${bg}cc`,
  borderColor: border,
  backdropFilter: 'blur(20px) saturate(180%)',
  boxShadow: '0 20px 40px -10px rgba(0,0,0,0.1), 0 0 10px -5px rgba(0,0,0,0.05)',
});

export const stickyHeaderStyle = (bg: string) => ({
  background: `linear-gradient(to bottom, ${bg}ee 0%, ${bg}cc 80%, transparent 100%)`,
  backdropFilter: 'blur(10px)',
});
