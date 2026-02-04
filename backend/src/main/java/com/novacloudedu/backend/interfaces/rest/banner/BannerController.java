package com.novacloudedu.backend.interfaces.rest.banner;

import com.novacloudedu.backend.application.service.BannerApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.banner.entity.Banner;
import com.novacloudedu.backend.interfaces.rest.banner.assembler.BannerAssembler;
import com.novacloudedu.backend.interfaces.rest.banner.dto.response.BannerListResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 轮播图控制器（用户端）
 */
@Tag(name = "轮播图", description = "用户端轮播图接口")
@RestController
@RequestMapping("/api/banner")
@RequiredArgsConstructor
@Slf4j
public class BannerController {

    private final BannerApplicationService bannerApplicationService;
    private final BannerAssembler bannerAssembler;

    /**
     * 获取轮播图列表
     */
    @Operation(summary = "获取轮播图列表", description = "获取用户可见的轮播图列表")
    @GetMapping("/list")
    public BaseResponse<List<BannerListResponse>> getBannerList() {
        List<Banner> banners = bannerApplicationService.getVisibleBanners();
        return ResultUtils.success(bannerAssembler.toListResponses(banners));
    }
}
