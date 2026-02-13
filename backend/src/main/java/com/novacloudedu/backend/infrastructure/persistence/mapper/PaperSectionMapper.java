package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PaperSectionPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 试卷大题数据库操作Mapper
 */
@Mapper
public interface PaperSectionMapper extends BaseMapper<PaperSectionPO> {

}
