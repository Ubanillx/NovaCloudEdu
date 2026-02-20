-- 会员系统相关表

-- 会员计划表（管理员配置）
CREATE TABLE IF NOT EXISTS membership_plan
(
    id                    BIGSERIAL PRIMARY KEY,
    name                  VARCHAR(128)                           NOT NULL,
    code                  VARCHAR(64)                            NOT NULL,
    description           TEXT                                   NULL,
    price                 DECIMAL(10, 2) DEFAULT 0.00            NOT NULL,
    duration_days         INT            DEFAULT 30              NOT NULL,
    ai_chat_daily_limit   INT            DEFAULT -1              NOT NULL,
    ai_chat_monthly_limit INT            DEFAULT -1              NOT NULL,
    ai_ppt_daily_limit    INT            DEFAULT -1              NOT NULL,
    ai_ppt_monthly_limit  INT            DEFAULT -1              NOT NULL,
    ai_exam_daily_limit   INT            DEFAULT -1              NOT NULL,
    ai_exam_monthly_limit INT            DEFAULT -1              NOT NULL,
    ai_book_daily_limit   INT            DEFAULT -1              NOT NULL,
    ai_book_monthly_limit INT            DEFAULT -1              NOT NULL,
    ai_grading_daily_limit INT           DEFAULT -1              NOT NULL,
    ai_grading_monthly_limit INT         DEFAULT -1              NOT NULL,
    course_member_access  SMALLINT       DEFAULT 0               NOT NULL,
    is_default            SMALLINT       DEFAULT 0               NOT NULL,
    sort_order            INT            DEFAULT 0               NOT NULL,
    create_time           TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time           TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete             SMALLINT       DEFAULT 0               NOT NULL,
    CONSTRAINT uk_membership_plan_code UNIQUE (code)
);
COMMENT ON TABLE membership_plan IS '会员计划';
COMMENT ON COLUMN membership_plan.id IS 'id';
COMMENT ON COLUMN membership_plan.name IS '计划名称，如：免费版、基础版、专业版';
COMMENT ON COLUMN membership_plan.code IS '计划编码：FREE/BASIC/PRO/TEACHER';
COMMENT ON COLUMN membership_plan.description IS '计划描述';
COMMENT ON COLUMN membership_plan.price IS '价格（元）';
COMMENT ON COLUMN membership_plan.duration_days IS '有效期天数，0表示永久';
COMMENT ON COLUMN membership_plan.ai_chat_daily_limit IS 'AI对话每日限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_chat_monthly_limit IS 'AI对话每月限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_ppt_daily_limit IS 'PPT生成每日限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_ppt_monthly_limit IS 'PPT生成每月限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_exam_daily_limit IS 'AI出题每日限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_exam_monthly_limit IS 'AI出题每月限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_book_daily_limit IS '电子书AI每日限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_book_monthly_limit IS '电子书AI每月限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_grading_daily_limit IS '智能批改每日限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.ai_grading_monthly_limit IS '智能批改每月限额，-1表示无限制';
COMMENT ON COLUMN membership_plan.course_member_access IS '是否可访问会员课：0-否，1-是';
COMMENT ON COLUMN membership_plan.is_default IS '是否默认计划（未开通会员的用户使用）：0-否，1-是';
COMMENT ON COLUMN membership_plan.sort_order IS '排序，越小越靠前';
COMMENT ON COLUMN membership_plan.create_time IS '创建时间';
COMMENT ON COLUMN membership_plan.update_time IS '更新时间';
COMMENT ON COLUMN membership_plan.is_delete IS '是否删除';

