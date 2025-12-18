package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.feedback.entity.UserFeedback;
import com.novacloudedu.backend.domain.feedback.repository.UserFeedbackRepository;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.UserFeedbackConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.UserFeedbackMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserFeedbackPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

/**
 * 用户反馈仓储实现
 */
@Repository
@RequiredArgsConstructor
public class UserFeedbackRepositoryImpl implements UserFeedbackRepository {

    private final UserFeedbackMapper feedbackMapper;
    private final UserFeedbackConverter feedbackConverter;

    @Override
    public UserFeedback save(UserFeedback feedback) {
        UserFeedbackPO po = feedbackConverter.toPO(feedback);
        if (feedback.getId() == null) {
            feedbackMapper.insert(po);
            feedback.assignId(FeedbackId.of(po.getId()));
        } else {
            feedbackMapper.updateById(po);
        }
        return feedback;
    }

    @Override
    public Optional<UserFeedback> findById(FeedbackId id) {
        UserFeedbackPO po = feedbackMapper.selectById(id.value());
        return Optional.ofNullable(feedbackConverter.toDomain(po));
    }

    @Override
    public FeedbackPage findByUserId(UserId userId, int pageNum, int pageSize) {
        LambdaQueryWrapper<UserFeedbackPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserFeedbackPO::getUserId, userId.value())
                .orderByDesc(UserFeedbackPO::getCreateTime);

        Page<UserFeedbackPO> page = new Page<>(pageNum, pageSize);
        Page<UserFeedbackPO> resultPage = feedbackMapper.selectPage(page, wrapper);

        List<UserFeedback> feedbacks = resultPage.getRecords().stream()
                .map(feedbackConverter::toDomain)
                .toList();

        return new FeedbackPage(feedbacks, resultPage.getTotal(), pageNum, pageSize);
    }

    @Override
    public FeedbackPage findByCondition(FeedbackQueryCondition condition) {
        LambdaQueryWrapper<UserFeedbackPO> wrapper = new LambdaQueryWrapper<>();

        if (condition.userId() != null) {
            wrapper.eq(UserFeedbackPO::getUserId, condition.userId());
        }
        if (StringUtils.hasText(condition.feedbackType())) {
            wrapper.eq(UserFeedbackPO::getFeedbackType, condition.feedbackType());
        }
        if (condition.status() != null) {
            wrapper.eq(UserFeedbackPO::getStatus, condition.status().getCode());
        }

        wrapper.orderByDesc(UserFeedbackPO::getCreateTime);

        Page<UserFeedbackPO> page = new Page<>(condition.pageNum(), condition.pageSize());
        Page<UserFeedbackPO> resultPage = feedbackMapper.selectPage(page, wrapper);

        List<UserFeedback> feedbacks = resultPage.getRecords().stream()
                .map(feedbackConverter::toDomain)
                .toList();

        return new FeedbackPage(feedbacks, resultPage.getTotal(), condition.pageNum(), condition.pageSize());
    }

    @Override
    public void delete(FeedbackId id) {
        feedbackMapper.deleteById(id.value());
    }
}
