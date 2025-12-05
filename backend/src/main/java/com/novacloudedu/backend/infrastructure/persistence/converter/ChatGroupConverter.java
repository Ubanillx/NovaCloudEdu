package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.InviteMode;
import com.novacloudedu.backend.domain.social.valueobject.JoinMode;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ChatGroupPO;
import org.springframework.stereotype.Component;

/**
 * 群聊转换器
 */
@Component
public class ChatGroupConverter {

    public ChatGroup toDomain(ChatGroupPO po) {
        if (po == null) {
            return null;
        }
        return ChatGroup.reconstruct(
                GroupId.of(po.getId()),
                po.getGroupName(),
                po.getAvatar(),
                po.getDescription(),
                UserId.of(po.getOwnerId()),
                po.getClassId(),
                po.getMaxMembers(),
                po.getMemberCount(),
                InviteMode.fromCode(po.getInviteMode()),
                JoinMode.fromCode(po.getJoinMode()),
                po.getIsMute() == 1,
                po.getAnnouncement(),
                po.getAnnouncementTime(),
                po.getCreateTime(),
                po.getUpdateTime(),
                po.getIsDelete() == 1
        );
    }

    public ChatGroupPO toPO(ChatGroup domain) {
        if (domain == null) {
            return null;
        }
        ChatGroupPO po = new ChatGroupPO();
        if (domain.getId() != null) {
            po.setId(domain.getId().value());
        }
        po.setGroupName(domain.getGroupName());
        po.setAvatar(domain.getAvatar());
        po.setDescription(domain.getDescription());
        po.setOwnerId(domain.getOwnerId().value());
        po.setClassId(domain.getClassId());
        po.setMaxMembers(domain.getMaxMembers());
        po.setMemberCount(domain.getMemberCount());
        po.setInviteMode(domain.getInviteMode().getCode());
        po.setJoinMode(domain.getJoinMode().getCode());
        po.setIsMute(domain.isMute() ? 1 : 0);
        po.setAnnouncement(domain.getAnnouncement());
        po.setAnnouncementTime(domain.getAnnouncementTime());
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }
}
