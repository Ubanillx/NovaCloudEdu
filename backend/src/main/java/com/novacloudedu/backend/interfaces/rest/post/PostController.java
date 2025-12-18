package com.novacloudedu.backend.interfaces.rest.post;

import com.novacloudedu.backend.application.service.PostApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.post.entity.Post;
import com.novacloudedu.backend.interfaces.rest.post.dto.request.CreatePostRequest;
import com.novacloudedu.backend.interfaces.rest.post.dto.request.UpdatePostRequest;
import com.novacloudedu.backend.interfaces.rest.post.dto.response.PostDetailResponse;
import com.novacloudedu.backend.interfaces.rest.post.dto.response.PostPageResponse;
import com.novacloudedu.backend.interfaces.rest.post.dto.response.PostResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 帖子控制器
 */
@RestController
@RequestMapping("/api/posts")
@RequiredArgsConstructor
@Tag(name = "帖子管理", description = "帖子的发布、编辑、删除、查询等功能")
public class PostController {

    private final PostApplicationService postService;

    // ==================== 帖子管理 ====================

    @PostMapping
    @Operation(summary = "发布帖子")
    public BaseResponse<PostResponse> createPost(
            @AuthenticationPrincipal Long userId,
            @Valid @RequestBody CreatePostRequest request,
            HttpServletRequest httpRequest) {
        String ipAddress = getIpAddress(httpRequest);
        Post post = postService.createPost(
                userId, request.getTitle(), request.getContent(),
                request.getTags(), request.getPostType(), ipAddress
        );
        return ResultUtils.success(PostResponse.from(post));
    }

    @PutMapping("/{postId}")
    @Operation(summary = "更新帖子")
    public BaseResponse<Void> updatePost(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long postId,
            @Valid @RequestBody UpdatePostRequest request) {
        postService.updatePost(postId, userId, request.getTitle(), request.getContent(),
                request.getTags(), request.getPostType());
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{postId}")
    @Operation(summary = "删除帖子")
    public BaseResponse<Void> deletePost(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long postId) {
        postService.deletePost(postId, userId);
        return ResultUtils.success(null);
    }

    @GetMapping("/{postId}")
    @Operation(summary = "获取帖子详情")
    public BaseResponse<PostDetailResponse> getPostDetail(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long postId) {
        Post post = postService.getPostDetail(postId);
        boolean hasThumb = userId != null && postService.hasThumb(postId, userId);
        boolean hasFavour = userId != null && postService.hasFavour(postId, userId);
        return ResultUtils.success(PostDetailResponse.from(post, hasThumb, hasFavour));
    }

    @GetMapping
    @Operation(summary = "分页获取帖子列表")
    public BaseResponse<PostPageResponse> getPostList(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        return ResultUtils.success(PostPageResponse.from(postService.getPostList(pageNum, pageSize)));
    }

    @GetMapping("/type/{postType}")
    @Operation(summary = "根据类型获取帖子列表")
    public BaseResponse<PostPageResponse> getPostListByType(
            @PathVariable String postType,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        return ResultUtils.success(PostPageResponse.from(postService.getPostListByType(postType, pageNum, pageSize)));
    }

    @GetMapping("/search")
    @Operation(summary = "搜索帖子")
    public BaseResponse<PostPageResponse> searchPosts(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        return ResultUtils.success(PostPageResponse.from(postService.searchPosts(keyword, pageNum, pageSize)));
    }

    @GetMapping("/tag")
    @Operation(summary = "根据标签搜索帖子")
    public BaseResponse<PostPageResponse> searchPostsByTag(
            @RequestParam String tag,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        return ResultUtils.success(PostPageResponse.from(postService.searchPostsByTag(tag, pageNum, pageSize)));
    }

    @GetMapping("/my")
    @Operation(summary = "获取我的帖子列表")
    public BaseResponse<List<PostResponse>> getMyPosts(@AuthenticationPrincipal Long userId) {
        List<Post> posts = postService.getUserPosts(userId);
        return ResultUtils.success(posts.stream().map(PostResponse::from).toList());
    }

    @GetMapping("/user/{targetUserId}")
    @Operation(summary = "获取指定用户的帖子列表")
    public BaseResponse<List<PostResponse>> getUserPosts(@PathVariable Long targetUserId) {
        List<Post> posts = postService.getUserPosts(targetUserId);
        return ResultUtils.success(posts.stream().map(PostResponse::from).toList());
    }

    @GetMapping("/favourites")
    @Operation(summary = "获取我收藏的帖子")
    public BaseResponse<PostPageResponse> getMyFavourites(
            @AuthenticationPrincipal Long userId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        return ResultUtils.success(PostPageResponse.from(postService.getUserFavourites(userId, pageNum, pageSize)));
    }

    // ==================== 点赞功能 ====================

    @PostMapping("/{postId}/thumb")
    @Operation(summary = "点赞/取消点赞帖子")
    public BaseResponse<Boolean> toggleThumb(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long postId) {
        boolean result = postService.toggleThumb(postId, userId);
        return ResultUtils.success(result);
    }

    // ==================== 收藏功能 ====================

    @PostMapping("/{postId}/favour")
    @Operation(summary = "收藏/取消收藏帖子")
    public BaseResponse<Boolean> toggleFavour(
            @AuthenticationPrincipal Long userId,
            @PathVariable Long postId) {
        boolean result = postService.toggleFavour(postId, userId);
        return ResultUtils.success(result);
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
