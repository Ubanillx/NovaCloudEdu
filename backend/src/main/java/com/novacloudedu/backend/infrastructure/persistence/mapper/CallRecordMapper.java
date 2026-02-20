package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.CallRecordPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 通话记录 Mapper
 */
@Mapper
public interface CallRecordMapper extends BaseMapper<CallRecordPO> {
}
