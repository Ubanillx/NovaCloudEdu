package com.novacloudedu.backend.domain.exam.repository;

import com.novacloudedu.backend.domain.exam.entity.PaperSection;
import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;

import java.util.List;
import java.util.Optional;

public interface PaperSectionRepository {

    PaperSection save(PaperSection section);

    Optional<PaperSection> findById(PaperSectionId id);

    List<PaperSection> findByPaperId(ExamPaperId paperId);

    void deleteById(PaperSectionId id);

    void deleteByPaperId(ExamPaperId paperId);
}
