package com.novacloudedu.backend.interfaces.rest.common;

import com.novacloudedu.backend.application.service.LinkPreviewService;
import com.novacloudedu.backend.application.service.LinkPreviewService.LinkPreview;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 通用链接预览接口。
 */
@RestController
@RequestMapping("/api/link-preview")
@RequiredArgsConstructor
public class LinkPreviewController {

    private final LinkPreviewService linkPreviewService;

    @PostMapping
    public BaseResponse<LinkPreview> preview(@RequestBody @Valid LinkPreviewRequest request) {
        return ResultUtils.success(linkPreviewService.fetch(request.getUrl()));
    }

    @Data
    public static class LinkPreviewRequest {
        @NotBlank(message = "链接不能为空")
        @Size(max = 2048, message = "链接长度不能超过2048")
        private String url;
    }
}
