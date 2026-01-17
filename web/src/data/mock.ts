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
      title: 'Flutter Advanced Development',
      brief: 'Master Flutter with advanced techniques and patterns.',
      cover: 'https://images.unsplash.com/photo-1617042375876-a13e36732a04?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      tag: 'Mobile',
      studentsCount: 1234,
    },
    {
      id: '2',
      title: 'React Performance Optimization',
      brief: 'Deep dive into React internals and performance tuning.',
      cover: 'https://images.unsplash.com/photo-1633356122544-f134324a6cee?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      tag: 'Web',
      studentsCount: 892,
    },
    {
      id: '3',
      title: 'Spring Boot Microservices',
      brief: 'Build scalable microservices with Spring Boot.',
      cover: 'https://images.unsplash.com/photo-1605379399642-870262d3d051?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      tag: 'Backend',
      studentsCount: 2156,
    },
    {
      id: '4',
      title: 'UI/UX Design Principles',
      brief: 'Learn the fundamentals of great design.',
      cover: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      tag: 'Design',
      studentsCount: 567,
    },
  ] as Course[],
  
  aiAssistants: [
    {
      id: '1',
      name: 'Code Reviewer',
      description: 'Helps you review code and find bugs.',
      icon: 'bug_report',
    },
    {
      id: '2',
      name: 'Study Planner',
      description: 'Creates personalized study plans.',
      icon: 'calendar_today',
    },
    {
      id: '3',
      name: 'Interview Coach',
      description: 'Mock interviews and feedback.',
      icon: 'question_answer',
    },
     {
      id: '4',
      name: 'Tech Translator',
      description: 'Translate technical docs instantly.',
      icon: 'translate',
    },
  ] as AiAssistant[],

  dailyWord: {
    word: 'Persistance',
    phonetic: '/pəˈzɪst(ə)ns/',
    translation: 'n. 坚持，毅力',
    example: 'Persistence is the key to success.',
  } as DailyWord,

  notices: [
    { id: '1', title: 'New Course "System Design" is out now!', time: '2h ago' },
    { id: '2', title: 'System maintenance scheduled for Sunday.', time: '1d ago' },
    { id: '3', title: 'Join our weekly developer community call.', time: '2d ago' },
  ],

  articles: [
    {
      id: '1',
      title: 'Understanding React Server Components',
      brief: 'A comprehensive guide to the new React architecture.',
      cover: 'https://images.unsplash.com/photo-1633356122102-3fe601e1570f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      category: 'Frontend',
      readTime: 5,
    },
    {
      id: '2',
      title: 'The Future of AI in Education',
      brief: 'How AI is transforming the way we learn.',
      cover: 'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      category: 'Tech',
      readTime: 8,
    },
    {
      id: '3',
      title: 'Optimizing SQL Queries',
      brief: 'Tips and tricks for faster database performance.',
      cover: 'https://images.unsplash.com/photo-1662036235978-a78c18732f77?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3',
      category: 'Database',
      readTime: 6,
    },
  ] as Article[],
};
