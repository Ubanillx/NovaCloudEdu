package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.novacloudedu.backend.domain.post.entity.PostThumb;
import com.novacloudedu.backend.domain.post.repository.PostThumbRepository;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PostThumbConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PostThumbMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostThumbPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * 帖子点赞仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PostThumbRepositoryImpl implements PostThumbRepository {

    private final PostThumbMapper postThumbMapper;
    private final PostThumbConverter converter;

    @Override
    public PostThumb save(PostThumb thumb) {
        PostThumbPO po = converter.toPO(thumb);
        postThumbMapper.insert(po);
        thumb.assignId(po.getId());
        return thumb;
    }

    @Override
    public void delete(PostId postId, UserId userId) {
        LambdaQueryWrapper<PostThumbPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostThumbPO::getPostId, postId.value())
               .eq(PostThumbPO::getUserId, userId.value());
        postThumbMapper.delete(wrapper);
    }

    @Override
    public Optional<PostThumb> findByPostIdAndUserId(PostId postId, UserId userId) {
        LambdaQueryWrapper<PostThumbPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostThumbPO::getPostId, postId.value())
               .eq(PostThumbPO::getUserId, userId.value());
        PostThumbPO po = postThumbMapper.selectOne(wrapper);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public boolean existsByPostIdAndUserId(PostId postId, UserId userId) {
        LambdaQueryWrapper<PostThumbPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostThumbPO::getPostId, postId.value())
               .eq(PostThumbPO::getUserId, userId.value());
        return postThumbMapper.selectCount(wrapper) > 0;
    }

    @Override
    public long countByPostId(PostId postId) {
        LambdaQueryWrapper<PostThumbPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostThumbPO::getPostId, postId.value());
        return postThumbMapper.selectCount(wrapper);
    }
}
