package com.novacloudedu.backend.interfaces.rest.post.dto.response;

import com.novacloudedu.backend.domain.post.repository.PostCommentRepository;
import lombok.Data;

import java.util.List;

/**
 * 评论分页响应
 */
@Data
public class CommentPageResponse {

    private List<CommentResponse> comments;
    private Long total;
    private Integer pageNum;
    private Integer pageSize;
    private Integer totalPages;

    public static CommentPageResponse from(PostCommentRepository.CommentPage page) {
        CommentPageResponse response = new CommentPageResponse();
        response.setComments(page.comments().stream().map(CommentResponse::from).toList());
        response.setTotal(page.total());
        response.setPageNum(page.pageNum());
        response.setPageSize(page.pageSize());
        response.setTotalPages(page.getTotalPages());
        return response;
    }
}
