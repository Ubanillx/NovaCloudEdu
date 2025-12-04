-- AI聊天领域相关表

-- AI聊天消息表
CREATE TABLE IF NOT EXISTS ai_chat_message
(
    id          BIGSERIAL PRIMARY KEY,
    session_id  BIGINT                             NOT NULL,
    user_id     BIGINT                             NOT NULL,
    content     TEXT                               NOT NULL,
    type        VARCHAR(32)                        NOT NULL,
    role        VARCHAR(32)                        NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT  DEFAULT 0                NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_acm_session_id ON ai_chat_message(session_id);
CREATE INDEX IF NOT EXISTS idx_acm_user_id ON ai_chat_message(user_id);
COMMENT ON TABLE ai_chat_message IS 'AI聊天消息';
COMMENT ON COLUMN ai_chat_message.id IS 'id';
COMMENT ON COLUMN ai_chat_message.session_id IS '会话id';
COMMENT ON COLUMN ai_chat_message.user_id IS '用户id';
COMMENT ON COLUMN ai_chat_message.content IS '消息内容';
COMMENT ON COLUMN ai_chat_message.type IS '消息类型：text/image/file/audio/video';
COMMENT ON COLUMN ai_chat_message.role IS '消息角色：user/ai';
COMMENT ON COLUMN ai_chat_message.create_time IS '创建时间';
COMMENT ON COLUMN ai_chat_message.update_time IS '更新时间';
COMMENT ON COLUMN ai_chat_message.is_delete IS '是否删除';

-- AI角色表
CREATE TABLE IF NOT EXISTS ai_role
(
    id             BIGSERIAL PRIMARY KEY,
    name           VARCHAR(128)                            NOT NULL,
    description    TEXT                                    NULL,
    avatar_img_url VARCHAR(1024)                           NULL,
    avatar_auth    VARCHAR(512)                            NULL,
    tags           VARCHAR(512)                            NULL,
    is_public      SMALLINT      DEFAULT 1                 NOT NULL,
    usage_count    INT           DEFAULT 0                 NOT NULL,
    rating         DECIMAL(2, 1) DEFAULT 0.0               NOT NULL,
    creator_id     BIGINT                                  NOT NULL,
    sort           INT           DEFAULT 0                 NOT NULL,
    create_time    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete      SMALLINT      DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ar_tags ON ai_role(tags);
CREATE INDEX IF NOT EXISTS idx_ar_creator_id ON ai_role(creator_id);
CREATE INDEX IF NOT EXISTS idx_ar_sort ON ai_role(sort);
CREATE INDEX IF NOT EXISTS idx_ar_usage_count ON ai_role(usage_count);
COMMENT ON TABLE ai_role IS 'AI角色';
COMMENT ON COLUMN ai_role.id IS 'id';
COMMENT ON COLUMN ai_role.name IS 'AI角色名称';
COMMENT ON COLUMN ai_role.description IS 'AI角色描述';
COMMENT ON COLUMN ai_role.avatar_img_url IS 'AI角色头像URL';
COMMENT ON COLUMN ai_role.avatar_auth IS 'AI角色鉴权，UUID';
COMMENT ON COLUMN ai_role.tags IS '标签，JSON数组格式';
COMMENT ON COLUMN ai_role.is_public IS '是否公开：0-否，1-是';
COMMENT ON COLUMN ai_role.usage_count IS '使用次数';
COMMENT ON COLUMN ai_role.rating IS '评分，1-5分';
COMMENT ON COLUMN ai_role.creator_id IS '创建者id';
COMMENT ON COLUMN ai_role.sort IS '排序，数字越小排序越靠前';
COMMENT ON COLUMN ai_role.create_time IS '创建时间';
COMMENT ON COLUMN ai_role.update_time IS '更新时间';
COMMENT ON COLUMN ai_role.is_delete IS '是否删除';

-- AI工作流表
CREATE TABLE IF NOT EXISTS ai_workflow
(
    id           BIGSERIAL PRIMARY KEY,
    name         VARCHAR(128)                            NOT NULL,
    description  TEXT                                    NULL,
    flow_data    JSONB                                   NOT NULL,
    version      INT           DEFAULT 1                 NOT NULL,
    is_public    SMALLINT      DEFAULT 0                 NOT NULL,
    creator_id   BIGINT                                  NOT NULL,
    create_time  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete    SMALLINT      DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_aw_creator_id ON ai_workflow(creator_id);
CREATE INDEX IF NOT EXISTS idx_aw_is_public ON ai_workflow(is_public);
COMMENT ON TABLE ai_workflow IS 'AI工作流';
COMMENT ON COLUMN ai_workflow.id IS 'id';
COMMENT ON COLUMN ai_workflow.name IS '工作流名称';
COMMENT ON COLUMN ai_workflow.description IS '工作流描述';
COMMENT ON COLUMN ai_workflow.flow_data IS '流程定义JSON，包含nodes和edges，如：{"nodes":[{"id":"1","type":"start","data":{}}],"edges":[{"source":"1","target":"2"}]}';
COMMENT ON COLUMN ai_workflow.creator_id IS '创建者id';
COMMENT ON COLUMN ai_workflow.create_time IS '创建时间';
COMMENT ON COLUMN ai_workflow.update_time IS '更新时间';
COMMENT ON COLUMN ai_workflow.is_delete IS '是否删除';

-- AI角色工作流关联表
CREATE TABLE IF NOT EXISTS ai_role_workflow
(
    id           BIGSERIAL PRIMARY KEY,
    ai_role_id   BIGINT                             NOT NULL,
    workflow_id  BIGINT                             NOT NULL,
    create_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_arw_ai_role_id ON ai_role_workflow(ai_role_id);
CREATE INDEX IF NOT EXISTS idx_arw_workflow_id ON ai_role_workflow(workflow_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_arw_role_workflow ON ai_role_workflow(ai_role_id, workflow_id);
COMMENT ON TABLE ai_role_workflow IS 'AI角色工作流关联';
COMMENT ON COLUMN ai_role_workflow.id IS 'id';
COMMENT ON COLUMN ai_role_workflow.ai_role_id IS 'AI角色id';
COMMENT ON COLUMN ai_role_workflow.workflow_id IS '工作流id';
COMMENT ON COLUMN ai_role_workflow.create_time IS '创建时间';
COMMENT ON COLUMN ai_role_workflow.update_time IS '更新时间';

-- AI角色知识库向量表（RAG）
CREATE TABLE IF NOT EXISTS ai_role_knowledge
(
    id           BIGSERIAL PRIMARY KEY,
    ai_role_id   BIGINT                             NOT NULL,
    content      TEXT                               NOT NULL,
    embedding    VECTOR(1536)                       NOT NULL,
    metadata     JSONB                              NULL,
    create_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete    SMALLINT  DEFAULT 0                NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ark_ai_role_id ON ai_role_knowledge(ai_role_id);
CREATE INDEX IF NOT EXISTS idx_ark_embedding ON ai_role_knowledge USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);
COMMENT ON TABLE ai_role_knowledge IS 'AI角色知识库向量表';
COMMENT ON COLUMN ai_role_knowledge.id IS 'id';
COMMENT ON COLUMN ai_role_knowledge.ai_role_id IS 'AI角色id';
COMMENT ON COLUMN ai_role_knowledge.content IS '原始文本内容';
COMMENT ON COLUMN ai_role_knowledge.embedding IS '向量嵌入，1536维（OpenAI text-embedding-ada-002）';
COMMENT ON COLUMN ai_role_knowledge.metadata IS '元数据JSON，如来源、标题、分块信息等';
COMMENT ON COLUMN ai_role_knowledge.create_time IS '创建时间';
COMMENT ON COLUMN ai_role_knowledge.update_time IS '更新时间';
COMMENT ON COLUMN ai_role_knowledge.is_delete IS '是否删除';

-- 用户AI角色关联表
CREATE TABLE IF NOT EXISTS user_ai_role
(
    id            BIGSERIAL PRIMARY KEY,
    user_id       BIGINT                             NOT NULL,
    ai_role_id    BIGINT                             NOT NULL,
    is_favorite   SMALLINT DEFAULT 0                 NOT NULL,
    last_use_time TIMESTAMP                          NULL,
    rating        DECIMAL(2, 1) DEFAULT 0.0          NOT NULL,
    use_count     INT      DEFAULT 0                 NOT NULL,
    create_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_uar_user_id ON user_ai_role(user_id);
CREATE INDEX IF NOT EXISTS idx_uar_ai_role_id ON user_ai_role(ai_role_id);
CREATE INDEX IF NOT EXISTS idx_uar_is_favorite ON user_ai_role(is_favorite);
COMMENT ON TABLE user_ai_role IS '用户AI角色关联';
COMMENT ON COLUMN user_ai_role.id IS 'id';
COMMENT ON COLUMN user_ai_role.user_id IS '用户id';
COMMENT ON COLUMN user_ai_role.ai_role_id IS 'AI角色id';
COMMENT ON COLUMN user_ai_role.is_favorite IS '是否收藏：0-否，1-是';
COMMENT ON COLUMN user_ai_role.last_use_time IS '最后使用时间';
COMMENT ON COLUMN user_ai_role.rating IS '评分，1-5分';
COMMENT ON COLUMN user_ai_role.use_count IS '使用次数';
COMMENT ON COLUMN user_ai_role.create_time IS '创建时间';
COMMENT ON COLUMN user_ai_role.update_time IS '更新时间';

-- AI角色会话表
CREATE TABLE IF NOT EXISTS ai_role_session
(
    id           BIGSERIAL PRIMARY KEY,
    user_id      BIGINT                             NOT NULL,
    ai_role_id   BIGINT                             NOT NULL,
    session_name VARCHAR(256)                       NULL,
    create_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete    SMALLINT  DEFAULT 0                NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ars_user_id ON ai_role_session(user_id);
CREATE INDEX IF NOT EXISTS idx_ars_ai_role_id ON ai_role_session(ai_role_id);
COMMENT ON TABLE ai_role_session IS 'AI角色会话';
COMMENT ON COLUMN ai_role_session.id IS 'id';
COMMENT ON COLUMN ai_role_session.user_id IS '用户id';
COMMENT ON COLUMN ai_role_session.ai_role_id IS 'AI角色id';
COMMENT ON COLUMN ai_role_session.session_name IS '会话名称';
COMMENT ON COLUMN ai_role_session.create_time IS '创建时间';
COMMENT ON COLUMN ai_role_session.update_time IS '更新时间';
COMMENT ON COLUMN ai_role_session.is_delete IS '是否删除';

-- AI角色聊天消息列表
CREATE TABLE IF NOT EXISTS ai_role_message_list
(
    id          BIGSERIAL PRIMARY KEY,
    session_id  BIGINT                             NOT NULL,
    user_id     BIGINT                             NOT NULL,
    content     TEXT                               NOT NULL,
    type        VARCHAR(32)                        NOT NULL,
    role        VARCHAR(32)                        NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT  DEFAULT 0                NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_arml_session_id ON ai_role_message_list(session_id);
CREATE INDEX IF NOT EXISTS idx_arml_user_id ON ai_role_message_list(user_id);
COMMENT ON TABLE ai_role_message_list IS 'AI角色聊天消息';
COMMENT ON COLUMN ai_role_message_list.id IS 'id';
COMMENT ON COLUMN ai_role_message_list.session_id IS '会话id';
COMMENT ON COLUMN ai_role_message_list.user_id IS '用户id';
COMMENT ON COLUMN ai_role_message_list.content IS '消息内容';
COMMENT ON COLUMN ai_role_message_list.type IS '消息类型：text/image/file/audio/video';
COMMENT ON COLUMN ai_role_message_list.role IS '消息角色：user/ai';
COMMENT ON COLUMN ai_role_message_list.create_time IS '创建时间';
COMMENT ON COLUMN ai_role_message_list.update_time IS '更新时间';
COMMENT ON COLUMN ai_role_message_list.is_delete IS '是否删除';
