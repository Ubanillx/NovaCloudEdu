package com.novacloudedu.backend.interfaces.rest.schedule.dto.response;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ClassScheduleItemResponse {
    private String id;
    private String settingId;
    private String classId;
    private String userId;
    
    // Core Type
    private Integer courseType;
    private String courseTypeDesc;
    
    // Custom Course Info
    private String courseName;
    private String teacherName;
    private String location;
    
    // Platform Course Info
    private String courseId;
    private String teacherId;
    
    // Schedule Rules
    private Integer dayOfWeek;
    private Integer startSection;
    private Integer endSection;
    private Integer startWeek;
    private Integer endWeek;
    private Integer weekType;
    private String weekTypeDesc;
    
    // Display Info
    private String color;
    private String remark;
    
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
