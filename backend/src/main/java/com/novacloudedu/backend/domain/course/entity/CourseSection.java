package com.novacloudedu.backend.domain.course.entity;

import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class CourseSection {

    private SectionId id;
    private final CourseId courseId;
    private final ChapterId chapterId;
    private String title;
    private String description;
    private String videoUrl;
    private Integer duration;
    private Integer sort;
    private Boolean isFree;
    private String resourceUrl;
    private String hlsUrl;
    private String encryptionKeyId;
    private Integer transcodeStatus; // 0-未转码, 1-转码中, 2-已完成, 3-失败
    private String thumbnailUrl;
    private Integer thumbnailCount;
    private final UserId adminId;
    private final LocalDateTime createTime;
    private LocalDateTime updateTime;

    private CourseSection(SectionId id, CourseId courseId, ChapterId chapterId, String title,
                         String description, String videoUrl, Integer duration, Integer sort,
                         Boolean isFree, String resourceUrl, String hlsUrl,
                         String encryptionKeyId, Integer transcodeStatus,
                         String thumbnailUrl, Integer thumbnailCount,
                         UserId adminId,
                         LocalDateTime createTime, LocalDateTime updateTime) {
        this.id = id;
        this.courseId = courseId;
        this.chapterId = chapterId;
        this.title = title;
        this.description = description;
        this.videoUrl = videoUrl;
        this.duration = duration;
        this.sort = sort;
        this.isFree = isFree;
        this.resourceUrl = resourceUrl;
        this.hlsUrl = hlsUrl;
        this.encryptionKeyId = encryptionKeyId;
        this.transcodeStatus = transcodeStatus;
        this.thumbnailUrl = thumbnailUrl;
        this.thumbnailCount = thumbnailCount;
        this.adminId = adminId;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public static CourseSection create(CourseId courseId, ChapterId chapterId, String title,
                                      String description, String videoUrl, Integer duration,
                                      Integer sort, Boolean isFree, String resourceUrl, UserId adminId) {
        LocalDateTime now = LocalDateTime.now();
        return new CourseSection(null, courseId, chapterId, title, description, videoUrl,
                duration, sort, isFree, resourceUrl, null, null, 0,
                null, 0, adminId, now, now);
    }

    public static CourseSection reconstruct(SectionId id, CourseId courseId, ChapterId chapterId,
                                           String title, String description, String videoUrl,
                                           Integer duration, Integer sort, Boolean isFree,
                                           String resourceUrl, String hlsUrl,
                                           String encryptionKeyId, Integer transcodeStatus,
                                           String thumbnailUrl, Integer thumbnailCount,
                                           UserId adminId,
                                           LocalDateTime createTime, LocalDateTime updateTime) {
        return new CourseSection(id, courseId, chapterId, title, description, videoUrl,
                duration, sort, isFree, resourceUrl, hlsUrl, encryptionKeyId, transcodeStatus,
                thumbnailUrl, thumbnailCount, adminId, createTime, updateTime);
    }

    public void assignId(SectionId id) {
        if (this.id != null) {
            throw new IllegalStateException("小节ID已存在");
        }
        this.id = id;
    }

    public void updateInfo(String title, String description, String videoUrl, Integer duration,
                          Integer sort, Boolean isFree, String resourceUrl) {
        this.title = title;
        this.description = description;
        this.videoUrl = videoUrl;
        this.duration = duration;
        this.sort = sort;
        this.isFree = isFree;
        this.resourceUrl = resourceUrl;
        this.updateTime = LocalDateTime.now();
    }

    public void updateSort(Integer sort) {
        this.sort = sort;
        this.updateTime = LocalDateTime.now();
    }

    public void updateTranscodeStatus(Integer transcodeStatus) {
        this.transcodeStatus = transcodeStatus;
        this.updateTime = LocalDateTime.now();
    }

    public void updateHlsInfo(String hlsUrl, String encryptionKeyId) {
        this.hlsUrl = hlsUrl;
        this.encryptionKeyId = encryptionKeyId;
        this.transcodeStatus = 2; // 已完成
        this.updateTime = LocalDateTime.now();
    }

    public void updateThumbnailInfo(String thumbnailUrl, Integer thumbnailCount) {
        this.thumbnailUrl = thumbnailUrl;
        this.thumbnailCount = thumbnailCount;
        this.updateTime = LocalDateTime.now();
    }
}
