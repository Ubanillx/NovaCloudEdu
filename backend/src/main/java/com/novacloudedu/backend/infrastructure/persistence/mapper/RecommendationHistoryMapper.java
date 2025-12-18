package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.RecommendationHistoryPO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RecommendationHistoryMapper extends BaseMapper<RecommendationHistoryPO> {
}
