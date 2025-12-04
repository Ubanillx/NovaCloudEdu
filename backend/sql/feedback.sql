-- 反馈领域相关表

-- 用户反馈表
CREATE TABLE IF NOT EXISTS user_feedback
(
    id           BIGSERIAL PRIMARY KEY,
    user_id      BIGINT                             NOT NULL,
    feedback_type VARCHAR(64)                       NOT NULL,
    title        VARCHAR(256)                       NULL,
    content      TEXT                               NOT NULL,
    attachment   VARCHAR(1024)                      NULL,
    status       SMALLINT DEFAULT 0                 NOT NULL,
    admin_id     BIGINT                             NULL,
    process_time TIMESTAMP                          NULL,
    create_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete    SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_uf_user_id ON user_feedback(user_id);
CREATE INDEX IF NOT EXISTS idx_uf_status ON user_feedback(status);
COMMENT ON TABLE user_feedback IS '用户反馈';
COMMENT ON COLUMN user_feedback.id IS 'id';
COMMENT ON COLUMN user_feedback.user_id IS '用户ID';
COMMENT ON COLUMN user_feedback.feedback_type IS '反馈类型';
COMMENT ON COLUMN user_feedback.title IS '反馈标题';
COMMENT ON COLUMN user_feedback.content IS '反馈内容';
COMMENT ON COLUMN user_feedback.attachment IS '附件URL';
COMMENT ON COLUMN user_feedback.status IS '处理状态：0-待处理，1-处理中，2-已处理';
COMMENT ON COLUMN user_feedback.admin_id IS '处理管理员ID';
COMMENT ON COLUMN user_feedback.process_time IS '处理时间';
COMMENT ON COLUMN user_feedback.create_time IS '创建时间';
COMMENT ON COLUMN user_feedback.update_time IS '更新时间';
COMMENT ON COLUMN user_feedback.is_delete IS '是否删除';

-- 用户反馈回复表
CREATE TABLE IF NOT EXISTS user_feedback_reply
(
    id          BIGSERIAL PRIMARY KEY,
    feedback_id BIGINT        NOT NULL,
    sender_id   BIGINT        NOT NULL,
    sender_role SMALLINT      NOT NULL,
    content     VARCHAR(1000) NOT NULL,
    attachment  VARCHAR(1024) NULL,
    is_read     SMALLINT      DEFAULT 0 NOT NULL,
    create_time TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT      DEFAULT 0 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ufr_feedback_id ON user_feedback_reply(feedback_id);
CREATE INDEX IF NOT EXISTS idx_ufr_sender_id ON user_feedback_reply(sender_id);
CREATE INDEX IF NOT EXISTS idx_ufr_create_time ON user_feedback_reply(create_time);
COMMENT ON TABLE user_feedback_reply IS '反馈回复';
COMMENT ON COLUMN user_feedback_reply.id IS 'id';
COMMENT ON COLUMN user_feedback_reply.feedback_id IS '关联的反馈ID';
COMMENT ON COLUMN user_feedback_reply.sender_id IS '发送者ID';
COMMENT ON COLUMN user_feedback_reply.sender_role IS '发送者角色：0-用户，1-管理员';
COMMENT ON COLUMN user_feedback_reply.content IS '回复内容';
COMMENT ON COLUMN user_feedback_reply.attachment IS '附件URL';
COMMENT ON COLUMN user_feedback_reply.is_read IS '是否已读：0-未读，1-已读';
COMMENT ON COLUMN user_feedback_reply.create_time IS '创建时间';
COMMENT ON COLUMN user_feedback_reply.update_time IS '更新时间';
COMMENT ON COLUMN user_feedback_reply.is_delete IS '是否删除';
