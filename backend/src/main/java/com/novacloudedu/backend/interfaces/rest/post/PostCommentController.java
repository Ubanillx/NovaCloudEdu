package com.novacloudedu.backend.interfaces.rest.post;

import com.novacloudedu.backend.application.service.PostApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.post.entity.PostComment;
import com.novacloudedu.backend.domain.post.entity.PostCommentReply;
import com.novacloudedu.backend.interfaces.rest.post.dto.request.CreateCommentRequest;
import com.novacloudedu.backend.interfaces.rest.post.dto.request.CreateReplyRequest;
import com.novacloudedu.backend.interfaces.rest.post.dto.response.CommentPageResponse;
import com.novacloudedu.backend.interfaces.rest.post.dto.response.CommentResponse;
import com.novacloudedu.backend.interfaces.rest.post.dto.response.ReplyPageResponse;
import com.novacloudedu.backend.interfaces.rest.post.dto.response.ReplyResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

/**
 * 帖子评论控制器
 */
@RestController
@RequestMapping("/api/posts")
@RequiredArgsConstructor
@Tag(name = "帖子评论", description = "帖子评论和回复功能")
public class PostCommentController {

    private final PostApplicationService postService;

    // ==================== 评论功能 ====================

    @PostMapping("/{postId}/comments")
    @Operation(summary = "发表评论")
    public BaseResponse<CommentResponse> createComment(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long postId,
            @Valid @RequestBody CreateCommentRequest request,
            HttpServletRequest httpRequest) {
        String ipAddress = getIpAddress(httpRequest);
        PostComment comment = postService.createComment(postId, userId, request.getContent(), ipAddress);
        return ResultUtils.success(CommentResponse.from(comment));
    }

    @DeleteMapping("/comments/{commentId}")
    @Operation(summary = "删除评论")
    public BaseResponse<Void> deleteComment(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long commentId) {
        postService.deleteComment(commentId, userId);
        return ResultUtils.success(null);
    }

    @GetMapping("/{postId}/comments")
    @Operation(summary = "获取帖子评论列表")
    public BaseResponse<CommentPageResponse> getPostComments(
            @PathVariable Long postId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "20") int pageSize) {
        return ResultUtils.success(CommentPageResponse.from(postService.getPostComments(postId, pageNum, pageSize)));
    }

    // ==================== 回复功能 ====================

    @PostMapping("/comments/{commentId}/replies")
    @Operation(summary = "发表回复")
    public BaseResponse<ReplyResponse> createReply(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long commentId,
            @Valid @RequestBody CreateReplyRequest request,
            HttpServletRequest httpRequest) {
        String ipAddress = getIpAddress(httpRequest);
        PostCommentReply reply = postService.createReply(commentId, userId, request.getContent(), ipAddress);
        return ResultUtils.success(ReplyResponse.from(reply));
    }

    @DeleteMapping("/replies/{replyId}")
    @Operation(summary = "删除回复")
    public BaseResponse<Void> deleteReply(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long replyId) {
        postService.deleteReply(replyId, userId);
        return ResultUtils.success(null);
    }

    @GetMapping("/comments/{commentId}/replies")
    @Operation(summary = "获取评论回复列表")
    public BaseResponse<ReplyPageResponse> getCommentReplies(
            @PathVariable Long commentId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "20") int pageSize) {
        return ResultUtils.success(ReplyPageResponse.from(postService.getCommentReplies(commentId, pageNum, pageSize)));
    }

    // ==================== 私有方法 ====================

    private String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        // 多个代理时取第一个IP
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }
}
