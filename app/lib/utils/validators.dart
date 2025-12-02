/// 表单验证工具
/// 提供常用的表单验证方法
library;

class Validators {
  Validators._();

  /// 验证邮箱格式
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return '邮箱格式不正确';
    }
    return null;
  }

  /// 验证手机号格式
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入手机号';
    }
    final phoneRegex = RegExp(r'^1[3-9]\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return '手机号格式不正确';
    }
    return null;
  }

  /// 验证密码（至少6位）
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    if (value.length < 6) {
      return '密码至少6位';
    }
    return null;
  }
}