-- 用户会员表
CREATE TABLE IF NOT EXISTS user_membership
(
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT                             NOT NULL,
    plan_id     BIGINT                             NOT NULL,
    order_no    VARCHAR(64)                        NULL,
    start_time  TIMESTAMP                          NOT NULL,
    expire_time TIMESTAMP                          NULL,
    status      SMALLINT DEFAULT 0                 NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_um_user_id ON user_membership(user_id);
CREATE INDEX IF NOT EXISTS idx_um_plan_id ON user_membership(plan_id);
CREATE INDEX IF NOT EXISTS idx_um_status ON user_membership(status);
CREATE INDEX IF NOT EXISTS idx_um_order_no ON user_membership(order_no);
CREATE INDEX IF NOT EXISTS idx_um_expire_time ON user_membership(expire_time);
COMMENT ON TABLE user_membership IS '用户会员';
COMMENT ON COLUMN user_membership.id IS 'id';
COMMENT ON COLUMN user_membership.user_id IS '用户id';
COMMENT ON COLUMN user_membership.plan_id IS '会员计划id';
COMMENT ON COLUMN user_membership.order_no IS '关联订单号';
COMMENT ON COLUMN user_membership.start_time IS '生效时间';
COMMENT ON COLUMN user_membership.expire_time IS '到期时间，null表示永久';
COMMENT ON COLUMN user_membership.status IS '状态：0-待支付，1-生效中，2-已过期，3-已取消';
COMMENT ON COLUMN user_membership.create_time IS '创建时间';
COMMENT ON COLUMN user_membership.update_time IS '更新时间';
COMMENT ON COLUMN user_membership.is_delete IS '是否删除';

-- AI使用记录表（按天/月聚合计数）
CREATE TABLE IF NOT EXISTS ai_usage_record
(
    id           BIGSERIAL PRIMARY KEY,
    user_id      BIGINT                             NOT NULL,
    feature_type VARCHAR(32)                        NOT NULL,
    usage_date   DATE                               NOT NULL,
    usage_count  INT      DEFAULT 0                 NOT NULL,
    create_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT uk_ai_usage_record UNIQUE (user_id, feature_type, usage_date)
);
CREATE INDEX IF NOT EXISTS idx_aur_user_id ON ai_usage_record(user_id);
CREATE INDEX IF NOT EXISTS idx_aur_feature_type ON ai_usage_record(feature_type);
CREATE INDEX IF NOT EXISTS idx_aur_usage_date ON ai_usage_record(usage_date);
COMMENT ON TABLE ai_usage_record IS 'AI功能使用记录';
COMMENT ON COLUMN ai_usage_record.id IS 'id';
COMMENT ON COLUMN ai_usage_record.user_id IS '用户id';
COMMENT ON COLUMN ai_usage_record.feature_type IS '功能类型：AI_CHAT/AI_PPT/AI_EXAM/AI_BOOK/AI_GRADING';
COMMENT ON COLUMN ai_usage_record.usage_date IS '使用日期';
COMMENT ON COLUMN ai_usage_record.usage_count IS '当日使用次数';
COMMENT ON COLUMN ai_usage_record.create_time IS '创建时间';
COMMENT ON COLUMN ai_usage_record.update_time IS '更新时间';

-- 种子数据：默认会员计划
INSERT INTO membership_plan (name, code, description, price, duration_days,
    ai_chat_daily_limit, ai_chat_monthly_limit,
    ai_ppt_daily_limit, ai_ppt_monthly_limit,
    ai_exam_daily_limit, ai_exam_monthly_limit,
    ai_book_daily_limit, ai_book_monthly_limit,
    ai_grading_daily_limit, ai_grading_monthly_limit,
    course_member_access, is_default, sort_order)
VALUES
    ('免费版', 'FREE', '注册即享的基础权益', 0.00, 0,
     10, 200, 1, 20, 3, 60, 5, 100, 3, 60,
     0, 1, 0),
    ('基础版', 'BASIC', '适合日常学习的进阶套餐', 29.90, 30,
     50, 1000, 5, 100, 15, 300, 30, 600, 15, 300,
     1, 0, 1),
    ('专业版', 'PRO', '全功能无限制的专业套餐', 59.90, 30,
     -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
     1, 0, 2),
    ('教师版', 'TEACHER', '教师专属权益计划', 0.00, 0,
     100, 2000, 20, 400, 50, 1000, 50, 1000, 50, 1000,
     1, 0, 3)
ON CONFLICT (code) DO NOTHING;
