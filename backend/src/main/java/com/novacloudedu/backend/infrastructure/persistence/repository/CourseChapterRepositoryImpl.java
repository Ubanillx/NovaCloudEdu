package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.repository.CourseChapterRepository;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.infrastructure.persistence.converter.CourseChapterConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.CourseChapterMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CourseChapterPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class CourseChapterRepositoryImpl implements CourseChapterRepository {

    private final CourseChapterMapper chapterMapper;
    private final CourseChapterConverter chapterConverter;

    @Override
    public CourseChapter save(CourseChapter chapter) {
        CourseChapterPO po = chapterConverter.toChapterPO(chapter);
        if (po.getId() == null) {
            chapterMapper.insert(po);
            chapter.assignId(ChapterId.of(po.getId()));
        } else {
            chapterMapper.updateById(po);
        }
        return chapter;
    }

    @Override
    public Optional<CourseChapter> findById(ChapterId id) {
        CourseChapterPO po = chapterMapper.selectById(id.value());
        return Optional.ofNullable(po).map(chapterConverter::toChapter);
    }

    @Override
    public List<CourseChapter> findByCourseId(CourseId courseId) {
        LambdaQueryWrapper<CourseChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseChapterPO::getCourseId, courseId.value())
                .orderByAsc(CourseChapterPO::getSort);
        return chapterMapper.selectList(wrapper).stream()
                .map(chapterConverter::toChapter)
                .collect(Collectors.toList());
    }

    @Override
    public long countByCourseId(CourseId courseId) {
        LambdaQueryWrapper<CourseChapterPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CourseChapterPO::getCourseId, courseId.value());
        return chapterMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(ChapterId id) {
        chapterMapper.deleteById(id.value());
    }
}
