package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PptProjectDocumentPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * PPT项目文档 Mapper
 */
@Mapper
public interface PptProjectDocumentMapper extends BaseMapper<PptProjectDocumentPO> {
}
