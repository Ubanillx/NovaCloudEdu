package com.novacloudedu.backend.domain.file.valueobject;

import lombok.Getter;

@Getter
public enum FileBusinessType {

    COURSE_COVER("course/cover", "课程封面", 5 * 1024 * 1024),
    COURSE_VIDEO("course/video", "课程视频", 500 * 1024 * 1024),
    COURSE_MATERIAL("course/material", "课程资料", 50 * 1024 * 1024),
    USER_AVATAR("user/avatar", "用户头像", 2 * 1024 * 1024),
    TEACHER_AVATAR("teacher/avatar", "讲师头像", 2 * 1024 * 1024),
    TEACHER_CERTIFICATE("teacher/certificate", "讲师证书", 10 * 1024 * 1024),
    SYSTEM_DOCUMENT("system/document", "系统文档", 20 * 1024 * 1024),
    FEEDBACK_ATTACHMENT("feedback/attachment", "反馈附件", 30 * 1024 * 1024),
    GENERAL("general", "通用文件", 100 * 1024 * 1024),
    CHAT_FILE("chat/file", "对话文件", 50 * 1024 * 1024),
    GROUP_CHAT_FILE("chat/group", "群聊文件", 50 * 1024 * 1024),
    AI_CHAT_FILE("chat/ai", "AI聊天文件", 50 * 1024 * 1024);

    private final String folder;
    private final String description;
    private final long maxSizeBytes;

    FileBusinessType(String folder, String description, long maxSizeBytes) {
        this.folder = folder;
        this.description = description;
        this.maxSizeBytes = maxSizeBytes;
    }

    public static FileBusinessType fromFolder(String folder) {
        for (FileBusinessType type : values()) {
            if (type.folder.equals(folder)) {
                return type;
            }
        }
        throw new IllegalArgumentException("未知的业务类型: " + folder);
    }
}
