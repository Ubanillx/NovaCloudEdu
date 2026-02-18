package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.HomeworkSubmission;
import com.novacloudedu.backend.domain.grading.valueobject.GradingMode;
import com.novacloudedu.backend.domain.grading.valueobject.GradingStatus;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.HomeworkSubmissionPO;
import org.springframework.stereotype.Component;

@Component
public class HomeworkSubmissionConverter {

    public HomeworkSubmissionPO toPO(HomeworkSubmission entity) {
        HomeworkSubmissionPO po = new HomeworkSubmissionPO();
        if (entity.getId() != null) {
            po.setId(entity.getId().getValue());
        }
        po.setStudentId(entity.getStudentId().value());
        po.setClassId(entity.getClassId());
        po.setGradingMode(entity.getGradingMode() != null ? entity.getGradingMode().getCode() : "GENERAL");
        po.setTitle(entity.getTitle());
        po.setSubject(entity.getSubject() != null ? entity.getSubject().getCode() : null);
        po.setGrade(entity.getGrade());
        po.setImageUrls(entity.getImageUrls());
        po.setOcrRawText(entity.getOcrRawText());
        po.setStructuredData(entity.getStructuredData());
        po.setStatus(entity.getStatus().getCode());
        po.setExamPaperId(entity.getExamPaperId());
        po.setCreateTime(entity.getCreateTime());
        po.setUpdateTime(entity.getUpdateTime());
        return po;
    }

    public HomeworkSubmission toDomain(HomeworkSubmissionPO po) {
        Subject subject = null;
        if (po.getSubject() != null && !po.getSubject().isBlank()) {
            try { subject = Subject.fromCode(po.getSubject()); } catch (Exception ignored) {}
        }
        return HomeworkSubmission.reconstruct(
                SubmissionId.of(po.getId()),
                UserId.of(po.getStudentId()),
                po.getClassId(),
                GradingMode.fromCode(po.getGradingMode()),
                po.getTitle(),
                subject,
                po.getGrade(),
                po.getImageUrls(),
                po.getOcrRawText(),
                po.getStructuredData(),
                GradingStatus.fromCode(po.getStatus()),
                po.getExamPaperId(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
