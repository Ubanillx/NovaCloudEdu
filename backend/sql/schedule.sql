-- 班级课程表领域相关表

-- 班级课程表配置（学期/作息配置）
CREATE TABLE IF NOT EXISTS class_schedule_setting
(
    id              BIGSERIAL PRIMARY KEY,
    class_id        BIGINT                             NOT NULL,
    semester        VARCHAR(64)                        NOT NULL, -- 学期，如：2024-2025-1
    start_date      DATE                               NOT NULL, -- 学期开始日期
    total_weeks     INT         DEFAULT 20             NOT NULL, -- 总周数
    days_per_week   INT         DEFAULT 7              NOT NULL, -- 每周天数
    sections_per_day INT        DEFAULT 12             NOT NULL, -- 每天节数
    time_config     JSONB                              NULL,     -- 节次时间配置 [{"section":1,"start":"08:00","end":"08:45"}]
    is_active       SMALLINT    DEFAULT 0              NOT NULL, -- 是否当前激活学期
    create_time     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT    DEFAULT 0              NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_css_class_id ON class_schedule_setting (class_id);
CREATE INDEX IF NOT EXISTS idx_css_active ON class_schedule_setting (class_id, is_active);

COMMENT ON TABLE class_schedule_setting IS '班级课程表配置';
COMMENT ON COLUMN class_schedule_setting.id IS '配置ID';
COMMENT ON COLUMN class_schedule_setting.class_id IS '班级ID';
COMMENT ON COLUMN class_schedule_setting.semester IS '学期名称';
COMMENT ON COLUMN class_schedule_setting.start_date IS '开学日期(第一周周一)';
COMMENT ON COLUMN class_schedule_setting.total_weeks IS '学期总周数';
COMMENT ON COLUMN class_schedule_setting.time_config IS '具体节次时间安排';
COMMENT ON COLUMN class_schedule_setting.is_active IS '是否为当前生效学期：0-否，1-是';


-- 班级课程表项（具体排课）
CREATE TABLE IF NOT EXISTS class_schedule_item
(
    id              BIGSERIAL PRIMARY KEY,
    setting_id      BIGINT                             NULL,     -- 关联配置 (个人日程可能不关联班级配置)
    class_id        BIGINT                             NULL,     -- 关联班级ID
    user_id         BIGINT                             NULL,     -- 关联用户ID (个人日程)
    
    -- 核心类型区分
    course_type     SMALLINT    DEFAULT 1              NOT NULL, -- 1-现实课程(自定义), 2-虚拟课程(平台课程)
    
    -- 现实课程信息 (当 type=1 时使用)
    course_name     VARCHAR(128)                       NULL,     -- 自定义课程名
    teacher_name    VARCHAR(64)                        NULL,     -- 自定义教师名
    location        VARCHAR(128)                       NULL,     -- 上课地点/教室
    
    -- 虚拟课程信息 (当 type=2 时使用)
    course_id       BIGINT                             NULL,     -- 关联平台课程ID
    teacher_id      BIGINT                             NULL,     -- 关联平台讲师ID
    
    -- 排课时间规则
    day_of_week     SMALLINT                           NOT NULL, -- 星期几(1-7)
    start_section   SMALLINT                           NOT NULL, -- 开始节次
    end_section     SMALLINT                           NOT NULL, -- 结束节次
    start_week      SMALLINT    DEFAULT 1              NOT NULL, -- 开始周
    end_week        SMALLINT    DEFAULT 20             NOT NULL, -- 结束周
    week_type       SMALLINT    DEFAULT 0              NOT NULL, -- 周类型: 0-每周, 1-单周, 2-双周
    
    -- 其他展示信息
    color           VARCHAR(32)                        NULL,     -- 课程卡片颜色
    remark          VARCHAR(512)                       NULL,     -- 备注
    
    create_time     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete       SMALLINT    DEFAULT 0              NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_csi_setting_id ON class_schedule_item (setting_id);
CREATE INDEX IF NOT EXISTS idx_csi_class_date ON class_schedule_item (class_id, day_of_week);
CREATE INDEX IF NOT EXISTS idx_csi_course_id ON class_schedule_item (course_id);

COMMENT ON TABLE class_schedule_item IS '班级课程表项';
COMMENT ON COLUMN class_schedule_item.course_type IS '课程类型：1-现实课程(手动录入)，2-虚拟课程(关联平台)';
COMMENT ON COLUMN class_schedule_item.course_id IS '关联平台课程ID';
COMMENT ON COLUMN class_schedule_item.week_type IS '周类型：0-全周，1-单周，2-双周';
