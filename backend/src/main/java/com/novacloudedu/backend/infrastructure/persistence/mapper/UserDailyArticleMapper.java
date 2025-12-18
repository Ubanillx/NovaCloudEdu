package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserDailyArticlePO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserDailyArticleMapper extends BaseMapper<UserDailyArticlePO> {
}
