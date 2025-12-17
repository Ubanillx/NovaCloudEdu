package com.novacloudedu.backend.domain.schedule.repository;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;

import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;

import java.util.List;
import java.util.Optional;

public interface ScheduleRepository {
    
    // Setting related
    ClassScheduleSetting saveSetting(ClassScheduleSetting setting);
    Optional<ClassScheduleSetting> findSettingById(Long id);
    Optional<ClassScheduleSetting> findActiveSettingByClassId(ClassId classId);
    List<ClassScheduleSetting> findAllSettingsByClassId(ClassId classId);
    void deactivateAllSettings(ClassId classId);
    
    // Item related
    ClassScheduleItem saveItem(ClassScheduleItem item);
    Optional<ClassScheduleItem> findItemById(Long id);
    List<ClassScheduleItem> findItemsBySettingId(Long settingId);
    List<ClassScheduleItem> findItemsByUserId(com.novacloudedu.backend.domain.user.valueobject.UserId userId);
    List<ClassScheduleItem> findActiveItemsByTeacherId(TeacherId teacherId);
    void deleteItem(Long id);
    void deleteItemsBySettingId(Long settingId);
}
