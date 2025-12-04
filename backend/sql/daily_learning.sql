-- 每日学习领域相关表

-- 每日单词表
CREATE TABLE IF NOT EXISTS daily_word
(
    id                  BIGSERIAL PRIMARY KEY,
    word                VARCHAR(128) NOT NULL,
    pronunciation       VARCHAR(128) NULL,
    audio_url           VARCHAR(2048) NULL,
    translation         VARCHAR(512) NOT NULL,
    example             TEXT NULL,
    example_translation TEXT NULL,
    difficulty          SMALLINT DEFAULT 1 NOT NULL,
    category            VARCHAR(64) NULL,
    notes               TEXT NULL,
    publish_date        DATE NOT NULL,
    admin_id            BIGINT NOT NULL,
    create_time         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete           SMALLINT DEFAULT 0 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_dw_publish_date ON daily_word(publish_date);
CREATE INDEX IF NOT EXISTS idx_dw_word ON daily_word(word);
CREATE INDEX IF NOT EXISTS idx_dw_category ON daily_word(category);
CREATE INDEX IF NOT EXISTS idx_dw_difficulty ON daily_word(difficulty);
COMMENT ON TABLE daily_word IS '每日单词';
COMMENT ON COLUMN daily_word.id IS 'ID';
COMMENT ON COLUMN daily_word.word IS '单词';
COMMENT ON COLUMN daily_word.pronunciation IS '音标';
COMMENT ON COLUMN daily_word.audio_url IS '发音音频URL';
COMMENT ON COLUMN daily_word.translation IS '翻译';
COMMENT ON COLUMN daily_word.example IS '例句';
COMMENT ON COLUMN daily_word.example_translation IS '例句翻译';
COMMENT ON COLUMN daily_word.difficulty IS '难度等级：1-简单，2-中等，3-困难';
COMMENT ON COLUMN daily_word.category IS '单词分类（如小学、初中、高中、CET4、CET6、雅思、托福等）';
COMMENT ON COLUMN daily_word.notes IS '单词笔记';
COMMENT ON COLUMN daily_word.publish_date IS '发布日期';
COMMENT ON COLUMN daily_word.admin_id IS '创建管理员ID';
COMMENT ON COLUMN daily_word.create_time IS '创建时间';
COMMENT ON COLUMN daily_word.update_time IS '更新时间';
COMMENT ON COLUMN daily_word.is_delete IS '是否删除：0-未删除，1-已删除';

-- 每日文章表
CREATE TABLE IF NOT EXISTS daily_article
(
    id            BIGSERIAL PRIMARY KEY,
    title         VARCHAR(256)                       NOT NULL,
    content       TEXT                               NOT NULL,
    summary       VARCHAR(512)                       NULL,
    cover_image   VARCHAR(1024)                      NULL,
    author        VARCHAR(128)                       NULL,
    source        VARCHAR(256)                       NULL,
    source_url    VARCHAR(1024)                      NULL,
    category      VARCHAR(64)                        NULL,
    tags          VARCHAR(512)                       NULL,
    difficulty    SMALLINT DEFAULT 1                 NOT NULL,
    read_time     INT      DEFAULT 0                 NOT NULL,
    publish_date  DATE                               NOT NULL,
    admin_id      BIGINT                             NOT NULL,
    view_count    INT      DEFAULT 0                 NOT NULL,
    like_count    INT      DEFAULT 0                 NOT NULL,
    collect_count INT      DEFAULT 0                 NOT NULL,
    create_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete     SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_da_publish_date ON daily_article(publish_date);
CREATE INDEX IF NOT EXISTS idx_da_category ON daily_article(category);
CREATE INDEX IF NOT EXISTS idx_da_difficulty ON daily_article(difficulty);
COMMENT ON TABLE daily_article IS '每日文章';
COMMENT ON COLUMN daily_article.id IS 'id';
COMMENT ON COLUMN daily_article.title IS '文章标题';
COMMENT ON COLUMN daily_article.content IS '文章内容';
COMMENT ON COLUMN daily_article.summary IS '文章摘要';
COMMENT ON COLUMN daily_article.cover_image IS '封面图片URL';
COMMENT ON COLUMN daily_article.author IS '作者';
COMMENT ON COLUMN daily_article.source IS '来源';
COMMENT ON COLUMN daily_article.source_url IS '原文链接';
COMMENT ON COLUMN daily_article.category IS '文章分类，技能、生活、科技、文化、艺术等';
COMMENT ON COLUMN daily_article.tags IS '标签，JSON数组格式';
COMMENT ON COLUMN daily_article.difficulty IS '难度等级：1-简单，2-中等，3-困难';
COMMENT ON COLUMN daily_article.read_time IS '预计阅读时间(分钟)';
COMMENT ON COLUMN daily_article.publish_date IS '发布日期';
COMMENT ON COLUMN daily_article.admin_id IS '创建管理员id';
COMMENT ON COLUMN daily_article.view_count IS '查看次数';
COMMENT ON COLUMN daily_article.like_count IS '点赞次数';
COMMENT ON COLUMN daily_article.collect_count IS '收藏次数';
COMMENT ON COLUMN daily_article.create_time IS '创建时间';
COMMENT ON COLUMN daily_article.update_time IS '更新时间';
COMMENT ON COLUMN daily_article.is_delete IS '是否删除';

-- 用户与每日文章关联表
CREATE TABLE IF NOT EXISTS user_daily_article
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                             NOT NULL,
    article_id      BIGINT                             NOT NULL,
    is_read         SMALLINT DEFAULT 0                 NOT NULL,
    is_liked        SMALLINT DEFAULT 0                 NOT NULL,
    is_collected    SMALLINT DEFAULT 0                 NOT NULL,
    comment_content TEXT                               NULL,
    comment_time    TIMESTAMP                          NULL,
    create_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_uda_user_id ON user_daily_article(user_id);
CREATE INDEX IF NOT EXISTS idx_uda_article_id ON user_daily_article(article_id);
COMMENT ON TABLE user_daily_article IS '用户与每日文章关联';
COMMENT ON COLUMN user_daily_article.id IS 'id';
COMMENT ON COLUMN user_daily_article.user_id IS '用户id';
COMMENT ON COLUMN user_daily_article.article_id IS '文章id';
COMMENT ON COLUMN user_daily_article.is_read IS '是否阅读：0-否，1-是';
COMMENT ON COLUMN user_daily_article.is_liked IS '是否点赞：0-否，1-是';
COMMENT ON COLUMN user_daily_article.is_collected IS '是否收藏：0-否，1-是';
COMMENT ON COLUMN user_daily_article.comment_content IS '评论内容';
COMMENT ON COLUMN user_daily_article.comment_time IS '评论时间';
COMMENT ON COLUMN user_daily_article.create_time IS '创建时间';
COMMENT ON COLUMN user_daily_article.update_time IS '更新时间';

-- 用户与每日单词关联表
CREATE TABLE IF NOT EXISTS user_daily_word
(
    id            BIGSERIAL PRIMARY KEY,
    user_id       BIGINT                             NOT NULL,
    word_id       BIGINT                             NOT NULL,
    is_studied    SMALLINT DEFAULT 0                 NOT NULL,
    is_collected  SMALLINT DEFAULT 0                 NOT NULL,
    mastery_level SMALLINT DEFAULT 0                 NOT NULL,
    create_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_udw_user_id ON user_daily_word(user_id);
CREATE INDEX IF NOT EXISTS idx_udw_word_id ON user_daily_word(word_id);
COMMENT ON TABLE user_daily_word IS '用户与每日单词关联';
COMMENT ON COLUMN user_daily_word.id IS 'id';
COMMENT ON COLUMN user_daily_word.user_id IS '用户id';
COMMENT ON COLUMN user_daily_word.word_id IS '单词id';
COMMENT ON COLUMN user_daily_word.is_studied IS '是否学习：0-否，1-是';
COMMENT ON COLUMN user_daily_word.is_collected IS '是否收藏：0-否，1-是';
COMMENT ON COLUMN user_daily_word.mastery_level IS '掌握程度：0-未知，1-生词，2-熟悉，3-掌握';
COMMENT ON COLUMN user_daily_word.create_time IS '创建时间';
COMMENT ON COLUMN user_daily_word.update_time IS '更新时间';

-- 用户生词本表
CREATE TABLE IF NOT EXISTS user_word_book
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                             NOT NULL,
    word_id         BIGINT                             NOT NULL,
    learning_status SMALLINT DEFAULT 0                 NOT NULL,
    collected_time  TIMESTAMP                          NULL,
    is_deleted      SMALLINT DEFAULT 0                 NOT NULL,
    create_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_uwb_user_id ON user_word_book(user_id);
CREATE INDEX IF NOT EXISTS idx_uwb_word_id ON user_word_book(word_id);
CREATE INDEX IF NOT EXISTS idx_uwb_learning_status ON user_word_book(learning_status);
CREATE INDEX IF NOT EXISTS idx_uwb_collected_time ON user_word_book(collected_time);
CREATE INDEX IF NOT EXISTS idx_uwb_is_deleted ON user_word_book(is_deleted);
COMMENT ON TABLE user_word_book IS '用户生词本';
COMMENT ON COLUMN user_word_book.id IS 'id';
COMMENT ON COLUMN user_word_book.user_id IS '用户id，关联到user表';
COMMENT ON COLUMN user_word_book.word_id IS '单词id，关联到daily_word表';
COMMENT ON COLUMN user_word_book.learning_status IS '学习状态：0-未学习，1-已学习，2-已掌握';
COMMENT ON COLUMN user_word_book.collected_time IS '收藏时间';
COMMENT ON COLUMN user_word_book.is_deleted IS '是否删除：0-否，1-是';
COMMENT ON COLUMN user_word_book.create_time IS '创建时间';
COMMENT ON COLUMN user_word_book.update_time IS '更新时间';
