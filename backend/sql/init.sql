-- 数据库初始化

-- 创建库（需在psql中以超级用户执行，或使用createdb命令）
CREATE DATABASE NovaCloudEdu

-- 启用pgvector扩展（需在smart_class库中执行）
-- \c NovaCloudEdu
CREATE EXTENSION IF NOT EXISTS vector;
