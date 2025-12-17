package com.novacloudedu.backend.application.schedule.command;

import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UpdateScheduleSettingCommand {

    private final ScheduleRepository scheduleRepository;

    @Transactional
    public void execute(Long settingId, String semester, LocalDate startDate,
                        Integer totalWeeks, Integer daysPerWeek, Integer sectionsPerDay,
                        List<TimeConfigItem> timeConfig) {
        
        ClassScheduleSetting setting = scheduleRepository.findSettingById(settingId)
                .orElseThrow(() -> new BusinessException(404, "Schedule setting not found"));
        
        setting.updateConfig(semester, startDate, totalWeeks, daysPerWeek, sectionsPerDay, timeConfig);
        scheduleRepository.saveSetting(setting);
    }
}
