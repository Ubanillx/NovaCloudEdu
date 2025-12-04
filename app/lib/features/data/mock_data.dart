/// Mock数据层 - 模拟后端API数据
library;

// ==================== 首页相关数据 ====================

/// 公告
class Notice {
  final int id;
  final String title;
  final String content;
  final String date;

  const Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });
}

/// AI助手
class AiAssistant {
  final int id;
  final String name;
  final String description;
  final String avatar;

  const AiAssistant({
    required this.id,
    required this.name,
    required this.description,
    required this.avatar,
  });
}

/// 每日单词
class DailyWord {
  final int id;
  final String word;
  final String phonetic;
  final String translation;
  final String example;
  final bool isCollected;

  const DailyWord({
    required this.id,
    required this.word,
    required this.phonetic,
    required this.translation,
    required this.example,
    this.isCollected = false,
  });
}

/// 文章
class Article {
  final int id;
  final String title;
  final String brief;
  final String cover;
  final String category;
  final int readTime;

  const Article({
    required this.id,
    required this.title,
    required this.brief,
    required this.cover,
    required this.category,
    required this.readTime,
  });
}

// ==================== 课程相关数据 ====================

/// 课程
class Course {
  final int id;
  final String title;
  final String brief;
  final String cover;
  final String tag;
  final String? grade;
  final int duration;
  final int studentsCount;

  const Course({
    required this.id,
    required this.title,
    required this.brief,
    required this.cover,
    required this.tag,
    this.grade,
    required this.duration,
    required this.studentsCount,
  });
}

/// 课程分类
class CourseCategory {
  final int id;
  final String name;
  final String icon;

  const CourseCategory({
    required this.id,
    required this.name,
    required this.icon,
  });
}

// ==================== 聊天相关数据 ====================

/// 聊天会话
class ChatSession {
  final int id;
  final String name;
  final String avatar;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isAi;

  const ChatSession({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isAi = false,
  });
}

// ==================== 圈子相关数据 ====================

/// 帖子
class Post {
  final int id;
  final String title;
  final String content;
  final String authorName;
  final String authorAvatar;
  final String createTime;
  final int thumbNum;
  final int commentNum;
  final int favourNum;
  final List<String> images;
  bool hasThumb;
  bool hasFavour;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.authorAvatar,
    required this.createTime,
    required this.thumbNum,
    required this.commentNum,
    required this.favourNum,
    this.images = const [],
    this.hasThumb = false,
    this.hasFavour = false,
  });
}

// ==================== 个人中心相关数据 ====================

/// 用户信息
class UserProfile {
  final int id;
  final String username;
  final String avatar;
  final int level;
  final int daysLearned;
  final int streakDays;
  final int stars;
  final int badges;

  const UserProfile({
    required this.id,
    required this.username,
    required this.avatar,
    required this.level,
    required this.daysLearned,
    required this.streakDays,
    required this.stars,
    required this.badges,
  });
}

/// 学习目标
class LearningGoal {
  final int id;
  final String text;
  bool completed;

  LearningGoal({required this.id, required this.text, this.completed = false});
}

/// 成就徽章
class AchievementBadge {
  final int id;
  final String name;
  final String icon;
  final int color;

