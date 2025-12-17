package com.novacloudedu.backend.interfaces.rest.schedule.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AddScheduleItemRequest {
    @NotNull
    private Long settingId;
    @NotNull
    private Integer courseType;
    
    // Optional depending on type
    private String courseName;
    private String teacherName;
    private Long courseId;
    private Long teacherId;
    
    private String location;
    
    @NotNull
    private Integer dayOfWeek;
    @NotNull
    private Integer startSection;
    @NotNull
    private Integer endSection;
    
    private Integer startWeek;
    private Integer endWeek;
    private Integer weekType;
    
    private String color;
    private String remark;
}
