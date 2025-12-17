package com.novacloudedu.backend.interfaces.rest.schedule.dto.request;

import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class UpdateScheduleSettingRequest {
    @NotNull
    private String semester;
    @NotNull
    private LocalDate startDate;
    private Integer totalWeeks;
    private Integer daysPerWeek;
    private Integer sectionsPerDay;
    private List<TimeConfigItem> timeConfig;
}
