package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UpdateSectionCommand {

    private final CourseSectionRepository sectionRepository;

    @Transactional
    public void execute(Long sectionId, String title, String description, String videoUrl,
                       Integer duration, Integer sort, Boolean isFree, String resourceUrl) {
        
        CourseSection section = sectionRepository.findById(SectionId.of(sectionId))
                .orElseThrow(() -> new BusinessException(40400, "小节不存在"));

        section.updateInfo(title, description, videoUrl, duration, sort, isFree, resourceUrl);
        sectionRepository.save(section);
    }
}
