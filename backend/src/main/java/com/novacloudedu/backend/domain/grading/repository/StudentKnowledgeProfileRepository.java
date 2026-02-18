package com.novacloudedu.backend.domain.grading.repository;

import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.StudentKnowledgeProfile;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 学生知识画像仓储接口
 */
public interface StudentKnowledgeProfileRepository {

    StudentKnowledgeProfile save(StudentKnowledgeProfile profile);

    Optional<StudentKnowledgeProfile> findByStudentAndSubjectAndPoint(UserId studentId, Subject subject, String knowledgePoint);

    List<StudentKnowledgeProfile> findByStudentAndSubject(UserId studentId, Subject subject);

    List<StudentKnowledgeProfile> findWeakPoints(UserId studentId, Subject subject);

    List<StudentKnowledgeProfile> findByStudentId(UserId studentId);
}
