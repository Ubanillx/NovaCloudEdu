-- ============================================================
-- 知识库 RAG 检索配置扩展
-- 新增字段: retrieval_mode, enable_query_rewrite, use_dynamic_top_k
-- 全文检索支持: pg_trgm 扩展 + GIN 索引
-- ============================================================

-- 1. 添加 RAG 检索配置字段到 knowledge_base 表
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS retrieval_mode VARCHAR(32) DEFAULT 'HYBRID_RERANK';
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS enable_query_rewrite BOOLEAN DEFAULT FALSE;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS use_dynamic_top_k BOOLEAN DEFAULT TRUE;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS default_top_k INTEGER DEFAULT 5;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS query_rewrite_model_id VARCHAR(64) DEFAULT 'dashscope/qwen-turbo';

COMMENT ON COLUMN knowledge_base.retrieval_mode IS '检索模式: VECTOR_ONLY/HYBRID/HYBRID_RERANK';
COMMENT ON COLUMN knowledge_base.enable_query_rewrite IS '是否启用LLM查询改写';
COMMENT ON COLUMN knowledge_base.use_dynamic_top_k IS '是否启用动态topK';
COMMENT ON COLUMN knowledge_base.query_rewrite_model_id IS 'Query改写使用的LLM模型ID，如 dashscope/qwen-turbo';

-- 2. 启用 pg_trgm 扩展（支持 trigram 模糊匹配，用于 BM25 降级）
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- 3. 为 knowledge_chunk.content 创建全文检索 GIN 索引
CREATE INDEX IF NOT EXISTS idx_knowledge_chunk_content_tsvector
    ON knowledge_chunk USING GIN (to_tsvector('simple', content))
    WHERE is_delete = 0;

-- 4. 为 knowledge_chunk.content 创建 trigram GIN 索引（模糊匹配降级）
CREATE INDEX IF NOT EXISTS idx_knowledge_chunk_content_trigram
    ON knowledge_chunk USING GIN (content gin_trgm_ops)
    WHERE is_delete = 0;

-- 5. 更新现有知识库的默认 RAG 配置
UPDATE knowledge_base
SET retrieval_mode = 'HYBRID_RERANK',
    enable_query_rewrite = FALSE,
    use_dynamic_top_k = TRUE
WHERE retrieval_mode IS NULL;
