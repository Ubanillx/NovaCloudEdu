package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.infrastructure.persistence.converter.CourseSectionConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.CourseSectionMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseSectionPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class CourseSectionRepositoryImpl implements CourseSectionRepository {

    private final CourseSectionMapper sectionMapper;
    private final CourseSectionConverter sectionConverter;

    @Override
    public CourseSection save(CourseSection section) {
        CourseSectionPO po = sectionConverter.toSectionPO(section);
        if (po.getId() == null) {
            sectionMapper.insert(po);
            section.assignId(SectionId.of(po.getId()));
        } else {
            sectionMapper.updateById(po);
        }
        return section;
    }

    @Override
    public Optional<CourseSection> findById(SectionId id) {
        CourseSectionPO po = sectionMapper.selectById(id.value());
        return Optional.ofNullable(po).map(sectionConverter::toSection);
    }

    @Override
    public List<CourseSection> findByChapterId(ChapterId chapterId) {
        LambdaQueryWrapper<CourseSectionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseSectionPO::getChapterId, chapterId.value())
                .orderByAsc(CourseSectionPO::getSort);
        return sectionMapper.selectList(wrapper).stream()
                .map(sectionConverter::toSection)
                .collect(Collectors.toList());
    }

    @Override
    public List<CourseSection> findByCourseId(CourseId courseId) {
        LambdaQueryWrapper<CourseSectionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseSectionPO::getCourseId, courseId.value())
                .orderByAsc(CourseSectionPO::getSort);
        return sectionMapper.selectList(wrapper).stream()
                .map(sectionConverter::toSection)
                .collect(Collectors.toList());
    }

    @Override
    public long countByChapterId(ChapterId chapterId) {
        LambdaQueryWrapper<CourseSectionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseSectionPO::getChapterId, chapterId.value());
        return sectionMapper.selectCount(wrapper);
    }

    @Override
    public long countByCourseId(CourseId courseId) {
        LambdaQueryWrapper<CourseSectionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseSectionPO::getCourseId, courseId.value());
        return sectionMapper.selectCount(wrapper);
    }

    @Override
    public int sumDurationByCourseId(CourseId courseId) {
        return sectionMapper.sumDurationByCourseId(courseId.value());
    }

    @Override
    public void deleteById(SectionId id) {
        sectionMapper.deleteById(id.value());
    }

    @Override
    public void deleteByChapterId(ChapterId chapterId) {
        LambdaQueryWrapper<CourseSectionPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseSectionPO::getChapterId, chapterId.value());
        sectionMapper.delete(wrapper);
    }
}
