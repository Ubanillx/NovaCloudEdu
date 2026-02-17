package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ReadingBookmarkPO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReadingBookmarkMapper extends BaseMapper<ReadingBookmarkPO> {
}
