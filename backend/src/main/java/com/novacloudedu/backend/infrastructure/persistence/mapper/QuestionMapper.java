package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.QuestionPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 题目数据库操作Mapper
 */
@Mapper
public interface QuestionMapper extends BaseMapper<QuestionPO> {

}
