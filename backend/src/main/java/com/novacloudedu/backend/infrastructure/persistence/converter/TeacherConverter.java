package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.TeacherPO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class TeacherConverter {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    public TeacherPO toTeacherPO(Teacher teacher) {
        TeacherPO po = new TeacherPO();
        if (teacher.getId() != null) {
            po.setId(teacher.getId().value());
        }
        po.setName(teacher.getName());
        po.setIntroduction(teacher.getIntroduction());
        po.setExpertise(toJson(teacher.getExpertise()));
        if (teacher.getUserId() != null) {
            po.setUserId(teacher.getUserId().value());
        }
        if (teacher.getAdminId() != null) {
            po.setAdminId(teacher.getAdminId().value());
        }
        po.setCreateTime(teacher.getCreateTime());
        po.setUpdateTime(teacher.getUpdateTime());
        return po;
    }

    public Teacher toTeacher(TeacherPO po) {
        return Teacher.reconstruct(
                TeacherId.of(po.getId()),
                po.getName(),
                po.getIntroduction(),
                fromJson(po.getExpertise()),
                po.getUserId() != null ? UserId.of(po.getUserId()) : null,
                po.getAdminId() != null ? UserId.of(po.getAdminId()) : null,
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
