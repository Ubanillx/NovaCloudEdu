package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.post.entity.PostFavour;
import com.novacloudedu.backend.domain.post.repository.PostFavourRepository;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PostFavourConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PostFavourMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostFavourPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 帖子收藏仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PostFavourRepositoryImpl implements PostFavourRepository {

    private final PostFavourMapper postFavourMapper;
    private final PostFavourConverter converter;

    @Override
    public PostFavour save(PostFavour favour) {
        PostFavourPO po = converter.toPO(favour);
        postFavourMapper.insert(po);
        favour.assignId(po.getId());
        return favour;
    }

    @Override
    public void delete(PostId postId, UserId userId) {
        LambdaQueryWrapper<PostFavourPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostFavourPO::getPostId, postId.value())
               .eq(PostFavourPO::getUserId, userId.value());
        postFavourMapper.delete(wrapper);
    }

    @Override
    public Optional<PostFavour> findByPostIdAndUserId(PostId postId, UserId userId) {
        LambdaQueryWrapper<PostFavourPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostFavourPO::getPostId, postId.value())
               .eq(PostFavourPO::getUserId, userId.value());
        PostFavourPO po = postFavourMapper.selectOne(wrapper);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public boolean existsByPostIdAndUserId(PostId postId, UserId userId) {
        LambdaQueryWrapper<PostFavourPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostFavourPO::getPostId, postId.value())
               .eq(PostFavourPO::getUserId, userId.value());
        return postFavourMapper.selectCount(wrapper) > 0;
    }

    @Override
    public long countByPostId(PostId postId) {
        LambdaQueryWrapper<PostFavourPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostFavourPO::getPostId, postId.value());
        return postFavourMapper.selectCount(wrapper);
    }

    @Override
    public List<PostId> findPostIdsByUserId(UserId userId, int pageNum, int pageSize) {
        Page<PostFavourPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<PostFavourPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostFavourPO::getUserId, userId.value())
               .orderByDesc(PostFavourPO::getCreateTime);
        Page<PostFavourPO> result = postFavourMapper.selectPage(page, wrapper);
        return result.getRecords().stream()
                .map(po -> PostId.of(po.getPostId()))
                .toList();
    }

    @Override
    public long countByUserId(UserId userId) {
        LambdaQueryWrapper<PostFavourPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostFavourPO::getUserId, userId.value());
        return postFavourMapper.selectCount(wrapper);
    }
}
