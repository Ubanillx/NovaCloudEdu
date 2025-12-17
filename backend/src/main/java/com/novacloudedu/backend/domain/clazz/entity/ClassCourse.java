package com.novacloudedu.backend.domain.clazz.entity;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class ClassCourse {
    private Long id;
    private ClassId classId;
    private CourseId courseId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    private ClassCourse() {}

    public static ClassCourse create(ClassId classId, CourseId courseId) {
        ClassCourse classCourse = new ClassCourse();
        classCourse.classId = classId;
        classCourse.courseId = courseId;
        classCourse.createTime = LocalDateTime.now();
        classCourse.updateTime = LocalDateTime.now();
        classCourse.isDelete = false;
        return classCourse;
    }

    public static ClassCourse reconstruct(Long id, ClassId classId, CourseId courseId,
                                        LocalDateTime createTime, LocalDateTime updateTime, boolean isDelete) {
        ClassCourse classCourse = new ClassCourse();
        classCourse.id = id;
        classCourse.classId = classId;
        classCourse.courseId = courseId;
        classCourse.createTime = createTime;
        classCourse.updateTime = updateTime;
        classCourse.isDelete = isDelete;
        return classCourse;
    }

    public void assignId(Long id) {
        this.id = id;
    }

    public void delete() {
        this.isDelete = true;
        this.updateTime = LocalDateTime.now();
    }
}
