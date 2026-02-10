-- AI聊天领域相关表（重构版）
-- 包含：AI助手、知识库、工作流、会话消息等

-- =====================================================
-- AI助手表（替代原ai_role表，增强功能）
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_assistant
(
    id              BIGSERIAL PRIMARY KEY,
    name            VARCHAR(128)                            NOT NULL,
    description     TEXT                                    NULL,
    avatar_url      VARCHAR(1024)                           NULL,
    tags            JSONB           DEFAULT '[]'            NOT NULL,
    category        VARCHAR(64)                             NULL,
    
    -- 提示词配置
    system_prompt   TEXT                                    NULL,
    opening_message TEXT                                    NULL,
    suggested_questions JSONB       DEFAULT '[]'            NOT NULL,
    
    -- 模型配置
    model_name      VARCHAR(64)     DEFAULT 'qwen-plus'     NOT NULL,
    temperature     DECIMAL(3,2)    DEFAULT 0.7             NOT NULL,
    top_p           DECIMAL(3,2)    DEFAULT 0.8             NOT NULL,
    max_tokens      INT             DEFAULT 2000            NOT NULL,
    
    -- 状态与版本
    status          VARCHAR(32)     DEFAULT 'DRAFT'         NOT NULL,
    version         INT             DEFAULT 1               NOT NULL,
    published_version INT           DEFAULT 0               NOT NULL,
    
    -- 统计
    is_public       SMALLINT        DEFAULT 0               NOT NULL,
    usage_count     INT             DEFAULT 0               NOT NULL,
    rating          DECIMAL(2,1)    DEFAULT 0.0             NOT NULL,
    
    -- 审计
    creator_id      BIGINT                                  NOT NULL,
    sort            INT             DEFAULT 0               NOT NULL,
    create_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT        DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_aa_creator_id ON ai_assistant(creator_id);
CREATE INDEX IF NOT EXISTS idx_aa_status ON ai_assistant(status);
CREATE INDEX IF NOT EXISTS idx_aa_is_public ON ai_assistant(is_public);
CREATE INDEX IF NOT EXISTS idx_aa_category ON ai_assistant(category);
CREATE INDEX IF NOT EXISTS idx_aa_sort ON ai_assistant(sort);

COMMENT ON TABLE ai_assistant IS 'AI助手';
COMMENT ON COLUMN ai_assistant.id IS 'id';
COMMENT ON COLUMN ai_assistant.name IS 'AI助手名称';
COMMENT ON COLUMN ai_assistant.description IS 'AI助手描述';
COMMENT ON COLUMN ai_assistant.avatar_url IS '头像URL';
COMMENT ON COLUMN ai_assistant.tags IS '标签，JSON数组格式';
COMMENT ON COLUMN ai_assistant.category IS '分类';
COMMENT ON COLUMN ai_assistant.system_prompt IS '系统提示词';
COMMENT ON COLUMN ai_assistant.opening_message IS '开场白';
COMMENT ON COLUMN ai_assistant.suggested_questions IS '推荐问题，JSON数组格式';
COMMENT ON COLUMN ai_assistant.model_name IS '模型名称';
COMMENT ON COLUMN ai_assistant.temperature IS '温度参数';
COMMENT ON COLUMN ai_assistant.top_p IS 'Top-P参数';
COMMENT ON COLUMN ai_assistant.max_tokens IS '最大Token数';
COMMENT ON COLUMN ai_assistant.status IS '状态：DRAFT-草稿，PUBLISHED-已发布，ARCHIVED-已归档';
COMMENT ON COLUMN ai_assistant.version IS '当前版本号';
COMMENT ON COLUMN ai_assistant.published_version IS '已发布版本号';
COMMENT ON COLUMN ai_assistant.is_public IS '是否公开：0-否，1-是';
COMMENT ON COLUMN ai_assistant.usage_count IS '使用次数';
COMMENT ON COLUMN ai_assistant.rating IS '评分';
COMMENT ON COLUMN ai_assistant.creator_id IS '创建者id';
COMMENT ON COLUMN ai_assistant.sort IS '排序';
COMMENT ON COLUMN ai_assistant.create_time IS '创建时间';
COMMENT ON COLUMN ai_assistant.update_time IS '更新时间';
COMMENT ON COLUMN ai_assistant.is_delete IS '是否删除';

-- =====================================================
-- AI助手版本历史表
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_assistant_version
(
    id              BIGSERIAL PRIMARY KEY,
    assistant_id    BIGINT                                  NOT NULL,
    version         INT                                     NOT NULL,
    
    -- 快照数据
    name            VARCHAR(128)                            NOT NULL,
    description     TEXT                                    NULL,
    system_prompt   TEXT                                    NULL,
    opening_message TEXT                                    NULL,
    suggested_questions JSONB       DEFAULT '[]'            NOT NULL,
    model_name      VARCHAR(64)                             NOT NULL,
    temperature     DECIMAL(3,2)                            NOT NULL,
    top_p           DECIMAL(3,2)                            NOT NULL,
    max_tokens      INT                                     NOT NULL,
    
    -- 关联的知识库快照
    knowledge_base_ids JSONB       DEFAULT '[]'             NOT NULL,
    
    -- 发布信息
    publish_note    TEXT                                    NULL,
    published_by    BIGINT                                  NOT NULL,
    create_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_aav_assistant_id ON ai_assistant_version(assistant_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_aav_assistant_version ON ai_assistant_version(assistant_id, version);

COMMENT ON TABLE ai_assistant_version IS 'AI助手版本历史';
COMMENT ON COLUMN ai_assistant_version.id IS 'id';
COMMENT ON COLUMN ai_assistant_version.assistant_id IS 'AI助手id';
COMMENT ON COLUMN ai_assistant_version.version IS '版本号';
COMMENT ON COLUMN ai_assistant_version.name IS '名称快照';
COMMENT ON COLUMN ai_assistant_version.description IS '描述快照';
COMMENT ON COLUMN ai_assistant_version.system_prompt IS '系统提示词快照';
COMMENT ON COLUMN ai_assistant_version.opening_message IS '开场白快照';
COMMENT ON COLUMN ai_assistant_version.suggested_questions IS '推荐问题快照';
COMMENT ON COLUMN ai_assistant_version.model_name IS '模型名称快照';
COMMENT ON COLUMN ai_assistant_version.temperature IS '温度参数快照';
COMMENT ON COLUMN ai_assistant_version.top_p IS 'Top-P参数快照';
COMMENT ON COLUMN ai_assistant_version.max_tokens IS '最大Token数快照';
COMMENT ON COLUMN ai_assistant_version.knowledge_base_ids IS '关联知识库ID列表快照';
COMMENT ON COLUMN ai_assistant_version.publish_note IS '发布说明';
COMMENT ON COLUMN ai_assistant_version.published_by IS '发布者id';
COMMENT ON COLUMN ai_assistant_version.create_time IS '创建时间';

-- AI工作流表
CREATE TABLE IF NOT EXISTS ai_workflow
(
    id           BIGSERIAL PRIMARY KEY,
    name         VARCHAR(128)                            NOT NULL,
    description  TEXT                                    NULL,
    flow_data    JSONB                                   NOT NULL,
    status       VARCHAR(32)   DEFAULT 'DRAFT'           NOT NULL,
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
COMMENT ON COLUMN ai_workflow.status IS '工作流状态：DRAFT/PUBLISHED/ARCHIVED';
COMMENT ON COLUMN ai_workflow.creator_id IS '创建者id';
COMMENT ON COLUMN ai_workflow.create_time IS '创建时间';
COMMENT ON COLUMN ai_workflow.update_time IS '更新时间';
COMMENT ON COLUMN ai_workflow.is_delete IS '是否删除';

-- =====================================================
-- AI助手工作流关联表
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_assistant_workflow
(
    id              BIGSERIAL PRIMARY KEY,
    assistant_id    BIGINT                             NOT NULL,
    workflow_id     BIGINT                             NOT NULL,
    create_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_aaw_assistant_id ON ai_assistant_workflow(assistant_id);
CREATE INDEX IF NOT EXISTS idx_aaw_workflow_id ON ai_assistant_workflow(workflow_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_aaw_unique ON ai_assistant_workflow(assistant_id, workflow_id);
COMMENT ON TABLE ai_assistant_workflow IS 'AI助手工作流关联';
COMMENT ON COLUMN ai_assistant_workflow.id IS 'id';
COMMENT ON COLUMN ai_assistant_workflow.assistant_id IS 'AI助手id';
COMMENT ON COLUMN ai_assistant_workflow.workflow_id IS '工作流id';
COMMENT ON COLUMN ai_assistant_workflow.create_time IS '创建时间';
COMMENT ON COLUMN ai_assistant_workflow.update_time IS '更新时间';

-- =====================================================
-- 知识库表
-- =====================================================
CREATE TABLE IF NOT EXISTS knowledge_base
(
    id              BIGSERIAL PRIMARY KEY,
    name            VARCHAR(128)                            NOT NULL,
    description     TEXT                                    NULL,
    
    -- 向量化配置
    embedding_model VARCHAR(64)     DEFAULT 'text-embedding-v2' NOT NULL,
    embedding_dimension INT         DEFAULT 1536            NOT NULL,
    chunk_size      INT             DEFAULT 500             NOT NULL,
    chunk_overlap   INT             DEFAULT 50              NOT NULL,
    
    -- 统计
    document_count  INT             DEFAULT 0               NOT NULL,
    chunk_count     INT             DEFAULT 0               NOT NULL,
    
    -- 状态
    status          VARCHAR(32)     DEFAULT 'ACTIVE'        NOT NULL,
    
    -- 审计
    creator_id      BIGINT                                  NOT NULL,
    create_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT        DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_kb_creator_id ON knowledge_base(creator_id);
CREATE INDEX IF NOT EXISTS idx_kb_status ON knowledge_base(status);

COMMENT ON TABLE knowledge_base IS '知识库';
COMMENT ON COLUMN knowledge_base.id IS 'id';
COMMENT ON COLUMN knowledge_base.name IS '知识库名称';
COMMENT ON COLUMN knowledge_base.description IS '知识库描述';
COMMENT ON COLUMN knowledge_base.embedding_model IS '向量化模型';
COMMENT ON COLUMN knowledge_base.embedding_dimension IS '向量维度';
COMMENT ON COLUMN knowledge_base.chunk_size IS '分块大小';
COMMENT ON COLUMN knowledge_base.chunk_overlap IS '分块重叠';
COMMENT ON COLUMN knowledge_base.document_count IS '文档数量';
COMMENT ON COLUMN knowledge_base.chunk_count IS '分块数量';
COMMENT ON COLUMN knowledge_base.status IS '状态：ACTIVE-活跃，ARCHIVED-已归档';
COMMENT ON COLUMN knowledge_base.creator_id IS '创建者id';
COMMENT ON COLUMN knowledge_base.create_time IS '创建时间';
COMMENT ON COLUMN knowledge_base.update_time IS '更新时间';
COMMENT ON COLUMN knowledge_base.is_delete IS '是否删除';

-- =====================================================
-- 知识库文档表
-- =====================================================
CREATE TABLE IF NOT EXISTS knowledge_document
(
    id                  BIGSERIAL PRIMARY KEY,
    knowledge_base_id   BIGINT                                  NOT NULL,
    
    -- 文档信息
    name                VARCHAR(256)                            NOT NULL,
    file_type           VARCHAR(32)                             NOT NULL,
    file_url            VARCHAR(1024)                           NULL,
    file_size           BIGINT          DEFAULT 0               NOT NULL,
    
    -- 内容
    content             TEXT                                    NULL,
    content_hash        VARCHAR(64)                             NULL,
    
    -- 处理状态
    chunk_count         INT             DEFAULT 0               NOT NULL,
    status              VARCHAR(32)     DEFAULT 'PENDING'       NOT NULL,
    error_message       TEXT                                    NULL,
    
    -- 审计
    creator_id          BIGINT                                  NOT NULL,
    create_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete           SMALLINT        DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_kd_knowledge_base_id ON knowledge_document(knowledge_base_id);
CREATE INDEX IF NOT EXISTS idx_kd_status ON knowledge_document(status);
CREATE INDEX IF NOT EXISTS idx_kd_file_type ON knowledge_document(file_type);

COMMENT ON TABLE knowledge_document IS '知识库文档';
COMMENT ON COLUMN knowledge_document.id IS 'id';
COMMENT ON COLUMN knowledge_document.knowledge_base_id IS '知识库id';
COMMENT ON COLUMN knowledge_document.name IS '文档名称';
COMMENT ON COLUMN knowledge_document.file_type IS '文件类型：PDF/DOCX/TXT/MD/HTML/URL';
COMMENT ON COLUMN knowledge_document.file_url IS '文件URL';
COMMENT ON COLUMN knowledge_document.file_size IS '文件大小（字节）';
COMMENT ON COLUMN knowledge_document.content IS '文档内容（提取后的纯文本）';
COMMENT ON COLUMN knowledge_document.content_hash IS '内容哈希（用于去重）';
COMMENT ON COLUMN knowledge_document.chunk_count IS '分块数量';
COMMENT ON COLUMN knowledge_document.status IS '状态：PENDING-待处理，PROCESSING-处理中，COMPLETED-已完成，FAILED-失败';
COMMENT ON COLUMN knowledge_document.error_message IS '错误信息';
COMMENT ON COLUMN knowledge_document.creator_id IS '创建者id';
COMMENT ON COLUMN knowledge_document.create_time IS '创建时间';
COMMENT ON COLUMN knowledge_document.update_time IS '更新时间';
COMMENT ON COLUMN knowledge_document.is_delete IS '是否删除';

-- =====================================================
-- 知识库向量分块表
-- =====================================================
CREATE TABLE IF NOT EXISTS knowledge_chunk
(
    id                  BIGSERIAL PRIMARY KEY,
    knowledge_base_id   BIGINT                                  NOT NULL,
    document_id         BIGINT                                  NOT NULL,
    
    -- 分块内容
    content             TEXT                                    NOT NULL,
    chunk_index         INT                                     NOT NULL,
    
    -- 向量
    embedding           VECTOR(1536)                            NOT NULL,
    
    -- 元数据
    metadata            JSONB           DEFAULT '{}'            NOT NULL,
    
    -- 审计
    create_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete           SMALLINT        DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_kc_knowledge_base_id ON knowledge_chunk(knowledge_base_id);
CREATE INDEX IF NOT EXISTS idx_kc_document_id ON knowledge_chunk(document_id);
CREATE INDEX IF NOT EXISTS idx_kc_embedding ON knowledge_chunk USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);

COMMENT ON TABLE knowledge_chunk IS '知识库向量分块';
COMMENT ON COLUMN knowledge_chunk.id IS 'id';
COMMENT ON COLUMN knowledge_chunk.knowledge_base_id IS '知识库id';
COMMENT ON COLUMN knowledge_chunk.document_id IS '文档id';
COMMENT ON COLUMN knowledge_chunk.content IS '分块内容';
COMMENT ON COLUMN knowledge_chunk.chunk_index IS '分块索引';
COMMENT ON COLUMN knowledge_chunk.embedding IS '向量嵌入';
COMMENT ON COLUMN knowledge_chunk.metadata IS '元数据JSON';
COMMENT ON COLUMN knowledge_chunk.create_time IS '创建时间';
COMMENT ON COLUMN knowledge_chunk.is_delete IS '是否删除';

-- =====================================================
-- AI助手与知识库关联表
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_assistant_knowledge
(
    id                  BIGSERIAL PRIMARY KEY,
    assistant_id        BIGINT                                  NOT NULL,
    knowledge_base_id   BIGINT                                  NOT NULL,
    create_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_aak_assistant_id ON ai_assistant_knowledge(assistant_id);
CREATE INDEX IF NOT EXISTS idx_aak_knowledge_base_id ON ai_assistant_knowledge(knowledge_base_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_aak_unique ON ai_assistant_knowledge(assistant_id, knowledge_base_id);

COMMENT ON TABLE ai_assistant_knowledge IS 'AI助手与知识库关联';
COMMENT ON COLUMN ai_assistant_knowledge.id IS 'id';
COMMENT ON COLUMN ai_assistant_knowledge.assistant_id IS 'AI助手id';
COMMENT ON COLUMN ai_assistant_knowledge.knowledge_base_id IS '知识库id';
COMMENT ON COLUMN ai_assistant_knowledge.create_time IS '创建时间';

-- =====================================================
-- 用户AI助手收藏表
-- =====================================================
CREATE TABLE IF NOT EXISTS user_ai_assistant
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                                  NOT NULL,
    assistant_id    BIGINT                                  NOT NULL,
    
    -- 用户偏好
    is_favorite     SMALLINT        DEFAULT 0               NOT NULL,
    use_count       INT             DEFAULT 0               NOT NULL,
    last_use_time   TIMESTAMP                               NULL,
    rating          DECIMAL(2,1)    DEFAULT 0.0             NOT NULL,
    
    -- 审计
    create_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_uaa_user_id ON user_ai_assistant(user_id);
CREATE INDEX IF NOT EXISTS idx_uaa_assistant_id ON user_ai_assistant(assistant_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_uaa_unique ON user_ai_assistant(user_id, assistant_id);

COMMENT ON TABLE user_ai_assistant IS '用户AI助手收藏';
COMMENT ON COLUMN user_ai_assistant.id IS 'id';
COMMENT ON COLUMN user_ai_assistant.user_id IS '用户id';
COMMENT ON COLUMN user_ai_assistant.assistant_id IS 'AI助手id';
COMMENT ON COLUMN user_ai_assistant.is_favorite IS '是否收藏';
COMMENT ON COLUMN user_ai_assistant.use_count IS '使用次数';
COMMENT ON COLUMN user_ai_assistant.last_use_time IS '最后使用时间';
COMMENT ON COLUMN user_ai_assistant.rating IS '评分';
COMMENT ON COLUMN user_ai_assistant.create_time IS '创建时间';
COMMENT ON COLUMN user_ai_assistant.update_time IS '更新时间';

-- =====================================================
-- AI助手会话表
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_assistant_session
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                                  NOT NULL,
    assistant_id    BIGINT                                  NOT NULL,
    
    -- 会话信息
    title           VARCHAR(256)                            NULL,
    
    -- 审计
    create_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT        DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_aas_user_id ON ai_assistant_session(user_id);
CREATE INDEX IF NOT EXISTS idx_aas_assistant_id ON ai_assistant_session(assistant_id);

COMMENT ON TABLE ai_assistant_session IS 'AI助手会话';
COMMENT ON COLUMN ai_assistant_session.id IS 'id';
COMMENT ON COLUMN ai_assistant_session.user_id IS '用户id';
COMMENT ON COLUMN ai_assistant_session.assistant_id IS 'AI助手id';
COMMENT ON COLUMN ai_assistant_session.title IS '会话标题';
COMMENT ON COLUMN ai_assistant_session.create_time IS '创建时间';
COMMENT ON COLUMN ai_assistant_session.update_time IS '更新时间';
COMMENT ON COLUMN ai_assistant_session.is_delete IS '是否删除';

-- =====================================================
-- AI助手会话消息表
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_assistant_message
(
    id              BIGSERIAL PRIMARY KEY,
    session_id      BIGINT                                  NOT NULL,
    user_id         BIGINT                                  NOT NULL,
    
    -- 消息内容
    role            VARCHAR(32)                             NOT NULL,
    content         TEXT                                    NOT NULL,
    content_type    VARCHAR(32)     DEFAULT 'TEXT'          NOT NULL,
    
    -- RAG来源
    sources         JSONB           DEFAULT '[]'            NOT NULL,
    
    -- 审计
    create_time     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT        DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_aam_session_id ON ai_assistant_message(session_id);
CREATE INDEX IF NOT EXISTS idx_aam_user_id ON ai_assistant_message(user_id);

COMMENT ON TABLE ai_assistant_message IS 'AI助手会话消息';
COMMENT ON COLUMN ai_assistant_message.id IS 'id';
COMMENT ON COLUMN ai_assistant_message.session_id IS '会话id';
COMMENT ON COLUMN ai_assistant_message.user_id IS '用户id';
COMMENT ON COLUMN ai_assistant_message.role IS '角色：USER/ASSISTANT/SYSTEM';
COMMENT ON COLUMN ai_assistant_message.content IS '消息内容';
COMMENT ON COLUMN ai_assistant_message.content_type IS '内容类型：TEXT/IMAGE/FILE';
COMMENT ON COLUMN ai_assistant_message.sources IS 'RAG来源，JSON数组';
COMMENT ON COLUMN ai_assistant_message.create_time IS '创建时间';
COMMENT ON COLUMN ai_assistant_message.is_delete IS '是否删除';

-- =====================================================
-- 工作流执行日志表
-- =====================================================
CREATE TABLE IF NOT EXISTS ai_workflow_execution_log
(
    id              BIGSERIAL PRIMARY KEY,
    execution_id    VARCHAR(64)                             NOT NULL,
    workflow_id     BIGINT                                  NOT NULL,
    workflow_name   VARCHAR(128)                            NOT NULL,
    node_id         VARCHAR(64)                             NULL,
    node_name       VARCHAR(128)                            NULL,
    node_type       VARCHAR(32)                             NULL,
    level           VARCHAR(16)     DEFAULT 'INFO'          NOT NULL,
    message         TEXT                                    NOT NULL,
    input           JSONB           DEFAULT '{}'            NOT NULL,
    output          JSONB           DEFAULT '{}'            NOT NULL,
    error_stack     TEXT                                    NULL,
    duration_ms     BIGINT          DEFAULT 0               NOT NULL,
    trace_id        VARCHAR(64)                             NULL,
    user_id         BIGINT                                  NOT NULL,
    timestamp       TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_awel_execution_id ON ai_workflow_execution_log(execution_id);
CREATE INDEX IF NOT EXISTS idx_awel_workflow_id ON ai_workflow_execution_log(workflow_id);
CREATE INDEX IF NOT EXISTS idx_awel_timestamp ON ai_workflow_execution_log(timestamp);
CREATE INDEX IF NOT EXISTS idx_awel_level ON ai_workflow_execution_log(level);

COMMENT ON TABLE ai_workflow_execution_log IS '工作流执行日志';
COMMENT ON COLUMN ai_workflow_execution_log.id IS 'id';
COMMENT ON COLUMN ai_workflow_execution_log.execution_id IS '执行ID';
COMMENT ON COLUMN ai_workflow_execution_log.workflow_id IS '工作流ID';
COMMENT ON COLUMN ai_workflow_execution_log.workflow_name IS '工作流名称';
COMMENT ON COLUMN ai_workflow_execution_log.node_id IS '节点ID';
COMMENT ON COLUMN ai_workflow_execution_log.node_name IS '节点名称';
COMMENT ON COLUMN ai_workflow_execution_log.node_type IS '节点类型';
COMMENT ON COLUMN ai_workflow_execution_log.level IS '日志级别：DEBUG/INFO/WARN/ERROR';
COMMENT ON COLUMN ai_workflow_execution_log.message IS '日志消息';
COMMENT ON COLUMN ai_workflow_execution_log.input IS '输入数据';
COMMENT ON COLUMN ai_workflow_execution_log.output IS '输出数据';
COMMENT ON COLUMN ai_workflow_execution_log.error_stack IS '错误堆栈';
COMMENT ON COLUMN ai_workflow_execution_log.duration_ms IS '执行耗时(毫秒)';
COMMENT ON COLUMN ai_workflow_execution_log.trace_id IS '追踪ID';
COMMENT ON COLUMN ai_workflow_execution_log.user_id IS '用户ID';
COMMENT ON COLUMN ai_workflow_execution_log.timestamp IS '时间戳';

-- =====================================================
-- 工作流执行记录表（主表）
-- =====================================================
CREATE TABLE IF NOT EXISTS workflow_execution
(
    id                  VARCHAR(64) PRIMARY KEY,
    workflow_id         BIGINT                                  NOT NULL,
    workflow_name       VARCHAR(255)                            NOT NULL,
    workflow_version    INT             DEFAULT 1               NOT NULL,
    status              VARCHAR(32)     DEFAULT 'PENDING'       NOT NULL,
    input               JSONB                                   NULL,
    output              JSONB                                   NULL,
    variables           JSONB                                   NULL,
    node_executions     JSONB                                   NULL,
    current_node_id     VARCHAR(64)                             NULL,
    error_message       TEXT                                    NULL,
    user_id             BIGINT                                  NOT NULL,
    start_time          TIMESTAMP                               NULL,
    end_time            TIMESTAMP                               NULL,
    duration_ms         BIGINT          DEFAULT 0               NOT NULL,
    create_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted             INT             DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_we_workflow_id ON workflow_execution(workflow_id);
CREATE INDEX IF NOT EXISTS idx_we_user_id ON workflow_execution(user_id);
CREATE INDEX IF NOT EXISTS idx_we_status ON workflow_execution(status);
CREATE INDEX IF NOT EXISTS idx_we_create_time ON workflow_execution(create_time);

COMMENT ON TABLE workflow_execution IS '工作流执行记录';
COMMENT ON COLUMN workflow_execution.id IS '执行ID（UUID）';
COMMENT ON COLUMN workflow_execution.workflow_id IS '工作流ID';
COMMENT ON COLUMN workflow_execution.workflow_name IS '工作流名称快照';
COMMENT ON COLUMN workflow_execution.workflow_version IS '工作流版本快照';
COMMENT ON COLUMN workflow_execution.status IS '执行状态：PENDING/RUNNING/PAUSED/COMPLETED/FAILED/TIMEOUT/CANCELLED';
COMMENT ON COLUMN workflow_execution.input IS '输入参数JSON';
COMMENT ON COLUMN workflow_execution.output IS '输出结果JSON';
COMMENT ON COLUMN workflow_execution.variables IS '执行变量JSON';
COMMENT ON COLUMN workflow_execution.node_executions IS '节点执行记录JSON';
COMMENT ON COLUMN workflow_execution.current_node_id IS '当前执行节点ID';
COMMENT ON COLUMN workflow_execution.error_message IS '错误信息';
COMMENT ON COLUMN workflow_execution.user_id IS '执行用户ID';
COMMENT ON COLUMN workflow_execution.start_time IS '开始时间';
COMMENT ON COLUMN workflow_execution.end_time IS '结束时间';
COMMENT ON COLUMN workflow_execution.duration_ms IS '执行耗时（毫秒）';
COMMENT ON COLUMN workflow_execution.create_time IS '创建时间';
COMMENT ON COLUMN workflow_execution.update_time IS '更新时间';
COMMENT ON COLUMN workflow_execution.deleted IS '是否删除';

-- =====================================================
-- 工作流模板表
-- =====================================================
CREATE TABLE IF NOT EXISTS workflow_template
(
    id                  BIGSERIAL PRIMARY KEY,
    name                VARCHAR(128)                            NOT NULL,
    description         TEXT                                    NULL,
    category            VARCHAR(64)                             NULL,
    icon                VARCHAR(256)                            NULL,
    definition          JSONB                                   NOT NULL,
    tags                JSONB           DEFAULT '[]'            NOT NULL,
    is_system           SMALLINT        DEFAULT 0               NOT NULL,
    is_public           SMALLINT        DEFAULT 0               NOT NULL,
    creator_id          BIGINT                                  NULL,
    usage_count         INT             DEFAULT 0               NOT NULL,
    create_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted             INT             DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_wt_category ON workflow_template(category);
CREATE INDEX IF NOT EXISTS idx_wt_is_system ON workflow_template(is_system);
CREATE INDEX IF NOT EXISTS idx_wt_is_public ON workflow_template(is_public);
CREATE INDEX IF NOT EXISTS idx_wt_creator_id ON workflow_template(creator_id);

COMMENT ON TABLE workflow_template IS '工作流模板';
COMMENT ON COLUMN workflow_template.id IS 'id';
COMMENT ON COLUMN workflow_template.name IS '模板名称';
COMMENT ON COLUMN workflow_template.description IS '模板描述';
COMMENT ON COLUMN workflow_template.category IS '分类：RAG/CHATBOT/AUTOMATION/DATA_PROCESSING';
COMMENT ON COLUMN workflow_template.icon IS '图标URL';
COMMENT ON COLUMN workflow_template.definition IS '工作流定义JSON';
COMMENT ON COLUMN workflow_template.tags IS '标签JSON数组';
COMMENT ON COLUMN workflow_template.is_system IS '是否系统预置：0-否，1-是';
COMMENT ON COLUMN workflow_template.is_public IS '是否公开：0-否，1-是';
COMMENT ON COLUMN workflow_template.creator_id IS '创建者ID（系统模板为空）';
COMMENT ON COLUMN workflow_template.usage_count IS '使用次数';
COMMENT ON COLUMN workflow_template.create_time IS '创建时间';
COMMENT ON COLUMN workflow_template.update_time IS '更新时间';
COMMENT ON COLUMN workflow_template.deleted IS '是否删除';

-- =====================================================
-- 工作流触发器表
-- =====================================================
CREATE TABLE IF NOT EXISTS workflow_trigger
(
    id                  BIGSERIAL PRIMARY KEY,
    workflow_id         BIGINT                                  NOT NULL,
    type                VARCHAR(32)                             NOT NULL,
    name                VARCHAR(128)                            NOT NULL,
    enabled             SMALLINT        DEFAULT 0               NOT NULL,
    config              JSONB           DEFAULT '{}'            NOT NULL,
    last_triggered_at   TIMESTAMP                               NULL,
    trigger_count       INT             DEFAULT 0               NOT NULL,
    create_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted             INT             DEFAULT 0               NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_wtr_workflow_id ON workflow_trigger(workflow_id);
CREATE INDEX IF NOT EXISTS idx_wtr_type ON workflow_trigger(type);
CREATE INDEX IF NOT EXISTS idx_wtr_enabled ON workflow_trigger(enabled);

COMMENT ON TABLE workflow_trigger IS '工作流触发器';
COMMENT ON COLUMN workflow_trigger.id IS 'id';
COMMENT ON COLUMN workflow_trigger.workflow_id IS '工作流ID';
COMMENT ON COLUMN workflow_trigger.type IS '触发器类型：SCHEDULE/WEBHOOK/EVENT';
COMMENT ON COLUMN workflow_trigger.name IS '触发器名称';
COMMENT ON COLUMN workflow_trigger.enabled IS '是否启用：0-否，1-是';
COMMENT ON COLUMN workflow_trigger.config IS '配置JSON（cron表达式/webhook路径/事件类型等）';
COMMENT ON COLUMN workflow_trigger.last_triggered_at IS '最后触发时间';
COMMENT ON COLUMN workflow_trigger.trigger_count IS '触发次数';
COMMENT ON COLUMN workflow_trigger.create_time IS '创建时间';
COMMENT ON COLUMN workflow_trigger.update_time IS '更新时间';
COMMENT ON COLUMN workflow_trigger.deleted IS '是否删除';

-- =====================================================
-- 工作流版本历史表
-- =====================================================
CREATE TABLE IF NOT EXISTS workflow_version
(
    id                  BIGSERIAL PRIMARY KEY,
    workflow_id         BIGINT                                  NOT NULL,
    version             INT                                     NOT NULL,
    name                VARCHAR(128)                            NOT NULL,
    description         TEXT                                    NULL,
    definition          JSONB                                   NOT NULL,
    publish_note        TEXT                                    NULL,
    published_by        BIGINT                                  NOT NULL,
    create_time         TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_wv_workflow_id ON workflow_version(workflow_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_wv_workflow_version ON workflow_version(workflow_id, version);

COMMENT ON TABLE workflow_version IS '工作流版本历史';
COMMENT ON COLUMN workflow_version.id IS 'id';
COMMENT ON COLUMN workflow_version.workflow_id IS '工作流ID';
COMMENT ON COLUMN workflow_version.version IS '版本号';
COMMENT ON COLUMN workflow_version.name IS '名称快照';
COMMENT ON COLUMN workflow_version.description IS '描述快照';
COMMENT ON COLUMN workflow_version.definition IS '工作流定义快照';
COMMENT ON COLUMN workflow_version.publish_note IS '发布说明';
COMMENT ON COLUMN workflow_version.published_by IS '发布者ID';
COMMENT ON COLUMN workflow_version.create_time IS '创建时间';
