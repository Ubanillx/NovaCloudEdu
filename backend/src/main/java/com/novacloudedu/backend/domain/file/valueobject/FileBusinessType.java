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
    AI_CHAT_FILE("chat/ai", "AI聊天文件", 50 * 1024 * 1024),
    BOOK_FILE("book/file", "书籍文件", 200 * 1024 * 1024),
    BOOK_COVER("book/cover", "书籍封面", 5 * 1024 * 1024),
    AI_GENERATED_IMAGE("ai/generated", "AI生成图片", 20 * 1024 * 1024),
    AI_GENERATED_VIDEO("ai/video", "AI生成视频", 200 * 1024 * 1024),
    WORKFLOW_FILE("workflow/file", "工作流文件", 50 * 1024 * 1024),
    PPT_TEMPLATE("ppt/template", "PPT模板", 100 * 1024 * 1024),
    PPT_GENERATED("ppt/generated", "生成的PPT", 100 * 1024 * 1024),
    PPT_COVER("ppt/cover", "PPT封面", 5 * 1024 * 1024),
    EXAM_QUESTION_IMAGE("exam/question", "试题图片", 10 * 1024 * 1024),
    EXAM_TEMPLATE("exam/template", "试卷模板", 1 * 1024 * 1024),
    BANNER("banner", "轮播图", 10 * 1024 * 1024),
    ANNOUNCEMENT("announcement", "公告图片", 5 * 1024 * 1024);

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
