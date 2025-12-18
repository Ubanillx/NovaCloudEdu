package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.recommendation.entity.UserPreference;
import com.novacloudedu.backend.domain.recommendation.valueobject.PreferenceType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserPreferencePO;
import org.springframework.stereotype.Component;

@Component
public class UserPreferenceConverter {

    public UserPreferencePO toPO(UserPreference preference) {
        UserPreferencePO po = new UserPreferencePO();
        if (preference.getId() != null) {
            po.setId(preference.getId());
        }
        po.setUserId(preference.getUserId().value());
        po.setPreferenceType(preference.getPreferenceType().getCode());
        po.setPreferenceKey(preference.getPreferenceKey());
        po.setPreferenceValue(preference.getPreferenceValue());
        po.setInteractionCount(preference.getInteractionCount());
        po.setLastInteractionTime(preference.getLastInteractionTime());
        po.setCreateTime(preference.getCreateTime());
        po.setUpdateTime(preference.getUpdateTime());
        return po;
    }

    public UserPreference toDomain(UserPreferencePO po) {
        return UserPreference.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                PreferenceType.fromCode(po.getPreferenceType()),
                po.getPreferenceKey(),
                po.getPreferenceValue(),
                po.getInteractionCount(),
                po.getLastInteractionTime(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
