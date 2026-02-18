-- 智能批改系统相关表

-- 作业提交表
CREATE TABLE IF NOT EXISTS homework_submission
(
    id              BIGSERIAL PRIMARY KEY,
    student_id      BIGINT                                 NOT NULL,
    class_id        BIGINT                                 NULL,
    grading_mode    VARCHAR(20)  DEFAULT 'GENERAL'         NOT NULL,
    title           VARCHAR(200)                           NULL,
    subject         VARCHAR(20)                            NULL,
    grade           VARCHAR(20)                            NULL,
    image_urls      TEXT[]                                 NOT NULL,
    ocr_raw_text    TEXT                                   NULL,
    structured_data JSONB                                  NULL,
    status          VARCHAR(20)  DEFAULT 'PENDING'         NOT NULL,
    exam_paper_id   BIGINT                                 NULL,
    create_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT     DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_hw_submission_student ON homework_submission(student_id);
CREATE INDEX IF NOT EXISTS idx_hw_submission_class ON homework_submission(class_id);
CREATE INDEX IF NOT EXISTS idx_hw_submission_subject ON homework_submission(subject);
CREATE INDEX IF NOT EXISTS idx_hw_submission_status ON homework_submission(status);
CREATE INDEX IF NOT EXISTS idx_hw_submission_exam_paper ON homework_submission(exam_paper_id);
COMMENT ON TABLE homework_submission IS '作业提交';
COMMENT ON COLUMN homework_submission.id IS '提交ID';
COMMENT ON COLUMN homework_submission.student_id IS '学生ID';
COMMENT ON COLUMN homework_submission.class_id IS '班级ID(可选)';
COMMENT ON COLUMN homework_submission.grading_mode IS '批改模式: EXAM_PAPER(试卷批改)/GENERAL(通用作业助手)';
COMMENT ON COLUMN homework_submission.title IS '作业标题(通用模式可自定义)';
COMMENT ON COLUMN homework_submission.subject IS '学科(可空，通用模式下AI自动推断): MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS';
COMMENT ON COLUMN homework_submission.grade IS '年级';
COMMENT ON COLUMN homework_submission.image_urls IS '作业图片OSS URL数组';
COMMENT ON COLUMN homework_submission.ocr_raw_text IS 'OCR原始识别文本';
COMMENT ON COLUMN homework_submission.structured_data IS 'OCR结构化数据JSON';
COMMENT ON COLUMN homework_submission.status IS '状态: PENDING/OCR_PROCESSING/GRADING/COMPLETED/FAILED';
COMMENT ON COLUMN homework_submission.exam_paper_id IS '关联试卷ID(可选,有标准答案时)';

-- 批改结果表
CREATE TABLE IF NOT EXISTS grading_result
(
    id              BIGSERIAL PRIMARY KEY,
    submission_id   BIGINT                                 NOT NULL REFERENCES homework_submission(id),
    total_score     INT                                    NULL,
    max_score       INT                                    NULL,
    overall_comment TEXT                                   NULL,
    model_id        VARCHAR(100)                           NULL,
    grading_time    TIMESTAMP                              NULL,
    create_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT     DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_grading_result_submission ON grading_result(submission_id);
COMMENT ON TABLE grading_result IS '批改结果';
COMMENT ON COLUMN grading_result.id IS '批改结果ID';
COMMENT ON COLUMN grading_result.submission_id IS '关联作业提交ID';
COMMENT ON COLUMN grading_result.total_score IS '总得分';
COMMENT ON COLUMN grading_result.max_score IS '满分';
COMMENT ON COLUMN grading_result.overall_comment IS '总评语';
COMMENT ON COLUMN grading_result.model_id IS '使用的AI模型ID';
COMMENT ON COLUMN grading_result.grading_time IS '批改完成时间';

-- 单题批改详情表
CREATE TABLE IF NOT EXISTS question_grading
(
    id                  BIGSERIAL PRIMARY KEY,
    grading_result_id   BIGINT                                 NOT NULL REFERENCES grading_result(id) ON DELETE CASCADE,
    question_index      INT                                    NOT NULL,
    question_content    TEXT                                   NULL,
    question_type       VARCHAR(20)                            NULL,
    student_answer      TEXT                                   NULL,
    standard_answer     TEXT                                   NULL,
    score               INT          DEFAULT 0                 NOT NULL,
    max_score           INT          DEFAULT 0                 NOT NULL,
    error_categories    TEXT[]                                 NULL,
    error_detail        TEXT                                   NULL,
    knowledge_points    TEXT[]                                 NULL,
    comment             TEXT                                   NULL,
    similar_question_id BIGINT                                 NULL,
    create_time         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_question_grading_result ON question_grading(grading_result_id);
COMMENT ON TABLE question_grading IS '单题批改详情';
COMMENT ON COLUMN question_grading.grading_result_id IS '关联批改结果ID';
COMMENT ON COLUMN question_grading.question_index IS '题号';
COMMENT ON COLUMN question_grading.question_content IS '题干内容';
COMMENT ON COLUMN question_grading.question_type IS '题型';
COMMENT ON COLUMN question_grading.student_answer IS '学生答案(OCR识别)';
COMMENT ON COLUMN question_grading.standard_answer IS '标准答案';
COMMENT ON COLUMN question_grading.score IS '得分';
COMMENT ON COLUMN question_grading.max_score IS '满分';
COMMENT ON COLUMN question_grading.error_categories IS '错误分类: CONCEPT_ERROR/CALCULATION_ERROR/READING_ERROR/UNIT_ERROR/STEP_MISSING/LOGIC_INCOMPLETE/EXPRESSION_UNCLEAR/GRAMMAR_ERROR/SPELLING_ERROR/FORMAT_ERROR/KNOWLEDGE_GAP/CARELESS_MISTAKE';
COMMENT ON COLUMN question_grading.error_detail IS '错误详情说明';
COMMENT ON COLUMN question_grading.knowledge_points IS '关联知识点';
COMMENT ON COLUMN question_grading.comment IS '单题评语';
COMMENT ON COLUMN question_grading.similar_question_id IS '推荐的同类题ID';

-- 学生知识画像表
CREATE TABLE IF NOT EXISTS student_knowledge_profile
(
    id                      BIGSERIAL PRIMARY KEY,
    student_id              BIGINT                                 NOT NULL,
    subject                 VARCHAR(20)                            NOT NULL,
    knowledge_point         VARCHAR(200)                           NOT NULL,
    mastery_level           DOUBLE PRECISION DEFAULT 0.5           NOT NULL,
    total_attempts          INT              DEFAULT 0             NOT NULL,
    correct_count           INT              DEFAULT 0             NOT NULL,
    recent_error_categories TEXT[]                                 NULL,
    last_updated            TIMESTAMP        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UNIQUE(student_id, subject, knowledge_point)
);
CREATE INDEX IF NOT EXISTS idx_skp_student ON student_knowledge_profile(student_id);
CREATE INDEX IF NOT EXISTS idx_skp_subject ON student_knowledge_profile(subject);
CREATE INDEX IF NOT EXISTS idx_skp_mastery ON student_knowledge_profile(mastery_level);
COMMENT ON TABLE student_knowledge_profile IS '学生知识画像';
COMMENT ON COLUMN student_knowledge_profile.student_id IS '学生ID';
COMMENT ON COLUMN student_knowledge_profile.subject IS '学科';
COMMENT ON COLUMN student_knowledge_profile.knowledge_point IS '知识点名称';
COMMENT ON COLUMN student_knowledge_profile.mastery_level IS '掌握度 0.0~1.0';
COMMENT ON COLUMN student_knowledge_profile.total_attempts IS '总答题次数';
COMMENT ON COLUMN student_knowledge_profile.correct_count IS '正确次数';
COMMENT ON COLUMN student_knowledge_profile.recent_error_categories IS '近期错误类型';
COMMENT ON COLUMN student_knowledge_profile.last_updated IS '最近更新时间';