  const AchievementBadge({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

// ==================== Mock数据实例 ====================

class MockData {
  // 公告数据
  static const List<Notice> notices = [
    Notice(
      id: 1,
      title: '系统升级公告',
      content: '本系统将于今晚22:00进行升级维护，预计2小时',
      date: '2024-12-01',
    ),
    Notice(
      id: 2,
      title: '新课程上线',
      content: '全新AI英语口语课程已上线，欢迎体验',
      date: '2024-12-01',
    ),
  ];

  // AI助手数据
  static const List<AiAssistant> aiAssistants = [
    AiAssistant(
      id: 1,
      name: '英语教师 Emma',
      description: '专业英语教学，语法讲解',
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Emma',
    ),
    AiAssistant(
      id: 2,
      name: '口语伙伴 Mike',
      description: '日常对话，地道表达',
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Mike',
    ),
    AiAssistant(
      id: 3,
      name: '写作助手 Sarah',
      description: '作文指导，文章润色',
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah',
    ),
  ];

  // 每日单词
  static const DailyWord dailyWord = DailyWord(
    id: 1,
    word: 'Serendipity',
    phonetic: '/ˌserənˈdɪpəti/',
    translation: 'n. 意外发现珍奇事物的本领；机缘巧合',
    example: 'Finding that rare book was pure serendipity.',
  );

  // 文章数据
  static const List<Article> articles = [
    Article(
      id: 1,
      title: 'The Art of Learning',
      brief: '探索有效学习的技巧与方法',
      cover: 'https://picsum.photos/200/150?random=1',
      category: '学习方法',
      readTime: 5,
    ),
    Article(
      id: 2,
      title: 'English in Daily Life',
      brief: '日常生活中的英语应用场景',
      cover: 'https://picsum.photos/200/150?random=2',
      category: '日常英语',
      readTime: 8,
    ),
  ];

  // 课程分类
  static const List<CourseCategory> categories = [
    CourseCategory(id: 0, name: '推荐', icon: 'star'),
    CourseCategory(id: 1, name: '语文', icon: 'book'),
    CourseCategory(id: 2, name: '数学', icon: 'calculate'),
    CourseCategory(id: 3, name: '英语', icon: 'language'),
    CourseCategory(id: 4, name: '物理', icon: 'science'),
    CourseCategory(id: 5, name: '化学', icon: 'flask'),
  ];

  // 课程数据
  static const List<Course> courses = [
    Course(
      id: 1,
      title: '填空选择秒选大招合集',
      brief: '数学解题技巧，快速提分',
      cover: 'https://picsum.photos/300/200?random=10',
      tag: '数学',
      grade: '高一',
      duration: 30,
      studentsCount: 1234,
    ),
    Course(
      id: 2,
      title: '典型实验大题解答合集',
      brief: '物理实验题型全解析',
      cover: 'https://picsum.photos/300/200?random=11',
      tag: '物理',
      grade: '初三',
      duration: 45,
      studentsCount: 856,
    ),
    Course(
      id: 3,
      title: '英语语法精讲',
      brief: '从基础到进阶的语法课程',
      cover: 'https://picsum.photos/300/200?random=12',
      tag: '英语',
      grade: '高二',
      duration: 40,
      studentsCount: 2100,
    ),
  ];

  // 聊天会话数据
  static const List<ChatSession> chatSessions = [
    ChatSession(
      id: 1,
      name: '英语教师 Emma',
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Emma',
      lastMessage: '今天的语法课程完成得很棒！',
      time: '10:30',
      isAi: true,
    ),
    ChatSession(
      id: 2,
      name: '张老师',
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Teacher',
      lastMessage: '作业记得按时提交哦',
      time: '昨天',
      unreadCount: 2,
    ),
    ChatSession(
      id: 3,
      name: '学习小组',
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Group',
      lastMessage: '明天一起复习数学吧',
      time: '周一',
    ),
  ];

  // 帖子数据
  static List<Post> posts = [
    Post(
      id: 1,
      title: '分享一个高效学习方法',
      content: '今天发现了一个特别好用的记忆技巧，番茄工作法+思维导图...',
      authorName: '学习达人',
      authorAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=User1',
      createTime: '2小时前',
      thumbNum: 128,
      commentNum: 32,
      favourNum: 56,
    ),
    Post(
      id: 2,
      title: '求助：物理大题不会做怎么办？',
      content: '每次考试物理大题都做不完，有什么好的解题思路吗？',
      authorName: '物理小白',
      authorAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=User2',
      createTime: '5小时前',
      thumbNum: 45,
      commentNum: 67,
      favourNum: 12,
    ),
    Post(
      id: 3,
      title: '英语四六级备考经验',
      content: '分享我的四六级备考经验，主要是听力和阅读的提升方法...',
      authorName: '英语学霸',
      authorAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=User3',
      createTime: '1天前',
      thumbNum: 256,
      commentNum: 89,
      favourNum: 134,
    ),
  ];

  // 用户信息
  static const UserProfile userProfile = UserProfile(
    id: 1,
    username: '学习小能手',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Me',
    level: 3,
    daysLearned: 15,
    streakDays: 7,
    stars: 128,
    badges: 8,
  );

  // 学习目标
  static List<LearningGoal> learningGoals = [
    LearningGoal(id: 1, text: '完成每日单词打卡', completed: true),
    LearningGoal(id: 2, text: '听力练习15分钟', completed: true),
    LearningGoal(id: 3, text: '完成一节口语课程', completed: false),
    LearningGoal(id: 4, text: '阅读英语文章一篇', completed: false),
  ];

  // 成就徽章
  static const List<AchievementBadge> badges = [
    AchievementBadge(id: 1, name: '单词达人', icon: 'star', color: 0xFF1989FA),
    AchievementBadge(id: 2, name: '坚持不懈', icon: 'fire', color: 0xFFFF976A),
    AchievementBadge(
      id: 3,
      name: '听力小子',
      icon: 'headphones',
      color: 0xFF07C160,
    ),
    AchievementBadge(id: 4, name: '初级达成', icon: 'trophy', color: 0xFFFFCD32),
  ];
}
