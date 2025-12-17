package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.repository.TeacherApplicationRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.TeacherApplicationConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.TeacherApplicationMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.TeacherApplicationPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class TeacherApplicationRepositoryImpl implements TeacherApplicationRepository {

    private final TeacherApplicationMapper applicationMapper;
    private final TeacherApplicationConverter applicationConverter;

    @Override
    public TeacherApplication save(TeacherApplication application) {
        TeacherApplicationPO po = applicationConverter.toTeacherApplicationPO(application);
        if (po.getId() == null) {
            applicationMapper.insert(po);
            application.assignId(po.getId());
        } else {
            applicationMapper.updateById(po);
        }
        return application;
    }

    @Override
    public Optional<TeacherApplication> findById(Long id) {
        TeacherApplicationPO po = applicationMapper.selectById(id);
        return Optional.ofNullable(po).map(applicationConverter::toTeacherApplication);
    }

    @Override
    public Optional<TeacherApplication> findByUserId(UserId userId) {
        LambdaQueryWrapper<TeacherApplicationPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TeacherApplicationPO::getUserId, userId.value())
                .orderByDesc(TeacherApplicationPO::getCreateTime)
                .last("LIMIT 1");
        TeacherApplicationPO po = applicationMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(applicationConverter::toTeacherApplication);
    }

    @Override
    public List<TeacherApplication> findByStatus(TeacherStatus status, int page, int size) {
        Page<TeacherApplicationPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<TeacherApplicationPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TeacherApplicationPO::getStatus, status.getCode())
                .orderByDesc(TeacherApplicationPO::getCreateTime);
        Page<TeacherApplicationPO> result = applicationMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(applicationConverter::toTeacherApplication)
                .collect(Collectors.toList());
    }

    @Override
    public List<TeacherApplication> findAll(int page, int size) {
        Page<TeacherApplicationPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<TeacherApplicationPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(TeacherApplicationPO::getCreateTime);
        Page<TeacherApplicationPO> result = applicationMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(applicationConverter::toTeacherApplication)
                .collect(Collectors.toList());
    }

    @Override
    public long countByStatus(TeacherStatus status) {
        LambdaQueryWrapper<TeacherApplicationPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TeacherApplicationPO::getStatus, status.getCode());
        return applicationMapper.selectCount(wrapper);
    }

    @Override
    public boolean existsPendingByUserId(UserId userId) {
        LambdaQueryWrapper<TeacherApplicationPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TeacherApplicationPO::getUserId, userId.value())
                .eq(TeacherApplicationPO::getStatus, TeacherStatus.PENDING.getCode());
        return applicationMapper.selectCount(wrapper) > 0;
    }
}
