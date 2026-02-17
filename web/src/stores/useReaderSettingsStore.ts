import { create } from 'zustand';

export type ReaderTheme = 'light' | 'warm' | 'dark' | 'green';
export type ReaderFontFamily = 'serif' | 'sans' | 'mono';

interface ReaderSettings {
  fontSize: number;
  lineHeight: number;
  fontFamily: ReaderFontFamily;
  theme: ReaderTheme;
  contentWidth: number;
}

interface ReaderSettingsStore extends ReaderSettings {
  setFontSize: (size: number) => void;
  setLineHeight: (height: number) => void;
  setFontFamily: (family: ReaderFontFamily) => void;
  setTheme: (theme: ReaderTheme) => void;
  setContentWidth: (width: number) => void;
}

const STORAGE_KEY = 'reader_settings';

const defaultSettings: ReaderSettings = {
  fontSize: 18,
  lineHeight: 1.8,
  fontFamily: 'serif',
  theme: 'light',
  contentWidth: 720,
};

function loadSettings(): ReaderSettings {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) {
      return { ...defaultSettings, ...JSON.parse(raw) };
    }
  } catch { /* ignore */ }
  return { ...defaultSettings };
}

function saveSettings(settings: ReaderSettings) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(settings));
  } catch { /* ignore */ }
}

export const useReaderSettingsStore = create<ReaderSettingsStore>((set, get) => ({
  ...loadSettings(),

  setFontSize: (fontSize: number) => {
    const clamped = Math.max(14, Math.min(28, fontSize));
    set({ fontSize: clamped });
    saveSettings({ ...get(), fontSize: clamped });
  },

  setLineHeight: (lineHeight: number) => {
    const clamped = Math.max(1.4, Math.min(2.4, lineHeight));
    set({ lineHeight: clamped });
    saveSettings({ ...get(), lineHeight: clamped });
  },

  setFontFamily: (fontFamily: ReaderFontFamily) => {
    set({ fontFamily });
    saveSettings({ ...get(), fontFamily });
  },

  setTheme: (theme: ReaderTheme) => {
    set({ theme });
    saveSettings({ ...get(), theme });
  },

  setContentWidth: (contentWidth: number) => {
    const clamped = Math.max(560, Math.min(960, contentWidth));
    set({ contentWidth: clamped });
    saveSettings({ ...get(), contentWidth: clamped });
  },
}));
