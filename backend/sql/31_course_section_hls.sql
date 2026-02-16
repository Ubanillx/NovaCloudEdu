-- 课程小节增加 HLS 加密相关字段
ALTER TABLE course_section ADD COLUMN IF NOT EXISTS hls_url VARCHAR(1024) NULL;
ALTER TABLE course_section ADD COLUMN IF NOT EXISTS encryption_key_id VARCHAR(64) NULL;
ALTER TABLE course_section ADD COLUMN IF NOT EXISTS transcode_status SMALLINT DEFAULT 0 NOT NULL;
-- transcode_status: 0-未转码, 1-转码中, 2-已完成, 3-失败

COMMENT ON COLUMN course_section.hls_url IS 'HLS播放地址(m3u8)';
COMMENT ON COLUMN course_section.encryption_key_id IS 'AES-128加密密钥ID';
COMMENT ON COLUMN course_section.transcode_status IS '转码状态: 0-未转码, 1-转码中, 2-已完成, 3-失败';
