package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.course.entity.CourseFavourite;
import com.novacloudedu.backend.domain.course.repository.CourseFavouriteRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.CourseFavouriteConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.CourseFavouriteMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseFavouritePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class CourseFavouriteRepositoryImpl implements CourseFavouriteRepository {

    private final CourseFavouriteMapper favouriteMapper;
    private final CourseFavouriteConverter favouriteConverter;

    @Override
    public CourseFavourite save(CourseFavourite favourite) {
        CourseFavouritePO po = favouriteConverter.toCourseFavouritePO(favourite);
        if (po.getId() == null) {
            favouriteMapper.insert(po);
            favourite.assignId(po.getId());
        } else {
            favouriteMapper.updateById(po);
        }
        return favourite;
    }

    @Override
    public Optional<CourseFavourite> findByUserIdAndCourseId(UserId userId, CourseId courseId) {
        LambdaQueryWrapper<CourseFavouritePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseFavouritePO::getUserId, userId.value())
                .eq(CourseFavouritePO::getCourseId, courseId.value());
        CourseFavouritePO po = favouriteMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(favouriteConverter::toCourseFavourite);
    }

    @Override
    public List<CourseFavourite> findByUserId(UserId userId, int page, int size) {
        Page<CourseFavouritePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<CourseFavouritePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseFavouritePO::getUserId, userId.value())
                .orderByDesc(CourseFavouritePO::getCreateTime);
        Page<CourseFavouritePO> result = favouriteMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(favouriteConverter::toCourseFavourite)
                .collect(Collectors.toList());
    }

    @Override
    public boolean existsByUserIdAndCourseId(UserId userId, CourseId courseId) {
        LambdaQueryWrapper<CourseFavouritePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseFavouritePO::getUserId, userId.value())
                .eq(CourseFavouritePO::getCourseId, courseId.value());
        return favouriteMapper.selectCount(wrapper) > 0;
    }

    @Override
    public void deleteByUserIdAndCourseId(UserId userId, CourseId courseId) {
        LambdaQueryWrapper<CourseFavouritePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseFavouritePO::getUserId, userId.value())
                .eq(CourseFavouritePO::getCourseId, courseId.value());
        favouriteMapper.delete(wrapper);
    }

    @Override
    public long countByCourseId(CourseId courseId) {
        LambdaQueryWrapper<CourseFavouritePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseFavouritePO::getCourseId, courseId.value());
        return favouriteMapper.selectCount(wrapper);
    }
}
