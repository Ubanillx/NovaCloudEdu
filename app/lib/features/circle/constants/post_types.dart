class PostTypeOption {
  final String value;
  final String label;

  const PostTypeOption({required this.value, required this.label});
}

const postTypeOptions = <PostTypeOption>[
  PostTypeOption(value: 'discussion', label: '讨论交流'),
  PostTypeOption(value: 'question', label: '提问求助'),
  PostTypeOption(value: 'share', label: '资料分享'),
  PostTypeOption(value: 'experience', label: '学习心得'),
  PostTypeOption(value: 'homework', label: '作业答疑'),
  PostTypeOption(value: 'exam', label: '考试升学'),
  PostTypeOption(value: 'course', label: '课程讨论'),
  PostTypeOption(value: 'announcement', label: '活动公告'),
  PostTypeOption(value: 'life', label: '闲聊生活'),
  PostTypeOption(value: 'tool', label: '工具技巧'),
  PostTypeOption(value: 'other', label: '其他'),
];

String getPostTypeLabel(String? type) {
  if (type == null || type.isEmpty) return '';
  for (final option in postTypeOptions) {
    if (option.value == type) {
      return option.label;
    }
  }
  return type;
}
