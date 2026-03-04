-- PPT项目表：一个项目包含多个文档，可关联多个生成会话

CREATE TABLE IF NOT EXISTS ppt_project
(
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT                              NOT NULL,
    name        VARCHAR(256)                        NOT NULL,
    description TEXT                                NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT  DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ppt_project_user ON ppt_project (user_id);
COMMENT ON TABLE ppt_project IS 'PPT项目';
COMMENT ON COLUMN ppt_project.name IS '项目名称';
COMMENT ON COLUMN ppt_project.description IS '项目描述';

-- PPT项目文档表：用户上传的参考文档

CREATE TABLE IF NOT EXISTS ppt_project_document
(
    id          BIGSERIAL PRIMARY KEY,
    project_id  BIGINT                              NOT NULL,
    file_name   VARCHAR(512)                        NOT NULL,
    file_url    VARCHAR(1024)                       NOT NULL,
    file_type   VARCHAR(32)                         NULL,
    file_size   BIGINT    DEFAULT 0                 NOT NULL,
    content     TEXT                                NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT  DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ppt_project_doc_project ON ppt_project_document (project_id);
COMMENT ON TABLE ppt_project_document IS 'PPT项目文档';
COMMENT ON COLUMN ppt_project_document.file_name IS '文件名';
COMMENT ON COLUMN ppt_project_document.file_url IS '文件OSS URL';
COMMENT ON COLUMN ppt_project_document.file_type IS '文件类型: pdf/docx/txt/md/pptx';
COMMENT ON COLUMN ppt_project_document.file_size IS '文件大小(字节)';
COMMENT ON COLUMN ppt_project_document.content IS '提取的文本内容(供AI使用)';
