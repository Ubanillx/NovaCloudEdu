package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.post.entity.PostCommentReply;
import com.novacloudedu.backend.domain.post.repository.PostCommentReplyRepository;
import com.novacloudedu.backend.domain.post.valueobject.CommentId;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.ReplyId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PostCommentReplyConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PostCommentReplyMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostCommentReplyPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 帖子评论回复仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PostCommentReplyRepositoryImpl implements PostCommentReplyRepository {

    private final PostCommentReplyMapper postCommentReplyMapper;
    private final PostCommentReplyConverter converter;

    @Override
    public PostCommentReply save(PostCommentReply reply) {
        PostCommentReplyPO po = converter.toPO(reply);
        postCommentReplyMapper.insert(po);
        reply.assignId(ReplyId.of(po.getId()));
        return reply;
    }

    @Override
    public Optional<PostCommentReply> findById(ReplyId id) {
        PostCommentReplyPO po = postCommentReplyMapper.selectById(id.value());
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<PostCommentReply> findByCommentId(CommentId commentId) {
        LambdaQueryWrapper<PostCommentReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentReplyPO::getCommentId, commentId.value())
               .orderByAsc(PostCommentReplyPO::getCreateTime);
        return postCommentReplyMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public ReplyPage findByCommentId(CommentId commentId, int pageNum, int pageSize) {
        Page<PostCommentReplyPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<PostCommentReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentReplyPO::getCommentId, commentId.value())
               .orderByAsc(PostCommentReplyPO::getCreateTime);
        Page<PostCommentReplyPO> result = postCommentReplyMapper.selectPage(page, wrapper);

        List<PostCommentReply> replies = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new ReplyPage(replies, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public void delete(ReplyId id) {
        postCommentReplyMapper.deleteById(id.value());
    }

    @Override
    public void deleteByCommentId(CommentId commentId) {
        LambdaQueryWrapper<PostCommentReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentReplyPO::getCommentId, commentId.value());
        postCommentReplyMapper.delete(wrapper);
    }

    @Override
    public void deleteByPostId(PostId postId) {
        LambdaQueryWrapper<PostCommentReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentReplyPO::getPostId, postId.value());
        postCommentReplyMapper.delete(wrapper);
    }

    @Override
    public long countByCommentId(CommentId commentId) {
        LambdaQueryWrapper<PostCommentReplyPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentReplyPO::getCommentId, commentId.value());
        return postCommentReplyMapper.selectCount(wrapper);
    }
}
