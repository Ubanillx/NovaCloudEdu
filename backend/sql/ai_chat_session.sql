-- AI通用聊天会话表
-- 用于管理通用AI聊天的会话和消息，支持记忆摘要

-- =====================================================
-- AI聊天会话表
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_chat_session
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                                  NOT NULL,

    -- 会话信息
    title           VARCHAR(256)                            NULL,

    -- 记忆摘要（当历史消息过多时，旧消息被压缩为摘要存储在此）
    memory_summary  TEXT                                    NULL,

    -- 消息统计
    message_count   INT             DEFAULT 0               NOT NULL,

    -- 审计
    create_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT        DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_acs_user_id ON ai_chat_session(user_id);
CREATE INDEX IF NOT EXISTS idx_acs_update_time ON ai_chat_session(update_time DESC);

COMMENT ON TABLE ai_chat_session IS 'AI通用聊天会话';
COMMENT ON COLUMN ai_chat_session.id IS 'id';
COMMENT ON COLUMN ai_chat_session.user_id IS '用户id';
COMMENT ON COLUMN ai_chat_session.title IS '会话标题（首次对话后由AI自动生成）';
COMMENT ON COLUMN ai_chat_session.memory_summary IS '记忆摘要（旧消息的压缩摘要，用于长对话的上下文保持）';
COMMENT ON COLUMN ai_chat_session.message_count IS '消息总数';
COMMENT ON COLUMN ai_chat_session.create_time IS '创建时间';
COMMENT ON COLUMN ai_chat_session.update_time IS '更新时间';
COMMENT ON COLUMN ai_chat_session.is_delete IS '是否删除';

-- =====================================================
-- AI聊天消息表
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_chat_message
(
    id              BIGSERIAL PRIMARY KEY,
    session_id      BIGINT                                  NOT NULL,
    user_id         BIGINT                                  NOT NULL,

    -- 消息内容
    role            VARCHAR(32)                             NOT NULL,
    content         TEXT                                    NOT NULL,

    -- 附件（图片URL等，JSON数组）
    attachments     JSONB           DEFAULT '[]'            NOT NULL,

    -- 是否已被摘要压缩（被压缩后的消息不再发送给LLM，仅保留用于前端展示）
    is_summarized   SMALLINT        DEFAULT 0               NOT NULL,

    -- 审计
    create_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT        DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_acm_session_id ON ai_chat_message(session_id);
CREATE INDEX IF NOT EXISTS idx_acm_user_id ON ai_chat_message(user_id);
CREATE INDEX IF NOT EXISTS idx_acm_create_time ON ai_chat_message(create_time);

COMMENT ON TABLE ai_chat_message IS 'AI聊天消息';
COMMENT ON COLUMN ai_chat_message.id IS 'id';
COMMENT ON COLUMN ai_chat_message.session_id IS '会话id';
COMMENT ON COLUMN ai_chat_message.user_id IS '用户id';
COMMENT ON COLUMN ai_chat_message.role IS '角色：user/assistant/system';
COMMENT ON COLUMN ai_chat_message.content IS '消息内容';
COMMENT ON COLUMN ai_chat_message.attachments IS '附件（图片URL等），JSON数组';
COMMENT ON COLUMN ai_chat_message.is_summarized IS '是否已被摘要压缩：0-否，1-是';
COMMENT ON COLUMN ai_chat_message.create_time IS '创建时间';
COMMENT ON COLUMN ai_chat_message.is_delete IS '是否删除';
