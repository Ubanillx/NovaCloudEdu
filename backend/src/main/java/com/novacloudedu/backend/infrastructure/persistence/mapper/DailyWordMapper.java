package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.DailyWordPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DailyWordMapper extends BaseMapper<DailyWordPO> {

    @Select("""
            SELECT category
            FROM daily_word
            WHERE is_delete = 0
              AND category IS NOT NULL
              AND btrim(category) <> ''
            GROUP BY category
            ORDER BY MIN(id)
            """)
    List<String> selectCategories();
}
