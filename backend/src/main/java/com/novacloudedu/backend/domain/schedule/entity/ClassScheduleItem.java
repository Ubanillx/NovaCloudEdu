package com.novacloudedu.backend.domain.schedule.entity;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleCourseType;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleWeekType;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ClassScheduleItem {

    private Long id;
    private Long settingId;
    private ClassId classId;
    private UserId userId;
    
    // Core Type
    private ScheduleCourseType courseType;
    
    // Custom Course Info
    private String courseName;
    private String teacherName;
    private String location;
    
    // Platform Course Info
    private CourseId courseId;
    private TeacherId teacherId;
    
    // Schedule Rules
    private Integer dayOfWeek;
    private Integer startSection;
    private Integer endSection;
    private Integer startWeek;
    private Integer endWeek;
    private ScheduleWeekType weekType;
    
    // Display Info
    private String color;
    private String remark;
    
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static ClassScheduleItem createCustom(Long settingId, ClassId classId, String courseName, String teacherName, 
                                                 String location, Integer dayOfWeek, Integer startSection, 
                                                 Integer endSection, Integer startWeek, Integer endWeek, 
                                                 ScheduleWeekType weekType, String color, String remark) {
        ClassScheduleItem item = new ClassScheduleItem();
        item.settingId = settingId;
        item.classId = classId;
        item.courseType = ScheduleCourseType.CUSTOM;
        item.courseName = courseName;
        item.teacherName = teacherName;
        item.location = location;
        item.dayOfWeek = dayOfWeek;
        item.startSection = startSection;
        item.endSection = endSection;
        item.startWeek = startWeek != null ? startWeek : 1;
        item.endWeek = endWeek != null ? endWeek : 20;
        item.weekType = weekType != null ? weekType : ScheduleWeekType.ALL;
        item.color = color;
        item.remark = remark;
        item.createTime = LocalDateTime.now();
        item.updateTime = LocalDateTime.now();
        return item;
    }

    public static ClassScheduleItem createPlatform(Long settingId, ClassId classId, CourseId courseId, TeacherId teacherId,
                                                   String location, Integer dayOfWeek, Integer startSection,
                                                   Integer endSection, Integer startWeek, Integer endWeek,
                                                   ScheduleWeekType weekType, String color, String remark) {
        ClassScheduleItem item = new ClassScheduleItem();
        item.settingId = settingId;
        item.classId = classId;
        item.courseType = ScheduleCourseType.PLATFORM;
        item.courseId = courseId;
        item.teacherId = teacherId;
        item.location = location;
        item.dayOfWeek = dayOfWeek;
        item.startSection = startSection;
        item.endSection = endSection;
        item.startWeek = startWeek != null ? startWeek : 1;
        item.endWeek = endWeek != null ? endWeek : 20;
        item.weekType = weekType != null ? weekType : ScheduleWeekType.ALL;
        item.color = color;
        item.remark = remark;
        item.createTime = LocalDateTime.now();
        item.updateTime = LocalDateTime.now();
        return item;
    }

    public static ClassScheduleItem reconstruct(Long id, Long settingId, ClassId classId, UserId userId,
                                                ScheduleCourseType courseType,
                                                String courseName, String teacherName, String location,
                                                CourseId courseId, TeacherId teacherId,
                                                Integer dayOfWeek, Integer startSection, Integer endSection,
                                                Integer startWeek, Integer endWeek, ScheduleWeekType weekType,
                                                String color, String remark,
                                                LocalDateTime createTime, LocalDateTime updateTime) {
        ClassScheduleItem item = new ClassScheduleItem();
        item.id = id;
        item.settingId = settingId;
        item.classId = classId;
        item.userId = userId;
        item.courseType = courseType;
        item.courseName = courseName;
        item.teacherName = teacherName;
        item.location = location;
        item.courseId = courseId;
        item.teacherId = teacherId;
        item.dayOfWeek = dayOfWeek;
        item.startSection = startSection;
        item.endSection = endSection;
        item.startWeek = startWeek;
        item.endWeek = endWeek;
        item.weekType = weekType;
        item.color = color;
        item.remark = remark;
        item.createTime = createTime;
        item.updateTime = updateTime;
        return item;
    }
    
    public void update(String location, Integer dayOfWeek, Integer startSection, Integer endSection,
                       Integer startWeek, Integer endWeek, ScheduleWeekType weekType, String color, String remark) {
        this.location = location;
        this.dayOfWeek = dayOfWeek;
        this.startSection = startSection;
        this.endSection = endSection;
        this.startWeek = startWeek;
        this.endWeek = endWeek;
        this.weekType = weekType;
        this.color = color;
        this.remark = remark;
        this.updateTime = LocalDateTime.now();
    }
    
    public void updateCustomInfo(String courseName, String teacherName) {
        if (this.courseType == ScheduleCourseType.CUSTOM) {
            this.courseName = courseName;
            this.teacherName = teacherName;
            this.updateTime = LocalDateTime.now();
        }
    }
}
