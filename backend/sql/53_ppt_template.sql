-- PPT模板领域相关表

-- PPT模板表
CREATE TABLE IF NOT EXISTS ppt_template
(
    id              BIGSERIAL PRIMARY KEY,
    name            VARCHAR(128)                        NOT NULL,
    description     VARCHAR(512)  DEFAULT ''            NOT NULL,
    cover_url       VARCHAR(1024) DEFAULT ''            NOT NULL,
    template_url    VARCHAR(1024)                       NOT NULL,
    slide_count     INT           DEFAULT 0             NOT NULL,
    structure_json  TEXT                                 NULL,
    parse_status    VARCHAR(16)   DEFAULT 'pending'     NOT NULL,
    uploader_id     BIGINT                              NULL,
    enabled         BOOLEAN       DEFAULT TRUE          NOT NULL,
    create_time     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT      DEFAULT 0             NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ppt_template_enabled ON ppt_template(enabled);
CREATE INDEX IF NOT EXISTS idx_ppt_template_uploader ON ppt_template(uploader_id);
COMMENT ON TABLE ppt_template IS 'PPT模板';
COMMENT ON COLUMN ppt_template.id IS '模板ID';
COMMENT ON COLUMN ppt_template.name IS '模板名称';
COMMENT ON COLUMN ppt_template.description IS '模板描述';
COMMENT ON COLUMN ppt_template.cover_url IS '封面预览图URL';
COMMENT ON COLUMN ppt_template.template_url IS 'PPTX模板文件OSS URL';
COMMENT ON COLUMN ppt_template.slide_count IS '幻灯片页数';
COMMENT ON COLUMN ppt_template.structure_json IS '模板结构JSON（解析后缓存）';
COMMENT ON COLUMN ppt_template.parse_status IS '解析状态: pending/parsing/ready/failed';
COMMENT ON COLUMN ppt_template.uploader_id IS '上传者用户ID';

-- 已有数据库增量迁移：添加 parse_status 列，已有行默认 ready（因为之前同步解析）
-- ALTER TABLE ppt_template ADD COLUMN IF NOT EXISTS parse_status VARCHAR(16) DEFAULT 'pending' NOT NULL;
-- UPDATE ppt_template SET parse_status = 'ready' WHERE structure_json IS NOT NULL AND structure_json != '';
COMMENT ON COLUMN ppt_template.enabled IS '是否启用';
COMMENT ON COLUMN ppt_template.create_time IS '创建时间';
COMMENT ON COLUMN ppt_template.update_time IS '更新时间';
COMMENT ON COLUMN ppt_template.is_delete IS '是否删除';
