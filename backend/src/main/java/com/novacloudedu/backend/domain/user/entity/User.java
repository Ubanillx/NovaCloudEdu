package com.novacloudedu.backend.domain.user.entity;

import com.novacloudedu.backend.domain.user.valueobject.Password;
import com.novacloudedu.backend.domain.user.valueobject.UserAccount;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.domain.user.valueobject.UserRole;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 用户聚合根（充血模型）
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User {

    private UserId id;
    private UserAccount account;
    private Password password;
    private String userName;
    private String userAvatar;
    private String userProfile;
    private UserRole role;
    private Integer userGender;
    private String userPhone;
    private String userEmail;
    private String userAddress;
    private LocalDate birthday;
    private Integer level;
    private boolean banned;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新用户（注册）
     */
    public static User create(UserAccount account, Password password, String phone) {
        User user = new User();
        user.account = account;
        user.password = password;
        user.userPhone = phone;
        user.role = UserRole.STUDENT;
        user.level = 0;
        user.banned = false;
        user.createTime = LocalDateTime.now();
        user.updateTime = LocalDateTime.now();
        return user;
    }

    /**
     * 从持久化数据重建用户
     */
    public static User reconstruct(UserId id, UserAccount account, Password password,
                                   String userName, String userAvatar, String userProfile,
                                   UserRole role, Integer userGender, String userPhone,
                                   String userEmail, String userAddress, LocalDate birthday,
                                   Integer level, boolean banned,
                                   LocalDateTime createTime, LocalDateTime updateTime) {
        User user = new User();
        user.id = id;
        user.account = account;
        user.password = password;
        user.userName = userName;
        user.userAvatar = userAvatar;
        user.userProfile = userProfile;
        user.role = role;
        user.userGender = userGender;
        user.userPhone = userPhone;
        user.userEmail = userEmail;
        user.userAddress = userAddress;
        user.birthday = birthday;
        user.level = level;
        user.banned = banned;
        user.createTime = createTime;
        user.updateTime = updateTime;
        return user;
    }

    /**
     * 分配ID（持久化后回填）
     */
    public void assignId(UserId id) {
        if (this.id != null) {
            throw new IllegalStateException("用户ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 验证密码
     */
    public boolean verifyPassword(String rawPassword, PasswordEncoder encoder) {
        return password.matches(rawPassword, encoder);
    }

    /**
     * 修改密码
     */
    public void changePassword(Password newPassword) {
        this.password = newPassword;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 检查是否被封禁
     */
    public void ensureNotBanned() {
        if (banned) {
            throw new UserBannedException("账号已被封禁");
        }
    }

    /**
     * 检查是否为管理员
     */
    public boolean isAdmin() {
        return role == UserRole.ADMIN;
    }

    /**
     * 封禁用户
     */
    public void ban() {
        this.banned = true;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 解封用户
     */
    public void unban() {
        this.banned = false;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新用户资料（用户自己）
     */
    public void updateProfile(String userName, String userAvatar, String userProfile,
                              Integer userGender, String userPhone, String userEmail,
                              String userAddress, LocalDate birthday) {
        this.userName = userName;
        this.userAvatar = userAvatar;
        this.userProfile = userProfile;
        this.userGender = userGender;
        this.userPhone = userPhone;
        this.userEmail = userEmail;
        this.userAddress = userAddress;
        this.birthday = birthday;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 管理员更新用户信息
     */
    public void updateByAdmin(String userName, String userAvatar, String userProfile,
                              UserRole role, Integer userGender, String userPhone,
                              String userEmail, String userAddress, LocalDate birthday,
                              Integer level) {
        this.userName = userName;
        this.userAvatar = userAvatar;
        this.userProfile = userProfile;
        this.role = role;
        this.userGender = userGender;
        this.userPhone = userPhone;
        this.userEmail = userEmail;
        this.userAddress = userAddress;
        this.birthday = birthday;
        this.level = level;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 管理员创建用户
     */
    public static User createByAdmin(UserAccount account, Password password, String userName,
                                     UserRole role, Integer userGender, String userPhone,
                                     String userEmail, String userAddress, LocalDate birthday) {
        User user = new User();
        user.account = account;
        user.password = password;
        user.userName = userName;
        user.role = role != null ? role : UserRole.STUDENT;
        user.userGender = userGender;
        user.userPhone = userPhone;
        user.userEmail = userEmail;
        user.userAddress = userAddress;
        user.birthday = birthday;
        user.level = 0;
        user.banned = false;
        user.createTime = LocalDateTime.now();
        user.updateTime = LocalDateTime.now();
        return user;
    }

    /**
     * 密码编码器接口（依赖倒置）
     */
    public interface PasswordEncoder {
        boolean matches(String rawPassword, String encodedPassword);
    }

    /**
     * 用户被封禁异常
     */
    public static class UserBannedException extends RuntimeException {
        public UserBannedException(String message) {
            super(message);
        }
    }
}
