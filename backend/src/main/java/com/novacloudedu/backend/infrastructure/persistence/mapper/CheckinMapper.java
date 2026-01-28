package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.novacloudedu.backend.infrastructure.persistence.po.UserCheckinPO;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCheckinStatsPO;
import org.apache.ibatis.annotations.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * 打卡 Mapper
 */
@Mapper
public interface CheckinMapper {

    @Insert("INSERT INTO user_checkin (user_id, checkin_date, checkin_time, streak_days, create_time) " +
            "VALUES (#{userId}, #{checkinDate}, #{checkinTime}, #{streakDays}, #{createTime})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertCheckin(UserCheckinPO po);

    @Select("SELECT * FROM user_checkin WHERE user_id = #{userId} AND checkin_date = #{checkinDate}")
    UserCheckinPO selectByUserIdAndDate(@Param("userId") Long userId, @Param("checkinDate") LocalDate checkinDate);

    @Select("SELECT * FROM user_checkin WHERE user_id = #{userId} ORDER BY checkin_date DESC LIMIT #{size} OFFSET #{offset}")
    List<UserCheckinPO> selectCheckinHistory(@Param("userId") Long userId, @Param("offset") int offset, @Param("size") int size);

    @Insert("INSERT INTO user_checkin_stats (user_id, total_checkin_days, current_streak, max_streak, last_checkin_date, update_time) " +
            "VALUES (#{userId}, #{totalCheckinDays}, #{currentStreak}, #{maxStreak}, #{lastCheckinDate}, #{updateTime})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertStats(UserCheckinStatsPO po);

    @Update("UPDATE user_checkin_stats SET total_checkin_days = #{totalCheckinDays}, current_streak = #{currentStreak}, " +
            "max_streak = #{maxStreak}, last_checkin_date = #{lastCheckinDate}, update_time = #{updateTime} WHERE id = #{id}")
    int updateStats(UserCheckinStatsPO po);

    @Select("SELECT * FROM user_checkin_stats WHERE user_id = #{userId}")
    UserCheckinStatsPO selectStatsByUserId(@Param("userId") Long userId);

    @Select("SELECT s.user_id as userId, u.user_name as userName, u.user_avatar as userAvatar, " +
            "s.total_checkin_days as totalCheckinDays, s.current_streak as currentStreak " +
            "FROM user_checkin_stats s " +
            "LEFT JOIN \"user\" u ON s.user_id = u.id " +
            "ORDER BY s.total_checkin_days DESC " +
            "LIMIT #{limit}")
    List<Map<String, Object>> selectCheckinRanking(@Param("limit") int limit);
}
