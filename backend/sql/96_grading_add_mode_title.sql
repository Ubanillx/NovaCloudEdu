-- 为已有数据库的 homework_submission 表添加 grading_mode 和 title 列（增量迁移）
-- 全新部署已在 94_grading.sql 中包含，此脚本可跳过

ALTER TABLE homework_submission ADD COLUMN IF NOT EXISTS grading_mode VARCHAR(20) DEFAULT 'GENERAL' NOT NULL;
ALTER TABLE homework_submission ADD COLUMN IF NOT EXISTS title VARCHAR(200) NULL;

-- subject 列从 NOT NULL 改为允许 NULL（通用模式下 AI 推断）
ALTER TABLE homework_submission ALTER COLUMN subject DROP NOT NULL;

COMMENT ON COLUMN homework_submission.grading_mode IS '批改模式: EXAM_PAPER(试卷批改)/GENERAL(通用作业助手)';
COMMENT ON COLUMN homework_submission.title IS '作业标题(通用模式可自定义)';
COMMENT ON COLUMN homework_submission.subject IS '学科(可空，通用模式下AI自动推断): MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS';
