package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.FeedbackReplyPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 反馈回复Mapper
 */
@Mapper
public interface FeedbackReplyMapper extends BaseMapper<FeedbackReplyPO> {

}
