-- 为已有数据库添加 AI 批改配额列（增量迁移脚本）
-- 如果是全新部署，93_membership.sql 已包含这些列，此脚本可跳过

ALTER TABLE membership_plan ADD COLUMN IF NOT EXISTS ai_grading_daily_limit INT DEFAULT -1 NOT NULL;
ALTER TABLE membership_plan ADD COLUMN IF NOT EXISTS ai_grading_monthly_limit INT DEFAULT -1 NOT NULL;

COMMENT ON COLUMN membership_plan.ai_grading_daily_limit IS '智能批改每日限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_grading_monthly_limit IS '智能批改每月限额，-1表示无限制';

-- 更新种子数据中的批改配额
UPDATE membership_plan SET ai_grading_daily_limit = 3,   ai_grading_monthly_limit = 60   WHERE code = 'FREE'    AND ai_grading_daily_limit = -1;
UPDATE membership_plan SET ai_grading_daily_limit = 15,  ai_grading_monthly_limit = 300  WHERE code = 'BASIC'   AND ai_grading_daily_limit = -1;
UPDATE membership_plan SET ai_grading_daily_limit = -1,  ai_grading_monthly_limit = -1   WHERE code = 'PRO'     AND ai_grading_daily_limit = -1;
UPDATE membership_plan SET ai_grading_daily_limit = 50,  ai_grading_monthly_limit = 1000 WHERE code = 'TEACHER' AND ai_grading_daily_limit = -1;
