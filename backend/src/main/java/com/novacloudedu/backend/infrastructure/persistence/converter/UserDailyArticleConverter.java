package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyArticle;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserDailyArticlePO;
import org.springframework.stereotype.Component;

@Component
public class UserDailyArticleConverter {

    public UserDailyArticlePO toPO(UserDailyArticle userDailyArticle) {
        UserDailyArticlePO po = new UserDailyArticlePO();
        if (userDailyArticle.getId() != null) {
            po.setId(userDailyArticle.getId());
        }
        po.setUserId(userDailyArticle.getUserId().value());
        po.setArticleId(userDailyArticle.getArticleId().value());
        po.setIsRead(userDailyArticle.isRead() ? 1 : 0);
        po.setIsLiked(userDailyArticle.isLiked() ? 1 : 0);
        po.setIsCollected(userDailyArticle.isCollected() ? 1 : 0);
        po.setCommentContent(userDailyArticle.getCommentContent());
        po.setCommentTime(userDailyArticle.getCommentTime());
        po.setCreateTime(userDailyArticle.getCreateTime());
        po.setUpdateTime(userDailyArticle.getUpdateTime());
        return po;
    }

    public UserDailyArticle toDomain(UserDailyArticlePO po) {
        return UserDailyArticle.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                DailyArticleId.of(po.getArticleId()),
                po.getIsRead() == 1,
                po.getIsLiked() == 1,
                po.getIsCollected() == 1,
                po.getCommentContent(),
                po.getCommentTime(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
