package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.valueobject.CourseDifficulty;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseStatus;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.CoursePO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CourseConverter {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    public CoursePO toCoursePO(Course course) {
        CoursePO po = new CoursePO();
        if (course.getId() != null) {
            po.setId(course.getId().value());
        }
        po.setTitle(course.getTitle());
        po.setSubtitle(course.getSubtitle());
        po.setDescription(course.getDescription());
        po.setCoverImage(course.getCoverImage());
        po.setPrice(course.getPrice());
        po.setCourseType(course.getCourseType().getCode());
        po.setDifficulty(course.getDifficulty().getCode());
        po.setStatus(course.getStatus().getCode());
        po.setTeacherId(course.getTeacherId().value());
        po.setTotalDuration(course.getTotalDuration());
        po.setTotalChapters(course.getTotalChapters());
        po.setTotalSections(course.getTotalSections());
        po.setStudentCount(course.getStudentCount());
        po.setRatingScore(course.getRatingScore());
        po.setTags(toJson(course.getTags()));
        po.setAdminId(course.getAdminId().value());
        po.setCreateTime(course.getCreateTime());
        po.setUpdateTime(course.getUpdateTime());
        return po;
    }

    public Course toCourse(CoursePO po) {
        return Course.reconstruct(
                CourseId.of(po.getId()),
                po.getTitle(),
                po.getSubtitle(),
                po.getDescription(),
                po.getCoverImage(),
                po.getPrice(),
                CourseType.fromCode(po.getCourseType()),
                CourseDifficulty.fromCode(po.getDifficulty()),
                CourseStatus.fromCode(po.getStatus()),
                TeacherId.of(po.getTeacherId()),
                po.getTotalDuration(),
                po.getTotalChapters(),
                po.getTotalSections(),
                po.getStudentCount(),
                po.getRatingScore(),
                fromJson(po.getTags()),
                UserId.of(po.getAdminId()),
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
