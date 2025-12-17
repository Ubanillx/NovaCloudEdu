package com.novacloudedu.backend.application.teacher.command;

import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.repository.TeacherApplicationRepository;
import com.novacloudedu.backend.domain.teacher.repository.TeacherRepository;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ApproveTeacherApplicationCommand {

    private final TeacherApplicationRepository applicationRepository;
    private final TeacherRepository teacherRepository;
    private final UserRepository userRepository;

    @Transactional
    public void execute(Long applicationId, UserId reviewerId) {
        TeacherApplication application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new BusinessException(40400, "讲师申请不存在"));

        if (!application.isPending()) {
            throw new BusinessException(40321, "该申请已被处理");
        }

        application.approve(reviewerId);
        applicationRepository.save(application);

        Teacher teacher = Teacher.create(
                application.getName(),
                application.getIntroduction(),
                application.getExpertise(),
                application.getUserId(),
                reviewerId
        );
        teacherRepository.save(teacher);


        User user = userRepository.findById(application.getUserId())
                .orElseThrow(() -> new BusinessException(40400, "用户不存在"));
        user.promoteToTeacher();
        userRepository.save(user);
    }
}
