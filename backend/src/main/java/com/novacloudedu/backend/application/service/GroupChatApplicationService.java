package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import com.novacloudedu.backend.domain.social.entity.GroupMessageRead;
import com.novacloudedu.backend.domain.social.repository.*;
import com.novacloudedu.backend.domain.social.valueobject.*;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 群聊消息应用服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class GroupChatApplicationService {

    private final GroupMessageRepository messageRepository;
    private final GroupMessageReadRepository readRepository;
    private final ChatGroupRepository groupRepository;
    private final ChatGroupMemberRepository memberRepository;
    private final UserRepository userRepository;
    private final NotificationService notificationService;

    /**
     * 发送群消息
     */
    @Transactional
    public GroupMessage sendMessage(Long groupId, Long senderId, String content, MessageType type, Long replyToId) {
        GroupId groupIdVo = GroupId.of(groupId);
        UserId senderIdVo = UserId.of(senderId);

        // 验证群存在
        ChatGroup group = groupRepository.findById(groupIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "群不存在"));

        // 验证发送者是群成员
        ChatGroupMember member = memberRepository.findByGroupIdAndUserId(groupIdVo, senderIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.FORBIDDEN_ERROR, "您不是群成员"));

        // 检查群是否全员禁言
        if (group.isMute() && !member.isAdminOrOwner()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "群处于全员禁言状态");
        }

        // 检查成员是否被禁言
        if (member.isMuted()) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "您已被禁言");
        }

        // 创建消息
        GroupMessageId replyTo = replyToId != null ? GroupMessageId.of(replyToId) : null;
        GroupMessage message = GroupMessage.createUserMessage(groupIdVo, senderIdVo, content, type, replyTo);

        // 保存消息
        GroupMessage savedMessage = messageRepository.save(message);

        log.info("群消息发送成功: groupId={}, senderId={}, messageId={}", 
                groupId, senderId, savedMessage.getId().value());

        // 发送群消息通知（群成员通过 HTTP 获取详情）
        User sender = userRepository.findById(senderIdVo).orElse(null);
        String senderName = sender != null ? sender.getUserName() : "未知用户";
        notificationService.notifyNewGroupMessage(groupId, group.getGroupName(), senderId, senderName);

        return savedMessage;
    }

    /**
     * 获取群消息列表（分页）
     */
    public GroupMessageRepository.MessagePage getMessages(Long groupId, Long userId, int pageNum, int pageSize) {
        GroupId groupIdVo = GroupId.of(groupId);
        UserId userIdVo = UserId.of(userId);

        // 验证是群成员
        if (!memberRepository.isMember(groupIdVo, userIdVo)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "您不是群成员");
        }

        return messageRepository.findByGroupId(groupIdVo, pageNum, pageSize);
    }

    /**
     * 获取群消息列表（游标分页，获取某消息之前的消息）
     */
    public List<GroupMessage> getMessagesBefore(Long groupId, Long userId, Long beforeMessageId, int limit) {
        GroupId groupIdVo = GroupId.of(groupId);
        UserId userIdVo = UserId.of(userId);

        // 验证是群成员
        if (!memberRepository.isMember(groupIdVo, userIdVo)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "您不是群成员");
        }

        return messageRepository.findByGroupIdBeforeMessage(groupIdVo, GroupMessageId.of(beforeMessageId), limit);
    }

    /**
     * 获取群最新消息
     */
    public List<GroupMessage> getLatestMessages(Long groupId, Long userId, int limit) {
        GroupId groupIdVo = GroupId.of(groupId);
        UserId userIdVo = UserId.of(userId);

        // 验证是群成员
        if (!memberRepository.isMember(groupIdVo, userIdVo)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "您不是群成员");
        }

        return messageRepository.findLatestByGroupId(groupIdVo, limit);
    }

    /**
     * 标记消息已读
     */
    @Transactional
    public void markAsRead(Long groupId, Long userId, Long messageId) {
        GroupId groupIdVo = GroupId.of(groupId);
        UserId userIdVo = UserId.of(userId);
        GroupMessageId messageIdVo = GroupMessageId.of(messageId);

        // 验证是群成员
        if (!memberRepository.isMember(groupIdVo, userIdVo)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "您不是群成员");
        }

        // 标记该消息及之前的消息为已读
        readRepository.markAllAsRead(groupIdVo, userIdVo, messageIdVo);
    }

    /**
     * 获取群未读消息数
     */
    public int getUnreadCount(Long groupId, Long userId) {
        GroupId groupIdVo = GroupId.of(groupId);
        UserId userIdVo = UserId.of(userId);

        // 验证是群成员
        if (!memberRepository.isMember(groupIdVo, userIdVo)) {
            return 0;
        }

        return readRepository.countUnreadMessages(groupIdVo, userIdVo);
    }

    /**
     * 获取消息已读人数
     */
    public int getReadCount(Long messageId) {
        return readRepository.countByMessageId(GroupMessageId.of(messageId));
    }

    /**
     * 获取消息已读用户列表
     */
    public List<GroupMessageRead> getReadUsers(Long messageId) {
        return readRepository.findByMessageId(GroupMessageId.of(messageId));
    }

    /**
     * 删除消息（仅管理员或消息发送者可删除）
     */
    @Transactional
    public void deleteMessage(Long groupId, Long operatorId, Long messageId) {
        GroupId groupIdVo = GroupId.of(groupId);
        UserId operatorIdVo = UserId.of(operatorId);
        GroupMessageId messageIdVo = GroupMessageId.of(messageId);

        // 获取消息
        GroupMessage message = messageRepository.findById(messageIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "消息不存在"));

        // 验证操作者是群成员
        ChatGroupMember operator = memberRepository.findByGroupIdAndUserId(groupIdVo, operatorIdVo)
                .orElseThrow(() -> new BusinessException(ErrorCode.FORBIDDEN_ERROR, "您不是群成员"));

        // 检查权限：管理员或消息发送者
        boolean isAdmin = operator.isAdminOrOwner();
        boolean isSender = message.getSenderId() != null && message.getSenderId().equals(operatorIdVo);

        if (!isAdmin && !isSender) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限删除此消息");
        }

        messageRepository.delete(messageIdVo);
        log.info("群消息已删除: groupId={}, operator={}, messageId={}", groupId, operatorId, messageId);
    }

    /**
     * 获取群成员列表（用于推送消息）
     */
    public List<ChatGroupMember> getGroupMembers(Long groupId) {
        return memberRepository.findByGroupId(GroupId.of(groupId));
    }
}
