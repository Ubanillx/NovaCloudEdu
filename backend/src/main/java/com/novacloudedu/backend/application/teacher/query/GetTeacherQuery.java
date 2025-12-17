package com.novacloudedu.backend.application.teacher.query;

import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.repository.TeacherRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetTeacherQuery {

    private final TeacherRepository teacherRepository;

    public Optional<Teacher> execute(TeacherId teacherId) {
        return teacherRepository.findById(teacherId);
    }

    public Optional<Teacher> executeByUserId(UserId userId) {
        return teacherRepository.findByUserId(userId);
    }

    public List<Teacher> executeList(int page, int size) {
        return teacherRepository.findAll(page, size);
    }

    public long count() {
        return teacherRepository.count();
    }
}
