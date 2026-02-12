package com.novacloudedu.backend.domain.ppt.repository;

import com.novacloudedu.backend.domain.ppt.entity.PptGenerationSession;

import java.util.List;
import java.util.Optional;

/**
 * PPT生成会话仓储接口
 */
public interface PptGenerationSessionRepository {

    PptGenerationSession save(PptGenerationSession session);

    Optional<PptGenerationSession> findById(Long id);

    List<PptGenerationSession> findByUserId(Long userId);

    void deleteById(Long id);
}
