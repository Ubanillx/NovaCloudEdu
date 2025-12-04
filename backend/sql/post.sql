-- 帖子/社区领域相关表

-- 帖子表
CREATE TABLE IF NOT EXISTS post
(
    id          BIGSERIAL PRIMARY KEY,
    title       VARCHAR(512)                       NULL,
    content     TEXT                               NULL,
    tags        VARCHAR(1024)                      NULL,
    thumb_num   INT      DEFAULT 0                 NOT NULL,
    favour_num  INT      DEFAULT 0                 NOT NULL,
    comment_num INT      DEFAULT 0                 NOT NULL,
    user_id     BIGINT                             NOT NULL,
    ip_address  VARCHAR(100)                       NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL,
    post_type   VARCHAR(50)                        NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_post_user_id ON post(user_id);
CREATE INDEX IF NOT EXISTS idx_post_list ON post(is_delete, post_type, create_time);
COMMENT ON TABLE post IS '帖子';
COMMENT ON COLUMN post.id IS 'id';
COMMENT ON COLUMN post.title IS '标题';
COMMENT ON COLUMN post.content IS '内容';
COMMENT ON COLUMN post.tags IS '标签列表（json 数组）';
COMMENT ON COLUMN post.thumb_num IS '点赞数';
COMMENT ON COLUMN post.favour_num IS '收藏数';
COMMENT ON COLUMN post.comment_num IS '评论数';
COMMENT ON COLUMN post.user_id IS '创建用户 id';
COMMENT ON COLUMN post.ip_address IS 'ip地址区域';
COMMENT ON COLUMN post.create_time IS '创建时间';
COMMENT ON COLUMN post.update_time IS '更新时间';
COMMENT ON COLUMN post.is_delete IS '是否删除';
COMMENT ON COLUMN post.post_type IS '帖子类型，如学习/生活/技巧';

-- 帖子点赞表（硬删除）
CREATE TABLE IF NOT EXISTS post_thumb
(
    id          BIGSERIAL PRIMARY KEY,
    post_id     BIGINT                             NOT NULL,
    user_id     BIGINT                             NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_pt_post_id ON post_thumb(post_id);
CREATE INDEX IF NOT EXISTS idx_pt_user_id ON post_thumb(user_id);
COMMENT ON TABLE post_thumb IS '帖子点赞';
COMMENT ON COLUMN post_thumb.id IS 'id';
COMMENT ON COLUMN post_thumb.post_id IS '帖子 id';
COMMENT ON COLUMN post_thumb.user_id IS '点赞用户 id';
COMMENT ON COLUMN post_thumb.create_time IS '创建时间';
COMMENT ON COLUMN post_thumb.update_time IS '更新时间';

-- 帖子收藏表（硬删除）
CREATE TABLE IF NOT EXISTS post_favour
(
    id          BIGSERIAL PRIMARY KEY,
    post_id     BIGINT                             NOT NULL,
    user_id     BIGINT                             NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_pf_post_id ON post_favour(post_id);
CREATE INDEX IF NOT EXISTS idx_pf_user_id ON post_favour(user_id);
COMMENT ON TABLE post_favour IS '帖子收藏';
COMMENT ON COLUMN post_favour.id IS 'id';
COMMENT ON COLUMN post_favour.post_id IS '帖子 id';
COMMENT ON COLUMN post_favour.user_id IS '收藏用户 id';
COMMENT ON COLUMN post_favour.create_time IS '创建时间';
COMMENT ON COLUMN post_favour.update_time IS '更新时间';

-- 帖子评论表（硬删除)
CREATE TABLE IF NOT EXISTS post_comment
(
    id          BIGSERIAL PRIMARY KEY,
    post_id     BIGINT                             NOT NULL,
    user_id     BIGINT                             NOT NULL,
    content     TEXT                               NOT NULL,
    ip_address  VARCHAR(100)                       NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_pc_post_user ON post_comment(post_id, user_id);
CREATE INDEX IF NOT EXISTS idx_pc_post_time ON post_comment(post_id, create_time);
COMMENT ON TABLE post_comment IS '帖子评论';
COMMENT ON COLUMN post_comment.id IS '评论ID';
COMMENT ON COLUMN post_comment.post_id IS '帖子ID，关联到post表';
COMMENT ON COLUMN post_comment.user_id IS '评论者ID，关联到user表';
COMMENT ON COLUMN post_comment.content IS '评论内容';
COMMENT ON COLUMN post_comment.ip_address IS 'ip地址区域';
COMMENT ON COLUMN post_comment.create_time IS '创建时间';
COMMENT ON COLUMN post_comment.update_time IS '更新时间';

-- 帖子评论回复表（硬删除）
CREATE TABLE IF NOT EXISTS post_comment_reply
(
    id          BIGSERIAL PRIMARY KEY,
    post_id     BIGINT                             NOT NULL,
    comment_id  BIGINT                             NOT NULL,
    user_id     BIGINT                             NOT NULL,
    content     TEXT                               NOT NULL,
    ip_address  VARCHAR(100)                       NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_pcr_post_comment ON post_comment_reply(post_id, comment_id);
CREATE INDEX IF NOT EXISTS idx_pcr_comment_user ON post_comment_reply(comment_id, user_id);
CREATE INDEX IF NOT EXISTS idx_pcr_user_time ON post_comment_reply(user_id, create_time);
COMMENT ON TABLE post_comment_reply IS '帖子评论回复';
COMMENT ON COLUMN post_comment_reply.id IS '回复ID';
COMMENT ON COLUMN post_comment_reply.post_id IS '帖子ID，关联到post表';
COMMENT ON COLUMN post_comment_reply.comment_id IS '评论ID，关联到post_comment表';
COMMENT ON COLUMN post_comment_reply.user_id IS '回复者ID，关联到user表';
COMMENT ON COLUMN post_comment_reply.content IS '回复内容';
COMMENT ON COLUMN post_comment_reply.ip_address IS 'ip地址区域';
COMMENT ON COLUMN post_comment_reply.create_time IS '创建时间';
COMMENT ON COLUMN post_comment_reply.update_time IS '更新时间';
