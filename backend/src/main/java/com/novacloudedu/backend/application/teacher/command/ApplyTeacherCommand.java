package com.novacloudedu.backend.application.teacher.command;

import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.repository.TeacherApplicationRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ApplyTeacherCommand {

    private final TeacherApplicationRepository applicationRepository;

    @Transactional
    public Long execute(UserId userId, String name, String introduction, 
                       List<String> expertise, String certificateUrl) {
        if (applicationRepository.existsPendingByUserId(userId)) {
            throw new BusinessException(40320, "您已有待审核的讲师申请，请勿重复提交");
        }

        TeacherApplication application = TeacherApplication.create(
                userId, name, introduction, expertise, certificateUrl
        );

        applicationRepository.save(application);
        return application.getId();
    }
}
