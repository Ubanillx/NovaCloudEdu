-- 课程小节增加缩略图雪碧图字段（用于视频进度条预览）
ALTER TABLE course_section ADD COLUMN IF NOT EXISTS thumbnail_url VARCHAR(1024) NULL;
ALTER TABLE course_section ADD COLUMN IF NOT EXISTS thumbnail_count INTEGER DEFAULT 0;

COMMENT ON COLUMN course_section.thumbnail_url IS '视频缩略图雪碧图URL';
COMMENT ON COLUMN course_section.thumbnail_count IS '缩略图数量';
