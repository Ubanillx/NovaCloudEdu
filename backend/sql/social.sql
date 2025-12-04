-- 社交/私聊领域相关表

-- 私聊消息表
CREATE TABLE IF NOT EXISTS private_message
(
    id          BIGSERIAL PRIMARY KEY,
    sender_id   BIGINT                             NOT NULL,
    receiver_id BIGINT                             NOT NULL,
    content     TEXT                               NOT NULL,
    type        VARCHAR(50)                        NOT NULL,
    is_read     SMALLINT DEFAULT 0                 NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_pm_sender_id ON private_message(sender_id);
CREATE INDEX IF NOT EXISTS idx_pm_receiver_id ON private_message(receiver_id);
CREATE INDEX IF NOT EXISTS idx_pm_create_time ON private_message(create_time);
COMMENT ON TABLE private_message IS '私聊消息';
COMMENT ON COLUMN private_message.id IS '消息ID';
COMMENT ON COLUMN private_message.sender_id IS '发送者ID，关联到user表';
COMMENT ON COLUMN private_message.receiver_id IS '接收者ID，关联到user表';
COMMENT ON COLUMN private_message.content IS '消息内容';
COMMENT ON COLUMN private_message.type IS '消息类型';
COMMENT ON COLUMN private_message.is_read IS '是否已读：0-否，1-是';
COMMENT ON COLUMN private_message.create_time IS '发送时间';
COMMENT ON COLUMN private_message.is_delete IS '是否删除：0-否，1-是';

-- 私聊会话表
CREATE TABLE IF NOT EXISTS private_chat_session
(
    id                BIGSERIAL PRIMARY KEY,
    user_id1          BIGINT                             NOT NULL,
    user_id2          BIGINT                             NOT NULL,
    last_message_time TIMESTAMP                          NULL,
    create_time       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete         SMALLINT DEFAULT 0                 NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_pcs_user_id1 ON private_chat_session(user_id1);
CREATE INDEX IF NOT EXISTS idx_pcs_user_id2 ON private_chat_session(user_id2);
COMMENT ON TABLE private_chat_session IS '私聊会话';
COMMENT ON COLUMN private_chat_session.id IS '会话ID';
COMMENT ON COLUMN private_chat_session.user_id1 IS '用户1 ID，关联到user表';
COMMENT ON COLUMN private_chat_session.user_id2 IS '用户2 ID，关联到user表';
COMMENT ON COLUMN private_chat_session.last_message_time IS '最后一条消息时间';
COMMENT ON COLUMN private_chat_session.create_time IS '创建时间';
COMMENT ON COLUMN private_chat_session.update_time IS '更新时间';
COMMENT ON COLUMN private_chat_session.is_delete IS '是否删除：0-否，1-是';

-- 好友关系表
CREATE TABLE IF NOT EXISTS friend_relationship
(
    id          BIGSERIAL PRIMARY KEY,
    user_id1    BIGINT                             NOT NULL,
    user_id2    BIGINT                             NOT NULL,
    status      VARCHAR(20)                        NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_fr_user_id1 ON friend_relationship(user_id1);
CREATE INDEX IF NOT EXISTS idx_fr_user_id2 ON friend_relationship(user_id2);
COMMENT ON TABLE friend_relationship IS '好友关系表';
COMMENT ON COLUMN friend_relationship.id IS '主键';
COMMENT ON COLUMN friend_relationship.user_id1 IS '用户1 ID，关联到user表';
COMMENT ON COLUMN friend_relationship.user_id2 IS '用户2 ID，关联到user表';
COMMENT ON COLUMN friend_relationship.status IS '关系状态：pending/accepted/blocked';
COMMENT ON COLUMN friend_relationship.create_time IS '创建时间';
COMMENT ON COLUMN friend_relationship.update_time IS '更新时间';

-- 好友申请表
CREATE TABLE IF NOT EXISTS friend_request
(
    id          BIGSERIAL PRIMARY KEY,
    sender_id   BIGINT                             NOT NULL,
    receiver_id BIGINT                             NOT NULL,
    status      VARCHAR(20)                        NOT NULL,
    message     VARCHAR(512)                       NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_freq_sender_id ON friend_request(sender_id);
CREATE INDEX IF NOT EXISTS idx_freq_receiver_id ON friend_request(receiver_id);
COMMENT ON TABLE friend_request IS '好友申请表';
COMMENT ON COLUMN friend_request.id IS '主键';
COMMENT ON COLUMN friend_request.sender_id IS '发送者 ID，关联到user表';
COMMENT ON COLUMN friend_request.receiver_id IS '接收者 ID，关联到user表';
COMMENT ON COLUMN friend_request.status IS '申请状态：pending/accepted/rejected';
COMMENT ON COLUMN friend_request.message IS '申请消息';
COMMENT ON COLUMN friend_request.create_time IS '创建时间';
COMMENT ON COLUMN friend_request.update_time IS '更新时间';

-- ===================== 群聊相关表 =====================

-- 群聊信息表
CREATE TABLE IF NOT EXISTS chat_group
(
    id                BIGSERIAL PRIMARY KEY,
    group_name        VARCHAR(128)                       NOT NULL,
    avatar            VARCHAR(1024)                      NULL,
    description       VARCHAR(512)                       NULL,
    owner_id          BIGINT                             NOT NULL,
    class_id          BIGINT                             NULL,
    max_members       INT         DEFAULT 200            NOT NULL,
    member_count      INT         DEFAULT 1              NOT NULL,
    invite_mode       SMALLINT    DEFAULT 0              NOT NULL,
    join_mode         SMALLINT    DEFAULT 0              NOT NULL,
    is_mute           SMALLINT    DEFAULT 0              NOT NULL,
    announcement      TEXT                               NULL,
    announcement_time TIMESTAMP                          NULL,
    create_time       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete         SMALLINT  DEFAULT 0                NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_cg_owner_id ON chat_group(owner_id);
CREATE INDEX IF NOT EXISTS idx_cg_class_id ON chat_group(class_id);
CREATE INDEX IF NOT EXISTS idx_cg_create_time ON chat_group(create_time);
COMMENT ON TABLE chat_group IS '群聊信息';
COMMENT ON COLUMN chat_group.id IS '群ID';
COMMENT ON COLUMN chat_group.group_name IS '群名称';
COMMENT ON COLUMN chat_group.avatar IS '群头像URL';
COMMENT ON COLUMN chat_group.description IS '群描述';
COMMENT ON COLUMN chat_group.owner_id IS '群主ID，关联到user表';
COMMENT ON COLUMN chat_group.class_id IS '关联班级ID，关联到class_info表，可为空';
COMMENT ON COLUMN chat_group.max_members IS '最大成员数';
COMMENT ON COLUMN chat_group.member_count IS '当前成员数';
COMMENT ON COLUMN chat_group.invite_mode IS '邀请模式：0-所有人可邀请，1-仅管理员可邀请';
COMMENT ON COLUMN chat_group.join_mode IS '加入模式：0-自由加入，1-需审批，2-禁止加入';
COMMENT ON COLUMN chat_group.is_mute IS '是否全员禁言：0-否，1-是';
COMMENT ON COLUMN chat_group.announcement IS '群公告';
COMMENT ON COLUMN chat_group.announcement_time IS '公告发布时间';
COMMENT ON COLUMN chat_group.create_time IS '创建时间';
COMMENT ON COLUMN chat_group.update_time IS '更新时间';
COMMENT ON COLUMN chat_group.is_delete IS '是否删除：0-否，1-是';

-- 群成员表
CREATE TABLE IF NOT EXISTS chat_group_member
(
    id          BIGSERIAL PRIMARY KEY,
    group_id    BIGINT                             NOT NULL,
    member_type SMALLINT   DEFAULT 0               NOT NULL,
    user_id     BIGINT                             NULL,
    ai_role_id  BIGINT                             NULL,
    role        SMALLINT   DEFAULT 0               NOT NULL,
    nickname    VARCHAR(64)                        NULL,
    is_mute     SMALLINT   DEFAULT 0               NOT NULL,
    mute_until  TIMESTAMP                          NULL,
    join_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT  DEFAULT 0                NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_cgm_group_id ON chat_group_member(group_id);
CREATE INDEX IF NOT EXISTS idx_cgm_user_id ON chat_group_member(user_id);
CREATE INDEX IF NOT EXISTS idx_cgm_ai_role_id ON chat_group_member(ai_role_id);
COMMENT ON TABLE chat_group_member IS '群成员';
COMMENT ON COLUMN chat_group_member.id IS '主键';
COMMENT ON COLUMN chat_group_member.group_id IS '群ID，关联到chat_group表';
COMMENT ON COLUMN chat_group_member.member_type IS '成员类型：0-普通用户，1-AI角色';
COMMENT ON COLUMN chat_group_member.user_id IS '用户ID，关联到user表，member_type=0时有值';
COMMENT ON COLUMN chat_group_member.ai_role_id IS 'AI角色ID，关联到ai_role表，member_type=1时有值';
COMMENT ON COLUMN chat_group_member.role IS '角色：0-普通成员，1-管理员，2-群主';
COMMENT ON COLUMN chat_group_member.nickname IS '群昵称';
COMMENT ON COLUMN chat_group_member.is_mute IS '是否被禁言：0-否，1-是';
COMMENT ON COLUMN chat_group_member.mute_until IS '禁言截止时间';
COMMENT ON COLUMN chat_group_member.join_time IS '加入时间';
COMMENT ON COLUMN chat_group_member.update_time IS '更新时间';
COMMENT ON COLUMN chat_group_member.is_delete IS '是否删除（退出群）：0-否，1-是';

-- 群消息表
CREATE TABLE IF NOT EXISTS group_message
(
    id          BIGSERIAL PRIMARY KEY,
    group_id    BIGINT                             NOT NULL,
    sender_type SMALLINT   DEFAULT 0               NOT NULL,
    sender_id   BIGINT                             NULL,
    ai_role_id  BIGINT                             NULL,
    content     TEXT                               NOT NULL,
    type        VARCHAR(50)                        NOT NULL,
    reply_to    BIGINT                             NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_delete   SMALLINT  DEFAULT 0                NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_gm_group_id ON group_message(group_id);
CREATE INDEX IF NOT EXISTS idx_gm_sender_id ON group_message(sender_id);
CREATE INDEX IF NOT EXISTS idx_gm_ai_role_id ON group_message(ai_role_id);
CREATE INDEX IF NOT EXISTS idx_gm_create_time ON group_message(create_time);
COMMENT ON TABLE group_message IS '群消息';
COMMENT ON COLUMN group_message.id IS '消息ID';
COMMENT ON COLUMN group_message.group_id IS '群ID，关联到chat_group表';
COMMENT ON COLUMN group_message.sender_type IS '发送者类型：0-普通用户，1-AI角色';
COMMENT ON COLUMN group_message.sender_id IS '发送者ID，关联到user表，sender_type=0时有值';
COMMENT ON COLUMN group_message.ai_role_id IS 'AI角色ID，关联到ai_role表，sender_type=1时有值';
COMMENT ON COLUMN group_message.content IS '消息内容';
COMMENT ON COLUMN group_message.type IS '消息类型：text/image/file/audio/video/system';
COMMENT ON COLUMN group_message.reply_to IS '回复的消息ID';
COMMENT ON COLUMN group_message.create_time IS '发送时间';
COMMENT ON COLUMN group_message.is_delete IS '是否删除：0-否，1-是';

-- 群消息已读记录表
CREATE TABLE IF NOT EXISTS group_message_read
(
    id          BIGSERIAL PRIMARY KEY,
    message_id  BIGINT                             NOT NULL,
    user_id     BIGINT                             NOT NULL,
    read_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_gmr_message_id ON group_message_read(message_id);
CREATE INDEX IF NOT EXISTS idx_gmr_user_id ON group_message_read(user_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_gmr_message_user ON group_message_read(message_id, user_id);
COMMENT ON TABLE group_message_read IS '群消息已读记录';
COMMENT ON COLUMN group_message_read.id IS '主键';
COMMENT ON COLUMN group_message_read.message_id IS '消息ID，关联到group_message表';
COMMENT ON COLUMN group_message_read.user_id IS '用户ID，关联到user表';
COMMENT ON COLUMN group_message_read.read_time IS '阅读时间';

-- 群申请表
CREATE TABLE IF NOT EXISTS group_join_request
(
    id          BIGSERIAL PRIMARY KEY,
    group_id    BIGINT                             NOT NULL,
    user_id     BIGINT                             NOT NULL,
    message     VARCHAR(512)                       NULL,
    status      SMALLINT   DEFAULT 0               NOT NULL,
    handler_id  BIGINT                             NULL,
    handle_time TIMESTAMP                          NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_gjr_group_id ON group_join_request(group_id);
CREATE INDEX IF NOT EXISTS idx_gjr_user_id ON group_join_request(user_id);
CREATE INDEX IF NOT EXISTS idx_gjr_status ON group_join_request(status);
COMMENT ON TABLE group_join_request IS '群申请';
COMMENT ON COLUMN group_join_request.id IS '主键';
COMMENT ON COLUMN group_join_request.group_id IS '群ID，关联到chat_group表';
COMMENT ON COLUMN group_join_request.user_id IS '申请人ID，关联到user表';
COMMENT ON COLUMN group_join_request.message IS '申请消息';
COMMENT ON COLUMN group_join_request.status IS '状态：0-待审批，1-已通过，2-已拒绝';
COMMENT ON COLUMN group_join_request.handler_id IS '处理人ID';
COMMENT ON COLUMN group_join_request.handle_time IS '处理时间';
COMMENT ON COLUMN group_join_request.create_time IS '申请时间';
COMMENT ON COLUMN group_join_request.update_time IS '更新时间';
