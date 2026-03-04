-- ppt_generation_session 增加 project_id 关联和 outline_json 字段

ALTER TABLE ppt_generation_session ADD COLUMN IF NOT EXISTS project_id BIGINT NULL;
ALTER TABLE ppt_generation_session ADD COLUMN IF NOT EXISTS outline_json TEXT NULL;

CREATE INDEX IF NOT EXISTS idx_ppt_gen_session_project ON ppt_generation_session (project_id);
COMMENT ON COLUMN ppt_generation_session.project_id IS '关联的PPT项目ID';
COMMENT ON COLUMN ppt_generation_session.outline_json IS '结构化大纲JSON(新格式)';
