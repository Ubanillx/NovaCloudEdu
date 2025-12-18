package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.feedback.entity.FeedbackReply;
import com.novacloudedu.backend.domain.feedback.repository.FeedbackReplyRepository;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackId;
import com.novacloudedu.backend.domain.feedback.valueobject.FeedbackReplyId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.FeedbackReplyConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.FeedbackReplyMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.FeedbackReplyPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * 反馈回复仓储实现
 */
@Repository
@RequiredArgsConstructor
public class FeedbackReplyRepositoryImpl implements FeedbackReplyRepository {

    private final FeedbackReplyMapper replyMapper;
    private final FeedbackReplyConverter replyConverter;

    @Override
    public FeedbackReply save(FeedbackReply reply) {
        FeedbackReplyPO po = replyConverter.toPO(reply);
        if (reply.getId() == null) {
            replyMapper.insert(po);
            reply.assignId(FeedbackReplyId.of(po.getId()));
        } else {
            replyMapper.updateById(po);
        }
        return reply;
    }

    @Override
    public Optional<FeedbackReply> findById(FeedbackReplyId id) {
        FeedbackReplyPO po = replyMapper.selectById(id.value());
        return Optional.ofNullable(replyConverter.toDomain(po));
    }

    @Override
    public List<FeedbackReply> findByFeedbackId(FeedbackId feedbackId) {
        LambdaQueryWrapper<FeedbackReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FeedbackReplyPO::getFeedbackId, feedbackId.value())
                .orderByAsc(FeedbackReplyPO::getCreateTime);

        List<FeedbackReplyPO> poList = replyMapper.selectList(wrapper);
        return poList.stream()
                .map(replyConverter::toDomain)
                .toList();
    }

    @Override
    public ReplyPage findByFeedbackIdPaged(FeedbackId feedbackId, int pageNum, int pageSize) {
        LambdaQueryWrapper<FeedbackReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FeedbackReplyPO::getFeedbackId, feedbackId.value())
                .orderByAsc(FeedbackReplyPO::getCreateTime);

        Page<FeedbackReplyPO> page = new Page<>(pageNum, pageSize);
        Page<FeedbackReplyPO> resultPage = replyMapper.selectPage(page, wrapper);

        List<FeedbackReply> replies = resultPage.getRecords().stream()
                .map(replyConverter::toDomain)
                .toList();

        return new ReplyPage(replies, resultPage.getTotal(), pageNum, pageSize);
    }

    @Override
    public void markAllAsRead(FeedbackId feedbackId, UserId readerId) {
        LambdaUpdateWrapper<FeedbackReplyPO> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(FeedbackReplyPO::getFeedbackId, feedbackId.value())
                .ne(FeedbackReplyPO::getSenderId, readerId.value())
                .eq(FeedbackReplyPO::getIsRead, 0)
                .set(FeedbackReplyPO::getIsRead, 1)
                .set(FeedbackReplyPO::getUpdateTime, LocalDateTime.now());
        replyMapper.update(null, wrapper);
    }

    @Override
    public long countUnreadByFeedbackId(FeedbackId feedbackId, UserId userId) {
        LambdaQueryWrapper<FeedbackReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FeedbackReplyPO::getFeedbackId, feedbackId.value())
                .ne(FeedbackReplyPO::getSenderId, userId.value())
                .eq(FeedbackReplyPO::getIsRead, 0);
        return replyMapper.selectCount(wrapper);
    }

    @Override
    public void delete(FeedbackReplyId id) {
        replyMapper.deleteById(id.value());
    }

    @Override
    public void deleteByFeedbackId(FeedbackId feedbackId) {
        LambdaQueryWrapper<FeedbackReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FeedbackReplyPO::getFeedbackId, feedbackId.value());
        replyMapper.delete(wrapper);
    }
}
