package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.banner.entity.Banner;
import com.novacloudedu.backend.domain.banner.repository.BannerRepository;
import com.novacloudedu.backend.domain.banner.valueobject.BannerId;
import com.novacloudedu.backend.domain.banner.valueobject.BannerStatus;
import com.novacloudedu.backend.infrastructure.persistence.converter.BannerConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.BannerMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.BannerPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * 轮播图仓储实现
 */
@Repository
@RequiredArgsConstructor
public class BannerRepositoryImpl implements BannerRepository {

    private final BannerMapper bannerMapper;
    private final BannerConverter bannerConverter;

    @Override
    public Banner save(Banner banner) {
        BannerPO po = bannerConverter.toPO(banner);
        if (banner.getId() == null) {
            bannerMapper.insert(po);
            banner.assignId(BannerId.of(po.getId()));
        } else {
            bannerMapper.updateById(po);
        }
        return banner;
    }

    @Override
    public Optional<Banner> findById(BannerId id) {
        BannerPO po = bannerMapper.selectById(id.value());
        return Optional.ofNullable(bannerConverter.toDomain(po));
    }

    @Override
    public void delete(BannerId id) {
        bannerMapper.deleteById(id.value());
    }

    @Override
    public BannerPage findByCondition(BannerQueryCondition condition) {
        LambdaQueryWrapper<BannerPO> wrapper = new LambdaQueryWrapper<>();

        if (StringUtils.hasText(condition.title())) {
            wrapper.like(BannerPO::getTitle, condition.title());
        }
        if (condition.status() != null) {
            wrapper.eq(BannerPO::getStatus, condition.status().getCode());
        }
        if (condition.adminId() != null) {
            wrapper.eq(BannerPO::getAdminId, condition.adminId());
        }

        wrapper.orderByDesc(BannerPO::getSort)
               .orderByDesc(BannerPO::getCreateTime);

        Page<BannerPO> page = new Page<>(condition.pageNum(), condition.pageSize());
        Page<BannerPO> resultPage = bannerMapper.selectPage(page, wrapper);

        List<Banner> banners = resultPage.getRecords().stream()
                .map(bannerConverter::toDomain)
                .toList();

        return new BannerPage(banners, resultPage.getTotal(),
                condition.pageNum(), condition.pageSize());
    }

    @Override
    public List<Banner> findVisibleBanners() {
        LocalDateTime now = LocalDateTime.now();

        LambdaQueryWrapper<BannerPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BannerPO::getStatus, BannerStatus.PUBLISHED.getCode())
               .and(w -> w.isNull(BannerPO::getStartTime)
                       .or()
                       .le(BannerPO::getStartTime, now))
               .and(w -> w.isNull(BannerPO::getEndTime)
                       .or()
                       .ge(BannerPO::getEndTime, now))
               .orderByDesc(BannerPO::getSort)
               .orderByDesc(BannerPO::getCreateTime);

        List<BannerPO> poList = bannerMapper.selectList(wrapper);

        return poList.stream()
                .map(bannerConverter::toDomain)
                .toList();
    }
}
