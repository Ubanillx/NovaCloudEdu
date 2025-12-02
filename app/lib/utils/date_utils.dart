/// 日期工具类
/// 日期格式化、计算等
library;

class AppDateUtils {
  AppDateUtils._();

  /// 格式化日期为 yyyy-MM-dd
  static String formatDate(DateTime date) {
    return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
  }

  /// 格式化日期时间为 yyyy-MM-dd HH:mm:ss
  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} ${_twoDigits(date.hour)}:${_twoDigits(date.minute)}:${_twoDigits(date.second)}';
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
