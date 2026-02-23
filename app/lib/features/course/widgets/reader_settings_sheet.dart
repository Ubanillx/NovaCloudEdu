import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// 翻页模式
enum PageTurnMode {
  vertical,    // 竖直滚动
  horizontal,  // 水平滑动
  simulated,   // 仿真翻页
}

/// 阅读主题定义
enum ReaderTheme { light, warm, dark, green }

/// 阅读主题颜色
class ReaderThemeColors {
  final Color bg;
  final Color text;
  final Color accent;
  final Color card;
  final Color border;
  final Color muted;

  const ReaderThemeColors({
    required this.bg,
    required this.text,
    required this.accent,
    required this.card,
    required this.border,
    required this.muted,
  });
}

/// 阅读主题映射（对应 web 端 readerConstants.ts 的 THEMES）
const Map<ReaderTheme, ReaderThemeColors> readerThemes = {
  ReaderTheme.light: ReaderThemeColors(
    bg: Color(0xFFFFFFFF),
    text: Color(0xFF111827),
    accent: Color(0xFF2563EB),
    card: Color(0xFFF3F4F6),
    border: Color(0xFFF3F4F6),
    muted: Color(0xFF6B7280),
  ),
  ReaderTheme.warm: ReaderThemeColors(
    bg: Color(0xFFFAF5E8),
    text: Color(0xFF3D3322),
    accent: Color(0xFF92400E),
    card: Color(0xFFF0E6D0),
    border: Color(0xFFE6D5B8),
    muted: Color(0xFF8B7355),
  ),
  ReaderTheme.dark: ReaderThemeColors(
    bg: Color(0xFF0F172A),
    text: Color(0xFFE2E8F0),
    accent: Color(0xFF38BDF8),
    card: Color(0xFF1E293B),
    border: Color(0xFF334155),
    muted: Color(0xFF94A3B8),
  ),
  ReaderTheme.green: ReaderThemeColors(
    bg: Color(0xFFF0FDF4),
    text: Color(0xFF166534),
    accent: Color(0xFF16A34A),
    card: Color(0xFFDCFCE7),
    border: Color(0xFFBBF7D0),
    muted: Color(0xFF15803D),
  ),
};

/// 阅读设置数据
class ReaderSettings {
  double fontSize;
  double lineHeight;
  ReaderTheme theme;
  bool isSerif;
  PageTurnMode pageTurnMode;

  ReaderSettings({
    this.fontSize = 18,
    this.lineHeight = 1.8,
    this.theme = ReaderTheme.light,
    this.isSerif = false,
    this.pageTurnMode = PageTurnMode.vertical,
  });

  ReaderThemeColors get themeColors => readerThemes[theme]!;
}

/// 阅读设置底部面板
class ReaderSettingsSheet extends StatefulWidget {
  final ReaderSettings settings;
  final VoidCallback onChanged;

  const ReaderSettingsSheet({
    super.key,
    required this.settings,
    required this.onChanged,
  });

  @override
  State<ReaderSettingsSheet> createState() => _ReaderSettingsSheetState();
}

class _ReaderSettingsSheetState extends State<ReaderSettingsSheet> {
  ReaderSettings get s => widget.settings;

