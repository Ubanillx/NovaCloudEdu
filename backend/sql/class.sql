-- 班级领域相关表

-- 班级信息表
CREATE TABLE IF NOT EXISTS class_info
(
    id          BIGSERIAL PRIMARY KEY,
    class_name  VARCHAR(256)                       NOT NULL,
    description TEXT                               NULL,
    creator_id  BIGINT                             NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_ci_creator_id ON class_info(creator_id);
COMMENT ON TABLE class_info IS '班级信息';
COMMENT ON COLUMN class_info.id IS '班级ID';
COMMENT ON COLUMN class_info.class_name IS '班级名称';
COMMENT ON COLUMN class_info.description IS '班级描述';
COMMENT ON COLUMN class_info.creator_id IS '创建者ID，关联到user表';
COMMENT ON COLUMN class_info.create_time IS '创建时间';
COMMENT ON COLUMN class_info.update_time IS '更新时间';
COMMENT ON COLUMN class_info.is_delete IS '是否删除：0-否，1-是';

-- 班级成员表
CREATE TABLE IF NOT EXISTS class_member
(
    id        BIGSERIAL PRIMARY KEY,
    class_id  BIGINT                             NOT NULL,
    user_id   BIGINT                             NOT NULL,
    role      VARCHAR(32)                        NOT NULL,
    join_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_cm_class_id ON class_member(class_id);
CREATE INDEX IF NOT EXISTS idx_cm_user_id ON class_member(user_id);
COMMENT ON TABLE class_member IS '班级成员';
COMMENT ON COLUMN class_member.id IS '成员ID';
COMMENT ON COLUMN class_member.class_id IS '班级ID，关联到class_info表';
COMMENT ON COLUMN class_member.user_id IS '用户ID，关联到user表';
COMMENT ON COLUMN class_member.role IS '角色，如teacher/student';
COMMENT ON COLUMN class_member.join_time IS '加入时间';
COMMENT ON COLUMN class_member.is_delete IS '是否删除：0-否，1-是';

-- 班级与课程关联表
CREATE TABLE IF NOT EXISTS class_course
(
    id          BIGSERIAL PRIMARY KEY,
    class_id    BIGINT                             NOT NULL,
    course_id   BIGINT                             NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_cc_class_id ON class_course(class_id);
CREATE INDEX IF NOT EXISTS idx_cc_course_id ON class_course(course_id);
COMMENT ON TABLE class_course IS '班级与课程关联';
COMMENT ON COLUMN class_course.id IS '关联ID';
COMMENT ON COLUMN class_course.class_id IS '班级ID，关联到class_info表';
COMMENT ON COLUMN class_course.course_id IS '课程ID，关联到course表';
COMMENT ON COLUMN class_course.create_time IS '创建时间';
COMMENT ON COLUMN class_course.update_time IS '更新时间';
COMMENT ON COLUMN class_course.is_delete IS '是否删除：0-否，1-是';
