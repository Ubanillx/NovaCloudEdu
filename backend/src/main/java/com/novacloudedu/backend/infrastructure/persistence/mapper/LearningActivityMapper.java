package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.novacloudedu.backend.infrastructure.persistence.po.LearningActivityPO;
import org.apache.ibatis.annotations.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * 学习活动 Mapper
 */
@Mapper
public interface LearningActivityMapper {

    @Insert("INSERT INTO learning_activity (user_id, activity_type, reference_id, subject, class_id, " +
            "duration_sec, score, max_score, detail, activity_date, create_time) " +
            "VALUES (#{userId}, #{activityType}, #{referenceId}, #{subject}, #{classId}, " +
            "#{durationSec}, #{score}, #{maxScore}, #{detail}::jsonb, #{activityDate}, #{createTime})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(LearningActivityPO po);

    @Select("SELECT * FROM learning_activity WHERE user_id = #{userId} " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "ORDER BY create_time DESC")
    List<LearningActivityPO> selectByUserIdAndDateRange(@Param("userId") Long userId,
                                                         @Param("startDate") LocalDate startDate,
                                                         @Param("endDate") LocalDate endDate);

    @Select("SELECT COALESCE(SUM(duration_sec), 0) FROM learning_activity " +
            "WHERE user_id = #{userId} AND activity_date >= #{startDate} AND activity_date <= #{endDate}")
    long sumDurationByUserIdAndDateRange(@Param("userId") Long userId,
                                          @Param("startDate") LocalDate startDate,
                                          @Param("endDate") LocalDate endDate);

    @Select("SELECT activity_type, COUNT(*) as cnt FROM learning_activity " +
            "WHERE user_id = #{userId} AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY activity_type")
    List<Map<String, Object>> countByTypeAndUserIdAndDateRange(@Param("userId") Long userId,
                                                                @Param("startDate") LocalDate startDate,
                                                                @Param("endDate") LocalDate endDate);

    // ==================== 按日/周/月聚合（个人） ====================

    @Select("SELECT activity_date::text as period, COUNT(*) as activity_count, COALESCE(SUM(duration_sec), 0) as total_duration_sec " +
            "FROM learning_activity WHERE user_id = #{userId} " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY activity_date ORDER BY activity_date")
    List<Map<String, Object>> aggregateByDay(@Param("userId") Long userId,
                                              @Param("startDate") LocalDate startDate,
                                              @Param("endDate") LocalDate endDate);

    @Select("SELECT TO_CHAR(DATE_TRUNC('week', activity_date), 'IYYY-IW') as period, " +
            "COUNT(*) as activity_count, COALESCE(SUM(duration_sec), 0) as total_duration_sec " +
            "FROM learning_activity WHERE user_id = #{userId} " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY DATE_TRUNC('week', activity_date) ORDER BY DATE_TRUNC('week', activity_date)")
    List<Map<String, Object>> aggregateByWeek(@Param("userId") Long userId,
                                               @Param("startDate") LocalDate startDate,
                                               @Param("endDate") LocalDate endDate);

    @Select("SELECT TO_CHAR(DATE_TRUNC('month', activity_date), 'YYYY-MM') as period, " +
            "COUNT(*) as activity_count, COALESCE(SUM(duration_sec), 0) as total_duration_sec " +
            "FROM learning_activity WHERE user_id = #{userId} " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY DATE_TRUNC('month', activity_date) ORDER BY DATE_TRUNC('month', activity_date)")
    List<Map<String, Object>> aggregateByMonth(@Param("userId") Long userId,
                                                @Param("startDate") LocalDate startDate,
                                                @Param("endDate") LocalDate endDate);

    // ==================== 班级维度 ====================

    @Select("SELECT COALESCE(SUM(duration_sec), 0) FROM learning_activity " +
            "WHERE class_id = #{classId} AND activity_date >= #{startDate} AND activity_date <= #{endDate}")
    long sumDurationByClassIdAndDateRange(@Param("classId") Long classId,
                                           @Param("startDate") LocalDate startDate,
                                           @Param("endDate") LocalDate endDate);

    @Select("SELECT activity_type, COUNT(*) as cnt FROM learning_activity " +
            "WHERE class_id = #{classId} AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY activity_type")
    List<Map<String, Object>> countByTypeAndClassIdAndDateRange(@Param("classId") Long classId,
                                                                 @Param("startDate") LocalDate startDate,
                                                                 @Param("endDate") LocalDate endDate);

    @Select("SELECT user_id, COUNT(*) as activity_count, COALESCE(SUM(duration_sec), 0) as total_duration_sec " +
            "FROM learning_activity WHERE class_id = #{classId} " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY user_id")
    List<Map<String, Object>> getMemberActivitySummaries(@Param("classId") Long classId,
                                                          @Param("startDate") LocalDate startDate,
                                                          @Param("endDate") LocalDate endDate);

    @Select("SELECT user_id, COALESCE(SUM(score), 0) as total_score, COALESCE(SUM(max_score), 0) as total_max_score, " +
            "COUNT(*) as submit_count FROM learning_activity " +
            "WHERE class_id = #{classId} AND activity_type = 'HOMEWORK_SUBMIT' AND score IS NOT NULL " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY user_id")
    List<Map<String, Object>> getMemberScoreSummaries(@Param("classId") Long classId,
                                                       @Param("startDate") LocalDate startDate,
                                                       @Param("endDate") LocalDate endDate);

    // ==================== 按日/周/月聚合（班级） ====================

    @Select("SELECT activity_date::text as period, COUNT(*) as activity_count, COALESCE(SUM(duration_sec), 0) as total_duration_sec " +
            "FROM learning_activity WHERE class_id = #{classId} " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY activity_date ORDER BY activity_date")
    List<Map<String, Object>> aggregateByDayForClass(@Param("classId") Long classId,
                                                      @Param("startDate") LocalDate startDate,
                                                      @Param("endDate") LocalDate endDate);

    @Select("SELECT TO_CHAR(DATE_TRUNC('week', activity_date), 'IYYY-IW') as period, " +
            "COUNT(*) as activity_count, COALESCE(SUM(duration_sec), 0) as total_duration_sec " +
            "FROM learning_activity WHERE class_id = #{classId} " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY DATE_TRUNC('week', activity_date) ORDER BY DATE_TRUNC('week', activity_date)")
    List<Map<String, Object>> aggregateByWeekForClass(@Param("classId") Long classId,
                                                       @Param("startDate") LocalDate startDate,
                                                       @Param("endDate") LocalDate endDate);

    @Select("SELECT TO_CHAR(DATE_TRUNC('month', activity_date), 'YYYY-MM') as period, " +
            "COUNT(*) as activity_count, COALESCE(SUM(duration_sec), 0) as total_duration_sec " +
            "FROM learning_activity WHERE class_id = #{classId} " +
            "AND activity_date >= #{startDate} AND activity_date <= #{endDate} " +
            "GROUP BY DATE_TRUNC('month', activity_date) ORDER BY DATE_TRUNC('month', activity_date)")
    List<Map<String, Object>> aggregateByMonthForClass(@Param("classId") Long classId,
                                                        @Param("startDate") LocalDate startDate,
                                                        @Param("endDate") LocalDate endDate);
}
