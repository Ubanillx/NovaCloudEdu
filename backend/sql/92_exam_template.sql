-- 试卷模板表
CREATE TABLE IF NOT EXISTS exam_template
(
    id              BIGSERIAL PRIMARY KEY,
    name            VARCHAR(100)                           NOT NULL,
    description     VARCHAR(500)                           NULL,
    template_url    VARCHAR(500)                           NOT NULL,
    cover_url       VARCHAR(500)                           NULL,
    creator_id      BIGINT                                 NOT NULL,
    is_system       BOOLEAN      DEFAULT FALSE             NOT NULL,
    is_enabled      BOOLEAN      DEFAULT TRUE              NOT NULL,
    create_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT     DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_exam_template_creator ON exam_template(creator_id);
COMMENT ON TABLE exam_template IS '试卷排版模板';
COMMENT ON COLUMN exam_template.name IS '模板名称';
COMMENT ON COLUMN exam_template.description IS '模板描述';
COMMENT ON COLUMN exam_template.template_url IS 'OSS上的.typ模板文件URL';
COMMENT ON COLUMN exam_template.cover_url IS '预览封面图URL';
COMMENT ON COLUMN exam_template.is_system IS '是否系统内置模板';
COMMENT ON COLUMN exam_template.is_enabled IS '是否启用';

-- 试卷表新增模板ID字段
ALTER TABLE exam_paper ADD COLUMN IF NOT EXISTS template_id BIGINT NULL;
COMMENT ON COLUMN exam_paper.template_id IS '关联的试卷模板ID，NULL使用系统默认模板';
