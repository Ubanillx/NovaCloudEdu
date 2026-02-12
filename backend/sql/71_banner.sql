-- 轮播图领域相关表

-- 轮播图表
CREATE TABLE IF NOT EXISTS banner
(
    id          BIGSERIAL PRIMARY KEY,
    title       VARCHAR(128)                       NOT NULL,
    image_url   VARCHAR(1024)                      NOT NULL,
    link_type   SMALLINT DEFAULT 0                 NOT NULL,
    link_url    VARCHAR(1024)                      NULL,
    sort        INT      DEFAULT 0                 NOT NULL,
    status      SMALLINT DEFAULT 0                 NOT NULL,
    start_time  TIMESTAMP                          NULL,
    end_time    TIMESTAMP                          NULL,
    admin_id    BIGINT                             NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_banner_admin_id ON banner(admin_id);
CREATE INDEX IF NOT EXISTS idx_banner_status ON banner(status);
CREATE INDEX IF NOT EXISTS idx_banner_sort ON banner(sort);
COMMENT ON TABLE banner IS '首页轮播图';
COMMENT ON COLUMN banner.id IS 'id';
COMMENT ON COLUMN banner.title IS '轮播图标题';
COMMENT ON COLUMN banner.image_url IS '图片URL';
COMMENT ON COLUMN banner.link_type IS '跳转类型：0-无跳转，1-内部路由，2-外部链接';
COMMENT ON COLUMN banner.link_url IS '跳转URL/路由';
COMMENT ON COLUMN banner.sort IS '排序权重，数字越大越靠前';
COMMENT ON COLUMN banner.status IS '状态：0-草稿，1-已发布，2-已下线';
COMMENT ON COLUMN banner.start_time IS '开始展示时间';
COMMENT ON COLUMN banner.end_time IS '结束展示时间';
COMMENT ON COLUMN banner.admin_id IS '创建管理员id';
COMMENT ON COLUMN banner.create_time IS '创建时间';
COMMENT ON COLUMN banner.update_time IS '更新时间';
COMMENT ON COLUMN banner.is_delete IS '是否删除';
