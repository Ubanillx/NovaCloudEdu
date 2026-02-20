-- 学情分析 - 学习活动流水表
CREATE TABLE IF NOT EXISTS learning_activity
(
    id            BIGSERIAL PRIMARY KEY,
    user_id       BIGINT       NOT NULL,
    activity_type VARCHAR(32)  NOT NULL,
    reference_id  BIGINT       NULL,
    subject       VARCHAR(20)  NULL,
    class_id      BIGINT       NULL,
    duration_sec  INT          DEFAULT 0  NOT NULL,
    score         INT          NULL,
    max_score     INT          NULL,
    detail        JSONB        NULL,
    activity_date DATE         NOT NULL,
    create_time   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_la_user_id ON learning_activity(user_id);
CREATE INDEX IF NOT EXISTS idx_la_activity_type ON learning_activity(activity_type);
CREATE INDEX IF NOT EXISTS idx_la_activity_date ON learning_activity(activity_date);
CREATE INDEX IF NOT EXISTS idx_la_class_id ON learning_activity(class_id);
CREATE INDEX IF NOT EXISTS idx_la_user_date ON learning_activity(user_id, activity_date);
CREATE INDEX IF NOT EXISTS idx_la_class_date ON learning_activity(class_id, activity_date);

COMMENT ON TABLE learning_activity IS '学习活动流水表';
COMMENT ON COLUMN learning_activity.id IS '活动ID';
COMMENT ON COLUMN learning_activity.user_id IS '用户ID';
COMMENT ON COLUMN learning_activity.activity_type IS '活动类型: COURSE_WATCH/WORD_STUDY/ARTICLE_READ/HOMEWORK_SUBMIT/CHECKIN/EXAM_PRACTICE';
COMMENT ON COLUMN learning_activity.reference_id IS '关联业务ID（课程ID/单词ID/提交ID等）';
COMMENT ON COLUMN learning_activity.subject IS '关联学科（可选）';
COMMENT ON COLUMN learning_activity.class_id IS '关联班级ID（可选）';
COMMENT ON COLUMN learning_activity.duration_sec IS '活动时长（秒）';
COMMENT ON COLUMN learning_activity.score IS '得分（做题类活动）';
COMMENT ON COLUMN learning_activity.max_score IS '满分';
COMMENT ON COLUMN learning_activity.detail IS '扩展详情JSON';
COMMENT ON COLUMN learning_activity.activity_date IS '活动日期';
COMMENT ON COLUMN learning_activity.create_time IS '创建时间';
