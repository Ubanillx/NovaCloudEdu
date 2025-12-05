package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 群消息分页响应
 */
@Data
public class GroupMessagePageResponse {

    private List<GroupMessageItem> messages;
    private long total;
    private int pageNum;
    private int pageSize;
    private int totalPages;

    @Data
    public static class GroupMessageItem {
        private Long messageId;
        private Long groupId;
        private int senderType;
        private Long senderId;
        private Long aiRoleId;
        private String senderName;
        private String senderAvatar;
        private String content;
        private String type;
        private Long replyTo;
        private LocalDateTime createTime;

        public static GroupMessageItem from(GroupMessage message) {
            GroupMessageItem item = new GroupMessageItem();
            item.setMessageId(message.getId().value());
            item.setGroupId(message.getGroupId().value());
            item.setSenderType(message.getSenderType().getCode());
            if (message.getSenderId() != null) {
                item.setSenderId(message.getSenderId().value());
            }
            item.setAiRoleId(message.getAiRoleId());
            item.setContent(message.getContent());
            item.setType(message.getType().getValue());
            if (message.getReplyTo() != null) {
                item.setReplyTo(message.getReplyTo().value());
            }
            item.setCreateTime(message.getCreateTime());
            return item;
        }
    }
}
