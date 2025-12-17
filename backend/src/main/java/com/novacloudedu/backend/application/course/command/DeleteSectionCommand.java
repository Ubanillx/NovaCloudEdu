package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DeleteSectionCommand {

    private final CourseSectionRepository sectionRepository;

    @Transactional
    public void execute(Long sectionId) {
        sectionRepository.deleteById(SectionId.of(sectionId));
    }
}
