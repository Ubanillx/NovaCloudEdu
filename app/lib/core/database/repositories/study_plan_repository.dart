import 'package:sqflite/sqflite.dart';
import '../database_service.dart';
import '../models/study_plan.dart';

/// 学习计划数据仓库
class StudyPlanRepository {
  final DatabaseService _databaseService = DatabaseService();

  /// 添加学习计划
  Future<int> insert(StudyPlan plan) async {
    final db = await _databaseService.database;
    return await db.insert('study_plans', plan.toMap());
  }

  /// 更新学习计划
  Future<int> update(StudyPlan plan) async {
    final db = await _databaseService.database;
    return await db.update(
      'study_plans',
      plan.toMap(),
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }

  /// 删除学习计划
  Future<int> delete(int id) async {
    final db = await _databaseService.database;
    return await db.delete(
      'study_plans',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 根据 ID 获取学习计划
  Future<StudyPlan?> getById(int id) async {
    final db = await _databaseService.database;
    final maps = await db.query(
      'study_plans',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return StudyPlan.fromMap(maps.first);
    }
    return null;
  }

  /// 获取指定日期的学习计划
  Future<List<StudyPlan>> getByDate(DateTime date) async {
    final db = await _databaseService.database;
    final dateStr = _formatDate(date);
    final maps = await db.query(
      'study_plans',
      where: 'target_date = ?',
      whereArgs: [dateStr],
      orderBy: 'priority DESC, created_at ASC',
    );
    return maps.map((map) => StudyPlan.fromMap(map)).toList();
  }

  /// 获取今日学习计划
  Future<List<StudyPlan>> getTodayPlans() async {
    return getByDate(DateTime.now());
  }

  /// 获取所有学习计划（分页）
  Future<List<StudyPlan>> getAll({int page = 1, int pageSize = 20}) async {
    final db = await _databaseService.database;
    final offset = (page - 1) * pageSize;
    final maps = await db.query(
      'study_plans',
      orderBy: 'target_date DESC, priority DESC',
      limit: pageSize,
      offset: offset,
    );
    return maps.map((map) => StudyPlan.fromMap(map)).toList();
  }

  /// 获取历史计划（按日期分组）
  Future<Map<String, List<StudyPlan>>> getHistoryGroupedByDate({
    int limit = 30,
  }) async {
    final db = await _databaseService.database;
    final maps = await db.query(
      'study_plans',
      orderBy: 'target_date DESC, priority DESC',
      limit: limit,
    );
    
    final plans = maps.map((map) => StudyPlan.fromMap(map)).toList();
    final grouped = <String, List<StudyPlan>>{};
    
    for (final plan in plans) {
      final dateKey = _formatDate(plan.targetDate);
      grouped.putIfAbsent(dateKey, () => []).add(plan);
    }
    
    return grouped;
  }

  /// 标记计划完成/未完成
  Future<int> toggleComplete(int id, bool isCompleted) async {
    final db = await _databaseService.database;
    return await db.update(
      'study_plans',
      {
        'is_completed': isCompleted ? 1 : 0,
        'completed_at': isCompleted ? DateTime.now().toIso8601String() : null,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 获取今日完成数量
  Future<int> getTodayCompletedCount() async {
    final db = await _databaseService.database;
    final dateStr = _formatDate(DateTime.now());
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM study_plans WHERE target_date = ? AND is_completed = 1',
      [dateStr],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// 获取今日总数量
  Future<int> getTodayTotalCount() async {
    final db = await _databaseService.database;
    final dateStr = _formatDate(DateTime.now());
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM study_plans WHERE target_date = ?',
      [dateStr],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// 格式化日期
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
