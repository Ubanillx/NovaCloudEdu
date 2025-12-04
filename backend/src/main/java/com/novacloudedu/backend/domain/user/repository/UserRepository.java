package com.novacloudedu.backend.domain.user.repository;

import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.valueobject.UserAccount;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 用户仓储接口（领域层定义）
 * 基础设施层提供具体实现
 */
public interface UserRepository {

    /**
     * 保存用户（新增或更新）
     */
    User save(User user);

    /**
     * 批量保存用户
     */
    List<User> saveAll(List<User> users);

    /**
     * 根据ID查找用户
     */
    Optional<User> findById(UserId id);

    /**
     * 根据账号查找用户
     */
    Optional<User> findByAccount(UserAccount account);

    /**
     * 检查账号是否已存在
     */
    boolean existsByAccount(UserAccount account);

    /**
     * 分页查询用户（支持模糊查询）
     */
    UserPage findByCondition(UserQueryCondition condition);

    /**
     * 根据ID列表批量查询用户
     */
    List<User> findByIds(List<UserId> ids);

    /**
     * 批量更新封禁状态
     */
    void updateBanStatus(List<UserId> ids, boolean banned);

    /**
     * 用户查询条件
     */
    record UserQueryCondition(
            String userName,
            String userAccount,
            String userPhone,
            String userEmail,
            String role,
            Boolean banned,
            int pageNum,
            int pageSize
    ) {
        public static UserQueryCondition of(String userName, String userAccount, String userPhone,
                                            String userEmail, String role, Boolean banned,
                                            int pageNum, int pageSize) {
            return new UserQueryCondition(userName, userAccount, userPhone, userEmail, role, banned,
                    Math.max(1, pageNum), Math.max(1, Math.min(100, pageSize)));
        }
    }

    /**
     * 用户分页结果
     */
    record UserPage(List<User> users, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
