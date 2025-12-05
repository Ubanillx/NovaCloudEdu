package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 群成员仓储接口
 */
public interface ChatGroupMemberRepository {

    /**
     * 保存群成员
     */
    ChatGroupMember save(ChatGroupMember member);

    /**
     * 更新群成员
     */
    void update(ChatGroupMember member);

    /**
     * 根据ID查找
     */
    Optional<ChatGroupMember> findById(Long id);

    /**
     * 根据群ID和用户ID查找
     */
    Optional<ChatGroupMember> findByGroupIdAndUserId(GroupId groupId, UserId userId);

    /**
     * 获取群成员列表
     */
    List<ChatGroupMember> findByGroupId(GroupId groupId);

    /**
     * 分页获取群成员
     */
    MemberPage findByGroupId(GroupId groupId, int pageNum, int pageSize);

    /**
     * 获取用户加入的群列表
     */
    List<ChatGroupMember> findByUserId(UserId userId);

    /**
     * 检查用户是否是群成员
     */
    boolean isMember(GroupId groupId, UserId userId);

    /**
     * 获取群管理员列表（包括群主）
     */
    List<ChatGroupMember> findAdmins(GroupId groupId);

    /**
     * 统计群成员数量
     */
    int countByGroupId(GroupId groupId);

    /**
     * 删除成员（逻辑删除）
     */
    void delete(Long id);

    /**
     * 批量删除群成员（解散群时用）
     */
    void deleteByGroupId(GroupId groupId);

    /**
     * 成员分页结果
     */
    record MemberPage(List<ChatGroupMember> members, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
