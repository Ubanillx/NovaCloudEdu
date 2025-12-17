package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.progress.entity.UserCourseProgress;
import com.novacloudedu.backend.domain.progress.repository.UserCourseProgressRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserCourseProgressConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserCourseProgressMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCourseProgressPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserCourseProgressRepositoryImpl implements UserCourseProgressRepository {

    private final UserCourseProgressMapper progressMapper;
    private final UserCourseProgressConverter progressConverter;

    @Override
    public UserCourseProgress save(UserCourseProgress progress) {
        UserCourseProgressPO po = progressConverter.toProgressPO(progress);
        if (po.getId() == null) {
            progressMapper.insert(po);
            progress.assignId(po.getId());
        } else {
            progressMapper.updateById(po);
        }
        return progress;
    }

    @Override
    public Optional<UserCourseProgress> findById(Long id) {
        UserCourseProgressPO po = progressMapper.selectById(id);
        return Optional.ofNullable(po).map(progressConverter::toProgress);
    }

    @Override
    public Optional<UserCourseProgress> findByUserIdAndSectionId(UserId userId, SectionId sectionId) {
        LambdaQueryWrapper<UserCourseProgressPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCourseProgressPO::getUserId, userId.value())
                .eq(UserCourseProgressPO::getSectionId, sectionId.value());
        UserCourseProgressPO po = progressMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(progressConverter::toProgress);
    }

    @Override
    public List<UserCourseProgress> findByUserIdAndCourseId(UserId userId, CourseId courseId) {
        LambdaQueryWrapper<UserCourseProgressPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCourseProgressPO::getUserId, userId.value())
                .eq(UserCourseProgressPO::getCourseId, courseId.value())
                .orderByDesc(UserCourseProgressPO::getUpdateTime);
        return progressMapper.selectList(wrapper).stream()
                .map(progressConverter::toProgress)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserCourseProgress> findByCourseId(CourseId courseId, int page, int size) {
        Page<UserCourseProgressPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserCourseProgressPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCourseProgressPO::getCourseId, courseId.value())
                .orderByDesc(UserCourseProgressPO::getUpdateTime);
        Page<UserCourseProgressPO> result = progressMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(progressConverter::toProgress)
                .collect(Collectors.toList());
    }

    @Override
    public long countCompletedSectionsByUserIdAndCourseId(UserId userId, CourseId courseId) {
        return progressMapper.countCompletedSections(userId.value(), courseId.value());
    }

    @Override
    public long countTotalSectionsByCourseId(CourseId courseId) {
        return progressMapper.countTotalSections(courseId.value());
    }

    @Override
    public int calculateCourseProgress(UserId userId, CourseId courseId) {
        return progressMapper.calculateAvgProgress(userId.value(), courseId.value());
    }

    @Override
    public void deleteById(Long id) {
        progressMapper.deleteById(id);
    }
}
