import 'package:flutter/foundation.dart';
import 'package:nova_api/nova_api.dart';
import '../../../../core/database/database_service.dart';

/// 每日单词本地存储服务
class DailyWordStorageService {
  static final DailyWordStorageService _instance = DailyWordStorageService._internal();
  factory DailyWordStorageService() => _instance;
  DailyWordStorageService._internal();

  final DatabaseService _dbService = DatabaseService();

  /// 获取用户设置
  Future<DailyWordSettings> getSettings() async {
    try {
      final db = await _dbService.database;
      final results = await db.query(
        'daily_word_settings',
        limit: 1,
        orderBy: 'id DESC',
      );

      if (results.isNotEmpty) {
        final row = results.first;
        return DailyWordSettings(
          wordSize: row['word_size'] as int? ?? 10,
          wordType: row['word_type'] as String?,
        );
      }
    } catch (e) {
      debugPrint('获取每日单词设置失败: $e');
    }
    return DailyWordSettings(wordSize: 10, wordType: null);
  }

  /// 保存用户设置
  Future<void> saveSettings(int wordSize, String? wordType) async {
    try {
      final db = await _dbService.database;
      final now = DateTime.now().toIso8601String();

      // 先删除旧设置
      await db.delete('daily_word_settings');

      // 插入新设置
      await db.insert('daily_word_settings', {
        'word_size': wordSize,
        'word_type': wordType,
        'updated_at': now,
      });
    } catch (e) {
      debugPrint('保存每日单词设置失败: $e');
    }
  }

  /// 获取今日缓存的单词
  Future<List<CachedDailyWord>> getCachedWords() async {
    try {
      final db = await _dbService.database;
      final today = _getTodayDateString();

      final results = await db.query(
        'daily_word_cache',
        where: 'cache_date = ?',
        whereArgs: [today],
        orderBy: 'display_order ASC',
      );

      return results.map((row) => CachedDailyWord.fromMap(row)).toList();
    } catch (e) {
      debugPrint('获取缓存单词失败: $e');
      return [];
    }
  }

  /// 缓存单词列表
  Future<void> cacheWords(List<DailyWordResponse> words) async {
    try {
      final db = await _dbService.database;
      final today = _getTodayDateString();

      // 清除今日之前的缓存
      await db.delete(
        'daily_word_cache',
        where: 'cache_date != ?',
        whereArgs: [today],
      );

      // 清除今日缓存
      await db.delete(
        'daily_word_cache',
        where: 'cache_date = ?',
        whereArgs: [today],
      );

      // 批量插入新缓存
      final batch = db.batch();
      for (var i = 0; i < words.length; i++) {
        final word = words[i];
        batch.insert('daily_word_cache', {
          'word_id': word.id,
          'word': word.word,
          'pronunciation_us': word.pronunciationUs,
          'pronunciation_uk': word.pronunciationUk,
          'audio_url_us': word.audioUrlUs,
          'audio_url_uk': word.audioUrlUk,
          'translation': word.translation,
          'example': word.example,
          'example_translation': word.exampleTranslation,
          'difficulty': word.difficulty,
          'difficulty_desc': word.difficultyDesc,
          'category': word.category,
          'notes': word.notes,
          'publish_date': word.publishDate?.toString(),
          'cache_date': today,
          'display_order': i,
        });
      }
      await batch.commit(noResult: true);
    } catch (e) {
      debugPrint('缓存单词失败: $e');
    }
  }

  /// 检查今日是否有缓存
  Future<bool> hasTodayCache() async {
    try {
      final db = await _dbService.database;
      final today = _getTodayDateString();

      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM daily_word_cache WHERE cache_date = ?',
        [today],
      );

      return (result.first['count'] as int) > 0;
    } catch (e) {
      debugPrint('检查缓存失败: $e');
      return false;
    }
  }

  /// 获取今日日期字符串
  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// 清除所有缓存
  Future<void> clearCache() async {
    try {
      final db = await _dbService.database;
      await db.delete('daily_word_cache');
    } catch (e) {
      debugPrint('清除缓存失败: $e');
    }
  }
}

/// 每日单词设置
class DailyWordSettings {
  final int wordSize;
  final String? wordType;

  DailyWordSettings({
    required this.wordSize,
    this.wordType,
  });
}

/// 缓存的每日单词
class CachedDailyWord {
  final int? id;
  final int wordId;
  final String word;
  final String? pronunciationUs;
  final String? pronunciationUk;
  final String? audioUrlUs;
  final String? audioUrlUk;
  final String? translation;
  final String? example;
  final String? exampleTranslation;
  final int? difficulty;
  final String? difficultyDesc;
  final String? category;
  final String? notes;
  final String? publishDate;
  final String cacheDate;
  final int displayOrder;

  CachedDailyWord({
    this.id,
    required this.wordId,
    required this.word,
    this.pronunciationUs,
    this.pronunciationUk,
    this.audioUrlUs,
    this.audioUrlUk,
    this.translation,
    this.example,
    this.exampleTranslation,
    this.difficulty,
    this.difficultyDesc,
    this.category,
    this.notes,
    this.publishDate,
    required this.cacheDate,
    this.displayOrder = 0,
  });

  factory CachedDailyWord.fromMap(Map<String, dynamic> map) {
    return CachedDailyWord(
      id: map['id'] as int?,
      wordId: map['word_id'] as int,
      word: map['word'] as String,
      pronunciationUs: map['pronunciation_us'] as String?,
      pronunciationUk: map['pronunciation_uk'] as String?,
      audioUrlUs: map['audio_url_us'] as String?,
      audioUrlUk: map['audio_url_uk'] as String?,
      translation: map['translation'] as String?,
      example: map['example'] as String?,
      exampleTranslation: map['example_translation'] as String?,
      difficulty: map['difficulty'] as int?,
      difficultyDesc: map['difficulty_desc'] as String?,
      category: map['category'] as String?,
      notes: map['notes'] as String?,
      publishDate: map['publish_date'] as String?,
      cacheDate: map['cache_date'] as String,
      displayOrder: map['display_order'] as int? ?? 0,
    );
  }

  /// 转换为DailyWordResponse
  DailyWordResponse toDailyWordResponse() {
    return DailyWordResponse((b) => b
      ..id = wordId
      ..word = word
      ..pronunciationUs = pronunciationUs
      ..pronunciationUk = pronunciationUk
      ..audioUrlUs = audioUrlUs
      ..audioUrlUk = audioUrlUk
      ..translation = translation
      ..example = example
      ..exampleTranslation = exampleTranslation
      ..difficulty = difficulty
      ..difficultyDesc = difficultyDesc
      ..category = category
      ..notes = notes);
  }
}
