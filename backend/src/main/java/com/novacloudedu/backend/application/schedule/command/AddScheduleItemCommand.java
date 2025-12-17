package com.novacloudedu.backend.application.schedule.command;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleCourseType;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleWeekType;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AddScheduleItemCommand {

    private final ScheduleRepository scheduleRepository;

    @Transactional
    public Long execute(Long settingId, Integer courseType,
                        String courseName, String teacherName, String location,
                        Long courseId, Long teacherId,
                        Integer dayOfWeek, Integer startSection, Integer endSection,
                        Integer startWeek, Integer endWeek, Integer weekType,
                        String color, String remark) {
        
        var setting = scheduleRepository.findSettingById(settingId)
                .orElseThrow(() -> new BusinessException(404, "Schedule setting not found"));

        ScheduleCourseType type = ScheduleCourseType.fromCode(courseType);
        ScheduleWeekType wType = ScheduleWeekType.fromCode(weekType);
        ClassId cId = setting.getClassId();

        ClassScheduleItem item;
        if (type == ScheduleCourseType.CUSTOM) {
            item = ClassScheduleItem.createCustom(
                    settingId, cId, courseName, teacherName, location,
                    dayOfWeek, startSection, endSection, startWeek, endWeek, wType,
                    color, remark
            );
        } else {
            item = ClassScheduleItem.createPlatform(
                    settingId, cId, CourseId.of(courseId), TeacherId.of(teacherId), location,
                    dayOfWeek, startSection, endSection, startWeek, endWeek, wType,
                    color, remark
            );
        }

        ClassScheduleItem saved = scheduleRepository.saveItem(item);
        return saved.getId();
    }
}
