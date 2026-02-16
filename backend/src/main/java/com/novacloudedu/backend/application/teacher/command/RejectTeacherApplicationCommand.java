package com.novacloudedu.backend.application.teacher.command;

import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.repository.TeacherApplicationRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.email.AdminEmailNotifier;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class RejectTeacherApplicationCommand {

    private final TeacherApplicationRepository applicationRepository;
    private final AdminEmailNotifier adminEmailNotifier;

    @Transactional
    public void execute(Long applicationId, UserId reviewerId, String reason) {
        TeacherApplication application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new BusinessException(40400, "讲师申请不存在"));

        if (!application.isPending()) {
            throw new BusinessException(40321, "该申请已被处理");
        }

        application.reject(reviewerId, reason);
        applicationRepository.save(application);

        // 异步通知管理员审核结果
        adminEmailNotifier.notifyTeacherReviewResult(application);
    }
}
