package com.novacloudedu.backend.interfaces.rest.common;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "分页响应")
public class PageResponse<T> {

    @Schema(description = "数据列表")
    private List<T> list;

    @Schema(description = "总记录数")
    private long total;

    @Schema(description = "当前页码")
    private int pageNum;

    @Schema(description = "每页大小")
    private int pageSize;

    @Schema(description = "总页数")
    private int totalPages;

    public PageResponse(List<T> list, long total, int pageNum, int pageSize) {
        this.list = list;
        this.total = total;
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.totalPages = (int) Math.ceil((double) total / pageSize);
    }

    public static <T> PageResponse<T> of(List<T> list, long total, int pageNum, int pageSize) {
        return new PageResponse<>(list, total, pageNum, pageSize);
    }
}
