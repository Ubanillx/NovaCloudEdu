package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.clazz.entity.ClassCourse;
import com.novacloudedu.backend.domain.clazz.entity.ClassInfo;
import com.novacloudedu.backend.domain.clazz.entity.ClassMember;
import com.novacloudedu.backend.domain.clazz.repository.ClassCourseRepository;
import com.novacloudedu.backend.domain.clazz.repository.ClassInfoRepository;
import com.novacloudedu.backend.domain.clazz.repository.ClassMemberRepository;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassRole;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.repository.ChatGroupRepository;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.domain.user.valueobject.UserRole;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * 班级应用服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ClassApplicationService {

    private final ClassInfoRepository classInfoRepository;
    private final ClassMemberRepository classMemberRepository;
    private final ClassCourseRepository classCourseRepository;
    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final ChatGroupApplicationService chatGroupApplicationService;
    private final ChatGroupRepository chatGroupRepository;

    // ==================== 班级管理 ====================

    /**
     * 创建班级
     */
    @Transactional
    public ClassInfo createClass(String className, String description, Long creatorId) {
        User creator = userRepository.findById(UserId.of(creatorId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "创建者不存在"));

        // 只有管理员或教师可以创建班级
        if (creator.getRole() != UserRole.ADMIN && creator.getRole() != UserRole.TEACHER) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "只有管理员或教师可以创建班级");
        }

        ClassInfo classInfo = ClassInfo.create(className, description, UserId.of(creatorId));
        classInfo = classInfoRepository.save(classInfo);

        log.info("班级创建成功: classId={}, className={}, creatorId={}", 
                classInfo.getId().getValue(), className, creatorId);
        return classInfo;
    }

    /**
     * 更新班级信息
     */
    @Transactional
    public void updateClass(Long classId, String className, String description, Long operatorId) {
        ClassInfo classInfo = getClassOrThrow(classId);
        
        // 检查权限：创建者或管理员
        checkPermission(classInfo, operatorId);

        classInfo.update(className, description);
        classInfoRepository.update(classInfo);
        
        log.info("班级信息更新: classId={}, operatorId={}", classId, operatorId);
    }

    /**
     * 删除班级
     */
    @Transactional
    public void deleteClass(Long classId, Long operatorId) {
        ClassInfo classInfo = getClassOrThrow(classId);
        checkPermission(classInfo, operatorId);

        // 逻辑删除班级
        classInfo.delete();
        classInfoRepository.update(classInfo);
        
        // 删除关联数据（实际项目中可能需要清理成员关联等，这里简单处理）
        // classMemberRepository.deleteByClassId(ClassId.of(classId));
        // classCourseRepository.deleteByClassId(ClassId.of(classId));

        log.info("班级已删除: classId={}, operatorId={}", classId, operatorId);
    }

    // ==================== 成员管理 ====================

    /**
     * 添加班级成员
     */
    @Transactional
    public void addMember(Long classId, Long userId, ClassRole role, Long operatorId) {
        ClassInfo classInfo = getClassOrThrow(classId);
        checkPermission(classInfo, operatorId);
        
        UserId memberId = UserId.of(userId);
        if (classMemberRepository.findByClassIdAndUserId(ClassId.of(classId), memberId).isPresent()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "该用户已是班级成员");
        }

        userRepository.findById(memberId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        ClassMember member = ClassMember.create(ClassId.of(classId), memberId, role);
        classMemberRepository.save(member);
        
        log.info("添加班级成员: classId={}, userId={}, role={}", classId, userId, role);
    }

    /**
     * 移除班级成员
     */
    @Transactional
    public void removeMember(Long classId, Long userId, Long operatorId) {
        ClassInfo classInfo = getClassOrThrow(classId);
        checkPermission(classInfo, operatorId);

        classMemberRepository.deleteByClassIdAndUserId(ClassId.of(classId), UserId.of(userId));
        log.info("移除班级成员: classId={}, userId={}", classId, userId);
    }

    // ==================== 课程关联 ====================

    /**
     * 添加课程到班级
     */
    @Transactional
    public void addCourse(Long classId, Long courseId, Long operatorId) {
        ClassInfo classInfo = getClassOrThrow(classId);
        checkPermission(classInfo, operatorId);

        CourseId cId = CourseId.of(courseId);
        courseRepository.findById(cId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "课程不存在"));

        if (classCourseRepository.findByClassIdAndCourseId(ClassId.of(classId), cId).isPresent()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "该课程已关联到班级");
        }

        ClassCourse classCourse = ClassCourse.create(ClassId.of(classId), cId);
        classCourseRepository.save(classCourse);
        
        log.info("班级关联课程: classId={}, courseId={}", classId, courseId);
    }

    /**
     * 移除班级课程
     */
    @Transactional
    public void removeCourse(Long classId, Long courseId, Long operatorId) {
        ClassInfo classInfo = getClassOrThrow(classId);
        checkPermission(classInfo, operatorId);

        ClassCourse classCourse = classCourseRepository.findByClassIdAndCourseId(ClassId.of(classId), CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "关联不存在"));
        
        classCourse.delete();
        classCourseRepository.save(classCourse);
        
        log.info("移除班级课程: classId={}, courseId={}", classId, courseId);
    }

    // ==================== 群聊集成 ====================

    /**
     * 基于班级创建群聊（支持增量更新）
     * 如果群已存在，则将新成员加入群聊
     */
    @Transactional
    public Long createGroupFromClass(Long classId, Long operatorId) {
        ClassInfo classInfo = getClassOrThrow(classId);
        checkPermission(classInfo, operatorId);

        // 1. 检查群是否已存在
        Optional<ChatGroup> existingGroup = chatGroupRepository.findByClassId(classId);
        Long groupId;

        if (existingGroup.isPresent()) {
            groupId = existingGroup.get().getId().value();
            log.info("班级群聊已存在，进行增量更新: classId={}, groupId={}", classId, groupId);
        } else {
            // 创建新群聊
            // 群名默认为班级名，描述默认为班级描述
            groupId = chatGroupApplicationService.createGroupForClass(
                    operatorId,
                    classInfo.getClassName(),
                    classInfo.getDescription(),
                    null, // avatar
                    classId
            );
        }

        // 2. 获取班级所有成员
        List<ClassMember> classMembers = classMemberRepository.findByClassId(ClassId.of(classId));

        // 3. 将成员加入群聊
        for (ClassMember member : classMembers) {
            // 跳过操作者（如果是新创建的群，操作者已经是群主；如果是已有群，可能需要检查）
            // 为简化逻辑，createGroupForClass已经把owner加入。
            // 对于增量更新，如果operator是群主，addMemberDirectly会处理跳过。
            // 但addMemberDirectly内部会检查 memberRepository.isMember，所以这里可以直接调用，
            // 唯一的问题是addMemberDirectly可能会抛出"群成员已满"或者其他业务异常，需要捕获。
            
            // 注意：如果operator不是群里的成员（比如管理员操作），这里也会尝试加入。
            // 这里的逻辑是将"班级成员"加入群。如果operator是班级成员，自然会被加入。
            
            try {
                chatGroupApplicationService.addMemberDirectly(groupId, member.getUserId().value());
            } catch (Exception e) {
                // 忽略单个添加失败，避免影响整体
                log.warn("添加群成员失败: groupId={}, userId={}, error={}", groupId, member.getUserId(), e.getMessage());
            }
        }
        
        log.info("基于班级同步群聊完成: classId={}, groupId={}", classId, groupId);
        return groupId;
    }

    // ==================== 查询方法 ====================

    public ClassInfo getClassInfo(Long classId) {
        return getClassOrThrow(classId);
    }

    public ClassMemberRepository.MemberPage getClassMembers(Long classId, int pageNum, int pageSize) {
        return classMemberRepository.findByClassId(ClassId.of(classId), pageNum, pageSize);
    }
    
    public List<ClassCourse> getClassCourses(Long classId) {
        return classCourseRepository.findByClassId(ClassId.of(classId));
    }

    // ==================== 私有辅助方法 ====================

    private ClassInfo getClassOrThrow(Long classId) {
        return classInfoRepository.findById(ClassId.of(classId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "班级不存在"));
    }

    private void checkPermission(ClassInfo classInfo, Long operatorId) {
        User operator = userRepository.findById(UserId.of(operatorId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));
        
        boolean isCreator = classInfo.getCreatorId().value().equals(operatorId);
        boolean isAdmin = operator.getRole() == UserRole.ADMIN;
        
        if (!isCreator && !isAdmin) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限操作该班级");
        }
    }
}
