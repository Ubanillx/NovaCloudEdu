export const SUBJECT_NAMES: Record<string, string> = {
  MATH: '数学',
  CHINESE: '语文',
  ENGLISH: '英语',
  PHYSICS: '物理',
  CHEMISTRY: '化学',
  BIOLOGY: '生物',
  HISTORY: '历史',
  GEOGRAPHY: '地理',
  POLITICS: '政治',
};

export const SUBJECT_OPTIONS = Object.entries(SUBJECT_NAMES).map(([value, label]) => ({ value, label }));

export const EXAM_QUESTION_TYPE_NAMES: Record<string, string> = {
  SINGLE_CHOICE: '单选题',
  MULTI_CHOICE: '多选题',
  FILL_BLANK: '填空题',
  TRUE_FALSE: '判断题',
  SHORT_ANSWER: '简答题',
  CALCULATION: '计算题',
  ESSAY: '论述题',
};

export const QUESTION_TYPE_NAMES: Record<string, string> = {
  ...EXAM_QUESTION_TYPE_NAMES,
  FILL: '填空题',
};

export const QUESTION_TYPE_OPTIONS = Object.entries(EXAM_QUESTION_TYPE_NAMES).map(([value, label]) => ({ value, label }));

export const getSubjectName = (code?: string | null) => code ? SUBJECT_NAMES[code] || code : '';

export const getQuestionTypeName = (code?: string | null) => code ? QUESTION_TYPE_NAMES[code] || code : '';
