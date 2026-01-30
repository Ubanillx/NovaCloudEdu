-- 用户关注表
CREATE TABLE IF NOT EXISTS user_follow (
    id BIGSERIAL PRIMARY KEY,
    follower_id BIGINT NOT NULL,
    following_id BIGINT NOT NULL,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_follower_following UNIQUE (follower_id, following_id)
);

-- 索引
CREATE INDEX IF NOT EXISTS idx_user_follow_follower_id ON user_follow (follower_id);
CREATE INDEX IF NOT EXISTS idx_user_follow_following_id ON user_follow (following_id);
CREATE INDEX IF NOT EXISTS idx_user_follow_create_time ON user_follow (create_time);

-- 注释
COMMENT ON TABLE user_follow IS '用户关注表';
COMMENT ON COLUMN user_follow.id IS '关注ID';
COMMENT ON COLUMN user_follow.follower_id IS '关注者ID（粉丝）';
COMMENT ON COLUMN user_follow.following_id IS '被关注者ID';
COMMENT ON COLUMN user_follow.create_time IS '关注时间';
