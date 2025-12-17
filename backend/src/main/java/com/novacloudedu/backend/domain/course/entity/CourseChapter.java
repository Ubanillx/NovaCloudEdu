 package com.novacloudedu.backend.domain.course.entity;

import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class CourseChapter {

    private ChapterId id;
    private final CourseId courseId;
    private String title;
    private String description;
    private Integer sort;
    private final UserId adminId;
    private final LocalDateTime createTime;
    private LocalDateTime updateTime;

    private CourseChapter(ChapterId id, CourseId courseId, String title, String description,
                         Integer sort, UserId adminId, LocalDateTime createTime, LocalDateTime updateTime) {
        this.id = id;
        this.courseId = courseId;
        this.title = title;
        this.description = description;
        this.sort = sort;
        this.adminId = adminId;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public static CourseChapter create(CourseId courseId, String title, String description,
                                      Integer sort, UserId adminId) {
        LocalDateTime now = LocalDateTime.now();
        return new CourseChapter(null, courseId, title, description, sort, adminId, now, now);
    }

    public static CourseChapter reconstruct(ChapterId id, CourseId courseId, String title, String description,
                                           Integer sort, UserId adminId, LocalDateTime createTime, LocalDateTime updateTime) {
        return new CourseChapter(id, courseId, title, description, sort, adminId, createTime, updateTime);
    }

    public void assignId(ChapterId id) {
        if (this.id != null) {
            throw new IllegalStateException("章节ID已存在");
        }
        this.id = id;
    }

    public void updateInfo(String title, String description, Integer sort) {
        this.title = title;
        this.description = description;
        this.sort = sort;
        this.updateTime = LocalDateTime.now();
    }

    public void updateSort(Integer sort) {
        this.sort = sort;
        this.updateTime = LocalDateTime.now();
    }
}
