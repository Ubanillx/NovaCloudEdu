package com.novacloudedu.backend.application.schedule.query;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetClassScheduleQuery {

    private final ScheduleRepository scheduleRepository;

    @Data
    @Builder
    public static class ScheduleDTO {
        private ClassScheduleSetting setting;
        private List<ClassScheduleItem> items;
    }

    public ScheduleDTO execute(Long classId) {
        Optional<ClassScheduleSetting> settingOpt = scheduleRepository.findActiveSettingByClassId(ClassId.of(classId));
        
        if (settingOpt.isEmpty()) {
            return ScheduleDTO.builder()
                    .setting(null)
                    .items(Collections.emptyList())
                    .build();
        }

        ClassScheduleSetting setting = settingOpt.get();
        List<ClassScheduleItem> items = scheduleRepository.findItemsBySettingId(setting.getId());

        return ScheduleDTO.builder()
                .setting(setting)
                .items(items)
                .build();
    }
    
    public ScheduleDTO executeBySettingId(Long settingId) {
        Optional<ClassScheduleSetting> settingOpt = scheduleRepository.findSettingById(settingId);
        
        if (settingOpt.isEmpty()) {
            return null;
        }

        ClassScheduleSetting setting = settingOpt.get();
        List<ClassScheduleItem> items = scheduleRepository.findItemsBySettingId(setting.getId());

        return ScheduleDTO.builder()
                .setting(setting)
                .items(items)
                .build();
    }
}
