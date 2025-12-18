package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyWord;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.MasteryLevel;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserDailyWordPO;
import org.springframework.stereotype.Component;

@Component
public class UserDailyWordConverter {

    public UserDailyWordPO toPO(UserDailyWord userDailyWord) {
        UserDailyWordPO po = new UserDailyWordPO();
        if (userDailyWord.getId() != null) {
            po.setId(userDailyWord.getId());
        }
        po.setUserId(userDailyWord.getUserId().value());
        po.setWordId(userDailyWord.getWordId().value());
        po.setIsStudied(userDailyWord.isStudied() ? 1 : 0);
        po.setIsCollected(userDailyWord.isCollected() ? 1 : 0);
        po.setMasteryLevel(userDailyWord.getMasteryLevel().getCode());
        po.setCreateTime(userDailyWord.getCreateTime());
        po.setUpdateTime(userDailyWord.getUpdateTime());
        return po;
    }

    public UserDailyWord toDomain(UserDailyWordPO po) {
        return UserDailyWord.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                DailyWordId.of(po.getWordId()),
                po.getIsStudied() == 1,
                po.getIsCollected() == 1,
                MasteryLevel.fromCode(po.getMasteryLevel()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
