package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseStatus;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.infrastructure.persistence.converter.CourseConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.CourseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CoursePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class CourseRepositoryImpl implements CourseRepository {

    private final CourseMapper courseMapper;
    private final CourseConverter courseConverter;

    @Override
    public Course save(Course course) {
        CoursePO po = courseConverter.toCoursePO(course);
        if (po.getId() == null) {
            courseMapper.insert(po);
            course.assignId(CourseId.of(po.getId()));
        } else {
            courseMapper.updateById(po);
        }
        return course;
    }

    @Override
    public Optional<Course> findById(CourseId id) {
        CoursePO po = courseMapper.selectById(id.value());
        return Optional.ofNullable(po).map(courseConverter::toCourse);
    }

    @Override
    public List<Course> findByTeacherId(TeacherId teacherId, int page, int size) {
        Page<CoursePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<CoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CoursePO::getTeacherId, teacherId.value())
                .orderByDesc(CoursePO::getCreateTime);
        Page<CoursePO> result = courseMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(courseConverter::toCourse)
                .collect(Collectors.toList());
    }

    @Override
    public List<Course> findByStatus(CourseStatus status, int page, int size) {
        Page<CoursePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<CoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CoursePO::getStatus, status.getCode())
                .orderByDesc(CoursePO::getCreateTime);
        Page<CoursePO> result = courseMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(courseConverter::toCourse)
                .collect(Collectors.toList());
    }

    @Override
    public List<Course> findAll(int page, int size) {
        Page<CoursePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<CoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(CoursePO::getCreateTime);
        Page<CoursePO> result = courseMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(courseConverter::toCourse)
                .collect(Collectors.toList());
    }

    @Override
    public List<Course> searchByKeyword(String keyword, int page, int size) {
        Page<CoursePO> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<CoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w.like(CoursePO::getTitle, keyword)
                        .or().like(CoursePO::getDescription, keyword))
                .orderByDesc(CoursePO::getCreateTime);
        Page<CoursePO> result = courseMapper.selectPage(pageParam, wrapper);
        return result.getRecords().stream()
                .map(courseConverter::toCourse)
                .collect(Collectors.toList());
    }

    @Override
    public long count() {
        return courseMapper.selectCount(null);
    }

    @Override
    public long countByStatus(CourseStatus status) {
        LambdaQueryWrapper<CoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CoursePO::getStatus, status.getCode());
        return courseMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(CourseId id) {
        courseMapper.deleteById(id.value());
    }
}
