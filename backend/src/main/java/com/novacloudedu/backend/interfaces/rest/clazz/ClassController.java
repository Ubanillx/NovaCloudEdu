package com.novacloudedu.backend.interfaces.rest.clazz;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.service.ClassApplicationService;
import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.valueobject.UserRole;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.domain.clazz.entity.ClassInfo;
import com.novacloudedu.backend.domain.clazz.repository.ClassInfoRepository;
import com.novacloudedu.backend.domain.clazz.repository.ClassMemberRepository;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassRole;
import com.novacloudedu.backend.interfaces.rest.clazz.assembler.ClassAssembler;
import com.novacloudedu.backend.interfaces.rest.clazz.dto.*;
import com.novacloudedu.backend.interfaces.rest.common.PageResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "班级管理")
@RestController
@RequestMapping("/api/classes")
@RequiredArgsConstructor
public class ClassController {

    private final ClassApplicationService classService;
    private final UserApplicationService userApplicationService;
    private final ClassAssembler assembler;

    @Operation(summary = "创建班级")
    @PostMapping
    @AuthCheck(mustRole = "teacher") 
    public BaseResponse<ClassResponse> createClass(@Valid @RequestBody CreateClassRequest request) {
        Long operatorId = getLoginUserId();
        ClassInfo classInfo = classService.createClass(
                request.getClassName(),
                request.getDescription(),
                operatorId
        );
        return ResultUtils.success(assembler.toClassResponse(classInfo));
    }

    @Operation(summary = "更新班级信息")
    @PutMapping("/{classId}")
    public BaseResponse<Void> updateClass(@PathVariable Long classId,
                                  @Valid @RequestBody UpdateClassRequest request) {
        Long operatorId = getLoginUserId();
        classService.updateClass(
                classId,
                request.getClassName(),
                request.getDescription(),
                operatorId
        );
        return ResultUtils.success(null);
    }

    @Operation(summary = "删除班级")
    @DeleteMapping("/{classId}")
    public BaseResponse<Void> deleteClass(@PathVariable Long classId) {
        Long operatorId = getLoginUserId();
        classService.deleteClass(classId, operatorId);
        return ResultUtils.success(null);
    }

    @Operation(summary = "获取班级详情")
    @GetMapping("/{classId}")
    public BaseResponse<ClassResponse> getClassInfo(@PathVariable Long classId) {
        Long operatorId = getLoginUserId();
        User currentUser = userApplicationService.getCurrentUser();
        ClassInfo classInfo;
        if (currentUser.getRole() == UserRole.ADMIN) {
            classInfo = classService.getClassInfo(classId);
        } else {
            classInfo = classService.getClassInfoWithPermission(classId, operatorId);
        }
        return ResultUtils.success(assembler.toClassResponse(classInfo));
    }

    @Operation(summary = "获取班级列表")
    @GetMapping("/list")
    public BaseResponse<PageResponse<ClassResponse>> listClasses(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String keyword) {
        Long operatorId = getLoginUserId();
        User currentUser = userApplicationService.getCurrentUser();
        boolean isAdmin = currentUser.getRole() == UserRole.ADMIN;

        ClassInfoRepository.ClassPage page;
        if (keyword != null && !keyword.isBlank()) {
            page = isAdmin
                    ? classService.searchClasses(keyword.trim(), pageNum, pageSize)
                    : classService.searchClassesByCreator(keyword.trim(), operatorId, pageNum, pageSize);
        } else {
            page = isAdmin
                    ? classService.listClasses(pageNum, pageSize)
                    : classService.listClassesByCreator(operatorId, pageNum, pageSize);
        }
        List<ClassResponse> list = page.getList().stream()
                .map(assembler::toClassResponse)
                .toList();
        return ResultUtils.success(PageResponse.of(list, page.getTotal(), pageNum, pageSize));
    }

    @Operation(summary = "添加成员")
    @PostMapping("/{classId}/members")
    public BaseResponse<Void> addMember(@PathVariable Long classId,
                                @Valid @RequestBody AddClassMemberRequest request) {
        Long operatorId = getLoginUserId();
        classService.addMember(
                classId,
                request.getUserId(),
                ClassRole.fromString(request.getRole()),
                operatorId
        );
        return ResultUtils.success(null);
    }

    @Operation(summary = "移除成员")
    @DeleteMapping("/{classId}/members/{userId}")
    public BaseResponse<Void> removeMember(@PathVariable Long classId,
                                   @PathVariable Long userId) {
        Long operatorId = getLoginUserId();
        classService.removeMember(classId, userId, operatorId);
        return ResultUtils.success(null);
    }

    @Operation(summary = "获取班级成员列表")
    @GetMapping("/{classId}/members")
    public BaseResponse<PageResponse<ClassMemberResponse>> getClassMembers(
            @PathVariable Long classId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "20") int pageSize) {
        Long operatorId = getLoginUserId();
        User currentUser = userApplicationService.getCurrentUser();
        ClassMemberRepository.MemberPage page;
        if (currentUser.getRole() == UserRole.ADMIN) {
            page = classService.getClassMembers(classId, pageNum, pageSize);
        } else {
            page = classService.getClassMembersWithPermission(classId, operatorId, pageNum, pageSize);
        }
        List<ClassMemberResponse> list = page.getList().stream()
                .map(assembler::toClassMemberResponse)
                .toList();
        return ResultUtils.success(PageResponse.of(list, page.getTotal(), pageNum, pageSize));
    }

    @Operation(summary = "添加课程")
    @PostMapping("/{classId}/courses")
    public BaseResponse<Void> addCourse(@PathVariable Long classId,
                                @Valid @RequestBody AddClassCourseRequest request) {
        Long operatorId = getLoginUserId();
        classService.addCourse(classId, request.getCourseId(), operatorId);
        return ResultUtils.success(null);
    }

    @Operation(summary = "移除课程")
    @DeleteMapping("/{classId}/courses/{courseId}")
    public BaseResponse<Void> removeCourse(@PathVariable Long classId,
                                   @PathVariable Long courseId) {
        Long operatorId = getLoginUserId();
        classService.removeCourse(classId, courseId, operatorId);
        return ResultUtils.success(null);
    }

    @Operation(summary = "基于班级创建群聊")
    @PostMapping("/{classId}/chat-group")
    public BaseResponse<Long> createGroupFromClass(@PathVariable Long classId) {
        Long operatorId = getLoginUserId();
        Long groupId = classService.createGroupFromClass(classId, operatorId);
        return ResultUtils.success(groupId);
    }

    private Long getLoginUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
        }
        Object principal = authentication.getPrincipal();
        if (principal instanceof Long) {
            return (Long) principal;
        }
        throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
    }
}
