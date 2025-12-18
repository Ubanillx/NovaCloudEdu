package com.novacloudedu.backend.interfaces.rest.post.dto.response;

import com.novacloudedu.backend.domain.post.repository.PostRepository;
import lombok.Data;

import java.util.List;

/**
 * 帖子分页响应
 */
@Data
public class PostPageResponse {

    private List<PostResponse> posts;
    private Long total;
    private Integer pageNum;
    private Integer pageSize;
    private Integer totalPages;

    public static PostPageResponse from(PostRepository.PostPage page) {
        PostPageResponse response = new PostPageResponse();
        response.setPosts(page.posts().stream().map(PostResponse::from).toList());
        response.setTotal(page.total());
        response.setPageNum(page.pageNum());
        response.setPageSize(page.pageSize());
        response.setTotalPages(page.getTotalPages());
        return response;
    }
}
