import React from 'react';
import { X, Settings, Minus, Plus, Type, AlignJustify, Maximize2, Check } from 'lucide-react';
import { useReaderSettingsStore, type ReaderTheme, type ReaderFontFamily } from '../../stores/useReaderSettingsStore';
import type { ThemeVars } from './readerConstants';
import { THEMES, FONT_FAMILIES, floatingPanelStyle } from './readerConstants';

interface ReaderSettingsPanelProps {
  themeVars: ThemeVars;
  onClose: () => void;
}

const ReaderSettingsPanel: React.FC<ReaderSettingsPanelProps> = ({ themeVars, onClose }) => {
  const settings = useReaderSettingsStore();

  return (
    <div
      className="absolute top-20 right-8 bottom-8 w-80 z-30 shadow-2xl animate-in slide-in-from-right-4 fade-in duration-300 rounded-2xl border flex flex-col overflow-hidden ring-1 ring-black/5 dark:ring-white/10"
      style={floatingPanelStyle(themeVars.bg, themeVars.border)}
    >
      <div className="flex flex-col h-full">
        <div
          className="flex items-center justify-between px-6 py-4 border-b transition-all duration-200"
          style={{ background: themeVars.bg, borderColor: themeVars.border }}
        >
          <h3 className="text-sm font-bold flex items-center gap-2 opacity-90">
            <Settings size={16} className="text-brand-500" />
            阅读设置
          </h3>
          <button
            onClick={onClose}
            className="p-1.5 rounded-lg hover:bg-black/5 dark:hover:bg-white/10 transition-colors text-gray-400 hover:text-gray-600 dark:hover:text-gray-200"
          >
            <X size={18} />
          </button>
        </div>

        <div className="flex-1 overflow-y-auto custom-scrollbar p-6 space-y-8">
          {/* 字号与行高 */}
          <div className="space-y-5">
            <SettingSlider
              icon={<Type size={14} />}
              label="字体大小"
              value={`${settings.fontSize}px`}
              progress={Math.min(100, Math.max(0, (settings.fontSize - 12) / 12 * 100))}
              onDecrease={() => settings.setFontSize(Math.max(12, settings.fontSize - 1))}
              onIncrease={() => settings.setFontSize(Math.min(32, settings.fontSize + 1))}
            />
            <SettingSlider
              icon={<AlignJustify size={14} />}
              label="行间距"
              value={settings.lineHeight.toFixed(1)}
              progress={Math.min(100, Math.max(0, (settings.lineHeight - 1) / 1 * 100))}
              onDecrease={() => settings.setLineHeight(Math.max(1, settings.lineHeight - 0.1))}
              onIncrease={() => settings.setLineHeight(Math.min(3, settings.lineHeight + 0.1))}
            />
            <SettingSlider
              icon={<Maximize2 size={14} />}
              label="正文宽度"
              value={`${settings.contentWidth}px`}
              progress={Math.min(100, Math.max(0, (settings.contentWidth - 600) / 600 * 100))}
              onDecrease={() => settings.setContentWidth(Math.max(600, settings.contentWidth - 40))}
              onIncrease={() => settings.setContentWidth(Math.min(1200, settings.contentWidth + 40))}
            />
          </div>

          {/* 字体选择 */}
          <div className="space-y-3">
            <div className="text-[11px] font-bold uppercase tracking-wider opacity-40 flex items-center gap-1.5 px-1">
              字体家族
            </div>
            <div className="grid grid-cols-1 gap-2">
              {(['serif', 'sans', 'mono'] as ReaderFontFamily[]).map(f => (
                <button
                  key={f}
                  onClick={() => settings.setFontFamily(f)}
                  className="px-4 py-3 rounded-xl text-sm transition-all text-left flex items-center justify-between group border"
                  style={{
                    borderColor: settings.fontFamily === f ? themeVars.accent : themeVars.border,
                    background: settings.fontFamily === f ? `${themeVars.accent}08` : 'transparent',
                    color: settings.fontFamily === f ? themeVars.accent : themeVars.text,
                    fontWeight: settings.fontFamily === f ? 600 : 400,
                  }}
                >
                  <span style={{ fontFamily: FONT_FAMILIES[f] }}>
                    {f === 'serif' ? '优雅衬线' : f === 'sans' ? '现代无衬线' : '极客等宽'}
                  </span>
                  {settings.fontFamily === f && <Check size={14} />}
                </button>
              ))}
            </div>
          </div>

          {/* 主题选择 */}
          <div className="space-y-3">
            <div className="text-[11px] font-bold uppercase tracking-wider opacity-40 flex items-center gap-1.5 px-1">
              视觉主题
            </div>
            <div className="grid grid-cols-2 gap-2">
              {(Object.keys(THEMES) as ReaderTheme[]).map(t => (
                <button
                  key={t}
                  onClick={() => settings.setTheme(t)}
                  className="flex flex-col gap-2 p-3 rounded-xl border transition-all active:scale-[0.98] group relative overflow-hidden"
                  style={{
                    borderColor: settings.theme === t ? themeVars.accent : themeVars.border,
                    background: THEMES[t].bg,
                  }}
                >
                  <div className="flex items-center justify-between w-full">
                    <div 
                      className="w-4 h-4 rounded-full border shadow-sm flex items-center justify-center" 
                      style={{ background: THEMES[t].accent, borderColor: THEMES[t].border }}
                    >
                      {settings.theme === t && <Check size={10} className="text-white" />}
                    </div>
                  </div>
                  <span className="text-[13px]" style={{ color: THEMES[t].text, fontWeight: settings.theme === t ? 600 : 400 }}>
                    {t === 'light' ? '明亮' : t === 'warm' ? '复古' : t === 'dark' ? '暗夜' : '护眼'}
                  </span>
                </button>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

// ─── 设置滑块子组件 ─────────────────────────────────────────────────────────────

interface SettingSliderProps {
  icon: React.ReactNode;
  label: string;
  value: string;
  progress: number;
  onDecrease: () => void;
  onIncrease: () => void;
}

const SettingSlider: React.FC<SettingSliderProps> = ({ icon, label, value, progress, onDecrease, onIncrease }) => (
  <div className="space-y-3">
    <div className="flex items-center justify-between px-1">
      <span className="text-[11px] font-bold uppercase tracking-wider opacity-40 flex items-center gap-2">
        {icon}
        {label}
      </span>
      <span className="text-xs font-mono font-bold opacity-80">{value}</span>
    </div>
    <div className="flex items-center gap-2 group">
      <button 
        onClick={onDecrease} 
        className="w-8 h-8 flex items-center justify-center rounded-lg border border-black/5 dark:border-white/10 hover:bg-black/5 dark:hover:bg-white/5 transition-all active:scale-90"
      >
        <Minus size={14} />
      </button>
      <div className="flex-1 h-1.5 bg-black/5 dark:bg-white/10 rounded-full relative overflow-hidden">
        <div 
          className="absolute top-0 left-0 h-full bg-brand-500 rounded-full transition-all duration-300" 
          style={{ width: `${progress}%` }} 
        />
      </div>
      <button 
        onClick={onIncrease} 
        className="w-8 h-8 flex items-center justify-center rounded-lg border border-black/5 dark:border-white/10 hover:bg-black/5 dark:hover:bg-white/5 transition-all active:scale-90"
      >
        <Plus size={14} />
      </button>
    </div>
  </div>
);

export default ReaderSettingsPanel;
