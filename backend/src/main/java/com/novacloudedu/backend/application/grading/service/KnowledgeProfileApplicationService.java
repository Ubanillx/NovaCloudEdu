package com.novacloudedu.backend.application.grading.service;

import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.StudentKnowledgeProfile;
import com.novacloudedu.backend.domain.grading.repository.StudentKnowledgeProfileRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 知识画像应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class KnowledgeProfileApplicationService {

    private final StudentKnowledgeProfileRepository profileRepository;

    /**
     * 查询学生某学科的全部知识画像
     */
    public List<StudentKnowledgeProfile> getSubjectProfile(Long userId, String subjectCode) {
        Subject subject = Subject.fromCode(subjectCode);
        return profileRepository.findByStudentAndSubject(UserId.of(userId), subject);
    }

    /**
     * 查询学生某学科的薄弱知识点
     */
    public List<StudentKnowledgeProfile> getWeakPoints(Long userId, String subjectCode) {
        Subject subject = Subject.fromCode(subjectCode);
        return profileRepository.findWeakPoints(UserId.of(userId), subject);
    }

    /**
     * 查询学生所有知识画像（全部学科）
     */
    public List<StudentKnowledgeProfile> getAllProfiles(Long userId) {
        return profileRepository.findByStudentId(UserId.of(userId));
    }
}
