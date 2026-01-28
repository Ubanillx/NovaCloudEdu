-- 用户打卡表
CREATE TABLE IF NOT EXISTS user_checkin (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    checkin_date DATE NOT NULL,
    checkin_time TIMESTAMP NOT NULL,
    streak_days INT NOT NULL DEFAULT 1,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_user_date UNIQUE (user_id, checkin_date)
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_user_checkin_user_id ON user_checkin(user_id);
CREATE INDEX IF NOT EXISTS idx_user_checkin_date ON user_checkin(checkin_date);
CREATE INDEX IF NOT EXISTS idx_user_checkin_streak ON user_checkin(streak_days);

-- 添加注释
COMMENT ON TABLE user_checkin IS '用户打卡表';
COMMENT ON COLUMN user_checkin.id IS '打卡记录ID';
COMMENT ON COLUMN user_checkin.user_id IS '用户ID';
COMMENT ON COLUMN user_checkin.checkin_date IS '打卡日期';
COMMENT ON COLUMN user_checkin.checkin_time IS '打卡时间';
COMMENT ON COLUMN user_checkin.streak_days IS '连续打卡天数';
COMMENT ON COLUMN user_checkin.create_time IS '创建时间';

-- 用户打卡统计表（汇总表，用于排行榜）
CREATE TABLE IF NOT EXISTS user_checkin_stats (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    total_checkin_days INT NOT NULL DEFAULT 0,
    current_streak INT NOT NULL DEFAULT 0,
    max_streak INT NOT NULL DEFAULT 0,
    last_checkin_date DATE DEFAULT NULL,
    update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_user_checkin_stats_user_id UNIQUE (user_id)
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_user_checkin_stats_total ON user_checkin_stats(total_checkin_days DESC);
CREATE INDEX IF NOT EXISTS idx_user_checkin_stats_streak ON user_checkin_stats(current_streak DESC);

-- 添加注释
COMMENT ON TABLE user_checkin_stats IS '用户打卡统计表';
COMMENT ON COLUMN user_checkin_stats.id IS '统计ID';
COMMENT ON COLUMN user_checkin_stats.user_id IS '用户ID';
COMMENT ON COLUMN user_checkin_stats.total_checkin_days IS '累计打卡天数';
COMMENT ON COLUMN user_checkin_stats.current_streak IS '当前连续打卡天数';
COMMENT ON COLUMN user_checkin_stats.max_streak IS '最长连续打卡天数';
COMMENT ON COLUMN user_checkin_stats.last_checkin_date IS '最后打卡日期';
COMMENT ON COLUMN user_checkin_stats.update_time IS '更新时间';

-- 创建触发器函数，用于自动更新 update_time
CREATE OR REPLACE FUNCTION update_user_checkin_stats_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 创建触发器
DROP TRIGGER IF EXISTS trigger_update_user_checkin_stats_timestamp ON user_checkin_stats;
CREATE TRIGGER trigger_update_user_checkin_stats_timestamp
    BEFORE UPDATE ON user_checkin_stats
    FOR EACH ROW
    EXECUTE FUNCTION update_user_checkin_stats_timestamp();
