-- 直播系统表
-- 包含直播间和直播间聊天消息

-- 直播间
CREATE TABLE IF NOT EXISTS live_room (
    id            BIGINT PRIMARY KEY,
    title         VARCHAR(200) NOT NULL,
    description   TEXT,
    cover_url     VARCHAR(500),
    host_user_id  BIGINT NOT NULL REFERENCES "user"(id),
    class_id      BIGINT REFERENCES class_info(id),
    stream_key    VARCHAR(64) NOT NULL UNIQUE,
    status        VARCHAR(20) NOT NULL DEFAULT 'CREATED',
    visibility    VARCHAR(20) NOT NULL DEFAULT 'PUBLIC',
    viewer_count  INT NOT NULL DEFAULT 0,
    peak_viewers  INT NOT NULL DEFAULT 0,
    started_at    TIMESTAMP,
    ended_at      TIMESTAMP,
    duration      INT,
    is_recording  BOOLEAN DEFAULT false,
    playback_url  VARCHAR(500),
    create_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_delete     SMALLINT NOT NULL DEFAULT 0
);

COMMENT ON TABLE live_room IS '直播间';
COMMENT ON COLUMN live_room.id IS '雪花ID';
COMMENT ON COLUMN live_room.title IS '直播间标题';
COMMENT ON COLUMN live_room.description IS '直播间描述';
COMMENT ON COLUMN live_room.cover_url IS '封面图URL';
COMMENT ON COLUMN live_room.host_user_id IS '主播用户ID';
COMMENT ON COLUMN live_room.class_id IS '关联班级ID（NULL=公开直播）';
COMMENT ON COLUMN live_room.stream_key IS 'OBS推流密钥';
COMMENT ON COLUMN live_room.status IS '状态: CREATED/LIVE/ENDED';
COMMENT ON COLUMN live_room.visibility IS '可见性: PUBLIC/CLASS_ONLY';
COMMENT ON COLUMN live_room.viewer_count IS '当前观看人数';
COMMENT ON COLUMN live_room.peak_viewers IS '峰值观看人数';
COMMENT ON COLUMN live_room.started_at IS '开播时间';
COMMENT ON COLUMN live_room.ended_at IS '结束时间';
COMMENT ON COLUMN live_room.duration IS '直播时长(秒)';
COMMENT ON COLUMN live_room.is_recording IS '是否录制';
COMMENT ON COLUMN live_room.playback_url IS '回放地址';

CREATE INDEX IF NOT EXISTS idx_live_room_host ON live_room(host_user_id);
CREATE INDEX IF NOT EXISTS idx_live_room_status ON live_room(status);
CREATE INDEX IF NOT EXISTS idx_live_room_class ON live_room(class_id);

-- 直播间聊天消息（持久化）
CREATE TABLE IF NOT EXISTS live_room_message (
    id            BIGINT PRIMARY KEY,
    room_id       BIGINT NOT NULL REFERENCES live_room(id),
    sender_id     BIGINT NOT NULL REFERENCES "user"(id),
    content       TEXT NOT NULL,
    message_type  VARCHAR(20) NOT NULL DEFAULT 'TEXT',
    create_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_delete     SMALLINT NOT NULL DEFAULT 0
);

COMMENT ON TABLE live_room_message IS '直播间聊天消息';
COMMENT ON COLUMN live_room_message.room_id IS '所属直播间ID';
COMMENT ON COLUMN live_room_message.sender_id IS '发送者用户ID';
COMMENT ON COLUMN live_room_message.content IS '消息内容';
COMMENT ON COLUMN live_room_message.message_type IS '消息类型: TEXT/SYSTEM/GIFT';

CREATE INDEX IF NOT EXISTS idx_live_msg_room ON live_room_message(room_id, create_time);
CREATE INDEX IF NOT EXISTS idx_live_msg_sender ON live_room_message(sender_id);
