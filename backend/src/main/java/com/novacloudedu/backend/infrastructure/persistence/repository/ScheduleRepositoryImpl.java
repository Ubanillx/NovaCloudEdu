package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleSetting;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ScheduleConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ClassScheduleItemMapper;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ClassScheduleSettingMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassScheduleItemPO;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassScheduleSettingPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class ScheduleRepositoryImpl implements ScheduleRepository {

    private final ClassScheduleSettingMapper settingMapper;
    private final ClassScheduleItemMapper itemMapper;
    private final ScheduleConverter converter;

    @Override
    public ClassScheduleSetting saveSetting(ClassScheduleSetting setting) {
        ClassScheduleSettingPO po = converter.toSettingPO(setting);
        if (po.getId() == null) {
            settingMapper.insert(po);
            // Re-construct to get ID if needed, though usually we just return the object.
            // But domain object is immutable-ish for ID usually. 
            // In this project structure, it seems we might need to reflect the ID back or return new instance.
            // Looking at CourseRepositoryImpl, it assigns ID back.
            // We need to implement assignId or similar if we want to reflect ID back to domain object, 
            // but ClassScheduleSetting uses factory/reconstruct pattern.
            // Let's check Course.java again. It has assignId.
            // I should probably add assignId to ClassScheduleSetting or just return the reconstructed one.
            // For now, let's rely on the fact that the PO has the ID after insert.
            return converter.toSetting(po);
        } else {
            settingMapper.updateById(po);
            return setting;
        }
    }

    @Override
    public Optional<ClassScheduleSetting> findSettingById(Long id) {
        ClassScheduleSettingPO po = settingMapper.selectById(id);
        return Optional.ofNullable(po).map(converter::toSetting);
    }

    @Override
    public Optional<ClassScheduleSetting> findActiveSettingByClassId(ClassId classId) {
        LambdaQueryWrapper<ClassScheduleSettingPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassScheduleSettingPO::getClassId, classId.getValue())
               .eq(ClassScheduleSettingPO::getIsActive, 1);
        ClassScheduleSettingPO po = settingMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(converter::toSetting);
    }

    @Override
    public List<ClassScheduleSetting> findAllSettingsByClassId(ClassId classId) {
        LambdaQueryWrapper<ClassScheduleSettingPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassScheduleSettingPO::getClassId, classId.getValue())
               .orderByDesc(ClassScheduleSettingPO::getCreateTime);
        return settingMapper.selectList(wrapper).stream()
                .map(converter::toSetting)
                .collect(Collectors.toList());
    }

    @Override
    public void deactivateAllSettings(ClassId classId) {
        LambdaUpdateWrapper<ClassScheduleSettingPO> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(ClassScheduleSettingPO::getClassId, classId.getValue())
               .set(ClassScheduleSettingPO::getIsActive, 0);
        settingMapper.update(null, wrapper);
    }

    @Override
    public ClassScheduleItem saveItem(ClassScheduleItem item) {
        ClassScheduleItemPO po = converter.toItemPO(item);
        if (po.getId() == null) {
            itemMapper.insert(po);
            return converter.toItem(po);
        } else {
            itemMapper.updateById(po);
            return item;
        }
    }

    @Override
    public Optional<ClassScheduleItem> findItemById(Long id) {
        ClassScheduleItemPO po = itemMapper.selectById(id);
        return Optional.ofNullable(po).map(converter::toItem);
    }

    @Override
    public List<ClassScheduleItem> findItemsBySettingId(Long settingId) {
        LambdaQueryWrapper<ClassScheduleItemPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassScheduleItemPO::getSettingId, settingId)
               .orderByAsc(ClassScheduleItemPO::getDayOfWeek)
               .orderByAsc(ClassScheduleItemPO::getStartSection);
        return itemMapper.selectList(wrapper).stream()
                .map(converter::toItem)
                .collect(Collectors.toList());
    }

    @Override
    public List<ClassScheduleItem> findItemsByUserId(com.novacloudedu.backend.domain.user.valueobject.UserId userId) {
        LambdaQueryWrapper<ClassScheduleItemPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassScheduleItemPO::getUserId, userId.value())
               .orderByAsc(ClassScheduleItemPO::getDayOfWeek)
               .orderByAsc(ClassScheduleItemPO::getStartSection);
        return itemMapper.selectList(wrapper).stream()
                .map(converter::toItem)
                .collect(Collectors.toList());
    }

    @Override
    public List<ClassScheduleItem> findActiveItemsByTeacherId(TeacherId teacherId) {
        return itemMapper.selectActiveByTeacherId(teacherId.value()).stream()
                .map(converter::toItem)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteItem(Long id) {
        itemMapper.deleteById(id);
    }

    @Override
    public void deleteItemsBySettingId(Long settingId) {
        LambdaQueryWrapper<ClassScheduleItemPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassScheduleItemPO::getSettingId, settingId);
        itemMapper.delete(wrapper);
    }
}
