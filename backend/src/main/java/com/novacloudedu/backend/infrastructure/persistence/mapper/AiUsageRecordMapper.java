package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiUsageRecordPO;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Map;

@Mapper
public interface AiUsageRecordMapper extends BaseMapper<AiUsageRecordPO> {

    @Select("SELECT COALESCE(SUM(usage_count), 0) FROM ai_usage_record " +
            "WHERE user_id = #{userId} AND feature_type = #{featureType} " +
            "AND usage_date >= MAKE_DATE(#{year}, #{month}, 1) " +
            "AND usage_date < MAKE_DATE(#{year}, #{month}, 1) + INTERVAL '1 month'")
    int sumMonthlyUsage(@Param("userId") Long userId,
                        @Param("featureType") String featureType,
                        @Param("year") int year,
                        @Param("month") int month);

    @MapKey("feature_type")
    @Select("SELECT feature_type, COALESCE(SUM(usage_count), 0) AS total " +
            "FROM ai_usage_record " +
            "WHERE user_id = #{userId} " +
            "AND usage_date >= MAKE_DATE(#{year}, #{month}, 1) " +
            "AND usage_date < MAKE_DATE(#{year}, #{month}, 1) + INTERVAL '1 month' " +
            "GROUP BY feature_type")
    Map<String, Map<String, Object>> sumAllMonthlyUsageRaw(@Param("userId") Long userId,
                                                           @Param("year") int year,
                                                           @Param("month") int month);
}
