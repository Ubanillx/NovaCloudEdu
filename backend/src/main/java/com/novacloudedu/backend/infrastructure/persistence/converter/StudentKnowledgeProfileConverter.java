package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.StudentKnowledgeProfile;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.StudentKnowledgeProfilePO;
import org.springframework.stereotype.Component;

@Component
public class StudentKnowledgeProfileConverter {

    public StudentKnowledgeProfilePO toPO(StudentKnowledgeProfile entity) {
        StudentKnowledgeProfilePO po = new StudentKnowledgeProfilePO();
        if (entity.getId() != null) {
            po.setId(entity.getId());
        }
        po.setStudentId(entity.getStudentId().value());
        po.setSubject(entity.getSubject().getCode());
        po.setKnowledgePoint(entity.getKnowledgePoint());
        po.setMasteryLevel(entity.getMasteryLevel());
        po.setTotalAttempts(entity.getTotalAttempts());
        po.setCorrectCount(entity.getCorrectCount());
        po.setRecentErrorCategories(entity.getRecentErrorCategories());
        po.setLastUpdated(entity.getLastUpdated());
        return po;
    }

    public StudentKnowledgeProfile toDomain(StudentKnowledgeProfilePO po) {
        return StudentKnowledgeProfile.reconstruct(
                po.getId(),
                UserId.of(po.getStudentId()),
                Subject.fromCode(po.getSubject()),
                po.getKnowledgePoint(),
                po.getMasteryLevel() != null ? po.getMasteryLevel() : 0.5,
                po.getTotalAttempts() != null ? po.getTotalAttempts() : 0,
                po.getCorrectCount() != null ? po.getCorrectCount() : 0,
                po.getRecentErrorCategories(),
                po.getLastUpdated()
        );
    }
}
