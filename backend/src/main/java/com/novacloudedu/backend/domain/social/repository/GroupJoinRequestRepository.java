package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.GroupJoinRequest;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.JoinRequestStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 群申请仓储接口
 */
public interface GroupJoinRequestRepository {

    /**
     * 保存群申请
     */
    GroupJoinRequest save(GroupJoinRequest request);

    /**
     * 更新群申请
     */
    void update(GroupJoinRequest request);

    /**
     * 根据ID查找
     */
    Optional<GroupJoinRequest> findById(Long id);

    /**
     * 查找用户对某群的待处理申请
     */
    Optional<GroupJoinRequest> findPendingRequest(GroupId groupId, UserId userId);

    /**
     * 获取群的申请列表（按状态）
     */
    List<GroupJoinRequest> findByGroupIdAndStatus(GroupId groupId, JoinRequestStatus status);

    /**
     * 分页获取群的申请列表
     */
    RequestPage findByGroupId(GroupId groupId, int pageNum, int pageSize);

    /**
     * 获取用户发起的申请列表
     */
    List<GroupJoinRequest> findByUserId(UserId userId);

    /**
     * 检查是否存在待处理的申请
     */
    boolean existsPendingRequest(GroupId groupId, UserId userId);

    /**
     * 申请分页结果
     */
    record RequestPage(List<GroupJoinRequest> requests, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
