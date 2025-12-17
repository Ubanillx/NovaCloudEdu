package com.novacloudedu.backend.application.teacher.command;

import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.repository.TeacherRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UpdateTeacherCommand {

    private final TeacherRepository teacherRepository;

    @Transactional
    public void execute(TeacherId teacherId, String name, String introduction, List<String> expertise) {
        Teacher teacher = teacherRepository.findById(teacherId)
                .orElseThrow(() -> new BusinessException(40400, "讲师不存在"));

        teacher.updateInfo(name, introduction, expertise);
        teacherRepository.save(teacher);
    }
}
