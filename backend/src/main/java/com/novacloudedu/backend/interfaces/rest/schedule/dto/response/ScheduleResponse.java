package com.novacloudedu.backend.interfaces.rest.schedule.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleResponse {
    private ClassScheduleSettingResponse setting;
    private List<ClassScheduleItemResponse> items;
}
