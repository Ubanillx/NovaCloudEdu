-- PPT生成会话表

CREATE TABLE IF NOT EXISTS ppt_generation_session
(
    id                BIGSERIAL PRIMARY KEY,
    user_id           BIGINT                              NOT NULL,
    state             VARCHAR(32)   DEFAULT 'init'        NOT NULL,
    topic             TEXT                                 NOT NULL,
    outline_markdown  TEXT                                 NULL,
    template_id       BIGINT                              NULL,
    template_url      VARCHAR(1024)                       NULL,
    template_json     TEXT                                 NULL,
    slides_json       TEXT                                 NULL,
    result_url        VARCHAR(1024)                       NULL,
    create_time       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete         SMALLINT      DEFAULT 0             NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ppt_gen_session_user ON ppt_generation_session(user_id);
CREATE INDEX IF NOT EXISTS idx_ppt_gen_session_state ON ppt_generation_session(state);
COMMENT ON TABLE ppt_generation_session IS 'PPT生成会话';
COMMENT ON COLUMN ppt_generation_session.id IS '会话ID';
COMMENT ON COLUMN ppt_generation_session.user_id IS '用户ID';
COMMENT ON COLUMN ppt_generation_session.state IS '状态: init/generating_outline/outline_ready/awaiting_template/parsing_template/template_ready/generating_slides/assembling/completed/failed';
COMMENT ON COLUMN ppt_generation_session.topic IS '用户输入的主题';
COMMENT ON COLUMN ppt_generation_session.outline_markdown IS 'AI生成的Markdown大纲';
COMMENT ON COLUMN ppt_generation_session.template_id IS '选择的PPT模板ID';
COMMENT ON COLUMN ppt_generation_session.template_url IS '模板文件URL';
COMMENT ON COLUMN ppt_generation_session.template_json IS '解析后的模板结构JSON';
COMMENT ON COLUMN ppt_generation_session.slides_json IS 'AI生成的slides填充配置JSON';
COMMENT ON COLUMN ppt_generation_session.result_url IS '最终生成的PPT文件URL';
COMMENT ON COLUMN ppt_generation_session.create_time IS '创建时间';
COMMENT ON COLUMN ppt_generation_session.update_time IS '更新时间';
COMMENT ON COLUMN ppt_generation_session.is_delete IS '是否删除';
