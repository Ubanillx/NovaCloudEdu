export interface Course {
  id: string;
  title: string;
  brief: string;
  cover: string;
  tag: string;
  studentsCount: number;
}

export interface AiAssistant {
  id: string;
  name: string;
  description: string;
  icon: string;
}

export interface Article {
  id: string;
  title: string;
  brief: string;
  cover: string;
  category: string;
  readTime: number;
}

export interface DailyWord {
  word: string;
  phonetic: string;
  translation: string;
  example: string;
}

export interface UserStats {
  streak: number;
  totalHours: number;
  points: number;
  completedCourses: number;
}

export const MockData = {
  userStats: {
    streak: 15,
    totalHours: 128,
    points: 2450,
    completedCourses: 3,
  } as UserStats,
  
  courses: [
    {
      id: '1',
      title: 'Scratch 图形化编程入门',
      brief: '通过趣味积木拼搭，开启孩子的编程启蒙之路，锻炼逻辑思维。',
      cover: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      tag: '编程',
      studentsCount: 3200,
    },
    {
      id: '2',
      title: '趣味数学：逻辑思维训练',
      brief: '打破传统枯燥数学，用游戏和绘图带你探索数学的奥秘。',
      cover: 'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      tag: '数学',
      studentsCount: 1560,
    },
    {
      id: '3',
      title: 'Python 少儿人工智能基础',
      brief: '专为青少年设计的 Python 课程，亲手编写你的第一个 AI 程序。',
      cover: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      tag: 'AI',
      studentsCount: 2840,
    },
    {
      id: '4',
      title: '小小科学家：物理实验课',
      brief: '利用身边的材料，亲手完成有趣的物理实验，探索科学真相。',
      cover: 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      tag: '科学',
      studentsCount: 1280,
    },
  ] as Course[],
  
  aiAssistants: [
    {
      id: '1',
      name: '小星老师 (AI 辅导员)',
      description: '全能学科助手，帮你解答作业难题。',
      icon: 'sparkles',
    },
    {
      id: '2',
      name: '英语口语搭子',
      description: '随时随地陪你练习地道英语口语。',
      icon: 'message-circle',
    },
    {
      id: '3',
      name: '编程小能手',
      description: '手把手带你写代码，解决编程小烦恼。',
      icon: 'terminal',
    },
     {
      id: '4',
      name: '灵感画板',
      description: '激发你的创意，辅助你完成美术作品。',
      icon: 'palette',
    },
  ] as AiAssistant[],

  dailyWord: {
    word: 'Curiosity',
    phonetic: '/ˌkjʊəriˈɒsəti/',
    translation: 'n. 好奇心，求知欲',
    example: 'Keep your curiosity and never stop exploring!',
  } as DailyWord,

  notices: [
    { id: '1', title: '【喜报】我校学员在全国少儿编程大赛中获奖！', time: '1小时前' },
    { id: '2', title: '新功能上线：AI 伴读机器人正式开放体验。', time: '5小时前' },
    { id: '3', title: '本周六晚 19:00：科学大讲堂不见不散。', time: '1天前' },
  ],

  articles: [
    {
      id: '1',
      title: '为什么孩子应该从小学习编程？',
      brief: '编程不仅仅是敲代码，更是在培养解决问题的思维方式。',
      cover: 'https://images.unsplash.com/photo-1584697964400-2af6a2f6204c?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      category: '教育视野',
      readTime: 4,
    },
    {
      id: '2',
      title: '如何激发学生对科学的兴趣？',
      brief: '让科学走出课本，走进孩子的生活点滴。',
      cover: 'https://images.unsplash.com/photo-1518152006812-edab29b069ac?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      category: '家长课堂',
      readTime: 6,
    },
    {
      id: '3',
      title: 'AI 时代的学习新范式',
      brief: '利用 AI 工具辅助学习，让效率翻倍的秘籍。',
      cover: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      category: '前沿资讯',
      readTime: 5,
    },
  ] as Article[],
};
