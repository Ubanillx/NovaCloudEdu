package com.novacloudedu.backend.application.schedule.command;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CreateScheduleSettingCommand {

    private final ScheduleRepository scheduleRepository;

    @Transactional
    public Long execute(Long classId, String semester, LocalDate startDate,
                        Integer totalWeeks, Integer daysPerWeek, Integer sectionsPerDay,
                        List<TimeConfigItem> timeConfig) {
        
        ClassScheduleSetting setting = ClassScheduleSetting.create(
                ClassId.of(classId),
                semester,
                startDate,
                totalWeeks,
                daysPerWeek,
                sectionsPerDay,
                timeConfig
        );
        
        ClassScheduleSetting saved = scheduleRepository.saveSetting(setting);
        return saved.getId();
    }
}
