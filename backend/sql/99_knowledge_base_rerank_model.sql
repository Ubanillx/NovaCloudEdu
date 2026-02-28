-- ============================================================
-- 知识库 Rerank 模型配置扩展
-- 新增字段: rerank_model (支持用户选择 Rerank 模型)
-- ============================================================

ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS rerank_model VARCHAR(64) DEFAULT 'qwen3-rerank';

COMMENT ON COLUMN knowledge_base.rerank_model IS 'Rerank精排模型: qwen3-rerank / gte-rerank-v2 / qwen3-vl-rerank';

-- 更新现有知识库的默认 Rerank 模型
UPDATE knowledge_base
SET rerank_model = 'qwen3-rerank'
WHERE rerank_model IS NULL;
