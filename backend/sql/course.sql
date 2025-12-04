-- 课程领域相关表

-- 课程表
CREATE TABLE IF NOT EXISTS course
(
    id             BIGSERIAL PRIMARY KEY,
    title          VARCHAR(256)                             NOT NULL,
    subtitle       VARCHAR(512)                             NULL,
    description    TEXT                                     NULL,
    cover_image    VARCHAR(1024)                            NULL,
    price          DECIMAL(10, 2) DEFAULT 0.00              NOT NULL,
    course_type    SMALLINT       DEFAULT 0                 NOT NULL,
    difficulty     SMALLINT       DEFAULT 1                 NOT NULL,
    status         SMALLINT       DEFAULT 0                 NOT NULL,
    teacher_id     BIGINT                                   NOT NULL,
    total_duration INT            DEFAULT 0                 NOT NULL,
    total_chapters INT            DEFAULT 0                 NOT NULL,
    total_sections INT            DEFAULT 0                 NOT NULL,
    student_count  INT            DEFAULT 0                 NOT NULL,
    rating_score   DECIMAL(2, 1)  DEFAULT 0.0               NOT NULL,
    tags           VARCHAR(512)                             NULL,
    admin_id       BIGINT                                   NOT NULL,
    create_time    TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time    TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete      SMALLINT       DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_course_teacher_id ON course(teacher_id);
CREATE INDEX IF NOT EXISTS idx_course_type ON course(course_type);
CREATE INDEX IF NOT EXISTS idx_course_status ON course(status);
CREATE INDEX IF NOT EXISTS idx_course_difficulty ON course(difficulty);
COMMENT ON TABLE course IS '课程';
COMMENT ON COLUMN course.id IS 'id';
COMMENT ON COLUMN course.title IS '课程标题';
COMMENT ON COLUMN course.subtitle IS '课程副标题';
COMMENT ON COLUMN course.description IS '课程描述';
COMMENT ON COLUMN course.cover_image IS '封面图片URL';
COMMENT ON COLUMN course.price IS '课程价格';
COMMENT ON COLUMN course.course_type IS '课程类型：0-公开课，1-付费课，2-会员课';
COMMENT ON COLUMN course.difficulty IS '难度等级：1-入门，2-初级，3-中级，4-高级，5-专家';
COMMENT ON COLUMN course.status IS '状态：0-未发布，1-已发布，2-已下架';
COMMENT ON COLUMN course.teacher_id IS '讲师id';
COMMENT ON COLUMN course.total_duration IS '总时长(分钟)';
COMMENT ON COLUMN course.total_chapters IS '总章节数';
COMMENT ON COLUMN course.total_sections IS '总小节数';
COMMENT ON COLUMN course.student_count IS '学习人数';
COMMENT ON COLUMN course.rating_score IS '评分，1-5分';
COMMENT ON COLUMN course.tags IS '标签，JSON数组格式';
COMMENT ON COLUMN course.admin_id IS '创建管理员id';
COMMENT ON COLUMN course.create_time IS '创建时间';
COMMENT ON COLUMN course.update_time IS '更新时间';
COMMENT ON COLUMN course.is_delete IS '是否删除';

-- 讲师表
CREATE TABLE IF NOT EXISTS teacher
(
    id           BIGSERIAL PRIMARY KEY,
    name         VARCHAR(128)                       NOT NULL,
    introduction TEXT                               NULL,
    expertise    VARCHAR(512)                       NULL,
    user_id      BIGINT                             NULL,
    admin_id     BIGINT                             NOT NULL,
    create_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete    SMALLINT  DEFAULT 0                NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_teacher_user_id ON teacher(user_id);
COMMENT ON TABLE teacher IS '讲师';
COMMENT ON COLUMN teacher.id IS 'id';
COMMENT ON COLUMN teacher.name IS '讲师姓名';
COMMENT ON COLUMN teacher.introduction IS '讲师简介';
COMMENT ON COLUMN teacher.expertise IS '专业领域，JSON数组格式';
COMMENT ON COLUMN teacher.user_id IS '关联的用户id，讲师也是平台用户';
COMMENT ON COLUMN teacher.admin_id IS '创建管理员id';
COMMENT ON COLUMN teacher.create_time IS '创建时间';
COMMENT ON COLUMN teacher.update_time IS '更新时间';
COMMENT ON COLUMN teacher.is_delete IS '是否删除';

-- 课程章节表
CREATE TABLE IF NOT EXISTS course_chapter
(
    id          BIGSERIAL PRIMARY KEY,
    course_id   BIGINT                             NOT NULL,
    title       VARCHAR(256)                       NOT NULL,
    description TEXT                               NULL,
    sort        INT      DEFAULT 0                 NOT NULL,
    admin_id    BIGINT                             NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_cchap_course_id ON course_chapter(course_id);
CREATE INDEX IF NOT EXISTS idx_cchap_sort ON course_chapter(sort);
COMMENT ON TABLE course_chapter IS '课程章节';
COMMENT ON COLUMN course_chapter.id IS 'id';
COMMENT ON COLUMN course_chapter.course_id IS '课程id';
COMMENT ON COLUMN course_chapter.title IS '章节标题';
COMMENT ON COLUMN course_chapter.description IS '章节描述';
COMMENT ON COLUMN course_chapter.sort IS '排序，数字越小排序越靠前';
COMMENT ON COLUMN course_chapter.admin_id IS '创建管理员id';
COMMENT ON COLUMN course_chapter.create_time IS '创建时间';
COMMENT ON COLUMN course_chapter.update_time IS '更新时间';
COMMENT ON COLUMN course_chapter.is_delete IS '是否删除';

-- 课程小节表
CREATE TABLE IF NOT EXISTS course_section
(
    id           BIGSERIAL PRIMARY KEY,
    course_id    BIGINT                             NOT NULL,
    chapter_id   BIGINT                             NOT NULL,
    title        VARCHAR(256)                       NOT NULL,
    description  TEXT                               NULL,
    video_url    VARCHAR(1024)                      NULL,
    duration     INT      DEFAULT 0                 NOT NULL,
    sort         INT      DEFAULT 0                 NOT NULL,
    is_free      SMALLINT DEFAULT 0                 NOT NULL,
    resource_url VARCHAR(1024)                      NULL,
    admin_id     BIGINT                             NOT NULL,
    create_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete    SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_csec_course_id ON course_section(course_id);
CREATE INDEX IF NOT EXISTS idx_csec_chapter_id ON course_section(chapter_id);
CREATE INDEX IF NOT EXISTS idx_csec_sort ON course_section(sort);
COMMENT ON TABLE course_section IS '课程小节';
COMMENT ON COLUMN course_section.id IS 'id';
COMMENT ON COLUMN course_section.course_id IS '课程id';
COMMENT ON COLUMN course_section.chapter_id IS '章节id';
COMMENT ON COLUMN course_section.title IS '小节标题';
COMMENT ON COLUMN course_section.description IS '小节描述';
COMMENT ON COLUMN course_section.video_url IS '视频URL';
COMMENT ON COLUMN course_section.duration IS '时长(秒)';
COMMENT ON COLUMN course_section.sort IS '排序，数字越小排序越靠前';
COMMENT ON COLUMN course_section.is_free IS '是否免费：0-否，1-是';
COMMENT ON COLUMN course_section.resource_url IS '资源URL';
COMMENT ON COLUMN course_section.admin_id IS '创建管理员id';
COMMENT ON COLUMN course_section.create_time IS '创建时间';
COMMENT ON COLUMN course_section.update_time IS '更新时间';
COMMENT ON COLUMN course_section.is_delete IS '是否删除';

-- 用户课程购买记录表
CREATE TABLE IF NOT EXISTS user_course
(
    id             BIGSERIAL PRIMARY KEY,
    user_id        BIGINT                             NOT NULL,
    course_id      BIGINT                             NOT NULL,
    order_no       VARCHAR(64)                        NULL,
    price          DECIMAL(10, 2)                     NOT NULL,
    payment_method VARCHAR(32)                        NULL,
    payment_time   TIMESTAMP                          NULL,
    expire_time    TIMESTAMP                          NULL,
    status         SMALLINT DEFAULT 1                 NOT NULL,
    create_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete      SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_uc_user_id ON user_course(user_id);
CREATE INDEX IF NOT EXISTS idx_uc_course_id ON user_course(course_id);
CREATE INDEX IF NOT EXISTS idx_uc_order_no ON user_course(order_no);
COMMENT ON TABLE user_course IS '用户课程购买记录';
COMMENT ON COLUMN user_course.id IS 'id';
COMMENT ON COLUMN user_course.user_id IS '用户id';
COMMENT ON COLUMN user_course.course_id IS '课程id';
COMMENT ON COLUMN user_course.order_no IS '订单编号';
COMMENT ON COLUMN user_course.price IS '购买价格';
COMMENT ON COLUMN user_course.payment_method IS '支付方式';
COMMENT ON COLUMN user_course.payment_time IS '支付时间';
COMMENT ON COLUMN user_course.expire_time IS '过期时间，null表示永久有效';
COMMENT ON COLUMN user_course.status IS '状态：0-未支付，1-已支付，2-已过期，3-已退款';
COMMENT ON COLUMN user_course.create_time IS '创建时间';
COMMENT ON COLUMN user_course.update_time IS '更新时间';
COMMENT ON COLUMN user_course.is_delete IS '是否删除';

-- 用户学习进度表
CREATE TABLE IF NOT EXISTS user_course_progress
(
    id             BIGSERIAL PRIMARY KEY,
    user_id        BIGINT                             NOT NULL,
    course_id      BIGINT                             NOT NULL,
    section_id     BIGINT                             NOT NULL,
    progress       INT      DEFAULT 0                 NOT NULL,
    watch_duration INT      DEFAULT 0                 NOT NULL,
    last_position  INT      DEFAULT 0                 NOT NULL,
    is_completed   SMALLINT DEFAULT 0                 NOT NULL,
    completed_time TIMESTAMP                          NULL,
    create_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ucp_user_id ON user_course_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_ucp_course_id ON user_course_progress(course_id);
CREATE INDEX IF NOT EXISTS idx_ucp_section_id ON user_course_progress(section_id);
COMMENT ON TABLE user_course_progress IS '用户学习进度';
COMMENT ON COLUMN user_course_progress.id IS 'id';
COMMENT ON COLUMN user_course_progress.user_id IS '用户id';
COMMENT ON COLUMN user_course_progress.course_id IS '课程id';
COMMENT ON COLUMN user_course_progress.section_id IS '小节id';
COMMENT ON COLUMN user_course_progress.progress IS '学习进度(百分比)';
COMMENT ON COLUMN user_course_progress.watch_duration IS '观看时长(秒)';
COMMENT ON COLUMN user_course_progress.last_position IS '上次观看位置(秒)';
COMMENT ON COLUMN user_course_progress.is_completed IS '是否完成：0-否，1-是';
COMMENT ON COLUMN user_course_progress.completed_time IS '完成时间';
COMMENT ON COLUMN user_course_progress.create_time IS '创建时间';
COMMENT ON COLUMN user_course_progress.update_time IS '更新时间';

-- 课程评价表
CREATE TABLE IF NOT EXISTS course_review
(
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT                             NOT NULL,
    course_id   BIGINT                             NOT NULL,
    rating      SMALLINT DEFAULT 5                 NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_cr_user_id ON course_review(user_id);
CREATE INDEX IF NOT EXISTS idx_cr_course_id ON course_review(course_id);
CREATE INDEX IF NOT EXISTS idx_cr_rating ON course_review(rating);
COMMENT ON TABLE course_review IS '课程评价';
COMMENT ON COLUMN course_review.id IS 'id';
COMMENT ON COLUMN course_review.user_id IS '用户id';
COMMENT ON COLUMN course_review.course_id IS '课程id';
COMMENT ON COLUMN course_review.rating IS '评分(1-5分)';
COMMENT ON COLUMN course_review.create_time IS '创建时间';
COMMENT ON COLUMN course_review.update_time IS '更新时间';
COMMENT ON COLUMN course_review.is_delete IS '是否删除';

-- 课程收藏表
CREATE TABLE IF NOT EXISTS course_favourite
(
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT                             NOT NULL,
    course_id   BIGINT                             NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_cf_user_id ON course_favourite(user_id);
CREATE INDEX IF NOT EXISTS idx_cf_course_id ON course_favourite(course_id);
COMMENT ON TABLE course_favourite IS '课程收藏';
COMMENT ON COLUMN course_favourite.id IS 'id';
COMMENT ON COLUMN course_favourite.user_id IS '用户id';
COMMENT ON COLUMN course_favourite.course_id IS '课程id';
COMMENT ON COLUMN course_favourite.create_time IS '创建时间';
COMMENT ON COLUMN course_favourite.update_time IS '更新时间';
