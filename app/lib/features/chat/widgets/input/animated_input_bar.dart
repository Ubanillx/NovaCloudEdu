import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../config/app_theme.dart';

class AnimatedInputBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttachmentTap;
  final VoidCallback onVoiceTap;
  final VoidCallback? onEmojiTap;
  final ValueChanged<String>? onChanged;
  final bool isSending;
  final bool showMorePanel;
  final bool showEmojiPicker;
  final String hintText;

  const AnimatedInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachmentTap,
    required this.onVoiceTap,
    this.onEmojiTap,
    this.onChanged,
    this.isSending = false,
    this.showMorePanel = false,
    this.showEmojiPicker = false,
    this.hintText = '输入消息...',
  });

  @override
  State<AnimatedInputBar> createState() => _AnimatedInputBarState();
}

class _AnimatedInputBarState extends State<AnimatedInputBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _flipAnim;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.trim().isNotEmpty;
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutBack),
    );

    if (_hasText) {
      _animController.value = 1.0;
    }

    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasTextNow = widget.controller.text.trim().isNotEmpty;
    if (hasTextNow != _hasText) {
      if (mounted) {
        setState(() => _hasText = hasTextNow);
      }
      if (hasTextNow) {
        _animController.forward();
      } else {
        _animController.reverse();
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
        bottom: widget.showEmojiPicker 
            ? 0  // 表情选择器展开时，完全移除底部间距
            : (widget.showMorePanel ? 8 : (bottomPadding > 0 ? bottomPadding + 8 : 12)),
      ),
      decoration: BoxDecoration(
        color: colors.surface.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.2 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 语音按钮
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: GestureDetector(
              onTap: widget.onVoiceTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Icon(PhosphorIcons.microphone(), color: colors.textSecondary, size: 22),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // 表情按钮
          if (widget.onEmojiTap != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: GestureDetector(
                onTap: widget.onEmojiTap,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.showEmojiPicker ? AppTheme.brand : colors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIcons.smiley(),
                    color: widget.showEmojiPicker ? Colors.white : colors.textSecondary,
                    size: 22,
                  ),
                ),
              ),
            ),
          if (widget.onEmojiTap != null) const SizedBox(width: 10),
          // 弹性跟随输入的 TextField
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              constraints: const BoxConstraints(minHeight: 48, maxHeight: 120),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors.surfaceVariant.withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _hasText ? AppTheme.brand : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Scrollbar(
                child: TextField(
                  controller: widget.controller,
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) {
                    if (_hasText) widget.onSend();
                  },
                  onChanged: widget.onChanged,
                  cursorColor: AppTheme.brand,
                  cursorWidth: 2,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: colors.textTertiary,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // 右侧动态变换按钮：平时为附件“+”，有文字时翻转为“发送”
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: AnimatedBuilder(
              animation: _flipAnim,
              builder: (context, child) {
                // value为0时显示附件，为1时显示发送，通过3D翻转
                if (_flipAnim.value < 0.5) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(_flipAnim.value * math.pi),
                    child: _buildAttachButton(colors),
                  );
                } else {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY((_flipAnim.value - 1) * math.pi),
                    child: _buildSendButton(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachButton(AppColors colors) {
    return GestureDetector(
      onTap: widget.onAttachmentTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: widget.showMorePanel ? AppTheme.brand : colors.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: Icon(
          PhosphorIcons.plus(),
          color: widget.showMorePanel ? Colors.white : colors.textSecondary,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return GestureDetector(
      onTap: () {
        if (!widget.isSending) widget.onSend();
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.brand, AppTheme.brand2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: widget.isSending
              ? null
              : [
                  BoxShadow(
                    color: AppTheme.brand.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: widget.isSending
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(PhosphorIcons.paperPlaneRight(), color: Colors.white, size: 22),
      ),
    );
  }
}
