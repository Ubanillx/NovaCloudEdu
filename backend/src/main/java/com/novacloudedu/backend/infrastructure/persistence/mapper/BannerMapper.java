package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.BannerPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 轮播图Mapper
 */
@Mapper
public interface BannerMapper extends BaseMapper<BannerPO> {
}
