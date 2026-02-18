package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleCourseType;
import com.novacloudedu.backend.domain.schedule.valueobject.ScheduleWeekType;
import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

/**
 * 课程表应用服务
 * 负责课程表设置和课程项的CRUD用例编排
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ScheduleApplicationService {

    private final ScheduleRepository scheduleRepository;

    // ==================== 课程表设置 ====================

    @Transactional
    public Long createScheduleSetting(Long classId, String semester, LocalDate startDate,
                                      Integer totalWeeks, Integer daysPerWeek, Integer sectionsPerDay,
                                      List<TimeConfigItem> timeConfig) {
        ClassScheduleSetting setting = ClassScheduleSetting.create(
                ClassId.of(classId), semester, startDate, totalWeeks, daysPerWeek, sectionsPerDay, timeConfig
        );
        ClassScheduleSetting saved = scheduleRepository.saveSetting(setting);
        log.info("课程表设置创建成功: settingId={}, classId={}", saved.getId(), classId);
        return saved.getId();
    }

    @Transactional
    public void updateScheduleSetting(Long settingId, String semester, LocalDate startDate,
                                      Integer totalWeeks, Integer daysPerWeek, Integer sectionsPerDay,
                                      List<TimeConfigItem> timeConfig) {
        ClassScheduleSetting setting = scheduleRepository.findSettingById(settingId)
                .orElseThrow(() -> new BusinessException(404, "Schedule setting not found"));
        setting.updateConfig(semester, startDate, totalWeeks, daysPerWeek, sectionsPerDay, timeConfig);
        scheduleRepository.saveSetting(setting);
        log.info("课程表设置更新成功: settingId={}", settingId);
    }

    @Transactional
    public void activateScheduleSetting(Long settingId) {
        ClassScheduleSetting setting = scheduleRepository.findSettingById(settingId)
                .orElseThrow(() -> new BusinessException(404, "Schedule setting not found"));
        scheduleRepository.deactivateAllSettings(setting.getClassId());
        setting.activate();
        scheduleRepository.saveSetting(setting);
        log.info("课程表设置激活成功: settingId={}", settingId);
    }

    // ==================== 课程表项 ====================

    @Transactional
    public Long addScheduleItem(Long settingId, Long userId, Integer courseType,
                                String courseName, String teacherName, String location,
                                Long courseId, Long teacherId,
                                Integer dayOfWeek, Integer startSection, Integer endSection,
                                Integer startWeek, Integer endWeek, Integer weekType,
                                String color, String remark) {
        var setting = scheduleRepository.findSettingById(settingId)
                .orElseThrow(() -> new BusinessException(404, "Schedule setting not found"));

        ScheduleCourseType type = ScheduleCourseType.fromCode(courseType);
        ScheduleWeekType wType = ScheduleWeekType.fromCode(weekType);

        // 统一工厂方法：类型分支逻辑已下沉到实体
        ClassScheduleItem item = ClassScheduleItem.create(
                settingId, setting.getClassId(), UserId.of(userId), type,
                courseName, teacherName, location,
                courseId != null ? CourseId.of(courseId) : null,
                teacherId != null ? TeacherId.of(teacherId) : null,
                dayOfWeek, startSection, endSection, startWeek, endWeek, wType,
                color, remark
        );

        ClassScheduleItem saved = scheduleRepository.saveItem(item);
        log.info("课程表项添加成功: itemId={}, settingId={}", saved.getId(), settingId);
        return saved.getId();
    }

    @Transactional
    public void updateScheduleItem(Long itemId, String location, Integer dayOfWeek,
                                   Integer startSection, Integer endSection,
                                   Integer startWeek, Integer endWeek, Integer weekType,
                                   String color, String remark,
                                   String courseName, String teacherName) {
        ClassScheduleItem item = scheduleRepository.findItemById(itemId)
                .orElseThrow(() -> new BusinessException(404, "Schedule item not found"));
        item.update(location, dayOfWeek, startSection, endSection,
                startWeek, endWeek, ScheduleWeekType.fromCode(weekType), color, remark);
        item.updateCustomInfo(courseName, teacherName);
        scheduleRepository.saveItem(item);
        log.info("课程表项更新成功: itemId={}", itemId);
    }

    @Transactional
    public void deleteScheduleItem(Long itemId) {
        scheduleRepository.deleteItem(itemId);
        log.info("课程表项删除成功: itemId={}", itemId);
    }
}
