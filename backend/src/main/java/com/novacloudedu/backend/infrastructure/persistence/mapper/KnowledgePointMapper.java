package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.KnowledgePointPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 知识点 Mapper
 */
@Mapper
public interface KnowledgePointMapper extends BaseMapper<KnowledgePointPO> {

    /**
     * 查找章节的所有知识点
     */
    List<KnowledgePointPO> findByChapterId(@Param("chapterId") Long chapterId);

    /**
     * 查找章节特定类型的知识点
     */
    List<KnowledgePointPO> findByChapterIdAndType(@Param("chapterId") Long chapterId, 
                                                    @Param("pointType") String pointType);

    /**
     * 按名称搜索知识点
     */
    List<KnowledgePointPO> searchByName(@Param("keyword") String keyword, 
                                         @Param("offset") int offset, 
                                         @Param("limit") int limit);

    /**
     * 删除章节的所有知识点
     */
    int deleteByChapterId(@Param("chapterId") Long chapterId);
}
