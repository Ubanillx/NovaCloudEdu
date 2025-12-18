package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.post.entity.Post;
import com.novacloudedu.backend.domain.post.repository.PostRepository;
import com.novacloudedu.backend.domain.post.valueobject.PostId;
import com.novacloudedu.backend.domain.post.valueobject.PostType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.PostConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PostFavourMapper;
import com.novacloudedu.backend.infrastructure.persistence.mapper.PostMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PostFavourPO;
import com.novacloudedu.backend.infrastructure.persistence.po.PostPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 帖子仓储实现
 */
@Repository
@RequiredArgsConstructor
public class PostRepositoryImpl implements PostRepository {

    private final PostMapper postMapper;
    private final PostFavourMapper postFavourMapper;
    private final PostConverter converter;

    @Override
    public Post save(Post post) {
        PostPO po = converter.toPO(post);
        postMapper.insert(po);
        post.assignId(PostId.of(po.getId()));
        return post;
    }

    @Override
    public void update(Post post) {
        PostPO po = converter.toPO(post);
        postMapper.updateById(po);
    }

    @Override
    public Optional<Post> findById(PostId id) {
        PostPO po = postMapper.selectById(id.value());
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<Post> findByUserId(UserId userId) {
        LambdaQueryWrapper<PostPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostPO::getUserId, userId.value())
               .orderByDesc(PostPO::getCreateTime);
        return postMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public PostPage findAll(int pageNum, int pageSize) {
        Page<PostPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<PostPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(PostPO::getCreateTime);
        Page<PostPO> result = postMapper.selectPage(page, wrapper);

        List<Post> posts = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new PostPage(posts, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public PostPage findByType(PostType postType, int pageNum, int pageSize) {
        Page<PostPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<PostPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PostPO::getPostType, postType.getCode())
               .orderByDesc(PostPO::getCreateTime);
        Page<PostPO> result = postMapper.selectPage(page, wrapper);

        List<Post> posts = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new PostPage(posts, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public PostPage searchByTag(String tag, int pageNum, int pageSize) {
        Page<PostPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<PostPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(PostPO::getTags, tag)
               .orderByDesc(PostPO::getCreateTime);
        Page<PostPO> result = postMapper.selectPage(page, wrapper);

        List<Post> posts = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new PostPage(posts, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public PostPage searchByKeyword(String keyword, int pageNum, int pageSize) {
        Page<PostPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<PostPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w.like(PostPO::getTitle, keyword)
                         .or()
                         .like(PostPO::getContent, keyword))
               .orderByDesc(PostPO::getCreateTime);
        Page<PostPO> result = postMapper.selectPage(page, wrapper);

        List<Post> posts = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new PostPage(posts, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public PostPage findFavouritesByUserId(UserId userId, int pageNum, int pageSize) {
        // 先查询用户收藏的帖子ID
        Page<PostFavourPO> favourPage = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<PostFavourPO> favourWrapper = new LambdaQueryWrapper<>();
        favourWrapper.eq(PostFavourPO::getUserId, userId.value())
                     .orderByDesc(PostFavourPO::getCreateTime);
        Page<PostFavourPO> favourResult = postFavourMapper.selectPage(favourPage, favourWrapper);

        if (favourResult.getRecords().isEmpty()) {
            return new PostPage(List.of(), 0, pageNum, pageSize);
        }

        // 根据帖子ID查询帖子
        List<Long> postIds = favourResult.getRecords().stream()
                .map(PostFavourPO::getPostId)
                .toList();

        LambdaQueryWrapper<PostPO> postWrapper = new LambdaQueryWrapper<>();
        postWrapper.in(PostPO::getId, postIds);
        List<Post> posts = postMapper.selectList(postWrapper).stream()
                .map(converter::toDomain)
                .toList();

        return new PostPage(posts, favourResult.getTotal(), pageNum, pageSize);
    }

    @Override
    public void delete(PostId id) {
        postMapper.deleteById(id.value());
    }
}
