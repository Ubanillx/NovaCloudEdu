package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.domain.course.repository.CourseReviewRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.CourseReviewConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.CourseReviewMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseReviewPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class CourseReviewRepositoryImpl implements CourseReviewRepository {

    private final CourseReviewMapper reviewMapper;
    private final CourseReviewConverter reviewConverter;

    @Override
    public CourseReview save(CourseReview review) {
        CourseReviewPO po = reviewConverter.toCourseReviewPO(review);
        if (po.getId() == null) {
            reviewMapper.insert(po);
            review.assignId(po.getId());
        } else {
            reviewMapper.updateById(po);
        }
        return review;
    }

    @Override
    public Optional<CourseReview> findById(Long id) {
        CourseReviewPO po = reviewMapper.selectById(id);
        return Optional.ofNullable(po).map(reviewConverter::toCourseReview);
    }

    @Override
    public Optional<CourseReview> findByUserIdAndCourseId(UserId userId, CourseId courseId) {
        LambdaQueryWrapper<CourseReviewPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseReviewPO::getUserId, userId.value())
                .eq(CourseReviewPO::getCourseId, courseId.value());
        CourseReviewPO po = reviewMapper.selectOne(wrapper);
        return Optional.ofNullable(po).map(reviewConverter::toCourseReview);
    }

    @Override
    public List<CourseReview> findByCourseId(CourseId courseId, int page, int size) {
        Page<CourseReviewPO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<CourseReviewPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseReviewPO::getCourseId, courseId.value())
                .orderByDesc(CourseReviewPO::getCreateTime);
        Page<CourseReviewPO> result = reviewMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(reviewConverter::toCourseReview)
                .collect(Collectors.toList());
    }

    @Override
    public boolean existsByUserIdAndCourseId(UserId userId, CourseId courseId) {
        LambdaQueryWrapper<CourseReviewPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseReviewPO::getUserId, userId.value())
                .eq(CourseReviewPO::getCourseId, courseId.value());
        return reviewMapper.selectCount(wrapper) > 0;
    }

    @Override
    public BigDecimal calculateAverageRating(CourseId courseId) {
        return reviewMapper.calculateAverageRating(courseId.value());
    }

    @Override
    public long countByCourseId(CourseId courseId) {
        LambdaQueryWrapper<CourseReviewPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseReviewPO::getCourseId, courseId.value());
        return reviewMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(Long id) {
        reviewMapper.deleteById(id);
    }
}
