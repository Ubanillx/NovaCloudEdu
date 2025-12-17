package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.clazz.entity.ClassCourse;
import com.novacloudedu.backend.domain.clazz.repository.ClassCourseRepository;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.infrastructure.persistence.converter.ClassCourseConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ClassCourseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassCoursePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class ClassCourseRepositoryImpl implements ClassCourseRepository {

    private final ClassCourseMapper classCourseMapper;
    private final ClassCourseConverter converter;

    @Override
    public ClassCourse save(ClassCourse classCourse) {
        ClassCoursePO po = converter.toPO(classCourse);
        if (po.getId() == null) {
            classCourseMapper.insert(po);
            classCourse.assignId(po.getId());
        } else {
            classCourseMapper.updateById(po);
        }
        return classCourse;
    }

    @Override
    public List<ClassCourse> findByClassId(ClassId classId) {
        LambdaQueryWrapper<ClassCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassCoursePO::getClassId, classId.getValue())
               .orderByDesc(ClassCoursePO::getCreateTime);
        return classCourseMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public List<ClassCourse> findByCourseId(CourseId courseId) {
        LambdaQueryWrapper<ClassCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassCoursePO::getCourseId, courseId.value())
               .orderByDesc(ClassCoursePO::getCreateTime);
        return classCourseMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public Optional<ClassCourse> findByClassIdAndCourseId(ClassId classId, CourseId courseId) {
        LambdaQueryWrapper<ClassCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassCoursePO::getClassId, classId.getValue())
               .eq(ClassCoursePO::getCourseId, courseId.value());
        ClassCoursePO po = classCourseMapper.selectOne(wrapper);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public void deleteByClassId(ClassId classId) {
        LambdaQueryWrapper<ClassCoursePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ClassCoursePO::getClassId, classId.getValue());
        classCourseMapper.delete(wrapper);
    }

    @Override
    public void delete(Long id) {
        classCourseMapper.deleteById(id);
    }
}
