package com.novacloudedu.backend.interfaces.rest.user;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository.UserPage;
import com.novacloudedu.backend.interfaces.rest.user.assembler.UserManageAssembler;
import com.novacloudedu.backend.interfaces.rest.user.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.user.dto.response.UserDetailResponse;
import com.novacloudedu.backend.interfaces.rest.user.dto.response.UserPageResponse;
import com.novacloudedu.backend.interfaces.rest.user.dto.response.UserPublicResponse;
import com.novacloudedu.backend.infrastructure.sms.SmsService;
import com.novacloudedu.backend.infrastructure.sms.SmsService.SendResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户管理控制器
 */
@Tag(name = "用户管理", description = "用户CRUD管理接口")
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
@Slf4j
public class UserManageController {

    private final UserApplicationService userApplicationService;
    private final UserManageAssembler userManageAssembler;
    private final SmsService smsService;

    // ==================== 管理员接口 ====================

    /**
     * 创建用户（管理员）
     */
    @Operation(summary = "创建用户", description = "管理员创建单个用户")
    @PostMapping("/admin/create")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Long> createUser(@RequestBody @Valid CreateUserRequest request) {
        Long userId = userApplicationService.createUser(
                userManageAssembler.toCreateCommand(request)
        );
        return ResultUtils.success(userId);
    }

    /**
     * 批量创建用户（管理员）
     */
    @Operation(summary = "批量创建用户", description = "管理员批量创建用户")
    @PostMapping("/admin/batch-create")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<List<Long>> batchCreateUsers(@RequestBody @Valid BatchCreateUserRequest request) {
        List<Long> userIds = userApplicationService.batchCreateUsers(
                userManageAssembler.toCreateCommands(request)
        );
        return ResultUtils.success(userIds);
    }

    /**
     * 更新用户信息（管理员）
     */
    @Operation(summary = "更新用户", description = "管理员更新用户信息")
    @PutMapping("/admin/update")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> updateUser(@RequestBody @Valid UpdateUserRequest request) {
        userApplicationService.updateUser(
                userManageAssembler.toUpdateCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 分页查询用户（管理员）
     */
    @Operation(summary = "分页查询用户", description = "管理员分页查询用户，支持模糊搜索")
    @PostMapping("/admin/list")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<UserPageResponse> queryUsers(@RequestBody QueryUserRequest request) {
        UserPage page = userApplicationService.queryUsers(
                userManageAssembler.toQueryCommand(request)
        );
        return ResultUtils.success(userManageAssembler.toPageResponse(page));
    }

    /**
     * 获取用户详情（管理员）
     */
    @Operation(summary = "获取用户详情", description = "管理员获取用户详细信息")
    @GetMapping("/admin/{id}")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<UserDetailResponse> getUserDetail(@PathVariable Long id) {
        User user = userApplicationService.getUserById(id);
        return ResultUtils.success(userManageAssembler.toDetailResponse(user));
    }

    /**
     * 批量封禁/解封用户（管理员）
     */
    @Operation(summary = "批量封禁/解封用户", description = "管理员批量封禁或解封用户")
    @PostMapping("/admin/ban")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> batchBanUsers(@RequestBody @Valid BatchBanUserRequest request) {
        userApplicationService.batchBanUsers(
                userManageAssembler.toBatchBanCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 重置用户密码（管理员）
     */
    @Operation(summary = "重置用户密码", description = "管理员重置指定用户的密码")
    @PostMapping("/admin/reset-password")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<Boolean> resetPassword(@RequestBody @Valid ResetPasswordRequest request) {
        userApplicationService.resetPassword(
                userManageAssembler.toResetPasswordCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 发送短信验证码（管理员）
     */
    @Operation(summary = "发送短信验证码", description = "管理员手动发送短信验证码")
    @PostMapping("/admin/send-sms")
    @AuthCheck(mustRole = "admin")
    public BaseResponse<SendResult> sendSms(@RequestBody @Valid SendSmsRequest request) {
        String code = (request.code() != null && !request.code().isBlank()) 
                ? request.code() 
                : smsService.generateCode();
        SendResult result;
        if (request.expireMinutes() != null) {
            result = smsService.sendSmsCode(request.phone(), code, request.expireMinutes());
        } else {
            result = smsService.sendSmsCode(request.phone(), code);
        }
        return ResultUtils.success(result);
    }

    // ==================== 普通用户接口 ====================

    /**
     * 更新个人资料（当前登录用户）
     */
    @Operation(summary = "更新个人资料", description = "用户更新自己的个人资料")
    @PutMapping("/profile")
    public BaseResponse<Boolean> updateProfile(@RequestBody @Valid UpdateProfileRequest request) {
        userApplicationService.updateProfile(
                userManageAssembler.toProfileCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 修改密码（当前登录用户）
     */
    @Operation(summary = "修改密码", description = "用户修改自己的密码，需要验证旧密码")
    @PostMapping("/password")
    public BaseResponse<Boolean> changePassword(@RequestBody @Valid ChangePasswordRequest request) {
        userApplicationService.changePassword(
                userManageAssembler.toChangePasswordCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 获取用户公开信息（普通用户）
     */
    @Operation(summary = "获取用户公开信息", description = "获取其他用户的公开信息（非敏感）")
    @GetMapping("/public/{id}")
    public BaseResponse<UserPublicResponse> getUserPublicInfo(@PathVariable Long id) {
        User user = userApplicationService.getUserPublicInfo(id);
        return ResultUtils.success(userManageAssembler.toPublicResponse(user));
    }
}
