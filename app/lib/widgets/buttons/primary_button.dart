/// 主按钮组件
/// 使用 TDesign Button 组件
library;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// 主要按钮
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool disabled;
  final double? width;
  final TDButtonSize size;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.isLoading = false,
    this.disabled = false,
    this.width,
    this.size = TDButtonSize.large,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TDButton(
        text: text,
        type: TDButtonType.fill,
        theme: TDButtonTheme.primary,
        size: size,
        isBlock: true,
        disabled: disabled || isLoading,
        onTap: isLoading ? null : onTap,
        icon: isLoading ? TDIcons.loading : null,
      ),
    );
  }
}

/// 次要按钮
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool disabled;
  final TDButtonSize size;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.disabled = false,
    this.size = TDButtonSize.large,
  });

  @override
  Widget build(BuildContext context) {
    return TDButton(
      text: text,
      type: TDButtonType.outline,
      theme: TDButtonTheme.primary,
      size: size,
      isBlock: true,
      disabled: disabled,
      onTap: onTap,
    );
  }
}

/// 文字按钮
class TextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool disabled;
  final TDButtonSize size;

  const TextButton({
    super.key,
    required this.text,
    this.onTap,
    this.disabled = false,
    this.size = TDButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return TDButton(
      text: text,
      type: TDButtonType.text,
      theme: TDButtonTheme.primary,
      size: size,
      disabled: disabled,
      onTap: onTap,
    );
  }
}

/// 危险按钮
class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool disabled;
  final TDButtonSize size;

  const DangerButton({
    super.key,
    required this.text,
    this.onTap,
    this.disabled = false,
    this.size = TDButtonSize.large,
  });

  @override
  Widget build(BuildContext context) {
    return TDButton(
      text: text,
      type: TDButtonType.fill,
      theme: TDButtonTheme.danger,
      size: size,
      isBlock: true,
      disabled: disabled,
      onTap: onTap,
    );
  }
}
