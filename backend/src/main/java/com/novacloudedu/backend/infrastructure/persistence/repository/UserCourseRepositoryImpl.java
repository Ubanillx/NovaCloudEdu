package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.order.valueobject.OrderStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserCourseConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserCourseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCoursePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class UserCourseRepositoryImpl implements UserCourseRepository {

    private final UserCourseMapper userCourseMapper;
    private final UserCourseConverter userCourseConverter;

    @Override
    public UserCourse save(UserCourse userCourse) {
        UserCoursePO po = userCourseConverter.toUserCoursePO(userCourse);
        if (po.getId() == null) {
            userCourseMapper.insert(po);
            userCourse.assignId(po.getId());
        } else {
            userCourseMapper.updateById(po);
        }
        return userCourse;
    }

    @Override
    public Optional<UserCourse> findById(Long id) {
        UserCoursePO po = userCourseMapper.selectById(id);
        return Optional.ofNullable(po).map(userCourseConverter::toUserCourse);
    }

    @Override
    public Optional<UserCourse> findByOrderNo(String orderNo) {
        LambdaQueryWrapper<UserCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCoursePO::getOrderNo, orderNo);
        UserCoursePO po = userCourseMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userCourseConverter::toUserCourse);
    }

    @Override
    public Optional<UserCourse> findByUserIdAndCourseId(UserId userId, CourseId courseId) {
        LambdaQueryWrapper<UserCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCoursePO::getUserId, userId.value())
                .eq(UserCoursePO::getCourseId, courseId.value())
                .eq(UserCoursePO::getStatus, OrderStatus.PAID.getCode())
                .orderByDesc(UserCoursePO::getCreateTime)
                .last("LIMIT 1");
        UserCoursePO po = userCourseMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(userCourseConverter::toUserCourse);
    }

    @Override
    public List<UserCourse> findByUserId(UserId userId, int page, int size) {
        Page<UserCoursePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCoursePO::getUserId, userId.value())
                .orderByDesc(UserCoursePO::getCreateTime);
        Page<UserCoursePO> result = userCourseMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userCourseConverter::toUserCourse)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserCourse> findByStatus(OrderStatus status, int page, int size) {
        Page<UserCoursePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<UserCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCoursePO::getStatus, status.getCode())
                .orderByDesc(UserCoursePO::getCreateTime);
        Page<UserCoursePO> result = userCourseMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(userCourseConverter::toUserCourse)
                .collect(Collectors.toList());
    }

    @Override
    public boolean existsByUserIdAndCourseId(UserId userId, CourseId courseId) {
        LambdaQueryWrapper<UserCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCoursePO::getUserId, userId.value())
                .eq(UserCoursePO::getCourseId, courseId.value())
                .eq(UserCoursePO::getStatus, OrderStatus.PAID.getCode());
        return userCourseMapper.selectCount(wrapper) > 0;
    }

    @Override
    public long countByStatus(OrderStatus status) {
        LambdaQueryWrapper<UserCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserCoursePO::getStatus, status.getCode());
        return userCourseMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(Long id) {
        userCourseMapper.deleteById(id);
    }
}
