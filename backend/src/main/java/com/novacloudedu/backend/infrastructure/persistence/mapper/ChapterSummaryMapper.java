package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ChapterSummaryPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 章节总结 Mapper
 */
@Mapper
public interface ChapterSummaryMapper extends BaseMapper<ChapterSummaryPO> {

    /**
     * 查找章节的特定类型总结
     */
    @Select("SELECT * FROM chapter_summary WHERE chapter_id = #{chapterId} AND summary_type = #{summaryType} AND is_delete = 0 LIMIT 1")
    ChapterSummaryPO findByChapterIdAndType(@Param("chapterId") Long chapterId, 
                                             @Param("summaryType") String summaryType);

    /**
     * 查找章节的所有总结
     */
    @Select("SELECT * FROM chapter_summary WHERE chapter_id = #{chapterId} AND is_delete = 0 ORDER BY create_time DESC")
    List<ChapterSummaryPO> findByChapterId(@Param("chapterId") Long chapterId);

    /**
     * 检查总结是否存在
     */
    @Select("SELECT COUNT(*) FROM chapter_summary WHERE chapter_id = #{chapterId} AND summary_type = #{summaryType} AND is_delete = 0")
    int countByChapterIdAndType(@Param("chapterId") Long chapterId, 
                                @Param("summaryType") String summaryType);
}
