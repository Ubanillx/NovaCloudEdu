-- 用户领域相关表

-- 用户表
CREATE TABLE IF NOT EXISTS "user"
(
    id            BIGSERIAL PRIMARY KEY,
    user_account  VARCHAR(256)                           NOT NULL,
    user_password VARCHAR(512)                           NOT NULL,
    user_gender   INT                                    NULL,
    user_phone    VARCHAR(256)                           NULL,
    level         INT                                    NOT NULL,
    user_name     VARCHAR(256)                           NULL,
    user_avatar   VARCHAR(1024)                          NULL,
    user_profile  VARCHAR(1024)                          NULL,
    user_role     VARCHAR(128) DEFAULT 'student'         NOT NULL,
    user_address  VARCHAR(1024)                          NULL,
    user_email    VARCHAR(512)                           NULL,
    birthday      TIMESTAMP                              NULL,
    create_time   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_ban        SMALLINT     DEFAULT 0                 NOT NULL,
    is_delete     SMALLINT     DEFAULT 0                 NOT NULL,
    CONSTRAINT uk_user_account UNIQUE (user_account)
);
CREATE INDEX IF NOT EXISTS idx_user_phone ON "user"(user_phone);
CREATE INDEX IF NOT EXISTS idx_user_email ON "user"(user_email);
CREATE INDEX IF NOT EXISTS idx_user_role ON "user"(user_role);
CREATE INDEX IF NOT EXISTS idx_user_display ON "user"(user_name, user_avatar, user_role);
COMMENT ON TABLE "user" IS '用户';
COMMENT ON COLUMN "user".id IS 'id';
COMMENT ON COLUMN "user".user_account IS '账号';
COMMENT ON COLUMN "user".user_password IS '密码';
COMMENT ON COLUMN "user".user_gender IS '性别 0-男 1-女 2-保密';
COMMENT ON COLUMN "user".user_phone IS '手机号';
COMMENT ON COLUMN "user".level IS '等级数值';
COMMENT ON COLUMN "user".user_name IS '用户昵称';
COMMENT ON COLUMN "user".user_avatar IS '用户头像';
COMMENT ON COLUMN "user".user_profile IS '用户简介';
COMMENT ON COLUMN "user".user_role IS '用户角色：student/teacher/admin';
COMMENT ON COLUMN "user".user_address IS '地址，JSON格式：{province,city,district}';
COMMENT ON COLUMN "user".user_email IS '邮箱';
COMMENT ON COLUMN "user".birthday IS '生日';
COMMENT ON COLUMN "user".create_time IS '创建时间';
COMMENT ON COLUMN "user".update_time IS '更新时间';
COMMENT ON COLUMN "user".is_ban IS '是否封禁,0-否,1-是';
COMMENT ON COLUMN "user".is_delete IS '是否删除,0-否,1-是';

