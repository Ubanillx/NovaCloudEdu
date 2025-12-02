/// 输入框组件
/// 使用 TDesign Input 组件
library;

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// 通用输入框
class AppInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const AppInput({
    super.key,
    this.label,
    this.placeholder,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.errorText,
    this.maxLines = 1,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TDInput(
      controller: controller,
      leftLabel: label,
      hintText: placeholder,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}

/// 搜索输入框
class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;

  const SearchInput({
    super.key,
    this.controller,
    this.placeholder,
    this.onSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TDSearchBar(
      controller: controller,
      placeHolder: placeholder ?? '搜索',
      onSubmitted: onSubmitted,
      onTextChanged: onChanged,
    );
  }
}
