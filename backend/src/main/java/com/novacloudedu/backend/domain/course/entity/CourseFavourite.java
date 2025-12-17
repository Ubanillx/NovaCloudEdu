package com.novacloudedu.backend.domain.course.entity;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CourseFavourite {

    private Long id;
    private UserId userId;
    private CourseId courseId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static CourseFavourite create(UserId userId, CourseId courseId) {
        CourseFavourite favourite = new CourseFavourite();
        favourite.userId = userId;
        favourite.courseId = courseId;
        favourite.createTime = LocalDateTime.now();
        favourite.updateTime = LocalDateTime.now();
        return favourite;
    }

    public static CourseFavourite reconstruct(Long id, UserId userId, CourseId courseId,
                                             LocalDateTime createTime, LocalDateTime updateTime) {
        CourseFavourite favourite = new CourseFavourite();
        favourite.id = id;
        favourite.userId = userId;
        favourite.courseId = courseId;
        favourite.createTime = createTime;
        favourite.updateTime = updateTime;
        return favourite;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("收藏ID已分配，不可重复分配");
        }
        this.id = id;
    }
}
