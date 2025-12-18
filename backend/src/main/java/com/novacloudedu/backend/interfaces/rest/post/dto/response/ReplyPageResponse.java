package com.novacloudedu.backend.interfaces.rest.post.dto.response;

import com.novacloudedu.backend.domain.post.repository.PostCommentReplyRepository;
import lombok.Data;

import java.util.List;

/**
 * 回复分页响应
 */
@Data
public class ReplyPageResponse {

    private List<ReplyResponse> replies;
    private Long total;
    private Integer pageNum;
    private Integer pageSize;
    private Integer totalPages;

    public static ReplyPageResponse from(PostCommentReplyRepository.ReplyPage page) {
        ReplyPageResponse response = new ReplyPageResponse();
        response.setReplies(page.replies().stream().map(ReplyResponse::from).toList());
        response.setTotal(page.total());
        response.setPageNum(page.pageNum());
        response.setPageSize(page.pageSize());
        response.setTotalPages(page.getTotalPages());
        return response;
    }
}
