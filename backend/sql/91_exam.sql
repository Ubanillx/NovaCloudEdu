-- 试卷编辑系统相关表

-- 题库表
CREATE TABLE IF NOT EXISTS question
(
    id              BIGSERIAL PRIMARY KEY,
    type            VARCHAR(20)                            NOT NULL,
    subject         VARCHAR(20)                            NOT NULL,
    grade           VARCHAR(20)                            NULL,
    difficulty      SMALLINT     DEFAULT 3                 NOT NULL,
    content         TEXT                                   NOT NULL,
    options         JSONB                                  NULL,
    answer          TEXT                                   NOT NULL,
    explanation     TEXT                                   NULL,
    knowledge_tags  TEXT[]                                 NULL,
    image_url       VARCHAR(500)                           NULL,
    source          VARCHAR(100) DEFAULT 'MANUAL'          NOT NULL,
    creator_id      BIGINT                                 NOT NULL,
    create_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT     DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_question_type ON question(type);
CREATE INDEX IF NOT EXISTS idx_question_subject ON question(subject);
CREATE INDEX IF NOT EXISTS idx_question_grade ON question(grade);
CREATE INDEX IF NOT EXISTS idx_question_difficulty ON question(difficulty);
CREATE INDEX IF NOT EXISTS idx_question_creator ON question(creator_id);
CREATE INDEX IF NOT EXISTS idx_question_knowledge_tags ON question USING GIN(knowledge_tags);
COMMENT ON TABLE question IS '题库';
COMMENT ON COLUMN question.id IS '题目ID';
COMMENT ON COLUMN question.type IS '题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY';
COMMENT ON COLUMN question.subject IS '学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS';
COMMENT ON COLUMN question.grade IS '年级: GRADE_7~GRADE_12 / COLLEGE';
COMMENT ON COLUMN question.difficulty IS '难度: 1-5';
COMMENT ON COLUMN question.content IS '题干内容(支持KaTeX公式)';
COMMENT ON COLUMN question.options IS '选项JSON数组 [{"label":"A","text":"..."}]';
COMMENT ON COLUMN question.answer IS '标准答案';
COMMENT ON COLUMN question.explanation IS '解析';
COMMENT ON COLUMN question.knowledge_tags IS '知识点标签数组';
COMMENT ON COLUMN question.source IS '来源: MANUAL/AI/IMPORT';

-- 试卷表
CREATE TABLE IF NOT EXISTS exam_paper
(
    id              BIGSERIAL PRIMARY KEY,
    title           VARCHAR(200)                           NOT NULL,
    subtitle        VARCHAR(500)                           NULL,
    subject         VARCHAR(20)                            NOT NULL,
    grade           VARCHAR(20)                            NULL,
    total_score     INT          DEFAULT 0                 NOT NULL,
    duration_min    INT                                    NULL,
    layout          JSONB        DEFAULT '{}'::jsonb       NOT NULL,
    status          VARCHAR(20)  DEFAULT 'DRAFT'           NOT NULL,
    creator_id      BIGINT                                 NOT NULL,
    create_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT     DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_exam_paper_subject ON exam_paper(subject);
CREATE INDEX IF NOT EXISTS idx_exam_paper_creator ON exam_paper(creator_id);
CREATE INDEX IF NOT EXISTS idx_exam_paper_status ON exam_paper(status);
COMMENT ON TABLE exam_paper IS '试卷';
COMMENT ON COLUMN exam_paper.id IS '试卷ID';
COMMENT ON COLUMN exam_paper.title IS '试卷标题';
COMMENT ON COLUMN exam_paper.subtitle IS '副标题';
COMMENT ON COLUMN exam_paper.subject IS '学科';
COMMENT ON COLUMN exam_paper.total_score IS '总分';
COMMENT ON COLUMN exam_paper.duration_min IS '考试时长(分钟)';
COMMENT ON COLUMN exam_paper.layout IS '排版配置JSON {paperSize,columns,fontSize}';
COMMENT ON COLUMN exam_paper.status IS '状态: DRAFT/PUBLISHED';

-- 试卷大题表
CREATE TABLE IF NOT EXISTS paper_section
(
    id              BIGSERIAL PRIMARY KEY,
    paper_id        BIGINT                                 NOT NULL REFERENCES exam_paper(id) ON DELETE CASCADE,
    title           VARCHAR(100)                           NOT NULL,
    description     VARCHAR(500)                           NULL,
    question_type   VARCHAR(20)                            NULL,
    sort_order      INT          DEFAULT 0                 NOT NULL,
    create_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_paper_section_paper ON paper_section(paper_id);
COMMENT ON TABLE paper_section IS '试卷大题';
COMMENT ON COLUMN paper_section.title IS '大题标题(如"一、选择题")';
COMMENT ON COLUMN paper_section.description IS '大题描述(如"每小题5分，共60分")';
COMMENT ON COLUMN paper_section.question_type IS '该大题的题型';
COMMENT ON COLUMN paper_section.sort_order IS '排序';

-- 试卷题目关联表
CREATE TABLE IF NOT EXISTS paper_question
(
    id              BIGSERIAL PRIMARY KEY,
    section_id      BIGINT                                 NOT NULL REFERENCES paper_section(id) ON DELETE CASCADE,
    question_id     BIGINT                                 NOT NULL REFERENCES question(id),
    score           INT          DEFAULT 0                 NOT NULL,
    sort_order      INT          DEFAULT 0                 NOT NULL,
    create_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_paper_question_section ON paper_question(section_id);
CREATE INDEX IF NOT EXISTS idx_paper_question_question ON paper_question(question_id);
COMMENT ON TABLE paper_question IS '试卷题目关联';
COMMENT ON COLUMN paper_question.section_id IS '所属大题ID';
COMMENT ON COLUMN paper_question.question_id IS '题目ID';
COMMENT ON COLUMN paper_question.score IS '该题分值';
COMMENT ON COLUMN paper_question.sort_order IS '排序';
