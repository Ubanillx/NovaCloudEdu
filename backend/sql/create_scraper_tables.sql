-- PostgreSQL 抓取配置管理表
-- 创建时间: 2026-02-05

-- 抓取源配置表
CREATE TABLE IF NOT EXISTS scraper_source_config (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    source_code VARCHAR(50) NOT NULL UNIQUE,
    base_url VARCHAR(500) NOT NULL,
    description TEXT,
    
    -- 选择器配置
    title_selector VARCHAR(500),
    author_selector VARCHAR(500),
    source_selector VARCHAR(500),
    content_selector VARCHAR(500),
    date_selector VARCHAR(500),
    image_selector VARCHAR(500),
    link_selector VARCHAR(500),
    
    -- 抓取配置
    max_depth INTEGER DEFAULT 2,
    max_pages INTEGER DEFAULT 10,
    delay_ms BIGINT DEFAULT 1500,
    use_dynamic BOOLEAN DEFAULT FALSE,
    wait_for_js_ms INTEGER DEFAULT 3000,
    
    -- 调度配置
    cron_expression VARCHAR(100),
    enabled BOOLEAN DEFAULT TRUE,
    default_max_articles INTEGER DEFAULT 5,
    default_category VARCHAR(50),
    default_difficulty INTEGER DEFAULT 2,
    
    creator_id BIGINT,
    create_time TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    is_delete INTEGER DEFAULT 0
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_scraper_config_source_code ON scraper_source_config(source_code);
CREATE INDEX IF NOT EXISTS idx_scraper_config_enabled ON scraper_source_config(enabled);
CREATE INDEX IF NOT EXISTS idx_scraper_config_create_time ON scraper_source_config(create_time);

-- 抓取任务表
CREATE TABLE IF NOT EXISTS scraper_task (
    id BIGINT PRIMARY KEY,
    config_id BIGINT NOT NULL,
    config_name VARCHAR(100),
    status INTEGER DEFAULT 0,
    total_articles INTEGER DEFAULT 0,
    success_count INTEGER DEFAULT 0,
    fail_count INTEGER DEFAULT 0,
    created_article_ids TEXT,
    error_message TEXT,
    start_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    duration_ms BIGINT,
    create_time TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    is_delete INTEGER DEFAULT 0
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_scraper_task_config_id ON scraper_task(config_id);
CREATE INDEX IF NOT EXISTS idx_scraper_task_status ON scraper_task(status);
CREATE INDEX IF NOT EXISTS idx_scraper_task_create_time ON scraper_task(create_time);

-- 添加表注释
COMMENT ON TABLE scraper_source_config IS '抓取源配置表';
COMMENT ON TABLE scraper_task IS '抓取任务表';

-- scraper_source_config 字段注释
COMMENT ON COLUMN scraper_source_config.id IS '主键ID';
COMMENT ON COLUMN scraper_source_config.name IS '配置名称';
COMMENT ON COLUMN scraper_source_config.source_code IS '数据源编码，唯一标识';
COMMENT ON COLUMN scraper_source_config.base_url IS '抓取的基础URL';
COMMENT ON COLUMN scraper_source_config.description IS '配置描述';
COMMENT ON COLUMN scraper_source_config.title_selector IS '标题CSS选择器';
COMMENT ON COLUMN scraper_source_config.author_selector IS '作者CSS选择器';
COMMENT ON COLUMN scraper_source_config.source_selector IS '来源CSS选择器';
COMMENT ON COLUMN scraper_source_config.content_selector IS '内容CSS选择器';
COMMENT ON COLUMN scraper_source_config.date_selector IS '日期CSS选择器';
COMMENT ON COLUMN scraper_source_config.image_selector IS '图片CSS选择器';
COMMENT ON COLUMN scraper_source_config.link_selector IS '链接CSS选择器';
COMMENT ON COLUMN scraper_source_config.max_depth IS '最大抓取深度';
COMMENT ON COLUMN scraper_source_config.max_pages IS '最大抓取页面数';
COMMENT ON COLUMN scraper_source_config.delay_ms IS '请求间隔(毫秒)';
COMMENT ON COLUMN scraper_source_config.use_dynamic IS '是否使用动态抓取(Selenium)';
COMMENT ON COLUMN scraper_source_config.wait_for_js_ms IS 'JS渲染等待时间(毫秒)';
COMMENT ON COLUMN scraper_source_config.cron_expression IS '定时任务Cron表达式';
COMMENT ON COLUMN scraper_source_config.enabled IS '是否启用';
COMMENT ON COLUMN scraper_source_config.default_max_articles IS '默认最大文章数';
COMMENT ON COLUMN scraper_source_config.default_category IS '默认文章分类';
COMMENT ON COLUMN scraper_source_config.default_difficulty IS '默认难度(1-5)';
COMMENT ON COLUMN scraper_source_config.creator_id IS '创建者ID';
COMMENT ON COLUMN scraper_source_config.create_time IS '创建时间';
COMMENT ON COLUMN scraper_source_config.update_time IS '更新时间';
COMMENT ON COLUMN scraper_source_config.is_delete IS '逻辑删除(0-未删除,1-已删除)';

-- scraper_task 字段注释
COMMENT ON COLUMN scraper_task.id IS '主键ID';
COMMENT ON COLUMN scraper_task.config_id IS '关联的配置ID';
COMMENT ON COLUMN scraper_task.config_name IS '配置名称(冗余)';
COMMENT ON COLUMN scraper_task.status IS '任务状态(0-待执行,1-执行中,2-成功,3-失败,4-部分成功)';
COMMENT ON COLUMN scraper_task.total_articles IS '抓取到的文章总数';
COMMENT ON COLUMN scraper_task.success_count IS '成功保存的文章数';
COMMENT ON COLUMN scraper_task.fail_count IS '保存失败的文章数';
COMMENT ON COLUMN scraper_task.created_article_ids IS '创建的文章ID列表(JSON数组)';
COMMENT ON COLUMN scraper_task.error_message IS '错误信息';
COMMENT ON COLUMN scraper_task.start_time IS '任务开始时间';
COMMENT ON COLUMN scraper_task.end_time IS '任务结束时间';
COMMENT ON COLUMN scraper_task.duration_ms IS '执行耗时(毫秒)';
COMMENT ON COLUMN scraper_task.create_time IS '创建时间';
COMMENT ON COLUMN scraper_task.is_delete IS '逻辑删除(0-未删除,1-已删除)';

