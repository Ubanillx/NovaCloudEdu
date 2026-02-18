package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.repository.TeacherApplicationRepository;
import com.novacloudedu.backend.domain.teacher.repository.TeacherRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.email.AdminEmailNotifier;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 讲师应用服务
 * 负责讲师申请、审核、更新、移除等用例编排
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class TeacherApplicationService {

    private final TeacherApplicationRepository applicationRepository;
    private final TeacherRepository teacherRepository;
    private final UserRepository userRepository;
    private final AdminEmailNotifier adminEmailNotifier;

    // ==================== 讲师申请 ====================

    /**
     * 申请成为讲师
     */
    @Transactional
    public Long applyTeacher(UserId userId, String name, String introduction,
                             List<String> expertise, String certificateUrl) {
        if (applicationRepository.existsPendingByUserId(userId)) {
            throw new BusinessException(40320, "您已有待审核的讲师申请，请勿重复提交");
        }

        TeacherApplication application = TeacherApplication.create(
                userId, name, introduction, expertise, certificateUrl
        );
        applicationRepository.save(application);

        // 异步通知管理员
        adminEmailNotifier.notifyTeacherApplied(application);

        log.info("讲师申请提交成功: userId={}, name={}", userId.value(), name);
        return application.getId();
    }

    /**
     * 审核通过讲师申请
     */
    @Transactional
    public void approveApplication(Long applicationId, UserId reviewerId) {
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

        // 异步通知审核结果
        adminEmailNotifier.notifyTeacherReviewResult(application);

        log.info("讲师申请审核通过: applicationId={}, reviewerId={}", applicationId, reviewerId.value());
    }

    /**
     * 拒绝讲师申请
     */
    @Transactional
    public void rejectApplication(Long applicationId, UserId reviewerId, String reason) {
        TeacherApplication application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new BusinessException(40400, "讲师申请不存在"));

        if (!application.isPending()) {
            throw new BusinessException(40321, "该申请已被处理");
        }

        application.reject(reviewerId, reason);
        applicationRepository.save(application);

        // 异步通知审核结果
        adminEmailNotifier.notifyTeacherReviewResult(application);

        log.info("讲师申请已拒绝: applicationId={}, reason={}", applicationId, reason);
    }

    // ==================== 讲师管理 ====================

    /**
     * 更新讲师信息
     */
    @Transactional
    public void updateTeacher(TeacherId teacherId, String name, String introduction, List<String> expertise) {
        Teacher teacher = teacherRepository.findById(teacherId)
                .orElseThrow(() -> new BusinessException(40400, "讲师不存在"));

        teacher.updateInfo(name, introduction, expertise);
        teacherRepository.save(teacher);
        log.info("讲师信息更新成功: teacherId={}", teacherId.value());
    }

    /**
     * 移除讲师
     */
    @Transactional
    public void removeTeacher(TeacherId teacherId) {
        Teacher teacher = teacherRepository.findById(teacherId)
                .orElseThrow(() -> new BusinessException(40400, "讲师不存在"));

        // 将用户角色降回学生
        User user = userRepository.findById(teacher.getUserId())
                .orElseThrow(() -> new BusinessException(40400, "讲师关联的用户不存在"));
        user.demoteToStudent();
        userRepository.save(user);

        // 删除讲师记录
        teacherRepository.deleteById(teacherId);
        log.info("讲师已移除: teacherId={}", teacherId.value());
    }
}
