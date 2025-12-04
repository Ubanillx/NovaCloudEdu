package com.novacloudedu.backend.interfaces.rest.auth.assembler;

import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.application.user.command.LoginUserCommand;
import com.novacloudedu.backend.application.user.command.RegisterUserCommand;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.interfaces.rest.auth.dto.request.UserLoginRequest;
import com.novacloudedu.backend.interfaces.rest.auth.dto.request.UserRegisterRequest;
import com.novacloudedu.backend.interfaces.rest.auth.dto.response.LoginUserResponse;
import org.springframework.stereotype.Component;

/**
 * 用户DTO组装器
 * 负责DTO与Command/Domain对象之间的转换
 */
@Component
public class UserAssembler {

    /**
     * 注册请求 -> 注册命令
     */
    public RegisterUserCommand toRegisterCommand(UserRegisterRequest request) {
        return new RegisterUserCommand(
                request.getUserAccount(),
                request.getUserPassword(),
                request.getCheckPassword(),
                request.getPhone(),
                request.getSmsCode()
        );
    }

    /**
     * 登录请求 -> 登录命令
     */
    public LoginUserCommand toLoginCommand(UserLoginRequest request) {
        return new LoginUserCommand(
                request.getUserAccount(),
                request.getUserPassword()
        );
    }

    /**
     * 领域对象 -> 响应DTO
     */
    public LoginUserResponse toLoginUserResponse(User user) {
        if (user == null) {
            return null;
        }
        LoginUserResponse response = new LoginUserResponse();
        response.setId(user.getId().value());
        response.setUserAccount(user.getAccount().value());
        response.setUserName(user.getUserName());
        response.setUserAvatar(user.getUserAvatar());
        response.setUserProfile(user.getUserProfile());
        response.setUserRole(user.getRole().getValue());
        response.setUserGender(user.getUserGender());
        response.setUserPhone(user.getUserPhone());
        response.setUserEmail(user.getUserEmail());
        response.setLevel(user.getLevel());
        response.setCreateTime(user.getCreateTime());
        return response;
    }

    /**
     * 登录结果 -> 响应DTO（含Token）
     */
    public LoginUserResponse toLoginUserResponse(UserApplicationService.LoginResult result) {
        LoginUserResponse response = toLoginUserResponse(result.user());
        if (response != null) {
            response.setToken(result.token());
        }
        return response;
    }
}
