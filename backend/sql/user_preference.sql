-- 用户喜好分析相关表

-- 用户喜好表（记录用户对各类别/难度的偏好权重）
CREATE TABLE IF NOT EXISTS user_preference
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                             NOT NULL,
    preference_type VARCHAR(32)                        NOT NULL,
    preference_key  VARCHAR(128)                       NOT NULL,
    preference_value DECIMAL(10, 4) DEFAULT 0          NOT NULL,
    interaction_count INT DEFAULT 0                    NOT NULL,
    last_interaction_time TIMESTAMP                    NULL,
    create_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS idx_up_user_type_key ON user_preference(user_id, preference_type, preference_key);
CREATE INDEX IF NOT EXISTS idx_up_user_id ON user_preference(user_id);
CREATE INDEX IF NOT EXISTS idx_up_preference_type ON user_preference(preference_type);
COMMENT ON TABLE user_preference IS '用户喜好表';
COMMENT ON COLUMN user_preference.id IS 'id';
COMMENT ON COLUMN user_preference.user_id IS '用户id';
COMMENT ON COLUMN user_preference.preference_type IS '喜好类型：WORD_CATEGORY-单词分类，WORD_DIFFICULTY-单词难度，ARTICLE_CATEGORY-文章分类，ARTICLE_DIFFICULTY-文章难度，ARTICLE_TAG-文章标签';
COMMENT ON COLUMN user_preference.preference_key IS '喜好键（如分类名称、难度等级、标签名称）';
COMMENT ON COLUMN user_preference.preference_value IS '喜好权重值（0-100，值越大表示越喜欢）';
COMMENT ON COLUMN user_preference.interaction_count IS '交互次数（学习/阅读/收藏/点赞等行为的累计次数）';
COMMENT ON COLUMN user_preference.last_interaction_time IS '最后交互时间';
COMMENT ON COLUMN user_preference.create_time IS '创建时间';
COMMENT ON COLUMN user_preference.update_time IS '更新时间';

-- 用户行为日志表（记录用户的学习行为，用于喜好分析）
CREATE TABLE IF NOT EXISTS user_behavior_log
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                             NOT NULL,
    behavior_type   VARCHAR(32)                        NOT NULL,
    target_type     VARCHAR(32)                        NOT NULL,
    target_id       BIGINT                             NOT NULL,
    behavior_data   TEXT                               NULL,
    duration        INT DEFAULT 0                      NOT NULL,
    create_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ubl_user_id ON user_behavior_log(user_id);
CREATE INDEX IF NOT EXISTS idx_ubl_behavior_type ON user_behavior_log(behavior_type);
CREATE INDEX IF NOT EXISTS idx_ubl_target ON user_behavior_log(target_type, target_id);
CREATE INDEX IF NOT EXISTS idx_ubl_create_time ON user_behavior_log(create_time);
COMMENT ON TABLE user_behavior_log IS '用户行为日志表';
COMMENT ON COLUMN user_behavior_log.id IS 'id';
COMMENT ON COLUMN user_behavior_log.user_id IS '用户id';
COMMENT ON COLUMN user_behavior_log.behavior_type IS '行为类型：STUDY-学习，READ-阅读，COLLECT-收藏，LIKE-点赞，SEARCH-搜索';
COMMENT ON COLUMN user_behavior_log.target_type IS '目标类型：WORD-单词，ARTICLE-文章';
COMMENT ON COLUMN user_behavior_log.target_id IS '目标id';
COMMENT ON COLUMN user_behavior_log.behavior_data IS '行为数据（JSON格式，存储额外信息如搜索关键词等）';
COMMENT ON COLUMN user_behavior_log.duration IS '持续时长（秒），如阅读时长';
COMMENT ON COLUMN user_behavior_log.create_time IS '创建时间';

-- 推荐记录表（记录推荐历史，避免重复推荐）
CREATE TABLE IF NOT EXISTS recommendation_history
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                             NOT NULL,
    target_type     VARCHAR(32)                        NOT NULL,
    target_id       BIGINT                             NOT NULL,
    recommendation_score DECIMAL(10, 4) DEFAULT 0      NOT NULL,
    recommendation_reason VARCHAR(256)                 NULL,
    is_clicked      SMALLINT DEFAULT 0                 NOT NULL,
    is_interacted   SMALLINT DEFAULT 0                 NOT NULL,
    create_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_rh_user_id ON recommendation_history(user_id);
CREATE INDEX IF NOT EXISTS idx_rh_target ON recommendation_history(target_type, target_id);
CREATE INDEX IF NOT EXISTS idx_rh_create_time ON recommendation_history(create_time);
COMMENT ON TABLE recommendation_history IS '推荐记录表';
COMMENT ON COLUMN recommendation_history.id IS 'id';
COMMENT ON COLUMN recommendation_history.user_id IS '用户id';
COMMENT ON COLUMN recommendation_history.target_type IS '目标类型：WORD-单词，ARTICLE-文章';
COMMENT ON COLUMN recommendation_history.target_id IS '目标id';
COMMENT ON COLUMN recommendation_history.recommendation_score IS '推荐分数';
COMMENT ON COLUMN recommendation_history.recommendation_reason IS '推荐原因';
COMMENT ON COLUMN recommendation_history.is_clicked IS '是否点击：0-否，1-是';
COMMENT ON COLUMN recommendation_history.is_interacted IS '是否产生交互（学习/阅读完成）：0-否，1-是';
COMMENT ON COLUMN recommendation_history.create_time IS '创建时间';
COMMENT ON COLUMN recommendation_history.update_time IS '更新时间';
