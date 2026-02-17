-- AI电子书功能相关表（从40_book.sql提取，用于补建缺失的表）

-- AI对话表
CREATE TABLE IF NOT EXISTS ai_conversation (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    chapter_id BIGINT,
    conversation_type VARCHAR(20) NOT NULL,
    messages JSONB NOT NULL DEFAULT '[]'::jsonb,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_delete INT NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_ai_conversation_user ON ai_conversation(user_id);
CREATE INDEX IF NOT EXISTS idx_ai_conversation_book ON ai_conversation(book_id);
CREATE INDEX IF NOT EXISTS idx_ai_conversation_type ON ai_conversation(conversation_type);

-- 章节总结表
CREATE TABLE IF NOT EXISTS chapter_summary (
    id BIGSERIAL PRIMARY KEY,
    chapter_id BIGINT NOT NULL,
    summary_type VARCHAR(20) NOT NULL,
    content TEXT NOT NULL,
    key_points JSONB DEFAULT '[]'::jsonb,
    ai_model VARCHAR(50) NOT NULL,
    is_cached BOOLEAN DEFAULT TRUE,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_delete INT NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_chapter_summary_chapter ON chapter_summary(chapter_id);
CREATE INDEX IF NOT EXISTS idx_chapter_summary_type ON chapter_summary(summary_type);
CREATE UNIQUE INDEX IF NOT EXISTS idx_chapter_summary_unique ON chapter_summary(chapter_id, summary_type) WHERE is_delete = 0;

-- 知识点表
CREATE TABLE IF NOT EXISTS knowledge_point (
    id BIGSERIAL PRIMARY KEY,
    chapter_id BIGINT NOT NULL,
    point_type VARCHAR(20) NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    position INT,
    related_chapter_ids JSONB DEFAULT '[]'::jsonb,
    related_point_ids JSONB DEFAULT '[]'::jsonb,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_delete INT NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_knowledge_point_chapter ON knowledge_point(chapter_id);
CREATE INDEX IF NOT EXISTS idx_knowledge_point_type ON knowledge_point(point_type);
CREATE INDEX IF NOT EXISTS idx_knowledge_point_name ON knowledge_point(name);

-- 阅读测试表
CREATE TABLE IF NOT EXISTS reading_quiz (
    id BIGSERIAL PRIMARY KEY,
    chapter_id BIGINT NOT NULL,
    questions JSONB NOT NULL DEFAULT '[]'::jsonb,
    ai_model VARCHAR(50) NOT NULL,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_delete INT NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_reading_quiz_chapter ON reading_quiz(chapter_id);
