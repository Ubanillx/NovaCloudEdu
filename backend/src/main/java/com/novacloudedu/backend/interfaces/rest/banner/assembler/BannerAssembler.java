package com.novacloudedu.backend.interfaces.rest.banner.assembler;

import com.novacloudedu.backend.application.banner.command.CreateBannerCommand;
import com.novacloudedu.backend.application.banner.command.GenerateBannerImageCommand;
import com.novacloudedu.backend.application.banner.command.UpdateBannerCommand;
import com.novacloudedu.backend.application.banner.query.BannerQuery;
import com.novacloudedu.backend.domain.banner.entity.Banner;
import com.novacloudedu.backend.domain.banner.repository.BannerRepository.BannerPage;
import com.novacloudedu.backend.interfaces.rest.banner.dto.request.CreateBannerRequest;
import com.novacloudedu.backend.interfaces.rest.banner.dto.request.GenerateBannerImageRequest;
import com.novacloudedu.backend.interfaces.rest.banner.dto.request.QueryBannerRequest;
import com.novacloudedu.backend.interfaces.rest.banner.dto.request.UpdateBannerRequest;
import com.novacloudedu.backend.interfaces.rest.banner.dto.response.BannerListResponse;
import com.novacloudedu.backend.interfaces.rest.banner.dto.response.BannerPageResponse;
import com.novacloudedu.backend.interfaces.rest.banner.dto.response.BannerResponse;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 轮播图组装器
 */
@Component
public class BannerAssembler {

    /**
     * 转换为创建命令
     */
    public CreateBannerCommand toCreateCommand(CreateBannerRequest request) {
        return new CreateBannerCommand(
                request.title(),
                request.imageUrl(),
                request.linkType(),
                request.linkUrl(),
                request.sort(),
                request.startTime(),
                request.endTime()
        );
    }

    /**
     * 转换为更新命令
     */
    public UpdateBannerCommand toUpdateCommand(UpdateBannerRequest request) {
        return new UpdateBannerCommand(
                request.id(),
                request.title(),
                request.imageUrl(),
                request.linkType(),
                request.linkUrl(),
                request.sort(),
                request.startTime(),
                request.endTime(),
                request.status()
        );
    }

    /**
     * 转换为查询参数
     */
    public BannerQuery toQuery(QueryBannerRequest request) {
        return new BannerQuery(
                request.title(),
                request.status(),
                request.adminId(),
                request.getPageNum(),
                request.getPageSize()
        );
    }

    /**
     * 转换为管理员响应
     */
    public BannerResponse toResponse(Banner banner) {
        return new BannerResponse(
                banner.getId().value(),
                banner.getTitle(),
                banner.getImageUrl(),
                banner.getLinkType().getCode(),
                banner.getLinkType().getDescription(),
                banner.getLinkUrl(),
                banner.getSort(),
                banner.getStatus().getCode(),
                banner.getStatus().getDescription(),
                banner.getStartTime(),
                banner.getEndTime(),
                banner.getAdminId(),
                banner.getCreateTime(),
                banner.getUpdateTime()
        );
    }

    /**
     * 转换为管理员分页响应
     */
    public BannerPageResponse toPageResponse(BannerPage page) {
        List<BannerResponse> records = page.banners().stream()
                .map(this::toResponse)
                .toList();

        return new BannerPageResponse(
                records,
                page.total(),
                page.pageNum(),
                page.pageSize(),
                page.getTotalPages()
        );
    }

    /**
     * 转换为用户列表响应
     */
    public BannerListResponse toListResponse(Banner banner) {
        return new BannerListResponse(
                banner.getId().value(),
                banner.getTitle(),
                banner.getImageUrl(),
                banner.getLinkType().getCode(),
                banner.getLinkUrl()
        );
    }

    /**
     * 转换为用户列表响应列表
     */
    public List<BannerListResponse> toListResponses(List<Banner> banners) {
        return banners.stream()
                .map(this::toListResponse)
                .toList();
    }

    /**
     * 转换为AI生成图片命令
     */
    public GenerateBannerImageCommand toGenerateImageCommand(GenerateBannerImageRequest request) {
        return new GenerateBannerImageCommand(
                request.title(),
                request.imageDescription()
        );
    }
}
