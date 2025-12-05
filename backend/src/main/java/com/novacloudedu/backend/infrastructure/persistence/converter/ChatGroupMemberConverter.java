package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.GroupRole;
import com.novacloudedu.backend.domain.social.valueobject.MemberType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ChatGroupMemberPO;
import org.springframework.stereotype.Component;

/**
 * 群成员转换器
 */
@Component
public class ChatGroupMemberConverter {

    public ChatGroupMember toDomain(ChatGroupMemberPO po) {
        if (po == null) {
            return null;
        }
        return ChatGroupMember.reconstruct(
                po.getId(),
                GroupId.of(po.getGroupId()),
                MemberType.fromCode(po.getMemberType()),
                po.getUserId() != null ? UserId.of(po.getUserId()) : null,
                po.getAiRoleId(),
                GroupRole.fromCode(po.getRole()),
                po.getNickname(),
                po.getIsMute() == 1,
                po.getMuteUntil(),
                po.getJoinTime(),
                po.getUpdateTime(),
                po.getIsDelete() == 1
        );
    }

    public ChatGroupMemberPO toPO(ChatGroupMember domain) {
        if (domain == null) {
            return null;
        }
        ChatGroupMemberPO po = new ChatGroupMemberPO();
        po.setId(domain.getId());
        po.setGroupId(domain.getGroupId().value());
        po.setMemberType(domain.getMemberType().getCode());
        if (domain.getUserId() != null) {
            po.setUserId(domain.getUserId().value());
        }
        po.setAiRoleId(domain.getAiRoleId());
        po.setRole(domain.getRole().getCode());
        po.setNickname(domain.getNickname());
        po.setIsMute(domain.isMute() ? 1 : 0);
        po.setMuteUntil(domain.getMuteUntil());
        po.setJoinTime(domain.getJoinTime());
        po.setUpdateTime(domain.getUpdateTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }
}