-- 等级特权表
CREATE TABLE IF NOT EXISTS level_privilege
(
    id          BIGSERIAL PRIMARY KEY,
    level       INT                                NOT NULL,
    description VARCHAR(512)                       NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_lp_level ON level_privilege(level);
COMMENT ON TABLE level_privilege IS '等级特权';
COMMENT ON COLUMN level_privilege.id IS 'id';
COMMENT ON COLUMN level_privilege.level IS '等级';
COMMENT ON COLUMN level_privilege.description IS '特权描述';
COMMENT ON COLUMN level_privilege.create_time IS '创建时间';
COMMENT ON COLUMN level_privilege.update_time IS '更新时间';

-- 用户学习统计表（天）
CREATE TABLE IF NOT EXISTS user_learning_stats
(
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT                             NOT NULL,
    experience  INT      DEFAULT 0                 NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_uls_user_id ON user_learning_stats(user_id);
CREATE INDEX IF NOT EXISTS idx_uls_experience ON user_learning_stats(experience);
COMMENT ON TABLE user_learning_stats IS '用户学习统计';
COMMENT ON COLUMN user_learning_stats.id IS 'id';
COMMENT ON COLUMN user_learning_stats.user_id IS '用户id';
COMMENT ON COLUMN user_learning_stats.experience IS '当日经验值';
COMMENT ON COLUMN user_learning_stats.create_time IS '创建时间';
COMMENT ON COLUMN user_learning_stats.update_time IS '更新时间';

-- 用户每日学习目标表
CREATE TABLE IF NOT EXISTS user_daily_goal
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                             NOT NULL,
    content         TEXT                               NULL,
    is_completed    SMALLINT  DEFAULT 0                NOT NULL,
    completed_time  TIMESTAMP                          NULL,
    create_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_udg_user_id ON user_daily_goal(user_id);
COMMENT ON TABLE user_daily_goal IS '用户每日学习目标';
COMMENT ON COLUMN user_daily_goal.id IS 'id';
COMMENT ON COLUMN user_daily_goal.user_id IS '用户id';
COMMENT ON COLUMN user_daily_goal.content IS '目标内容';
COMMENT ON COLUMN user_daily_goal.is_completed IS '是否全部完成：0-否，1-是';
COMMENT ON COLUMN user_daily_goal.completed_time IS '全部完成时间';
COMMENT ON COLUMN user_daily_goal.create_time IS '创建时间';
COMMENT ON COLUMN user_daily_goal.update_time IS '更新时间';

-- 用户课程表（学期配置）
CREATE TABLE IF NOT EXISTS user_course_table
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT                             NOT NULL,
    table_name      VARCHAR(128)                       NOT NULL,
    semester        VARCHAR(64)                        NULL,
    start_date      DATE                               NOT NULL,
    total_weeks     INT         DEFAULT 20             NOT NULL,
    days_per_week   INT         DEFAULT 7              NOT NULL,
    sections_per_day INT        DEFAULT 12             NOT NULL,
    time_config     JSONB                              NULL,
    background_img  VARCHAR(1024)                      NULL,
    is_default      SMALLINT    DEFAULT 0              NOT NULL,
    create_time     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT    DEFAULT 0              NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_uct_user_id ON user_course_table(user_id);
CREATE INDEX IF NOT EXISTS idx_uct_is_default ON user_course_table(is_default);
COMMENT ON TABLE user_course_table IS '用户课程表（学期配置）';
COMMENT ON COLUMN user_course_table.id IS 'id';
COMMENT ON COLUMN user_course_table.user_id IS '用户id';
COMMENT ON COLUMN user_course_table.table_name IS '课程表名称';
COMMENT ON COLUMN user_course_table.semester IS '学期，如：2024-2025-1';
COMMENT ON COLUMN user_course_table.start_date IS '学期开始日期（第一周周一）';
COMMENT ON COLUMN user_course_table.total_weeks IS '总周数';
COMMENT ON COLUMN user_course_table.days_per_week IS '每周天数，默认7';
COMMENT ON COLUMN user_course_table.sections_per_day IS '每天节数';
COMMENT ON COLUMN user_course_table.time_config IS '时间配置JSON，如：[{"section":1,"start":"08:00","end":"08:45"},{"section":2,"start":"08:55","end":"09:40"}]';
COMMENT ON COLUMN user_course_table.background_img IS '背景图片URL';
COMMENT ON COLUMN user_course_table.is_default IS '是否默认课程表：0-否，1-是';
COMMENT ON COLUMN user_course_table.create_time IS '创建时间';
COMMENT ON COLUMN user_course_table.update_time IS '更新时间';
COMMENT ON COLUMN user_course_table.is_delete IS '是否删除：0-否，1-是';

-- 用户课程表项目（具体课程）
CREATE TABLE IF NOT EXISTS user_course_table_item
(
    id              BIGSERIAL PRIMARY KEY,
    table_id        BIGINT                             NOT NULL,
    course_name     VARCHAR(128)                       NOT NULL,
    teacher_name    VARCHAR(64)                        NULL,
    location        VARCHAR(128)                       NULL,
    day_of_week     SMALLINT                           NOT NULL,
    start_section   SMALLINT                           NOT NULL,
    end_section     SMALLINT                           NOT NULL,
    start_week      SMALLINT    DEFAULT 1              NOT NULL,
    end_week        SMALLINT    DEFAULT 20             NOT NULL,
    week_type       SMALLINT    DEFAULT 0              NOT NULL,
    color           VARCHAR(32)                        NULL,
    remark          VARCHAR(512)                       NULL,
    create_time     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT    DEFAULT 0              NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ucti_table_id ON user_course_table_item(table_id);
CREATE INDEX IF NOT EXISTS idx_ucti_day_section ON user_course_table_item(day_of_week, start_section);
COMMENT ON TABLE user_course_table_item IS '用户课程表项目（具体课程）';
COMMENT ON COLUMN user_course_table_item.id IS 'id';
COMMENT ON COLUMN user_course_table_item.table_id IS '课程表id';
COMMENT ON COLUMN user_course_table_item.course_name IS '课程名称';
COMMENT ON COLUMN user_course_table_item.teacher_name IS '教师姓名';
COMMENT ON COLUMN user_course_table_item.location IS '上课地点';
COMMENT ON COLUMN user_course_table_item.day_of_week IS '星期几：1-7对应周一到周日';
COMMENT ON COLUMN user_course_table_item.start_section IS '开始节次';
COMMENT ON COLUMN user_course_table_item.end_section IS '结束节次';
COMMENT ON COLUMN user_course_table_item.start_week IS '开始周';
COMMENT ON COLUMN user_course_table_item.end_week IS '结束周';
COMMENT ON COLUMN user_course_table_item.week_type IS '周类型：0-每周，1-单周，2-双周';
COMMENT ON COLUMN user_course_table_item.color IS '显示颜色，如：#FF5733';
COMMENT ON COLUMN user_course_table_item.remark IS '备注';
COMMENT ON COLUMN user_course_table_item.create_time IS '创建时间';
COMMENT ON COLUMN user_course_table_item.update_time IS '更新时间';
COMMENT ON COLUMN user_course_table_item.is_delete IS '是否删除：0-否，1-是';
