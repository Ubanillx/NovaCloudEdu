import React, { useMemo } from 'react';
import MarkdownRenderer from '../chat/MarkdownRenderer';

const GRADING_MARKDOWN_CLASS = 'max-w-none [&_p]:my-0 [&_ul]:my-1 [&_ol]:my-1 [&_li]:my-0.5 [&_.katex-display]:my-2 [&_.katex-display]:overflow-x-auto [&_.katex]:text-inherit';
const PLACEHOLDER_PREFIX = '__GRADING_MATH_PROTECTED_';
const LATEX_COMMANDS = new Set([
  'frac', 'dfrac', 'tfrac', 'sqrt', 'root',
  'sum', 'prod', 'int', 'iint', 'iiint', 'lim',
  'sin', 'cos', 'tan', 'cot', 'sec', 'csc', 'log', 'ln',
  'left', 'right', 'overline', 'underline', 'hat', 'bar', 'vec',
  'cdot', 'times', 'div', 'pm', 'mp', 'le', 'leq', 'ge', 'geq', 'neq', 'approx',
  'alpha', 'beta', 'gamma', 'delta', 'theta', 'lambda', 'mu', 'pi', 'rho', 'sigma', 'phi', 'omega',
]);

interface GradingMarkdownProps {
  content?: string | null;
  className?: string;
}

const protectSegments = (text: string) => {
  const segments: string[] = [];
  let processed = text.replace(/```[\s\S]*?```|`[^`]*`|\$\$[\s\S]*?\$\$|\$[^$\n]+\$|\\\[[\s\S]*?\\\]|\\\([^)\n]*\\\)/g, (match) => {
    const index = segments.push(match) - 1;
    return `${PLACEHOLDER_PREFIX}${index}__`;
  });
  return {
    processed,
    restore: (value: string) => value.replace(new RegExp(`${PLACEHOLDER_PREFIX}(\\d+)__`, 'g'), (_match, index) => segments[Number(index)] ?? ''),
  };
};

const isCjkOrPunctuation = (char: string) => /[\u3400-\u9fff，。！？；：、]/.test(char);
const isMathBoundary = (char: string) => !char || isCjkOrPunctuation(char) || /[\n\r]/.test(char);
const isMathChar = (char: string) => /[A-Za-z0-9\\{}()[\]^_+\-*/=<>|.,:!~' ]/.test(char) || /[≤≥≠≈±×÷∞πθ]/.test(char);

const getCommandName = (text: string, slashIndex: number) => {
  const match = text.slice(slashIndex + 1).match(/^[A-Za-z]+/);
  return match?.[0] || '';
};

const findBareLatexRanges = (text: string) => {
  const ranges: Array<[number, number]> = [];

  text.replace(/\\begin\{[^}]+\}[\s\S]*?\\end\{[^}]+\}/g, (match, offset) => {
    ranges.push([offset, offset + match.length]);
    return match;
  });

  for (let index = 0; index < text.length; index += 1) {
    if (text[index] !== '\\') continue;
    const command = getCommandName(text, index);
    if (!LATEX_COMMANDS.has(command)) continue;

    let start = index;
    while (start > 0 && !isMathBoundary(text[start - 1]) && isMathChar(text[start - 1])) {
      start -= 1;
    }

    let end = index + command.length + 1;
    while (end < text.length) {
      const char = text[end];
      if (!isMathChar(char)) break;
      if (char === ' ') {
        const next = text.slice(end + 1).match(/\S/)?.[0] || '';
        if (!next || !isMathChar(next) || isCjkOrPunctuation(next)) break;
      }
      end += 1;
    }

    ranges.push([start, end]);
    index = end;
  }

  return ranges;
};

const mergeRanges = (ranges: Array<[number, number]>) => {
  const sorted = ranges
    .filter(([start, end]) => end > start)
    .sort((a, b) => a[0] - b[0]);
  const merged: Array<[number, number]> = [];

  for (const range of sorted) {
    const last = merged[merged.length - 1];
    if (!last || range[0] > last[1]) {
      merged.push([...range]);
    } else {
      last[1] = Math.max(last[1], range[1]);
    }
  }

  return merged;
};

const wrapRanges = (text: string, ranges: Array<[number, number]>) => {
  const merged = mergeRanges(ranges);
  if (merged.length === 0) return text;

  let result = '';
  let cursor = 0;
  for (const [start, end] of merged) {
    result += text.slice(cursor, start);
    const formula = text.slice(start, end).trim();
    result += formula.includes('\n') ? `\n$$${formula}$$\n` : `$${formula}$`;
    cursor = end;
  }
  return result + text.slice(cursor);
};

const wrapBareAlgebra = (text: string) => text.replace(
  /(^|[^\w$\\])([A-Za-z0-9][A-Za-z0-9{}()[\]^_+\-*/=<>≤≥≠≈±×÷., ]{1,80}[A-Za-z0-9}）])/g,
  (match, prefix: string, expression: string) => {
    const trimmed = expression.trim();
    const hasFormulaSignal = /[\^_=<>≤≥≠≈±×÷]|[A-Za-z]\s*\([^)]+\)/.test(trimmed);
    const hasOperand = /[A-Za-z0-9]/.test(trimmed);
    const hasOperator = /[+\-*/=<>≤≥≠≈±×÷]/.test(trimmed);
    if (!hasFormulaSignal || !hasOperand || !hasOperator) return match;
    return `${prefix}$${trimmed}$`;
  },
);

const normalizeEscapedNewlines = (text: string) => text
  .replace(/\\r\\n/g, '\n')
  .replace(/\\n(?![A-Za-z])/g, '\n')
  .replace(/\\r(?![A-Za-z])/g, '\n');

const normalizeGradingMath = (content: string) => {
  if (!content) return '';
  const normalizedNewlines = normalizeEscapedNewlines(content);
  const { processed, restore } = protectSegments(normalizedNewlines);
  const latexWrapped = wrapRanges(processed, findBareLatexRanges(processed));
  return restore(wrapBareAlgebra(latexWrapped));
};

const GradingMarkdown: React.FC<GradingMarkdownProps> = ({ content, className = '' }) => {
  const normalizedContent = useMemo(() => normalizeGradingMath(content || ''), [content]);

  return (
    <MarkdownRenderer
      content={normalizedContent}
      className={`${GRADING_MARKDOWN_CLASS} ${className}`}
    />
  );
};

export default React.memo(GradingMarkdown);
