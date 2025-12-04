package com.novacloudedu.backend.interfaces.rest.auth;

import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.infrastructure.sms.SmsCodeService;
import com.novacloudedu.backend.infrastructure.sms.SmsService.SendResult;
import com.novacloudedu.backend.interfaces.rest.auth.assembler.UserAssembler;
import com.novacloudedu.backend.interfaces.rest.auth.dto.request.SendCodeRequest;
import com.novacloudedu.backend.interfaces.rest.auth.dto.request.UserLoginRequest;
import com.novacloudedu.backend.interfaces.rest.auth.dto.request.UserRegisterRequest;
import com.novacloudedu.backend.interfaces.rest.auth.dto.response.LoginUserResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 认证控制器
 * 接口层：负责接收HTTP请求，调用应用服务，返回响应
 */
@Tag(name = "认证管理", description = "用户认证相关接口")
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Slf4j
public class AuthController {

    private final UserApplicationService userApplicationService;
    private final UserAssembler userAssembler;
    private final SmsCodeService smsCodeService;

    /**
     * 发送注册验证码
     */
    @Operation(summary = "发送注册验证码", description = "发送短信验证码用于注册")
    @PostMapping("/send-code")
    public BaseResponse<SendResult> sendRegisterCode(@RequestBody @Valid SendCodeRequest request) {
        SendResult result = smsCodeService.sendRegisterCode(request.phone());
        return ResultUtils.success(result);
    }

    /**
     * 用户注册
     */
    @Operation(summary = "用户注册", description = "新用户注册接口，需先获取短信验证码")
    @PostMapping("/register")
    public BaseResponse<Long> userRegister(@RequestBody @Valid UserRegisterRequest request) {
        Long userId = userApplicationService.register(
                userAssembler.toRegisterCommand(request)
        );
        return ResultUtils.success(userId);
    }

    /**
     * 用户登录
     */
    @Operation(summary = "用户登录", description = "用户登录并获取 JWT Token")
    @PostMapping("/login")
    public BaseResponse<LoginUserResponse> userLogin(@RequestBody @Valid UserLoginRequest request) {
        UserApplicationService.LoginResult result = userApplicationService.login(
                userAssembler.toLoginCommand(request)
        );
        return ResultUtils.success(userAssembler.toLoginUserResponse(result));
    }

    /**
     * 获取当前登录用户信息
     */
    @Operation(summary = "获取当前用户", description = "获取当前登录用户信息")
    @GetMapping("/current")
    public BaseResponse<LoginUserResponse> getLoginUser() {
        User user = userApplicationService.getCurrentUser();
        return ResultUtils.success(userAssembler.toLoginUserResponse(user));
    }
}
