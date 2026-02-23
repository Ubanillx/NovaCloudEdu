import React, { useMemo } from 'react';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import remarkMath from 'remark-math';
import rehypeRaw from 'rehype-raw';
import rehypeKatex from 'rehype-katex';

// ============ LaTeX 分隔符标准化 ============

/**
 * 将 LLM 常用的 LaTeX 分隔符统一转换为 remark-math 识别的格式：
 * - \(...\) → $...$  (行内公式)
 * - \[...\] → $$...$$ (块级公式)
 *
 * 跳过代码块内的内容，避免误转换。
 */
function normalizeLatexDelimiters(text: string): string {
  if (!text) return text;

  // 先把代码块提取出来，用占位符替代，避免误处理代码块内的 LaTeX
  const codeBlocks: string[] = [];
  let processed = text.replace(/```[\s\S]*?```/g, (match) => {
    codeBlocks.push(match);
    return `__CODE_BLOCK_${codeBlocks.length - 1}__`;
  });

  // 行内代码也保护起来
  const inlineCodes: string[] = [];
  processed = processed.replace(/`[^`]+`/g, (match) => {
    inlineCodes.push(match);
    return `__INLINE_CODE_${inlineCodes.length - 1}__`;
  });

  // \[...\] → $$...$$（块级公式，可能跨行）
  processed = processed.replace(/\\\[([\s\S]*?)\\\]/g, (_match, inner: string) => {
    return `$$${inner}$$`;
  });

  // \(...\) → $...$（行内公式，不跨行）
  processed = processed.replace(/\\\((.*?)\\\)/g, (_match, inner: string) => {
    return `$${inner}$`;
  });

  // 还原行内代码
  processed = processed.replace(/__INLINE_CODE_(\d+)__/g, (_match, idx: string) => {
    return inlineCodes[parseInt(idx)];
  });

  // 还原代码块
  processed = processed.replace(/__CODE_BLOCK_(\d+)__/g, (_match, idx: string) => {
    return codeBlocks[parseInt(idx)];
  });

  return processed;
}

// ============ 流式 Markdown 预处理 ============

/**
 * 修补流式传输中不完整的 Markdown 结构，避免渲染闪烁。
 * - 未闭合的代码块 → 补上 ```
 * - 未闭合的行内代码 → 补上 `
 * - 未闭合的 LaTeX 公式 → 补上 $$ 或 $
 * - 未闭合的 \( \) \[ \] 分隔符 → 补上
 */
function patchIncompleteMarkdown(text: string): string {
  if (!text) return text;

  let result = text;

  // 修补未闭合的代码块 (```)
  const fenceMatches = result.match(/```/g);
  if (fenceMatches && fenceMatches.length % 2 !== 0) {
    result += '\n```';
  }

  // 修补未闭合的 \[...\]（在标准化前处理）
  const openBracket = (result.match(/\\\[/g) || []).length;
  const closeBracket = (result.match(/\\\]/g) || []).length;
  if (openBracket > closeBracket) {
    result += '\\]';
  }

  // 修补未闭合的 \(...\)
  const openParen = (result.match(/\\\(/g) || []).length;
  const closeParen = (result.match(/\\\)/g) || []).length;
  if (openParen > closeParen) {
    result += '\\)';
  }

  // 修补未闭合的块级 LaTeX ($$)
  const blockMathMatches = result.match(/\$\$/g);
  if (blockMathMatches && blockMathMatches.length % 2 !== 0) {
    result += '$$';
  }

  // 修补未闭合的行内代码 (`) — 排除代码块内的反引号
  const withoutCodeBlocks = result.replace(/```[\s\S]*?```/g, '');
  const backtickMatches = withoutCodeBlocks.match(/`/g);
  if (backtickMatches && backtickMatches.length % 2 !== 0) {
    result += '`';
  }

  // 修补未闭合的行内 LaTeX ($) — 排除已处理的 $$
  const withoutBlockMath = withoutCodeBlocks.replace(/\$\$[\s\S]*?\$\$/g, '');
  const inlineMathMatches = withoutBlockMath.match(/\$/g);
  if (inlineMathMatches && inlineMathMatches.length % 2 !== 0) {
    result += '$';
  }

  return result;
}

// ============ 自定义组件 ============

const markdownComponents: React.ComponentProps<typeof ReactMarkdown>['components'] = {
  // 渲染 <video> 标签为视频播放器
  video: (props: React.ComponentProps<'video'>) => (
    <video
      {...props}
      controls
      className="rounded-xl border border-gray-200 dark:border-gray-700 shadow-md max-w-full not-prose"
      style={{ maxHeight: 320, maxWidth: '100%', borderRadius: 12 }}
    />
  ),
  // 兼容旧数据：[点击播放 AI 生成视频](url) 渲染为视频播放器
  a: ({ children, href, ...rest }: React.ComponentProps<'a'>) => {
    const text = typeof children === 'string' ? children : '';
    if (text === '点击播放 AI 生成视频' && href) {
      return (
        <video
          controls
          src={href}
          className="rounded-xl border border-gray-200 dark:border-gray-700 shadow-md max-w-full not-prose"
          style={{ maxHeight: 320, maxWidth: '100%', borderRadius: 12 }}
        />
      );
    }
    return <a href={href} {...rest} target="_blank" rel="noopener noreferrer">{children}</a>;
  },
};

// 不带视频处理的简化组件集
const simpleComponents: React.ComponentProps<typeof ReactMarkdown>['components'] = {
  a: ({ children, href, ...rest }: React.ComponentProps<'a'>) => (
    <a href={href} {...rest} target="_blank" rel="noopener noreferrer">{children}</a>
  ),
};

// ============ 插件列表 ============

const remarkPlugins = [remarkGfm, remarkMath];
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const rehypePlugins: any[] = [
  rehypeRaw,
  [rehypeKatex, { throwOnError: false, strict: false, output: 'htmlAndMathml' }],
];

// ============ MarkdownRenderer 组件 ============

interface MarkdownRendererProps {
  /** Markdown 文本内容 */
  content: string;
  /** 是否处于流式传输中（会自动修补不完整的 Markdown） */
  isStreaming?: boolean;
  /** 是否显示流式光标 */
  showCursor?: boolean;
  /** 是否包含视频渲染支持（AI 对话页需要） */
  enableVideo?: boolean;
  /** 额外的 CSS className */
  className?: string;
}

const MarkdownRenderer: React.FC<MarkdownRendererProps> = ({
  content,
  isStreaming = false,
  showCursor = false,
  enableVideo = false,
  className,
}) => {
  // 预处理：流式修补 → LaTeX 分隔符标准化
  const processedContent = useMemo(() => {
    if (!content) return '';
    const patched = isStreaming ? patchIncompleteMarkdown(content) : content;
    return normalizeLatexDelimiters(patched);
  }, [content, isStreaming]);

  const components = enableVideo ? markdownComponents : simpleComponents;

  return (
    <div className={className}>
      <ReactMarkdown
        remarkPlugins={remarkPlugins}
        rehypePlugins={rehypePlugins}
        components={components}
      >
        {processedContent}
      </ReactMarkdown>
      {showCursor && isStreaming && (
        <span className="inline-block w-2 h-4 bg-brand-500 animate-pulse rounded-sm ml-0.5 align-middle" />
      )}
    </div>
  );
};

export default React.memo(MarkdownRenderer);
