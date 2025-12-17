package com.novacloudedu.backend.interfaces.rest.schedule.dto.request;

import lombok.Data;

@Data
public class UpdateScheduleItemRequest {
    private String location;
    private Integer dayOfWeek;
    private Integer startSection;
    private Integer endSection;
    private Integer startWeek;
    private Integer endWeek;
    private Integer weekType;
    private String color;
    private String remark;
    
    // For custom info updates
    private String courseName;
    private String teacherName;
}