  void _notify() {
    setState(() {});
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final tc = s.themeColors;
    return Container(
      decoration: BoxDecoration(
        color: tc.bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 拖拽指示条
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: tc.muted.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // 标题
              Text(
                '阅读设置',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: tc.text),
              ),
              const SizedBox(height: 20),

              // 字体大小
              _buildSection(
                '字体大小',
                tc,
                Row(
                  children: [
                    _buildStepButton(PhosphorIcons.minus(), () {
                      if (s.fontSize > 14) { s.fontSize -= 1; _notify(); }
                    }, tc),
                    Expanded(
                      child: Slider(
                        value: s.fontSize,
                        min: 14,
                        max: 28,
                        divisions: 14,
                        activeColor: tc.accent,
                        inactiveColor: tc.border,
                        onChanged: (v) { s.fontSize = v; _notify(); },
                      ),
                    ),
                    _buildStepButton(PhosphorIcons.plus(), () {
                      if (s.fontSize < 28) { s.fontSize += 1; _notify(); }
                    }, tc),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 32,
                      child: Text(
                        '${s.fontSize.toInt()}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: tc.text),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 行间距
              _buildSection(
                '行间距',
                tc,
                Row(
                  children: [
                    _buildStepButton(PhosphorIcons.minus(), () {
                      if (s.lineHeight > 1.2) { s.lineHeight = (s.lineHeight - 0.1).clamp(1.2, 2.5); _notify(); }
                    }, tc),
                    Expanded(
                      child: Slider(
                        value: s.lineHeight,
                        min: 1.2,
                        max: 2.5,
                        divisions: 13,
                        activeColor: tc.accent,
                        inactiveColor: tc.border,
                        onChanged: (v) { s.lineHeight = v; _notify(); },
                      ),
                    ),
                    _buildStepButton(PhosphorIcons.plus(), () {
                      if (s.lineHeight < 2.5) { s.lineHeight = (s.lineHeight + 0.1).clamp(1.2, 2.5); _notify(); }
                    }, tc),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 32,
                      child: Text(
                        s.lineHeight.toStringAsFixed(1),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: tc.text),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 字体选择
              _buildSection(
                '字体',
                tc,
                Row(
                  children: [
                    _buildFontButton('无衬线', false, tc),
                    const SizedBox(width: 10),
                    _buildFontButton('衬线', true, tc),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 翻页模式
              _buildSection(
                '翻页模式',
                tc,
                Row(
                  children: [
                    _buildPageTurnModeButton('竖直滚动', PageTurnMode.vertical, PhosphorIcons.arrowsDownUp(), tc),
                    const SizedBox(width: 10),
                    _buildPageTurnModeButton('水平滑动', PageTurnMode.horizontal, PhosphorIcons.arrowsLeftRight(), tc),
                    const SizedBox(width: 10),
                    _buildPageTurnModeButton('仿真翻页', PageTurnMode.simulated, PhosphorIcons.bookOpenText(), tc),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 主题选择
              _buildSection(
                '主题',
                tc,
                Row(
                  children: [
                    _buildThemeButton('明亮', ReaderTheme.light, const Color(0xFFFFFFFF), const Color(0xFF111827)),
                    const SizedBox(width: 10),
                    _buildThemeButton('复古', ReaderTheme.warm, const Color(0xFFFAF5E8), const Color(0xFF3D3322)),
                    const SizedBox(width: 10),
                    _buildThemeButton('暗夜', ReaderTheme.dark, const Color(0xFF0F172A), const Color(0xFFE2E8F0)),
                    const SizedBox(width: 10),
                    _buildThemeButton('护眼', ReaderTheme.green, const Color(0xFFF0FDF4), const Color(0xFF166534)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, ReaderThemeColors tc, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: tc.muted),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildStepButton(IconData icon, VoidCallback onTap, ReaderThemeColors tc) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: tc.card,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: tc.text),
      ),
    );
  }

  Widget _buildFontButton(String label, bool serif, ReaderThemeColors tc) {
    final isActive = s.isSerif == serif;
    return Expanded(
      child: GestureDetector(
        onTap: () { s.isSerif = serif; _notify(); },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? tc.accent.withValues(alpha: 0.1) : tc.card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? tc.accent.withValues(alpha: 0.3) : tc.border,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                fontFamily: serif ? 'serif' : null,
                color: isActive ? tc.accent : tc.text,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageTurnModeButton(String label, PageTurnMode mode, IconData icon, ReaderThemeColors tc) {
    final isActive = s.pageTurnMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () { s.pageTurnMode = mode; _notify(); },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? tc.accent.withValues(alpha: 0.1) : tc.card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? tc.accent.withValues(alpha: 0.3) : tc.border,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: isActive ? tc.accent : tc.muted),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive ? tc.accent : tc.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton(String label, ReaderTheme theme, Color bg, Color text) {
    final isActive = s.theme == theme;
    final tc = s.themeColors;
    return Expanded(
      child: GestureDetector(
        onTap: () { s.theme = theme; _notify(); },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? tc.accent : Colors.grey.withValues(alpha: 0.3),
              width: isActive ? 2 : 1,
            ),
            boxShadow: isActive
                ? [BoxShadow(color: tc.accent.withValues(alpha: 0.2), blurRadius: 8)]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
