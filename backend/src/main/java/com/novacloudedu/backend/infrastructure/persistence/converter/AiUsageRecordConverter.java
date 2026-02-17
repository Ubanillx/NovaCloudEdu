package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.membership.entity.AiUsageRecord;
import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.AiUsageRecordPO;
import org.springframework.stereotype.Component;

@Component
public class AiUsageRecordConverter {

    public AiUsageRecordPO toPO(AiUsageRecord record) {
        AiUsageRecordPO po = new AiUsageRecordPO();
        if (record.getId() != null) {
            po.setId(record.getId());
        }
        po.setUserId(record.getUserId().value());
        po.setFeatureType(record.getFeatureType().getValue());
        po.setUsageDate(record.getUsageDate());
        po.setUsageCount(record.getUsageCount());
        po.setCreateTime(record.getCreateTime());
        po.setUpdateTime(record.getUpdateTime());
        return po;
    }

    public AiUsageRecord toDomain(AiUsageRecordPO po) {
        return AiUsageRecord.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                AiFeatureType.fromValue(po.getFeatureType()),
                po.getUsageDate(),
                po.getUsageCount(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
