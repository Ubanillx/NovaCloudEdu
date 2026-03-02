package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ReadingQuizPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 阅读测试 Mapper
 */
@Mapper
public interface ReadingQuizMapper extends BaseMapper<ReadingQuizPO> {

    /**
     * 查找章节的所有测试
     */
    @Select("SELECT * FROM reading_quiz WHERE chapter_id = #{chapterId} AND is_delete = 0 ORDER BY create_time DESC")
    List<ReadingQuizPO> findByChapterId(@Param("chapterId") Long chapterId);

    /**
     * 查找章节的最新测试
     */
    @Select("SELECT * FROM reading_quiz WHERE chapter_id = #{chapterId} AND is_delete = 0 ORDER BY create_time DESC LIMIT 1")
    ReadingQuizPO findLatestByChapterId(@Param("chapterId") Long chapterId);

    /**
     * 删除章节的所有测试
     */
    @Update("UPDATE reading_quiz SET is_delete = 1 WHERE chapter_id = #{chapterId}")
    int deleteByChapterId(@Param("chapterId") Long chapterId);
}
