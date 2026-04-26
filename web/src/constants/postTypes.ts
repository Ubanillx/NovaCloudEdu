export const POST_TYPES = [
  { value: 'discussion', label: '讨论交流' },
  { value: 'question', label: '提问求助' },
  { value: 'share', label: '资料分享' },
  { value: 'experience', label: '学习心得' },
  { value: 'homework', label: '作业答疑' },
  { value: 'exam', label: '考试升学' },
  { value: 'course', label: '课程讨论' },
  { value: 'announcement', label: '活动公告' },
  { value: 'life', label: '闲聊生活' },
  { value: 'tool', label: '工具技巧' },
  { value: 'other', label: '其他' },
] as const;

export const POST_TYPE_OPTIONS = POST_TYPES.map(({ value, label }) => ({ value, label }));

export const POST_TYPE_FILTER_OPTIONS = [
  { value: '', label: '全部类型' },
  ...POST_TYPE_OPTIONS,
];

export const getPostTypeLabel = (type?: string | null) => {
  if (!type) return '';
  return POST_TYPES.find(item => item.value === type)?.label || type;
};
