package com.novacloudedu.backend.domain.exam.repository;

import com.novacloudedu.backend.domain.exam.entity.PaperQuestion;
import com.novacloudedu.backend.domain.exam.valueobject.PaperQuestionId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;

import java.util.List;
import java.util.Optional;

public interface PaperQuestionRepository {

    PaperQuestion save(PaperQuestion paperQuestion);

    Optional<PaperQuestion> findById(PaperQuestionId id);

    List<PaperQuestion> findBySectionId(PaperSectionId sectionId);

    List<PaperQuestion> findBySectionIds(List<PaperSectionId> sectionIds);

    void deleteById(PaperQuestionId id);

    void deleteBySectionId(PaperSectionId sectionId);

    void deleteBySectionIds(List<PaperSectionId> sectionIds);
}
