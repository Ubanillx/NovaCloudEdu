package com.novacloudedu.backend.domain.grading.repository;

import com.novacloudedu.backend.domain.grading.entity.GradingResult;
import com.novacloudedu.backend.domain.grading.valueobject.GradingResultId;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;

import java.util.Optional;

/**
 * 批改结果仓储接口
 */
public interface GradingResultRepository {

    GradingResult save(GradingResult result);

    Optional<GradingResult> findById(GradingResultId id);

    Optional<GradingResult> findBySubmissionId(SubmissionId submissionId);
}
