package com.novacloudedu.backend.domain.ppt.repository;

import com.novacloudedu.backend.domain.ppt.entity.PptTemplate;
import com.novacloudedu.backend.domain.ppt.valueobject.PptTemplateId;

import java.util.List;
import java.util.Optional;

/**
 * PPT模板仓储接口
 */
public interface PptTemplateRepository {

    PptTemplate save(PptTemplate template);

    Optional<PptTemplate> findById(PptTemplateId id);

    void delete(PptTemplateId id);

    List<PptTemplate> findAll();

    List<PptTemplate> findEnabled();
}
