package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ReadingQuizPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 阅读测试 Mapper
 */
@Mapper
public interface ReadingQuizMapper extends BaseMapper<ReadingQuizPO> {

    /**
     * 查找章节的所有测试
     */
    List<ReadingQuizPO> findByChapterId(@Param("chapterId") Long chapterId);

    /**
     * 查找章节的最新测试
     */
    ReadingQuizPO findLatestByChapterId(@Param("chapterId") Long chapterId);

    /**
     * 删除章节的所有测试
     */
    int deleteByChapterId(@Param("chapterId") Long chapterId);
}
