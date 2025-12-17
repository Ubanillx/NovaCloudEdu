package com.novacloudedu.backend.application.teacher.query;

import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.repository.TeacherApplicationRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetTeacherApplicationQuery {

    private final TeacherApplicationRepository applicationRepository;

    public Optional<TeacherApplication> execute(Long applicationId) {
        return applicationRepository.findById(applicationId);
    }

    public Optional<TeacherApplication> executeByUserId(UserId userId) {
        return applicationRepository.findByUserId(userId);
    }

    public List<TeacherApplication> executeByStatus(TeacherStatus status, int page, int size) {
        return applicationRepository.findByStatus(status, page, size);
    }

    public List<TeacherApplication> executeList(int page, int size) {
        return applicationRepository.findAll(page, size);
    }

    public long countByStatus(TeacherStatus status) {
        return applicationRepository.countByStatus(status);
    }
}
