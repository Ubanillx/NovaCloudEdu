-- 音视频通话记录表

CREATE TABLE IF NOT EXISTS call_record (
    id            BIGINT PRIMARY KEY,
    call_id       VARCHAR(64) NOT NULL UNIQUE,
    caller_id     BIGINT NOT NULL REFERENCES "user"(id),
    callee_id     BIGINT NOT NULL REFERENCES "user"(id),
    media_type    VARCHAR(10) NOT NULL,
    status        VARCHAR(20) NOT NULL,
    mode          VARCHAR(10) NOT NULL DEFAULT 'p2p',
    started_at    TIMESTAMP,
    ended_at      TIMESTAMP,
    duration      INT,
    create_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE call_record IS '音视频通话记录';
COMMENT ON COLUMN call_record.call_id IS '通话UUID（Go侧生成）';
COMMENT ON COLUMN call_record.caller_id IS '发起者用户ID';
COMMENT ON COLUMN call_record.callee_id IS '接收者用户ID';
COMMENT ON COLUMN call_record.media_type IS '媒体类型: audio/video';
COMMENT ON COLUMN call_record.status IS '状态: completed/missed/rejected/busy/failed';
COMMENT ON COLUMN call_record.mode IS '通话模式: p2p/turn/sfu';
COMMENT ON COLUMN call_record.started_at IS '通话开始时间';
COMMENT ON COLUMN call_record.ended_at IS '通话结束时间';
COMMENT ON COLUMN call_record.duration IS '通话时长(秒)';

CREATE INDEX IF NOT EXISTS idx_call_record_caller ON call_record(caller_id, create_time DESC);
CREATE INDEX IF NOT EXISTS idx_call_record_callee ON call_record(callee_id, create_time DESC);
