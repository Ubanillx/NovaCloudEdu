package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.banner.command.CreateBannerCommand;
import com.novacloudedu.backend.application.banner.command.UpdateBannerCommand;
import com.novacloudedu.backend.application.banner.query.BannerQuery;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.banner.entity.Banner;
import com.novacloudedu.backend.domain.banner.repository.BannerRepository;
import com.novacloudedu.backend.domain.banner.repository.BannerRepository.BannerPage;
import com.novacloudedu.backend.domain.banner.repository.BannerRepository.BannerQueryCondition;
import com.novacloudedu.backend.domain.banner.valueobject.BannerId;
import com.novacloudedu.backend.domain.banner.valueobject.BannerStatus;
import com.novacloudedu.backend.domain.banner.valueobject.LinkType;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 轮播图应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class BannerApplicationService {

    private final BannerRepository bannerRepository;
    private final UserApplicationService userApplicationService;

    // ==================== 管理员功能 ====================

    /**
     * 创建轮播图
     */
    @Transactional
    public Long createBanner(CreateBannerCommand command) {
        User admin = userApplicationService.getCurrentUser();

        LinkType linkType = command.linkType() != null 
                ? LinkType.fromCode(command.linkType()) 
                : LinkType.NONE;

        Banner banner = Banner.create(
                command.title(),
                command.imageUrl(),
                linkType,
                command.linkUrl(),
                command.sort(),
                command.startTime(),
                command.endTime(),
                admin.getId().value()
        );

        bannerRepository.save(banner);
        log.info("管理员[{}]创建轮播图: {}", admin.getId().value(), banner.getId().value());
        return banner.getId().value();
    }

    /**
     * 更新轮播图
     */
    @Transactional
    public void updateBanner(UpdateBannerCommand command) {
        Banner banner = bannerRepository.findById(BannerId.of(command.id()))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "轮播图不存在"));

        LinkType linkType = command.linkType() != null 
                ? LinkType.fromCode(command.linkType()) 
                : banner.getLinkType();

        banner.update(
                command.title(),
                command.imageUrl(),
                linkType,
                command.linkUrl(),
                command.sort(),
                command.startTime(),
                command.endTime()
        );

        // 如果提供了状态，更新状态
        if (command.status() != null) {
            banner.updateStatus(BannerStatus.fromCode(command.status()));
        }

        bannerRepository.save(banner);
        log.info("更新轮播图: {}", command.id());
    }

    /**
     * 删除轮播图
     */
    @Transactional
    public void deleteBanner(Long id) {
        BannerId bannerId = BannerId.of(id);
        bannerRepository.findById(bannerId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "轮播图不存在"));

        bannerRepository.delete(bannerId);
        log.info("删除轮播图: {}", id);
    }

    /**
     * 发布轮播图
     */
    @Transactional
    public void publishBanner(Long id) {
        Banner banner = bannerRepository.findById(BannerId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "轮播图不存在"));

        banner.publish();
        bannerRepository.save(banner);
        log.info("发布轮播图: {}", id);
    }

    /**
     * 下线轮播图
     */
    @Transactional
    public void offlineBanner(Long id) {
        Banner banner = bannerRepository.findById(BannerId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "轮播图不存在"));

        banner.offline();
        bannerRepository.save(banner);
        log.info("下线轮播图: {}", id);
    }

    /**
     * 获取轮播图详情（管理员）
     */
    @Transactional(readOnly = true)
    public Banner getBannerById(Long id) {
        return bannerRepository.findById(BannerId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "轮播图不存在"));
    }

    /**
     * 分页查询轮播图（管理员）
     */
    @Transactional(readOnly = true)
    public BannerPage queryBanners(BannerQuery query) {
        BannerStatus status = query.status() != null
                ? BannerStatus.fromCode(query.status())
                : null;

        BannerQueryCondition condition = BannerQueryCondition.of(
                query.title(),
                status,
                query.adminId(),
                query.pageNum(),
                query.pageSize()
        );
        return bannerRepository.findByCondition(condition);
    }

    // ==================== 用户功能 ====================

    /**
     * 获取用户可见的轮播图列表
     */
    @Transactional(readOnly = true)
    public List<Banner> getVisibleBanners() {
        return bannerRepository.findVisibleBanners();
    }
}
