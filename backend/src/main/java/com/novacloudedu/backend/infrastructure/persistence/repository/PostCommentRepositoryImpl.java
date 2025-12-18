package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.post.entity.PostComment;
import com.novacloudedu.backend.domain.post.repository.PostCommentRepository;
import com.novacloudedu.backend.domain.post.valueobject.CommentId;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PostCommentConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PostCommentMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostCommentPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 帖子评论仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PostCommentRepositoryImpl implements PostCommentRepository {

    private final PostCommentMapper postCommentMapper;
    private final PostCommentConverter converter;

    @Override
    public PostComment save(PostComment comment) {
        PostCommentPO po = converter.toPO(comment);
        postCommentMapper.insert(po);
        comment.assignId(CommentId.of(po.getId()));
        return comment;
    }

    @Override
    public Optional<PostComment> findById(CommentId id) {
        PostCommentPO po = postCommentMapper.selectById(id.value());
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<PostComment> findByPostId(PostId postId) {
        LambdaQueryWrapper<PostCommentPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentPO::getPostId, postId.value())
               .orderByAsc(PostCommentPO::getCreateTime);
        return postCommentMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public CommentPage findByPostId(PostId postId, int pageNum, int pageSize) {
        Page<PostCommentPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<PostCommentPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentPO::getPostId, postId.value())
               .orderByAsc(PostCommentPO::getCreateTime);
        Page<PostCommentPO> result = postCommentMapper.selectPage(page, wrapper);

        List<PostComment> comments = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new CommentPage(comments, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public void delete(CommentId id) {
        postCommentMapper.deleteById(id.value());
    }

    @Override
    public void deleteByPostId(PostId postId) {
        LambdaQueryWrapper<PostCommentPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentPO::getPostId, postId.value());
        postCommentMapper.delete(wrapper);
    }

    @Override
    public long countByPostId(PostId postId) {
        LambdaQueryWrapper<PostCommentPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostCommentPO::getPostId, postId.value());
        return postCommentMapper.selectCount(wrapper);
    }
}
