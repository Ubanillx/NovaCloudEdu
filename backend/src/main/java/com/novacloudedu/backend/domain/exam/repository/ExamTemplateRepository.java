package com.novacloudedu.backend.domain.exam.repository;

import com.novacloudedu.backend.domain.exam.entity.ExamTemplate;
import com.novacloudedu.backend.domain.exam.valueobject.ExamTemplateId;

import java.util.List;
import java.util.Optional;

public interface ExamTemplateRepository {

    ExamTemplate save(ExamTemplate template);

    Optional<ExamTemplate> findById(ExamTemplateId id);

    void deleteById(ExamTemplateId id);

    List<ExamTemplate> findEnabled();

    List<ExamTemplate> findAll();
}
