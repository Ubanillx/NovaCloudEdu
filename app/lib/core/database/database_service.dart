import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// 数据库服务单例
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'nova_cloud_edu.db');

    return await openDatabase(
      path,
      version: 4,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // 创建学习计划表
    await db.execute('''
      CREATE TABLE study_plans (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        target_date TEXT NOT NULL,
        is_completed INTEGER DEFAULT 0,
        completed_at TEXT,
        priority INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // 创建索引
    await db.execute('CREATE INDEX idx_study_plans_target_date ON study_plans(target_date)');
    await db.execute('CREATE INDEX idx_study_plans_is_completed ON study_plans(is_completed)');

    // 创建聊天消息表
    await _createChatTables(db);
    
    // 创建群聊相关表
    await _createGroupTables(db);
    
    // 创建每日单词相关表
    await _createDailyWordTables(db);
  }

  Future<void> _createChatTables(Database db) async {
    // 聊天消息表
    await db.execute('''
      CREATE TABLE chat_messages (
        id INTEGER PRIMARY KEY,
        message_id INTEGER UNIQUE,
        sender_id INTEGER NOT NULL,
        sender_name TEXT,
        sender_avatar TEXT,
        receiver_id INTEGER NOT NULL,
        content TEXT,
        type TEXT DEFAULT 'TEXT',
        is_read INTEGER DEFAULT 0,
        is_sent INTEGER DEFAULT 1,
        create_time TEXT NOT NULL,
        sync_status INTEGER DEFAULT 0
      )
    ''');

    // 聊天会话表
    await db.execute('''
      CREATE TABLE chat_sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id INTEGER UNIQUE,
        partner_id INTEGER NOT NULL,
        partner_name TEXT,
        partner_avatar TEXT,
        last_message TEXT,
        last_message_time TEXT,
        unread_count INTEGER DEFAULT 0,
        updated_at TEXT NOT NULL
      )
    ''');

    // 创建索引
    await db.execute('CREATE INDEX idx_chat_messages_sender ON chat_messages(sender_id)');
    await db.execute('CREATE INDEX idx_chat_messages_receiver ON chat_messages(receiver_id)');
    await db.execute('CREATE INDEX idx_chat_messages_create_time ON chat_messages(create_time)');
    await db.execute('CREATE INDEX idx_chat_messages_sync ON chat_messages(sync_status)');
    await db.execute('CREATE INDEX idx_chat_sessions_partner ON chat_sessions(partner_id)');
    await db.execute('CREATE INDEX idx_chat_sessions_updated ON chat_sessions(updated_at)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 数据库升级逻辑
    if (oldVersion < 2) {
      await _createChatTables(db);
    }
    if (oldVersion < 3) {
      await _createGroupTables(db);
    }
    if (oldVersion < 4) {
      await _createDailyWordTables(db);
    }
  }

  Future<void> _createGroupTables(Database db) async {
    // 群组表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS chat_groups (
        id INTEGER PRIMARY KEY,
        group_id INTEGER UNIQUE,
        group_name TEXT NOT NULL,
        avatar TEXT,
        description TEXT,
        owner_id INTEGER,
        member_count INTEGER DEFAULT 0,
        announcement TEXT,
        announcement_time TEXT,
        mute INTEGER DEFAULT 0,
        create_time TEXT,
        updated_at TEXT NOT NULL
      )
    ''');

    // 群成员表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS group_members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        group_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        user_name TEXT,
        user_avatar TEXT,
        role INTEGER DEFAULT 0,
        join_time TEXT,
        UNIQUE(group_id, user_id)
      )
    ''');

    // 群消息表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS group_messages (
        id INTEGER PRIMARY KEY,
        message_id INTEGER UNIQUE,
        group_id INTEGER NOT NULL,
        sender_id INTEGER NOT NULL,
        sender_name TEXT,
        sender_avatar TEXT,
        content TEXT,
        type TEXT DEFAULT 'TEXT',
        reply_to INTEGER,
        create_time TEXT NOT NULL,
        sync_status INTEGER DEFAULT 0
      )
    ''');

    // 创建索引
    await db.execute('CREATE INDEX IF NOT EXISTS idx_chat_groups_group_id ON chat_groups(group_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_group_members_group ON group_members(group_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_group_members_user ON group_members(user_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_group_messages_group ON group_messages(group_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_group_messages_time ON group_messages(create_time)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_group_messages_sync ON group_messages(sync_status)');
  }

  Future<void> _createDailyWordTables(Database db) async {
    // 每日单词设置表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS daily_word_settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        word_size INTEGER DEFAULT 10,
        word_type TEXT,
        updated_at TEXT NOT NULL
      )
    ''');

    // 每日单词缓存表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS daily_word_cache (
        id INTEGER PRIMARY KEY,
        word_id INTEGER UNIQUE NOT NULL,
        word TEXT NOT NULL,
        pronunciation_us TEXT,
        pronunciation_uk TEXT,
        audio_url_us TEXT,
        audio_url_uk TEXT,
        translation TEXT,
        example TEXT,
        example_translation TEXT,
        difficulty INTEGER,
        difficulty_desc TEXT,
        category TEXT,
        notes TEXT,
        publish_date TEXT,
        cache_date TEXT NOT NULL,
        display_order INTEGER DEFAULT 0
      )
    ''');

    // 创建索引
    await db.execute('CREATE INDEX IF NOT EXISTS idx_daily_word_cache_date ON daily_word_cache(cache_date)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_daily_word_cache_order ON daily_word_cache(display_order)');
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
