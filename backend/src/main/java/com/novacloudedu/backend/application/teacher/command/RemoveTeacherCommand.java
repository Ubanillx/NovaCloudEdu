package com.novacloudedu.backend.application.teacher.command;

import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.repository.TeacherRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class RemoveTeacherCommand {

    private final TeacherRepository teacherRepository;
    private final UserRepository userRepository;

    @Transactional
    public void execute(TeacherId teacherId) {
        Teacher teacher = teacherRepository.findById(teacherId)
                .orElseThrow(() -> new BusinessException(40400, "讲师不存在"));

        // 将用户角色降回学生
        User user = userRepository.findById(teacher.getUserId())
                .orElseThrow(() -> new BusinessException(40400, "讲师关联的用户不存在"));
        user.demoteToStudent();
        userRepository.save(user);

        // 删除讲师记录
        teacherRepository.deleteById(teacherId);
    }
}
