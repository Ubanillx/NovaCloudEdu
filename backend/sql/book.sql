-- 电子阅览系统相关表

-- 书籍表
CREATE TABLE IF NOT EXISTS book
(
    id                BIGSERIAL PRIMARY KEY,
    title             VARCHAR(255)                             NOT NULL,
    author            VARCHAR(100)                             NULL,
    cover_url         VARCHAR(500)                             NULL,
    origin_file_url   VARCHAR(500)                             NOT NULL,
    file_type         VARCHAR(20)                              NOT NULL,
    status            SMALLINT       DEFAULT 0                 NOT NULL,
    total_chapters    INT            DEFAULT 0                 NOT NULL,
    word_count        INT            DEFAULT 0                 NOT NULL,
    file_size         BIGINT         DEFAULT 0                 NOT NULL,
    admin_id          BIGINT                                   NOT NULL,
    create_time       TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time       TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete         SMALLINT       DEFAULT 0                 NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_book_status ON book(status);
CREATE INDEX IF NOT EXISTS idx_book_file_type ON book(file_type);
CREATE INDEX IF NOT EXISTS idx_book_admin_id ON book(admin_id);
CREATE INDEX IF NOT EXISTS idx_book_create_time ON book(create_time);

COMMENT ON TABLE book IS '书籍表';
COMMENT ON COLUMN book.id IS '书籍ID';
COMMENT ON COLUMN book.title IS '书名';
COMMENT ON COLUMN book.author IS '作者';
COMMENT ON COLUMN book.cover_url IS '封面图片URL';
COMMENT ON COLUMN book.origin_file_url IS '原始文件URL（OSS地址）';
COMMENT ON COLUMN book.file_type IS '文件类型：EPUB, DOCX, TXT, PDF';
COMMENT ON COLUMN book.status IS '状态：0-已上传，1-解析中，2-就绪，3-解析失败';
COMMENT ON COLUMN book.total_chapters IS '总章节数';
COMMENT ON COLUMN book.word_count IS '总字数';
COMMENT ON COLUMN book.file_size IS '文件大小（字节）';
COMMENT ON COLUMN book.admin_id IS '上传管理员ID';
COMMENT ON COLUMN book.create_time IS '创建时间';
COMMENT ON COLUMN book.update_time IS '更新时间';
COMMENT ON COLUMN book.is_delete IS '是否删除：0-否，1-是';


-- 章节表
CREATE TABLE IF NOT EXISTS chapter
(
    id              BIGSERIAL PRIMARY KEY,
    book_id         BIGINT                                   NOT NULL,
    title           VARCHAR(255)                             NOT NULL,
    chapter_index   INT                                      NOT NULL,
    word_count      INT            DEFAULT 0                 NOT NULL,
    content         TEXT                                     NOT NULL,
    content_hash    VARCHAR(64)                              NULL,
    create_time     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT       DEFAULT 0                 NOT NULL,
    CONSTRAINT uk_chapter_book_index UNIQUE (book_id, chapter_index)
);

CREATE INDEX IF NOT EXISTS idx_chapter_book_id ON chapter(book_id);
CREATE INDEX IF NOT EXISTS idx_chapter_book_index ON chapter(book_id, chapter_index);

COMMENT ON TABLE chapter IS '章节表';
COMMENT ON COLUMN chapter.id IS '章节ID';
COMMENT ON COLUMN chapter.book_id IS '所属书籍ID';
COMMENT ON COLUMN chapter.title IS '章节标题';
COMMENT ON COLUMN chapter.chapter_index IS '章节序号（从0开始）';
COMMENT ON COLUMN chapter.word_count IS '章节字数';
COMMENT ON COLUMN chapter.content IS '章节内容（清洗后的HTML）';
COMMENT ON COLUMN chapter.content_hash IS '内容哈希值（用于去重和版本控制）';
COMMENT ON COLUMN chapter.create_time IS '创建时间';
COMMENT ON COLUMN chapter.update_time IS '更新时间';
COMMENT ON COLUMN chapter.is_delete IS '是否删除：0-否，1-是';


-- 用户书架表
CREATE TABLE IF NOT EXISTS user_book_shelf
(
    id                  BIGSERIAL PRIMARY KEY,
    user_id             BIGINT                                   NOT NULL,
    book_id             BIGINT                                   NOT NULL,
    last_chapter_index  INT            DEFAULT 0                 NOT NULL,
    last_position       INT            DEFAULT 0                 NOT NULL,
    reading_progress    DECIMAL(5, 2)  DEFAULT 0.00              NOT NULL,
    added_time          TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_read_time      TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete           SMALLINT       DEFAULT 0                 NOT NULL,
    CONSTRAINT uk_user_book UNIQUE (user_id, book_id)
);

CREATE INDEX IF NOT EXISTS idx_shelf_user_id ON user_book_shelf(user_id);
CREATE INDEX IF NOT EXISTS idx_shelf_book_id ON user_book_shelf(book_id);
CREATE INDEX IF NOT EXISTS idx_shelf_last_read ON user_book_shelf(user_id, last_read_time);

COMMENT ON TABLE user_book_shelf IS '用户书架表';
COMMENT ON COLUMN user_book_shelf.id IS '书架记录ID';
COMMENT ON COLUMN user_book_shelf.user_id IS '用户ID';
COMMENT ON COLUMN user_book_shelf.book_id IS '书籍ID';
COMMENT ON COLUMN user_book_shelf.last_chapter_index IS '最后阅读章节序号';
COMMENT ON COLUMN user_book_shelf.last_position IS '章节内阅读位置（字符偏移量）';
COMMENT ON COLUMN user_book_shelf.reading_progress IS '阅读进度百分比（0.00-100.00）';
COMMENT ON COLUMN user_book_shelf.added_time IS '添加到书架时间';
COMMENT ON COLUMN user_book_shelf.last_read_time IS '最后阅读时间';
COMMENT ON COLUMN user_book_shelf.is_delete IS '是否删除：0-否，1-是';


-- 书籍标签表
CREATE TABLE IF NOT EXISTS book_tag
(
    id          BIGSERIAL PRIMARY KEY,
    book_id     BIGINT                                   NOT NULL,
    tag_name    VARCHAR(50)                              NOT NULL,
    create_time TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_book_tag_book_id ON book_tag(book_id);
CREATE INDEX IF NOT EXISTS idx_book_tag_name ON book_tag(tag_name);

COMMENT ON TABLE book_tag IS '书籍标签表';
COMMENT ON COLUMN book_tag.id IS '标签ID';
COMMENT ON COLUMN book_tag.book_id IS '书籍ID';
COMMENT ON COLUMN book_tag.tag_name IS '标签名称';
COMMENT ON COLUMN book_tag.create_time IS '创建时间';


-- 阅读笔记表（可选，为后续功能预留）
CREATE TABLE IF NOT EXISTS reading_note
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                                   NOT NULL,
    book_id         BIGINT                                   NOT NULL,
    chapter_id      BIGINT                                   NOT NULL,
    note_content    TEXT                                     NOT NULL,
    selected_text   TEXT                                     NULL,
    position_start  INT                                      NULL,
    position_end    INT                                      NULL,
    create_time     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT       DEFAULT 0                 NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_note_user_book ON reading_note(user_id, book_id);
CREATE INDEX IF NOT EXISTS idx_note_chapter ON reading_note(chapter_id);

COMMENT ON TABLE reading_note IS '阅读笔记表';
COMMENT ON COLUMN reading_note.id IS '笔记ID';
COMMENT ON COLUMN reading_note.user_id IS '用户ID';
COMMENT ON COLUMN reading_note.book_id IS '书籍ID';
COMMENT ON COLUMN reading_note.chapter_id IS '章节ID';
COMMENT ON COLUMN reading_note.note_content IS '笔记内容';
COMMENT ON COLUMN reading_note.selected_text IS '选中的文本';
COMMENT ON COLUMN reading_note.position_start IS '选中文本起始位置';
COMMENT ON COLUMN reading_note.position_end IS '选中文本结束位置';
COMMENT ON COLUMN reading_note.create_time IS '创建时间';
COMMENT ON COLUMN reading_note.update_time IS '更新时间';
COMMENT ON COLUMN reading_note.is_delete IS '是否删除：0-否，1-是';


-- 书签表（可选，为后续功能预留）
CREATE TABLE IF NOT EXISTS reading_bookmark
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                                   NOT NULL,
    book_id         BIGINT                                   NOT NULL,
    chapter_id      BIGINT                                   NOT NULL,
    chapter_index   INT                                      NOT NULL,
    position        INT            DEFAULT 0                 NOT NULL,
    bookmark_name   VARCHAR(100)                             NULL,
    create_time     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT       DEFAULT 0                 NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_bookmark_user_book ON reading_bookmark(user_id, book_id);
CREATE INDEX IF NOT EXISTS idx_bookmark_chapter ON reading_bookmark(chapter_id);

COMMENT ON TABLE reading_bookmark IS '阅读书签表';
COMMENT ON COLUMN reading_bookmark.id IS '书签ID';
COMMENT ON COLUMN reading_bookmark.user_id IS '用户ID';
COMMENT ON COLUMN reading_bookmark.book_id IS '书籍ID';
COMMENT ON COLUMN reading_bookmark.chapter_id IS '章节ID';
COMMENT ON COLUMN reading_bookmark.chapter_index IS '章节序号';
COMMENT ON COLUMN reading_bookmark.position IS '书签位置（字符偏移量）';
COMMENT ON COLUMN reading_bookmark.bookmark_name IS '书签名称';
COMMENT ON COLUMN reading_bookmark.create_time IS '创建时间';
COMMENT ON COLUMN reading_bookmark.is_delete IS '是否删除：0-否，1-是';


-- ========================================
-- 向量化和全文搜索支持
-- ========================================

-- 1. 添加 pgvector 扩展(用于向量相似度搜索)
CREATE EXTENSION IF NOT EXISTS vector;

-- 2. 为笔记表添加字段
ALTER TABLE reading_note ADD COLUMN IF NOT EXISTS chapter_index INT;
ALTER TABLE reading_note ADD COLUMN IF NOT EXISTS note_color VARCHAR(20) DEFAULT '#FFEB3B';

-- 3. 为书签表添加字段
ALTER TABLE reading_bookmark ADD COLUMN IF NOT EXISTS note TEXT;

-- 4. 为章节表添加向量列
ALTER TABLE chapter ADD COLUMN IF NOT EXISTS content_vector vector(1536);
ALTER TABLE chapter ADD COLUMN IF NOT EXISTS vector_model VARCHAR(100);
ALTER TABLE chapter ADD COLUMN IF NOT EXISTS vectorized_at TIMESTAMP;

-- 5. 创建向量索引(使用 HNSW 算法,适合大规模向量检索)
CREATE INDEX IF NOT EXISTS idx_chapter_content_vector 
ON chapter USING hnsw (content_vector vector_cosine_ops);

-- 6. 为书籍表添加全文搜索列
ALTER TABLE book ADD COLUMN IF NOT EXISTS search_vector tsvector;

-- 7. 创建全文搜索索引
CREATE INDEX IF NOT EXISTS idx_book_search_vector 
ON book USING gin(search_vector);

-- 8. 创建触发器函数,自动更新全文搜索向量
CREATE OR REPLACE FUNCTION update_book_search_vector()
RETURNS TRIGGER AS $$
BEGIN
    NEW.search_vector := 
        setweight(to_tsvector('simple', COALESCE(NEW.title, '')), 'A') ||
        setweight(to_tsvector('simple', COALESCE(NEW.author, '')), 'B');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 9. 创建触发器
DROP TRIGGER IF EXISTS trigger_update_book_search_vector ON book;
CREATE TRIGGER trigger_update_book_search_vector
    BEFORE INSERT OR UPDATE ON book
    FOR EACH ROW
    EXECUTE FUNCTION update_book_search_vector();

-- 10. 为现有数据更新全文搜索向量
UPDATE book SET search_vector = 
    setweight(to_tsvector('simple', COALESCE(title, '')), 'A') ||
    setweight(to_tsvector('simple', COALESCE(author, '')), 'B')
WHERE search_vector IS NULL;

-- 11. 为章节表添加全文搜索列
ALTER TABLE chapter ADD COLUMN IF NOT EXISTS content_search_vector tsvector;

-- 12. 创建章节内容全文搜索索引
CREATE INDEX IF NOT EXISTS idx_chapter_content_search_vector 
ON chapter USING gin(content_search_vector);

-- 13. 创建章节全文搜索触发器函数
CREATE OR REPLACE FUNCTION update_chapter_search_vector()
RETURNS TRIGGER AS $$
BEGIN
    -- 只索引纯文本内容,去除HTML标签
    NEW.content_search_vector := 
        setweight(to_tsvector('simple', COALESCE(NEW.title, '')), 'A') ||
        setweight(to_tsvector('simple', COALESCE(regexp_replace(NEW.content, '<[^>]+>', '', 'g'), '')), 'B');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 14. 创建章节触发器
DROP TRIGGER IF EXISTS trigger_update_chapter_search_vector ON chapter;
CREATE TRIGGER trigger_update_chapter_search_vector
    BEFORE INSERT OR UPDATE ON chapter
    FOR EACH ROW
    EXECUTE FUNCTION update_chapter_search_vector();

-- 15. 添加向量搜索辅助函数
CREATE OR REPLACE FUNCTION search_similar_chapters(
    query_vector vector(1536),
    similarity_threshold FLOAT DEFAULT 0.7,
    result_limit INT DEFAULT 10
)
RETURNS TABLE (
    chapter_id BIGINT,
    book_id BIGINT,
    title VARCHAR,
    similarity FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id,
        c.book_id,
        c.title,
        1 - (c.content_vector <=> query_vector) as similarity
    FROM chapter c
    WHERE c.content_vector IS NOT NULL
        AND 1 - (c.content_vector <=> query_vector) >= similarity_threshold
        AND c.is_delete = 0
    ORDER BY c.content_vector <=> query_vector
    LIMIT result_limit;
END;
$$ LANGUAGE plpgsql;

-- 16. 添加全文搜索辅助函数
CREATE OR REPLACE FUNCTION search_books_fulltext(
    search_query TEXT,
    result_limit INT DEFAULT 20
)
RETURNS TABLE (
    book_id BIGINT,
    title VARCHAR,
    author VARCHAR,
    rank FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        b.id,
        b.title,
        b.author,
        ts_rank(b.search_vector, to_tsquery('simple', search_query)) as rank
    FROM book b
    WHERE b.search_vector @@ to_tsquery('simple', search_query)
        AND b.is_delete = 0
    ORDER BY rank DESC
    LIMIT result_limit;
END;
$$ LANGUAGE plpgsql;

-- 17. 添加章节内容全文搜索函数
CREATE OR REPLACE FUNCTION search_chapters_fulltext(
    search_query TEXT,
    book_id_filter BIGINT DEFAULT NULL,
    result_limit INT DEFAULT 50
)
RETURNS TABLE (
    chapter_id BIGINT,
    book_id BIGINT,
    title VARCHAR,
    chapter_index INT,
    rank FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id,
        c.book_id,
        c.title,
        c.chapter_index,
        ts_rank(c.content_search_vector, to_tsquery('simple', search_query)) as rank
    FROM chapter c
    WHERE c.content_search_vector @@ to_tsquery('simple', search_query)
        AND c.is_delete = 0
        AND (book_id_filter IS NULL OR c.book_id = book_id_filter)
    ORDER BY rank DESC
    LIMIT result_limit;
END;
$$ LANGUAGE plpgsql;

-- 18. 添加注释
COMMENT ON COLUMN chapter.content_vector IS '章节内容的向量表示,用于语义相似度搜索';
COMMENT ON COLUMN chapter.vector_model IS '生成向量使用的模型名称';
COMMENT ON COLUMN chapter.vectorized_at IS '向量化时间';
COMMENT ON COLUMN book.search_vector IS '书籍全文搜索向量';
COMMENT ON COLUMN chapter.content_search_vector IS '章节内容全文搜索向量';
COMMENT ON COLUMN reading_note.chapter_index IS '章节序号';
COMMENT ON COLUMN reading_note.note_color IS '笔记颜色标记';
COMMENT ON COLUMN reading_bookmark.note IS '书签备注';


-- ========================================
-- AI功能相关表
-- ========================================

-- 19. AI对话表
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

COMMENT ON TABLE ai_conversation IS 'AI对话记录表';
COMMENT ON COLUMN ai_conversation.id IS '对话ID';
COMMENT ON COLUMN ai_conversation.user_id IS '用户ID';
COMMENT ON COLUMN ai_conversation.book_id IS '书籍ID';
COMMENT ON COLUMN ai_conversation.chapter_id IS '章节ID（可选）';
COMMENT ON COLUMN ai_conversation.conversation_type IS '对话类型：SUMMARY-总结, QA-问答, KNOWLEDGE-知识点, QUIZ-测试';
COMMENT ON COLUMN ai_conversation.messages IS '对话消息列表（JSON格式）';
COMMENT ON COLUMN ai_conversation.create_time IS '创建时间';
COMMENT ON COLUMN ai_conversation.update_time IS '更新时间';
COMMENT ON COLUMN ai_conversation.is_delete IS '是否删除：0-否，1-是';

-- 20. 章节总结表
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

COMMENT ON TABLE chapter_summary IS '章节总结表';
COMMENT ON COLUMN chapter_summary.id IS '总结ID';
COMMENT ON COLUMN chapter_summary.chapter_id IS '章节ID';
COMMENT ON COLUMN chapter_summary.summary_type IS '总结类型：BRIEF-简短, DETAILED-详细, KEYPOINTS-要点';
COMMENT ON COLUMN chapter_summary.content IS '总结内容';
COMMENT ON COLUMN chapter_summary.key_points IS '关键要点列表（JSON格式）';
COMMENT ON COLUMN chapter_summary.ai_model IS '使用的AI模型';
COMMENT ON COLUMN chapter_summary.is_cached IS '是否已缓存';
COMMENT ON COLUMN chapter_summary.create_time IS '创建时间';
COMMENT ON COLUMN chapter_summary.is_delete IS '是否删除：0-否，1-是';

-- 21. 知识点表
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

COMMENT ON TABLE knowledge_point IS '知识点表';
COMMENT ON COLUMN knowledge_point.id IS '知识点ID';
COMMENT ON COLUMN knowledge_point.chapter_id IS '章节ID';
COMMENT ON COLUMN knowledge_point.point_type IS '知识点类型：CONCEPT-概念, TERM-术语, FORMULA-公式, PRINCIPLE-原理, METHOD-方法';
COMMENT ON COLUMN knowledge_point.name IS '知识点名称';
COMMENT ON COLUMN knowledge_point.description IS '知识点描述';
COMMENT ON COLUMN knowledge_point.position IS '在章节中的位置（字符偏移量）';
COMMENT ON COLUMN knowledge_point.related_chapter_ids IS '关联章节ID列表（JSON格式）';
COMMENT ON COLUMN knowledge_point.related_point_ids IS '关联知识点ID列表（JSON格式）';
COMMENT ON COLUMN knowledge_point.create_time IS '创建时间';
COMMENT ON COLUMN knowledge_point.is_delete IS '是否删除：0-否，1-是';

-- 22. 阅读测试表
CREATE TABLE IF NOT EXISTS reading_quiz (
    id BIGSERIAL PRIMARY KEY,
    chapter_id BIGINT NOT NULL,
    questions JSONB NOT NULL DEFAULT '[]'::jsonb,
    ai_model VARCHAR(50) NOT NULL,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_delete INT NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_reading_quiz_chapter ON reading_quiz(chapter_id);

COMMENT ON TABLE reading_quiz IS '阅读测试表';
COMMENT ON COLUMN reading_quiz.id IS '测试ID';
COMMENT ON COLUMN reading_quiz.chapter_id IS '章节ID';
COMMENT ON COLUMN reading_quiz.questions IS '题目列表（JSON格式）';
COMMENT ON COLUMN reading_quiz.ai_model IS '使用的AI模型';
COMMENT ON COLUMN reading_quiz.create_time IS '创建时间';
COMMENT ON COLUMN reading_quiz.is_delete IS '是否删除：0-否，1-是';
