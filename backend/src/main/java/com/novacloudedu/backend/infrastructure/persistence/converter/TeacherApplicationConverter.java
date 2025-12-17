package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.TeacherApplicationPO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class TeacherApplicationConverter {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    public TeacherApplicationPO toTeacherApplicationPO(TeacherApplication application) {
        TeacherApplicationPO po = new TeacherApplicationPO();
        if (application.getId() != null) {
            po.setId(application.getId());
        }
        po.setUserId(application.getUserId().value());
        po.setName(application.getName());
        po.setIntroduction(application.getIntroduction());
        po.setExpertise(toJson(application.getExpertise()));
        po.setCertificateUrl(application.getCertificateUrl());
        po.setStatus(application.getStatus().getCode());
        po.setRejectReason(application.getRejectReason());
        if (application.getReviewerId() != null) {
            po.setReviewerId(application.getReviewerId().value());
        }
        po.setReviewTime(application.getReviewTime());
        po.setCreateTime(application.getCreateTime());
        po.setUpdateTime(application.getUpdateTime());
        return po;
    }

    public TeacherApplication toTeacherApplication(TeacherApplicationPO po) {
        return TeacherApplication.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                po.getName(),
                po.getIntroduction(),
                fromJson(po.getExpertise()),
                po.getCertificateUrl(),
                TeacherStatus.fromCode(po.getStatus()),
                po.getRejectReason(),
                po.getReviewerId() != null ? UserId.of(po.getReviewerId()) : null,
                po.getReviewTime(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    private String toJson(List<String> list) {
        if (list == null || list.isEmpty()) {
            return "[]";
        }
        try {
            return objectMapper.writeValueAsString(list);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON序列化失败", e);
        }
    }

    private List<String> fromJson(String json) {
        if (json == null || json.isEmpty()) {
            return new ArrayList<>();
        }
        try {
            return objectMapper.readValue(json, new TypeReference<List<String>>() {});
        } catch (JsonProcessingException e) {
            return new ArrayList<>();
        }
    }
}
