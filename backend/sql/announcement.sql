-- 公告领域相关表

-- 公告表
CREATE TABLE IF NOT EXISTS announcement
(
    id          BIGSERIAL PRIMARY KEY,
    title       VARCHAR(256)                       NOT NULL,
    content     TEXT                               NOT NULL,
    sort        INT      DEFAULT 0                 NOT NULL,
    status      SMALLINT DEFAULT 1                 NOT NULL,
    start_time  TIMESTAMP                          NULL,
    end_time    TIMESTAMP                          NULL,
    cover_image VARCHAR(1024)                      NULL,
    admin_id    BIGINT                             NOT NULL,
    view_count  INT      DEFAULT 0                 NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ann_admin_id ON announcement(admin_id);
CREATE INDEX IF NOT EXISTS idx_ann_status ON announcement(status);
CREATE INDEX IF NOT EXISTS idx_ann_sort ON announcement(sort);
COMMENT ON TABLE announcement IS '系统公告';
COMMENT ON COLUMN announcement.id IS 'id';
COMMENT ON COLUMN announcement.title IS '公告标题';
COMMENT ON COLUMN announcement.content IS '公告内容';
COMMENT ON COLUMN announcement.sort IS '优先级，数字越大优先级越高';
COMMENT ON COLUMN announcement.status IS '状态：0-草稿，1-已发布，2-已下线';
COMMENT ON COLUMN announcement.start_time IS '公告开始展示时间';
COMMENT ON COLUMN announcement.end_time IS '公告结束展示时间';
COMMENT ON COLUMN announcement.cover_image IS '封面图片URL';
COMMENT ON COLUMN announcement.admin_id IS '发布管理员id';
COMMENT ON COLUMN announcement.view_count IS '查看次数';
COMMENT ON COLUMN announcement.create_time IS '创建时间';
COMMENT ON COLUMN announcement.update_time IS '更新时间';
COMMENT ON COLUMN announcement.is_delete IS '是否删除';

-- 公告已读表
CREATE TABLE IF NOT EXISTS announcement_read
(
    id              BIGSERIAL PRIMARY KEY,
    announcement_id BIGINT                             NOT NULL,
    user_id         BIGINT                             NOT NULL,
    create_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ar_announcement_id ON announcement_read(announcement_id);
CREATE INDEX IF NOT EXISTS idx_ar_user_id ON announcement_read(user_id);
COMMENT ON TABLE announcement_read IS '公告阅读记录';
COMMENT ON COLUMN announcement_read.id IS 'id';
COMMENT ON COLUMN announcement_read.announcement_id IS '公告id';
COMMENT ON COLUMN announcement_read.user_id IS '用户id';
COMMENT ON COLUMN announcement_read.create_time IS '阅读时间';

