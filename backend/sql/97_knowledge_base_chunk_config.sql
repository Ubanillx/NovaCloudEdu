-- 知识库切分配置增强：新增切分策略、父子chunk模式、元数据保留等字段
-- 执行前请确保 knowledge_base 和 knowledge_chunk 表已存在

-- ===================== knowledge_base 表新增列 =====================

ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS chunk_strategy VARCHAR(32) DEFAULT 'SEMANTIC';
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS parent_child_mode BOOLEAN DEFAULT FALSE;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS parent_chunk_size INTEGER DEFAULT 1500;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS preserve_metadata BOOLEAN DEFAULT TRUE;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS semantic_threshold DOUBLE PRECISION DEFAULT 0.5;

COMMENT ON COLUMN knowledge_base.chunk_strategy IS '切分策略: FIXED/PARAGRAPH/TITLE/SENTENCE/SEMANTIC';
COMMENT ON COLUMN knowledge_base.parent_child_mode IS '是否启用父子chunk模式';
COMMENT ON COLUMN knowledge_base.parent_chunk_size IS '父chunk大小（字符数）';
COMMENT ON COLUMN knowledge_base.preserve_metadata IS '是否保留元数据';
COMMENT ON COLUMN knowledge_base.semantic_threshold IS '语义切分相似度阈值(0~1)';

-- ===================== knowledge_chunk 表新增列 =====================

ALTER TABLE knowledge_chunk ADD COLUMN IF NOT EXISTS parent_chunk_id BIGINT DEFAULT NULL;
ALTER TABLE knowledge_chunk ADD COLUMN IF NOT EXISTS is_parent_chunk BOOLEAN DEFAULT FALSE;
ALTER TABLE knowledge_chunk ADD COLUMN IF NOT EXISTS section_title VARCHAR(512) DEFAULT NULL;

COMMENT ON COLUMN knowledge_chunk.parent_chunk_id IS '父chunk的ID（父子模式下子chunk指向父chunk）';
COMMENT ON COLUMN knowledge_chunk.is_parent_chunk IS '是否为父chunk';
COMMENT ON COLUMN knowledge_chunk.section_title IS '所属章节标题（标题切分/语义切分时提取）';

-- 父chunk索引
CREATE INDEX IF NOT EXISTS idx_knowledge_chunk_parent ON knowledge_chunk (parent_chunk_id) WHERE parent_chunk_id IS NOT NULL;
-- 父子模式过滤索引
CREATE INDEX IF NOT EXISTS idx_knowledge_chunk_is_parent ON knowledge_chunk (knowledge_base_id, is_parent_chunk) WHERE is_delete = 0;
