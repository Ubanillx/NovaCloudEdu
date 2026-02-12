import React from 'react';
import { Check } from 'lucide-react';
import type { PptPhase } from '../../hooks/usePptGeneration';

const STEPS = [
  { label: '输入主题', phases: ['idle', 'detecting'] },
  { label: '大纲确认', phases: ['generating_outline', 'outline_ready'] },
  { label: '选择模板', phases: ['awaiting_template', 'parsing_template', 'template_ready'] },
  { label: 'AI 生成', phases: ['generating_slides'] },
  { label: '导出完成', phases: ['assembling', 'completed'] },
];

const PHASE_ORDER: PptPhase[] = [
  'idle', 'detecting', 'generating_outline', 'outline_ready',
  'awaiting_template', 'parsing_template', 'template_ready',
  'generating_slides', 'assembling', 'completed',
];

interface StepIndicatorProps {
  currentPhase: PptPhase;
}

export const StepIndicator: React.FC<StepIndicatorProps> = ({ currentPhase }) => {
  const currentPhaseIdx = PHASE_ORDER.indexOf(currentPhase);

  const getStepStatus = (step: typeof STEPS[number]) => {
    const stepPhaseIndices = step.phases.map(p => PHASE_ORDER.indexOf(p as PptPhase));
    const maxStepPhaseIdx = Math.max(...stepPhaseIndices);
    const minStepPhaseIdx = Math.min(...stepPhaseIndices);

    if (currentPhaseIdx > maxStepPhaseIdx) return 'completed';
    if (currentPhaseIdx >= minStepPhaseIdx && currentPhaseIdx <= maxStepPhaseIdx) return 'active';
    return 'pending';
  };

  return (
    <div className="flex items-center justify-center gap-1 py-3">
      {STEPS.map((step, idx) => {
        const status = getStepStatus(step);

        return (
          <React.Fragment key={idx}>
            {idx > 0 && (
              <div
                className={`h-0.5 w-8 transition-all duration-300 ${
                  status === 'pending'
                    ? 'bg-gray-200 dark:bg-gray-700'
                    : 'bg-brand-500'
                }`}
              />
            )}
            <div className="flex items-center gap-1.5">
              <div
                className={`
                  w-6 h-6 rounded-full flex items-center justify-center text-xs font-semibold transition-all duration-300
                  ${status === 'completed'
                    ? 'bg-brand-500 text-white animate-bounceIn'
                    : status === 'active'
                      ? 'bg-brand-500 text-white ring-4 ring-brand-100 dark:ring-brand-900/30 animate-pulse'
                      : 'bg-gray-100 dark:bg-gray-800 text-gray-400 dark:text-gray-500'
                  }
                `}
              >
                {status === 'completed' ? <Check className="w-3.5 h-3.5" /> : idx + 1}
              </div>
              <span
                className={`text-xs font-medium transition-colors duration-200 hidden sm:inline ${
                  status === 'active'
                    ? 'text-brand-600 dark:text-brand-400'
                    : status === 'completed'
                      ? 'text-gray-600 dark:text-gray-400'
                      : 'text-gray-400 dark:text-gray-500'
                }`}
              >
                {step.label}
              </span>
            </div>
          </React.Fragment>
        );
      })}
    </div>
  );
};
