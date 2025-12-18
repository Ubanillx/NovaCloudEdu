package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.UserFeedbackPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户反馈Mapper
 */
@Mapper
public interface UserFeedbackMapper extends BaseMapper<UserFeedbackPO> {

}
