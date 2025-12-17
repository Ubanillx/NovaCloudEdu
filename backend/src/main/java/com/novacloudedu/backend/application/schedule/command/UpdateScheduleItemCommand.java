package com.novacloudedu.backend.application.schedule.command;

import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleWeekType;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UpdateScheduleItemCommand {

    private final ScheduleRepository scheduleRepository;

    @Transactional
    public void execute(Long itemId, String location, Integer dayOfWeek, 
                        Integer startSection, Integer endSection,
                        Integer startWeek, Integer endWeek, Integer weekType,
                        String color, String remark,
                        String courseName, String teacherName) { // For custom info update
        
        ClassScheduleItem item = scheduleRepository.findItemById(itemId)
                .orElseThrow(() -> new BusinessException(404, "Schedule item not found"));
        
        item.update(location, dayOfWeek, startSection, endSection, 
                   startWeek, endWeek, ScheduleWeekType.fromCode(weekType), color, remark);
                   
        item.updateCustomInfo(courseName, teacherName);
        
        scheduleRepository.saveItem(item);
    }
}
