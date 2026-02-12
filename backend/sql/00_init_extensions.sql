-- 数据库初始化脚本
-- 注意：数据库 novacloudedu 由 Docker 环境变量 POSTGRES_DB 自动创建
-- 此脚本在 novacloudedu 数据库中自动执行

-- 启用 pgvector 扩展
CREATE EXTENSION IF NOT EXISTS vector;
