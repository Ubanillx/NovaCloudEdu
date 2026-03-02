package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.KnowledgePointPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 知识点 Mapper
 */
@Mapper
public interface KnowledgePointMapper extends BaseMapper<KnowledgePointPO> {

    /**
     * 查找章节的所有知识点
     */
    @Select("SELECT * FROM knowledge_point WHERE chapter_id = #{chapterId} AND is_delete = 0 ORDER BY create_time DESC")
    List<KnowledgePointPO> findByChapterId(@Param("chapterId") Long chapterId);

    /**
     * 查找章节特定类型的知识点
     */
    @Select("SELECT * FROM knowledge_point WHERE chapter_id = #{chapterId} AND point_type = #{pointType} AND is_delete = 0 ORDER BY create_time DESC")
    List<KnowledgePointPO> findByChapterIdAndType(@Param("chapterId") Long chapterId, 
                                                    @Param("pointType") String pointType);

    /**
     * 按名称搜索知识点
     */
    @Select("SELECT * FROM knowledge_point WHERE name LIKE CONCAT('%', #{keyword}, '%') AND is_delete = 0 ORDER BY create_time DESC LIMIT #{limit} OFFSET #{offset}")
    List<KnowledgePointPO> searchByName(@Param("keyword") String keyword, 
                                         @Param("offset") int offset, 
                                         @Param("limit") int limit);

    /**
     * 删除章节的所有知识点
     */
    @Update("UPDATE knowledge_point SET is_delete = 1 WHERE chapter_id = #{chapterId}")
    int deleteByChapterId(@Param("chapterId") Long chapterId);
}
