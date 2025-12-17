-- 文件上传表
CREATE TABLE IF NOT EXISTS file_upload
(
    id            BIGSERIAL PRIMARY KEY,
    file_name     VARCHAR(256)                       NOT NULL,
    original_name VARCHAR(512)                       NOT NULL,
    file_url      VARCHAR(1024)                      NOT NULL,
    file_size     BIGINT                             NOT NULL,
    content_type  VARCHAR(128)                       NULL,
    business_type VARCHAR(64)                        NOT NULL,
    uploader_id   BIGINT                             NOT NULL,
    create_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete     SMALLINT DEFAULT 0                 NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_fu_uploader_id ON file_upload(uploader_id);
CREATE INDEX IF NOT EXISTS idx_fu_business_type ON file_upload(business_type);
CREATE INDEX IF NOT EXISTS idx_fu_create_time ON file_upload(create_time);

COMMENT ON TABLE file_upload IS '文件上传记录';
COMMENT ON COLUMN file_upload.id IS 'id';
COMMENT ON COLUMN file_upload.file_name IS '文件名（UUID）';
COMMENT ON COLUMN file_upload.original_name IS '原始文件名';
COMMENT ON COLUMN file_upload.file_url IS '文件访问URL';
COMMENT ON COLUMN file_upload.file_size IS '文件大小（字节）';
COMMENT ON COLUMN file_upload.content_type IS '文件类型';
COMMENT ON COLUMN file_upload.business_type IS '业务类型（决定存储文件夹）';
COMMENT ON COLUMN file_upload.uploader_id IS '上传者ID';
COMMENT ON COLUMN file_upload.create_time IS '上传时间';
COMMENT ON COLUMN file_upload.is_delete IS '是否删除';
