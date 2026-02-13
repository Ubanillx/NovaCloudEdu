package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PaperQuestionPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 试卷题目关联数据库操作Mapper
 */
@Mapper
public interface PaperQuestionMapper extends BaseMapper<PaperQuestionPO> {

}
