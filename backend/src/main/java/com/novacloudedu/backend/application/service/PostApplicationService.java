package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.post.entity.*;
import com.novacloudedu.backend.domain.post.repository.*;
import com.novacloudedu.backend.domain.post.valueobject.*;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 帖子应用服务
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class PostApplicationService {

    private final PostRepository postRepository;
    private final PostThumbRepository thumbRepository;
    private final PostFavourRepository favourRepository;
    private final PostCommentRepository commentRepository;
    private final PostCommentReplyRepository replyRepository;
    private final UserRepository userRepository;

    // ==================== 帖子管理 ====================

    /**
     * 创建帖子
     */
    @Transactional
    public Post createPost(Long userId, String title, String content, List<String> tags, 
                          String postType, String ipAddress) {
        // 验证用户存在
        userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        Post post = Post.create(title, content, tags, UserId.of(userId), PostType.fromCode(postType));
        post.setIpAddress(ipAddress);
        Post savedPost = postRepository.save(post);

        log.info("帖子创建成功: postId={}, userId={}", savedPost.getId().value(), userId);
        return savedPost;
    }

    /**
     * 更新帖子
     */
    @Transactional
    public void updatePost(Long postId, Long userId, String title, String content, 
                          List<String> tags, String postType) {
        Post post = getPostOrThrow(postId);

        // 只有作者可以修改
        if (!post.isAuthor(UserId.of(userId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限修改此帖子");
        }

        post.update(title, content, tags, postType != null ? PostType.fromCode(postType) : null);
        postRepository.update(post);

        log.info("帖子更新成功: postId={}, userId={}", postId, userId);
    }

    /**
     * 删除帖子
     */
    @Transactional
    public void deletePost(Long postId, Long userId) {
        Post post = getPostOrThrow(postId);

        // 只有作者可以删除
        if (!post.isAuthor(UserId.of(userId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限删除此帖子");
        }

        // 删除相关评论回复
        replyRepository.deleteByPostId(PostId.of(postId));
        // 删除相关评论
        commentRepository.deleteByPostId(PostId.of(postId));
        // 删除帖子（逻辑删除）
        post.delete();
        postRepository.update(post);

        log.info("帖子删除成功: postId={}, userId={}", postId, userId);
    }

    /**
     * 获取帖子详情
     */
    public Post getPostDetail(Long postId) {
        return getPostOrThrow(postId);
    }

    /**
     * 分页获取帖子列表
     */
    public PostRepository.PostPage getPostList(int pageNum, int pageSize) {
        return postRepository.findAll(pageNum, pageSize);
    }

    /**
     * 根据类型获取帖子列表
     */
    public PostRepository.PostPage getPostListByType(String postType, int pageNum, int pageSize) {
        return postRepository.findByType(PostType.fromCode(postType), pageNum, pageSize);
    }

    /**
     * 搜索帖子
     */
    public PostRepository.PostPage searchPosts(String keyword, int pageNum, int pageSize) {
        return postRepository.searchByKeyword(keyword, pageNum, pageSize);
    }

    /**
     * 根据标签搜索帖子
     */
    public PostRepository.PostPage searchPostsByTag(String tag, int pageNum, int pageSize) {
        return postRepository.searchByTag(tag, pageNum, pageSize);
    }

    /**
     * 获取用户的帖子列表
     */
    public List<Post> getUserPosts(Long userId) {
        return postRepository.findByUserId(UserId.of(userId));
    }

    /**
     * 获取用户收藏的帖子
     */
    public PostRepository.PostPage getUserFavourites(Long userId, int pageNum, int pageSize) {
        return postRepository.findFavouritesByUserId(UserId.of(userId), pageNum, pageSize);
    }

    // ==================== 点赞功能 ====================

    /**
     * 点赞/取消点赞帖子
     */
    @Transactional
    public boolean toggleThumb(Long postId, Long userId) {
        Post post = getPostOrThrow(postId);
        PostId postIdVo = PostId.of(postId);
        UserId userIdVo = UserId.of(userId);

        boolean hasThumb = thumbRepository.existsByPostIdAndUserId(postIdVo, userIdVo);

        if (hasThumb) {
            // 取消点赞
            thumbRepository.delete(postIdVo, userIdVo);
            post.decrementThumbNum();
            postRepository.update(post);
            log.info("取消点赞: postId={}, userId={}", postId, userId);
            return false;
        } else {
            // 点赞
            PostThumb thumb = PostThumb.create(postIdVo, userIdVo);
            thumbRepository.save(thumb);
            post.incrementThumbNum();
            postRepository.update(post);
            log.info("点赞成功: postId={}, userId={}", postId, userId);
            return true;
        }
    }

    /**
     * 检查是否已点赞
     */
    public boolean hasThumb(Long postId, Long userId) {
        return thumbRepository.existsByPostIdAndUserId(PostId.of(postId), UserId.of(userId));
    }

    // ==================== 收藏功能 ====================

    /**
     * 收藏/取消收藏帖子
     */
    @Transactional
    public boolean toggleFavour(Long postId, Long userId) {
        Post post = getPostOrThrow(postId);
        PostId postIdVo = PostId.of(postId);
        UserId userIdVo = UserId.of(userId);

        boolean hasFavour = favourRepository.existsByPostIdAndUserId(postIdVo, userIdVo);

        if (hasFavour) {
            // 取消收藏
            favourRepository.delete(postIdVo, userIdVo);
            post.decrementFavourNum();
            postRepository.update(post);
            log.info("取消收藏: postId={}, userId={}", postId, userId);
            return false;
        } else {
            // 收藏
            PostFavour favour = PostFavour.create(postIdVo, userIdVo);
            favourRepository.save(favour);
            post.incrementFavourNum();
            postRepository.update(post);
            log.info("收藏成功: postId={}, userId={}", postId, userId);
            return true;
        }
    }

    /**
     * 检查是否已收藏
     */
    public boolean hasFavour(Long postId, Long userId) {
        return favourRepository.existsByPostIdAndUserId(PostId.of(postId), UserId.of(userId));
    }

    // ==================== 评论功能 ====================

    /**
     * 发表评论
     */
    @Transactional
    public PostComment createComment(Long postId, Long userId, String content, String ipAddress) {
        Post post = getPostOrThrow(postId);

        // 验证用户存在
        userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        PostComment comment = PostComment.create(PostId.of(postId), UserId.of(userId), content);
        comment.setIpAddress(ipAddress);
        PostComment savedComment = commentRepository.save(comment);

        // 更新帖子评论数
        post.incrementCommentNum();
        postRepository.update(post);

        log.info("评论发表成功: postId={}, commentId={}, userId={}", postId, savedComment.getId().value(), userId);
        return savedComment;
    }

    /**
     * 删除评论
     */
    @Transactional
    public void deleteComment(Long commentId, Long userId) {
        PostComment comment = commentRepository.findById(CommentId.of(commentId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "评论不存在"));

        // 只有评论作者可以删除
        if (!comment.isAuthor(UserId.of(userId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限删除此评论");
        }

        Post post = getPostOrThrow(comment.getPostId().value());

        // 删除评论的所有回复
        replyRepository.deleteByCommentId(CommentId.of(commentId));
        // 删除评论
        commentRepository.delete(CommentId.of(commentId));

        // 更新帖子评论数
        post.decrementCommentNum();
        postRepository.update(post);

        log.info("评论删除成功: commentId={}, userId={}", commentId, userId);
    }

    /**
     * 获取帖子评论列表
     */
    public PostCommentRepository.CommentPage getPostComments(Long postId, int pageNum, int pageSize) {
        getPostOrThrow(postId);
        return commentRepository.findByPostId(PostId.of(postId), pageNum, pageSize);
    }

    // ==================== 回复功能 ====================

    /**
     * 发表回复
     */
    @Transactional
    public PostCommentReply createReply(Long commentId, Long userId, String content, String ipAddress) {
        PostComment comment = commentRepository.findById(CommentId.of(commentId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "评论不存在"));

        // 验证用户存在
        userRepository.findById(UserId.of(userId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "用户不存在"));

        PostCommentReply reply = PostCommentReply.create(
                comment.getPostId(), CommentId.of(commentId), UserId.of(userId), content
        );
        reply.setIpAddress(ipAddress);
        PostCommentReply savedReply = replyRepository.save(reply);

        log.info("回复发表成功: commentId={}, replyId={}, userId={}", commentId, savedReply.getId().value(), userId);
        return savedReply;
    }

    /**
     * 删除回复
     */
    @Transactional
    public void deleteReply(Long replyId, Long userId) {
        PostCommentReply reply = replyRepository.findById(ReplyId.of(replyId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "回复不存在"));

        // 只有回复作者可以删除
        if (!reply.isAuthor(UserId.of(userId))) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "没有权限删除此回复");
        }

        replyRepository.delete(ReplyId.of(replyId));

        log.info("回复删除成功: replyId={}, userId={}", replyId, userId);
    }

    /**
     * 获取评论回复列表
     */
    public PostCommentReplyRepository.ReplyPage getCommentReplies(Long commentId, int pageNum, int pageSize) {
        commentRepository.findById(CommentId.of(commentId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "评论不存在"));
        return replyRepository.findByCommentId(CommentId.of(commentId), pageNum, pageSize);
    }

    // ==================== 私有方法 ====================

    private Post getPostOrThrow(Long postId) {
        return postRepository.findById(PostId.of(postId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "帖子不存在"));
    }
}
