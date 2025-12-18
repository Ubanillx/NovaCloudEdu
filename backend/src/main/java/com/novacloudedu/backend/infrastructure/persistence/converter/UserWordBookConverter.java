package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.dailylearning.entity.UserWordBook;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.LearningStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserWordBookPO;
import org.springframework.stereotype.Component;

@Component
public class UserWordBookConverter {

    public UserWordBookPO toPO(UserWordBook userWordBook) {
        UserWordBookPO po = new UserWordBookPO();
        if (userWordBook.getId() != null) {
            po.setId(userWordBook.getId());
        }
        po.setUserId(userWordBook.getUserId().value());
        po.setWordId(userWordBook.getWordId().value());
        po.setLearningStatus(userWordBook.getLearningStatus().getCode());
        po.setCollectedTime(userWordBook.getCollectedTime());
        po.setIsDeleted(userWordBook.isDeleted() ? 1 : 0);
        po.setCreateTime(userWordBook.getCreateTime());
        po.setUpdateTime(userWordBook.getUpdateTime());
        return po;
    }

    public UserWordBook toDomain(UserWordBookPO po) {
        return UserWordBook.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                DailyWordId.of(po.getWordId()),
                LearningStatus.fromCode(po.getLearningStatus()),
                po.getCollectedTime(),
                po.getIsDeleted() == 1,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
