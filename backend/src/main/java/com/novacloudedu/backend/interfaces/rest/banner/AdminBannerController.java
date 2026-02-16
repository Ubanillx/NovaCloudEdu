package com.novacloudedu.backend.interfaces.rest.banner;

import com.novacloudedu.backend.application.banner.command.CreateBannerCommand;
import com.novacloudedu.backend.application.banner.command.GenerateBannerImageCommand;
import com.novacloudedu.backend.application.banner.command.UpdateBannerCommand;
import com.novacloudedu.backend.application.banner.query.BannerQuery;
import com.novacloudedu.backend.infrastructure.ai.ImageGenerationService;
import com.novacloudedu.backend.application.service.BannerApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.banner.entity.Banner;
import com.novacloudedu.backend.domain.banner.repository.BannerRepository.BannerPage;
import com.novacloudedu.backend.interfaces.rest.banner.assembler.BannerAssembler;
import com.novacloudedu.backend.interfaces.rest.banner.dto.request.CreateBannerRequest;
import com.novacloudedu.backend.interfaces.rest.banner.dto.request.QueryBannerRequest;
import com.novacloudedu.backend.interfaces.rest.banner.dto.request.GenerateBannerImageRequest;
import com.novacloudedu.backend.interfaces.rest.banner.dto.request.UpdateBannerRequest;
import com.novacloudedu.backend.interfaces.rest.banner.dto.response.BannerPageResponse;
import com.novacloudedu.backend.interfaces.rest.banner.dto.response.BannerResponse;
import com.novacloudedu.backend.interfaces.rest.banner.dto.response.GenerateBannerImageResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 轮播图管理控制器（管理员）
 */
@Tag(name = "轮播图管理", description = "管理员轮播图管理接口")
@RestController
@RequestMapping("/api/admin/banner")
@RequiredArgsConstructor
@Slf4j
@PreAuthorize("hasRole('ADMIN')")
public class AdminBannerController {

    private final BannerApplicationService bannerApplicationService;
    private final BannerAssembler bannerAssembler;

    /**
     * 创建轮播图
     */
    @Operation(summary = "创建轮播图", description = "创建新的轮播图")
    @PostMapping
    public BaseResponse<Long> createBanner(@Valid @RequestBody CreateBannerRequest request) {
        CreateBannerCommand command = bannerAssembler.toCreateCommand(request);
        Long id = bannerApplicationService.createBanner(command);
        return ResultUtils.success(id);
    }

    /**
     * 更新轮播图
     */
    @Operation(summary = "更新轮播图", description = "更新轮播图信息")
    @PutMapping
    public BaseResponse<Boolean> updateBanner(@Valid @RequestBody UpdateBannerRequest request) {
        UpdateBannerCommand command = bannerAssembler.toUpdateCommand(request);
        bannerApplicationService.updateBanner(command);
        return ResultUtils.success(true);
    }

    /**
     * 删除轮播图
     */
    @Operation(summary = "删除轮播图", description = "删除指定轮播图")
    @DeleteMapping("/{id}")
    public BaseResponse<Boolean> deleteBanner(@PathVariable Long id) {
        bannerApplicationService.deleteBanner(id);
        return ResultUtils.success(true);
    }

    /**
     * 获取轮播图详情
     */
    @Operation(summary = "获取轮播图详情", description = "获取轮播图详细信息")
    @GetMapping("/{id}")
    public BaseResponse<BannerResponse> getBannerDetail(@PathVariable Long id) {
        Banner banner = bannerApplicationService.getBannerById(id);
        return ResultUtils.success(bannerAssembler.toResponse(banner));
    }

    /**
     * 分页查询轮播图
     */
    @Operation(summary = "分页查询轮播图", description = "分页查询轮播图列表")
    @GetMapping("/list")
    public BaseResponse<BannerPageResponse> queryBanners(QueryBannerRequest request) {
        BannerQuery query = bannerAssembler.toQuery(request);
        BannerPage page = bannerApplicationService.queryBanners(query);
        return ResultUtils.success(bannerAssembler.toPageResponse(page));
    }

    /**
     * 发布轮播图
     */
    @Operation(summary = "发布轮播图", description = "将轮播图状态设置为已发布")
    @PostMapping("/{id}/publish")
    public BaseResponse<Boolean> publishBanner(@PathVariable Long id) {
        bannerApplicationService.publishBanner(id);
        return ResultUtils.success(true);
    }

    /**
     * 下线轮播图
     */
    @Operation(summary = "下线轮播图", description = "将轮播图状态设置为已下线")
    @PostMapping("/{id}/offline")
    public BaseResponse<Boolean> offlineBanner(@PathVariable Long id) {
        bannerApplicationService.offlineBanner(id);
        return ResultUtils.success(true);
    }

    /**
     * AI生成轮播图图片
     */
    @Operation(summary = "AI生成轮播图图片", description = "根据标题和图片描述，使用AI生成轮播图图片")
    @PostMapping("/generate-image")
    public BaseResponse<GenerateBannerImageResponse> generateBannerImage(
            @Valid @RequestBody GenerateBannerImageRequest request) {
        GenerateBannerImageCommand command = bannerAssembler.toGenerateImageCommand(request);
        ImageGenerationService.ImageResult result = bannerApplicationService.generateBannerImage(command);
        if (result.success()) {
            return ResultUtils.success(GenerateBannerImageResponse.success(result.imageUrl()));
        } else {
            return ResultUtils.success(GenerateBannerImageResponse.failure(result.errorMessage()));
        }
    }
}
