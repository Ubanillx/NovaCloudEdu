package com.novacloudedu.backend.interfaces.rest.user.assembler;

import com.novacloudedu.backend.application.user.command.*;
import com.novacloudedu.backend.application.user.query.UserQuery;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository.UserPage;
import com.novacloudedu.backend.interfaces.rest.user.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.user.dto.response.UserDetailResponse;
import com.novacloudedu.backend.interfaces.rest.user.dto.response.UserPageResponse;
import com.novacloudedu.backend.interfaces.rest.user.dto.response.UserPublicResponse;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 用户管理装配器
 */
@Component
public class UserManageAssembler {

    /**
     * 转换为创建用户命令
     */
    public CreateUserCommand toCreateCommand(CreateUserRequest request) {
        return new CreateUserCommand(
                request.userAccount(),
                request.userPassword(),
                request.userName(),
                request.role(),
                request.userGender(),
                request.userPhone(),
                request.userEmail(),
                request.userAddress(),
                request.birthday()
        );
    }

    /**
     * 批量转换为创建用户命令
     */
    public List<CreateUserCommand> toCreateCommands(BatchCreateUserRequest request) {
        return request.users().stream()
                .map(this::toCreateCommand)
                .toList();
    }

    /**
     * 转换为更新个人资料命令
     */
    public UpdateProfileCommand toProfileCommand(UpdateProfileRequest request) {
        return new UpdateProfileCommand(
                request.userName(),
                request.userAvatar(),
                request.userProfile(),
                request.userGender(),
                request.userPhone(),
                request.userEmail(),
                request.userAddress(),
                request.birthday()
        );
    }

    /**
     * 转换为更新用户命令
     */
    public UpdateUserCommand toUpdateCommand(UpdateUserRequest request) {
        return new UpdateUserCommand(
                request.id(),
                request.userName(),
                request.userAvatar(),
                request.userProfile(),
                request.role(),
                request.userGender(),
                request.userPhone(),
                request.userEmail(),
                request.userAddress(),
                request.birthday(),
                request.level()
        );
    }

    /**
     * 转换为查询用户命令
     */
    public UserQuery toQueryCommand(QueryUserRequest request) {
        return new UserQuery(
                request.userName(),
                request.userAccount(),
                request.userPhone(),
                request.userEmail(),
                request.role(),
                request.banned(),
                request.getPageNum(),
                request.getPageSize()
        );
    }

    /**
     * 转换为批量封禁命令
     */
    public BatchBanUserCommand toBatchBanCommand(BatchBanUserRequest request) {
        return new BatchBanUserCommand(request.userIds(), request.banned());
    }

    /**
     * 转换为用户详情响应
     */
    public UserDetailResponse toDetailResponse(User user) {
        return new UserDetailResponse(
                user.getId().value(),
                user.getAccount().value(),
                user.getUserName(),
                user.getUserAvatar(),
                user.getUserProfile(),
                user.getRole().getValue(),
                user.getUserGender(),
                user.getUserPhone(),
                user.getUserEmail(),
                user.getUserAddress(),
                user.getBirthday(),
                user.getLevel(),
                user.isBanned(),
                user.getCreateTime(),
                user.getUpdateTime()
        );
    }

    /**
     * 转换为用户公开信息响应
     */
    public UserPublicResponse toPublicResponse(User user) {
        return new UserPublicResponse(
                user.getId().value(),
                user.getUserName(),
                user.getUserAvatar(),
                user.getUserProfile(),
                user.getRole().getValue(),
                user.getUserGender(),
                user.getLevel()
        );
    }

    /**
     * 转换为分页响应
     */
    public UserPageResponse toPageResponse(UserPage page) {
        List<UserDetailResponse> users = page.users().stream()
                .map(this::toDetailResponse)
                .toList();
        return new UserPageResponse(
                users,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }

    /**
     * 转换为修改密码命令
     */
    public ChangePasswordCommand toChangePasswordCommand(ChangePasswordRequest request) {
        return new ChangePasswordCommand(
                request.oldPassword(),
                request.newPassword(),
                request.confirmPassword()
        );
    }

    /**
     * 转换为重置密码命令
     */
    public ResetPasswordCommand toResetPasswordCommand(ResetPasswordRequest request) {
        return new ResetPasswordCommand(
                request.userId(),
                request.newPassword()
        );
    }
}
