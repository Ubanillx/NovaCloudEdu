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
    private final UserId adminId;
    private final LocalDateTime createTime;
    private LocalDateTime updateTime;

    private CourseSection(SectionId id, CourseId courseId, ChapterId chapterId, String title,
                         String description, String videoUrl, Integer duration, Integer sort,
                         Boolean isFree, String resourceUrl, UserId adminId,
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
        this.adminId = adminId;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public static CourseSection create(CourseId courseId, ChapterId chapterId, String title,
                                      String description, String videoUrl, Integer duration,
                                      Integer sort, Boolean isFree, String resourceUrl, UserId adminId) {
        LocalDateTime now = LocalDateTime.now();
        return new CourseSection(null, courseId, chapterId, title, description, videoUrl,
                duration, sort, isFree, resourceUrl, adminId, now, now);
    }

    public static CourseSection reconstruct(SectionId id, CourseId courseId, ChapterId chapterId,
                                           String title, String description, String videoUrl,
                                           Integer duration, Integer sort, Boolean isFree,
                                           String resourceUrl, UserId adminId,
                                           LocalDateTime createTime, LocalDateTime updateTime) {
        return new CourseSection(id, courseId, chapterId, title, description, videoUrl,
                duration, sort, isFree, resourceUrl, adminId, createTime, updateTime);
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
}
