package com.novacloudedu.backend.interfaces.rest.teacher.assembler;

import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.interfaces.rest.teacher.dto.TeacherApplicationResponse;
import com.novacloudedu.backend.interfaces.rest.teacher.dto.TeacherResponse;
import org.springframework.stereotype.Component;

@Component
public class TeacherAssembler {

    public TeacherResponse toTeacherResponse(Teacher teacher) {
        return TeacherResponse.builder()
                .id(teacher.getId().value())
                .name(teacher.getName())
                .introduction(teacher.getIntroduction())
                .expertise(teacher.getExpertise())
                .userId(teacher.getUserId() != null ? teacher.getUserId().value() : null)
                .createTime(teacher.getCreateTime())
                .updateTime(teacher.getUpdateTime())
                .build();
    }

    public TeacherApplicationResponse toApplicationResponse(TeacherApplication application) {
        return TeacherApplicationResponse.builder()
                .id(application.getId())
                .userId(application.getUserId().value())
                .name(application.getName())
                .introduction(application.getIntroduction())
                .expertise(application.getExpertise())
                .certificateUrl(application.getCertificateUrl())
                .status(application.getStatus().getCode())
                .statusDesc(application.getStatus().getDescription())
                .rejectReason(application.getRejectReason())
                .reviewerId(application.getReviewerId() != null ? application.getReviewerId().value() : null)
                .reviewTime(application.getReviewTime())
                .createTime(application.getCreateTime())
                .updateTime(application.getUpdateTime())
                .build();
    }
}
