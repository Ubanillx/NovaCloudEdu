package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.user.command.*;
import com.novacloudedu.backend.application.user.command.PhoneLoginCommand;
import com.novacloudedu.backend.application.user.query.UserQuery;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.repository.UserRepository.UserPage;
import com.novacloudedu.backend.domain.user.repository.UserRepository.UserQueryCondition;
import com.novacloudedu.backend.domain.user.valueobject.Password;
import com.novacloudedu.backend.domain.user.valueobject.UserAccount;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.domain.user.valueobject.UserRole;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.security.PasswordEncoderAdapter;
import com.novacloudedu.backend.infrastructure.security.JwtTokenProvider;
import com.novacloudedu.backend.infrastructure.sms.SmsCodeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户应用服务
 * 编排领域逻辑，处理用例流程
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class UserApplicationService {

    private final UserRepository userRepository;
    private final PasswordEncoderAdapter passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;
    private final SmsCodeService smsCodeService;

    /**
     * 用户注册
     */
    @Transactional
    public Long register(RegisterUserCommand command) {
        // 1. 校验短信验证码
        if (!smsCodeService.verifyCode(command.phone(), command.smsCode())) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "验证码错误或已过期");
        }

        // 2. 校验密码
        Password.validateRaw(command.userPassword());
        Password.validateConfirm(command.userPassword(), command.checkPassword());

        // 2. 创建值对象（包含业务规则校验）
        UserAccount account = UserAccount.of(command.userAccount());

        // 3. 检查账号唯一性（使用同步锁防止并发）
        synchronized (command.userAccount().intern()) {
            if (userRepository.existsByAccount(account)) {
                throw new BusinessException(ErrorCode.USER_ACCOUNT_EXIST);
            }

            // 4. 创建密码值对象（加密）
            Password password = Password.fromRaw(command.userPassword(), passwordEncoder);

            // 5. 创建用户聚合根
            User user = User.create(account, password, command.phone());

            // 6. 持久化
            userRepository.save(user);

            log.info("用户注册成功: {}", account);
            return user.getId().value();
        }
    }

    /**
     * 用户登录
     */
    @Transactional(readOnly = true)
    public LoginResult login(LoginUserCommand command) {
        // 1. 创建值对象
        UserAccount account = UserAccount.of(command.userAccount());

        // 2. 查找用户
        User user = userRepository.findByAccount(account)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST, "用户不存在"));

        // 3. 验证密码
        if (!user.verifyPassword(command.userPassword(), passwordEncoder)) {
            throw new BusinessException(ErrorCode.USER_PASSWORD_ERROR, "密码错误");
        }

        // 4. 检查封禁状态
        user.ensureNotBanned();

        // 5. 生成Token
        String token = jwtTokenProvider.generateToken(
                user.getId().value(),
                user.getAccount().value(),
                user.getRole().getValue()
        );
        String refreshToken = jwtTokenProvider.generateRefreshToken(user.getId().value());

        log.info("用户登录成功: {}", account);
        return new LoginResult(user, token, refreshToken);
    }

    /**
     * 获取当前登录用户
     */
    @Transactional(readOnly = true)
    public User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
        }

        Object principal = authentication.getPrincipal();
        if (principal instanceof Long userId) {
            User user = userRepository.findById(UserId.of(userId))
                    .orElseThrow(() -> new BusinessException(ErrorCode.NOT_LOGIN_ERROR));
            user.ensureNotBanned();
            return user;
        }

        throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
    }

    /**
     * 手机验证码登录（未注册自动注册）
     */
    @Transactional
    public LoginResult loginByPhone(PhoneLoginCommand command) {
        // 1. 校验短信验证码
        if (!smsCodeService.verifyCode(command.phone(), command.smsCode())) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "验证码错误或已过期");
        }

        // 2. 查找用户，不存在则自动注册
        User user = userRepository.findByPhone(command.phone())
                .orElseGet(() -> autoRegisterByPhone(command.phone()));

        // 3. 检查封禁状态
        user.ensureNotBanned();

        // 4. 生成Token
        String token = jwtTokenProvider.generateToken(
                user.getId().value(),
                user.getAccount().value(),
                user.getRole().getValue()
        );
        String refreshToken = jwtTokenProvider.generateRefreshToken(user.getId().value());

        log.info("手机验证码登录成功: {}", command.phone());
        return new LoginResult(user, token, refreshToken);
    }

    /**
     * 手机号自动注册
     */
    private User autoRegisterByPhone(String phone) {
        synchronized (phone.intern()) {
            // 双重检查，防止并发注册
            return userRepository.findByPhone(phone)
                    .orElseGet(() -> {
                        // 生成随机密码
                        String randomPwd = generateRandomPassword();
                        Password password = Password.fromRaw(randomPwd, passwordEncoder);
                        
                        // 创建用户
                        User newUser = User.createByPhone(phone, password);
                        userRepository.save(newUser);
                        
                        log.info("手机号自动注册成功: {}", phone);
                        return newUser;
                    });
        }
    }

    /**
     * 生成随机密码
     */
    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
        StringBuilder sb = new StringBuilder();
        java.util.Random random = new java.util.Random();
        for (int i = 0; i < 16; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    /**
     * 登录结果
     */
    public record LoginResult(User user, String token, String refreshToken) {
    }

    /**
     * 刷新Token结果
     */
    public record RefreshTokenResult(String token, String refreshToken) {
    }

    /**
     * 使用Refresh Token刷新Access Token
     */
    @Transactional(readOnly = true)
    public RefreshTokenResult refreshToken(String refreshToken) {
        // 1. 验证refresh token
        if (!jwtTokenProvider.validateRefreshToken(refreshToken)) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR, "Refresh Token无效或已过期");
        }

        // 2. 获取用户ID
        Long userId = jwtTokenProvider.getUserIdFromRefreshToken(refreshToken);

        // 3. 查找用户
        User user = userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST, "用户不存在"));

        // 4. 检查封禁状态
        user.ensureNotBanned();

        // 5. 生成新的Token
        String newToken = jwtTokenProvider.generateToken(
                user.getId().value(),
                user.getAccount().value(),
                user.getRole().getValue()
        );
        String newRefreshToken = jwtTokenProvider.generateRefreshToken(user.getId().value());

        log.info("Token刷新成功: userId={}", userId);
        return new RefreshTokenResult(newToken, newRefreshToken);
    }

    // ==================== 用户管理功能（管理员） ====================

    /**
     * 创建用户（管理员）
     */
    @Transactional
    public Long createUser(CreateUserCommand command) {
        // 校验密码
        Password.validateRaw(command.userPassword());

        // 创建值对象
        UserAccount account = UserAccount.of(command.userAccount());

        synchronized (command.userAccount().intern()) {
            if (userRepository.existsByAccount(account)) {
                throw new BusinessException(ErrorCode.USER_ACCOUNT_EXIST);
            }

            Password password = Password.fromRaw(command.userPassword(), passwordEncoder);
            UserRole role = command.role() != null ? UserRole.fromValue(command.role()) : UserRole.STUDENT;

            User user = User.createByAdmin(
                    account, password, command.userName(), role,
                    command.userGender(), command.userPhone(),
                    command.userEmail(), command.userAddress(), command.birthday()
            );

            userRepository.save(user);
            log.info("管理员创建用户成功: {}", account);
            return user.getId().value();
        }
    }

    /**
     * 批量创建用户（管理员）
     */
    @Transactional
    public List<Long> batchCreateUsers(List<CreateUserCommand> commands) {
        List<Long> userIds = new ArrayList<>();
        for (CreateUserCommand command : commands) {
            Long userId = createUser(command);
            userIds.add(userId);
        }
        return userIds;
    }

    /**
     * 更新用户信息（管理员）
     */
    @Transactional
    public void updateUser(UpdateUserCommand command) {
        User user = userRepository.findById(UserId.of(command.id()))
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST));

        UserRole role = command.role() != null ? UserRole.fromValue(command.role()) : user.getRole();

        user.updateByAdmin(
                command.userName(), command.userAvatar(), command.userProfile(),
                role, command.userGender(), command.userPhone(),
                command.userEmail(), command.userAddress(), command.birthday(),
                command.level()
        );

        userRepository.save(user);
        log.info("管理员更新用户成功: {}", command.id());
    }

    /**
     * 分页查询用户（管理员）
     */
    @Transactional(readOnly = true)
    public UserPage queryUsers(UserQuery command) {
        UserQueryCondition condition = UserQueryCondition.of(
                command.userName(), command.userAccount(), command.userPhone(),
                command.userEmail(), command.role(), command.banned(),
                command.pageNum(), command.pageSize()
        );
        return userRepository.findByCondition(condition);
    }

    /**
     * 批量封禁用户（管理员）
     */
    @Transactional
    public void batchBanUsers(BatchBanUserCommand command) {
        if (command.userIds() == null || command.userIds().isEmpty()) {
            return;
        }
        List<UserId> ids = command.userIds().stream().map(UserId::of).toList();
        userRepository.updateBanStatus(ids, command.banned());
        log.info("管理员批量{}用户: {}", command.banned() ? "封禁" : "解封", command.userIds());
    }

    /**
     * 根据ID获取用户详情（管理员）
     */
    @Transactional(readOnly = true)
    public User getUserById(Long userId) {
        return userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST));
    }

    /**
     * 重置用户密码（管理员）
     */
    @Transactional
    public void resetPassword(ResetPasswordCommand command) {
        Password.validateRaw(command.newPassword());

        User user = userRepository.findById(UserId.of(command.userId()))
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST));

        Password newPassword = Password.fromRaw(command.newPassword(), passwordEncoder);
        user.changePassword(newPassword);
        userRepository.save(user);
        log.info("管理员重置用户密码: {}", command.userId());
    }

    // ==================== 用户个人操作 ====================

    /**
     * 修改密码（用户自己）
     */
    @Transactional
    public void changePassword(ChangePasswordCommand command) {
        // 校验新密码
        Password.validateRaw(command.newPassword());
        Password.validateConfirm(command.newPassword(), command.confirmPassword());

        User user = getCurrentUser();

        // 验证旧密码
        if (!user.verifyPassword(command.oldPassword(), passwordEncoder)) {
            throw new BusinessException(ErrorCode.USER_PASSWORD_ERROR, "旧密码错误");
        }

        // 创建新密码并更新
        Password newPassword = Password.fromRaw(command.newPassword(), passwordEncoder);
        user.changePassword(newPassword);
        userRepository.save(user);
        log.info("用户修改密码成功: {}", user.getId().value());
    }

    /**
     * 更新个人资料（用户自己）
     */
    @Transactional
    public void updateProfile(UpdateProfileCommand command) {
        User user = getCurrentUser();
        
        // 如果修改了手机号，需要验证码校验
        String newPhone = command.userPhone();
        String currentPhone = user.getUserPhone();
        boolean phoneChanged = newPhone != null && !newPhone.equals(currentPhone);
        
        if (phoneChanged) {
            // 校验新手机号的验证码
            if (command.phoneSmsCode() == null || command.phoneSmsCode().isBlank()) {
                throw new BusinessException(ErrorCode.PARAMS_ERROR, "修改手机号需要验证码");
            }
            if (!smsCodeService.verifyCode(newPhone, command.phoneSmsCode())) {
                throw new BusinessException(ErrorCode.PARAMS_ERROR, "验证码错误或已过期");
            }
            // 检查新手机号是否已被其他用户使用
            if (userRepository.existsByPhone(newPhone)) {
                throw new BusinessException(ErrorCode.PARAMS_ERROR, "该手机号已被其他用户使用");
            }
        }
        
        user.updateProfile(
                command.userName(), command.userAvatar(), command.userProfile(),
                command.userGender(), command.userPhone(), command.userEmail(),
                command.userAddress(), command.birthday()
        );
        userRepository.save(user);
        log.info("用户更新个人资料: {}", user.getId().value());
    }

    // ==================== 用户信息查询（普通用户） ====================

    /**
     * 获取用户公开信息（普通用户可调用）
     */
    @Transactional(readOnly = true)
    public User getUserPublicInfo(Long userId) {
        return userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST));
    }

    /**
     * 获取用户详细信息（管理员和本人可访问）
     */
    @Transactional(readOnly = true)
    public User getUserDetailInfo(Long userId) {
        User currentUser = getCurrentUser();
        User targetUser = userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_EXIST));
        
        // 权限检查：只有管理员或本人可以访问详细信息
        if (!currentUser.isAdmin() && !currentUser.getId().equals(targetUser.getId())) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR, "无权访问该用户的详细信息");
        }
        
        return targetUser;
    }
}
