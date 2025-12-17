package com.novacloudedu.backend.application.schedule.command;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ActivateScheduleSettingCommand {

    private final ScheduleRepository scheduleRepository;

    @Transactional
    public void execute(Long settingId) {
        ClassScheduleSetting setting = scheduleRepository.findSettingById(settingId)
                .orElseThrow(() -> new BusinessException(404, "Schedule setting not found"));

        // Deactivate all other settings for this class
        scheduleRepository.deactivateAllSettings(setting.getClassId());

        // Activate this one
        setting.activate();
        scheduleRepository.saveSetting(setting);
    }
}
