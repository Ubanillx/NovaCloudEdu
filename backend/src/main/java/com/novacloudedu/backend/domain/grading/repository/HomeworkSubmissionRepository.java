package com.novacloudedu.backend.domain.grading.repository;

import com.novacloudedu.backend.domain.grading.entity.HomeworkSubmission;
import com.novacloudedu.backend.domain.grading.valueobject.GradingStatus;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 作业提交仓储接口
 */
public interface HomeworkSubmissionRepository {

    HomeworkSubmission save(HomeworkSubmission submission);

    Optional<HomeworkSubmission> findById(SubmissionId id);

    List<HomeworkSubmission> findByStudentId(UserId studentId, int page, int size);

    List<HomeworkSubmission> findByStatus(GradingStatus status, int page, int size);

    List<HomeworkSubmission> findByClassId(Long classId, int page, int size);

    long countByStudentId(UserId studentId);
}
