/// 学习计划模型
class StudyPlan {
  final int? id;
  final String title;
  final String? description;
  final DateTime targetDate;
  final bool isCompleted;
  final DateTime? completedAt;
  final int priority; // 0: 普通, 1: 重要, 2: 紧急
  final DateTime createdAt;
  final DateTime updatedAt;

  StudyPlan({
    this.id,
    required this.title,
    this.description,
    required this.targetDate,
    this.isCompleted = false,
    this.completedAt,
    this.priority = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// 从数据库 Map 创建
  factory StudyPlan.fromMap(Map<String, dynamic> map) {
    return StudyPlan(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String?,
      targetDate: DateTime.parse(map['target_date'] as String),
      isCompleted: (map['is_completed'] as int) == 1,
      completedAt: map['completed_at'] != null
          ? DateTime.parse(map['completed_at'] as String)
          : null,
      priority: map['priority'] as int? ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// 转换为数据库 Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'target_date': _formatDate(targetDate),
      'is_completed': isCompleted ? 1 : 0,
      'completed_at': completedAt?.toIso8601String(),
      'priority': priority,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// 格式化日期为 yyyy-MM-dd
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// 复制并修改
  StudyPlan copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? targetDate,
    bool? isCompleted,
    DateTime? completedAt,
    int? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudyPlan(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      targetDate: targetDate ?? this.targetDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// 获取优先级文本
  String get priorityText {
    switch (priority) {
      case 2:
        return '紧急';
      case 1:
        return '重要';
      default:
        return '普通';
    }
  }

  /// 是否是今日计划
  bool get isToday {
    final now = DateTime.now();
    return targetDate.year == now.year &&
        targetDate.month == now.month &&
        targetDate.day == now.day;
  }

  @override
  String toString() {
    return 'StudyPlan(id: $id, title: $title, targetDate: $targetDate, isCompleted: $isCompleted)';
  }
}
