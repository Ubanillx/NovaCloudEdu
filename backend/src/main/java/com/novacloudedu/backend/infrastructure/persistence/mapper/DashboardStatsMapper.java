package com.novacloudedu.backend.infrastructure.persistence.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 仪表盘统计专用 Mapper（只读聚合查询）
 */
@Mapper
public interface DashboardStatsMapper {

    // ==================== 用户统计 ====================

    @Select("SELECT COUNT(*) FROM \"user\" WHERE is_delete = 0")
    long countTotalUsers();

    @Select("SELECT user_role, COUNT(*) as cnt FROM \"user\" WHERE is_delete = 0 GROUP BY user_role")
    List<Map<String, Object>> countUsersByRole();

    @Select("SELECT COUNT(*) FROM \"user\" WHERE is_delete = 0 AND create_time >= #{start} AND create_time < #{end}")
    long countNewUsers(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    // ==================== 课程统计 ====================

    @Select("SELECT COUNT(*) FROM course WHERE is_delete = 0")
    long countTotalCourses();

    @Select("SELECT status, COUNT(*) as cnt FROM course WHERE is_delete = 0 GROUP BY status")
    List<Map<String, Object>> countCoursesByStatus();

    @Select("SELECT COALESCE(SUM(student_count), 0) FROM course WHERE is_delete = 0")
    long sumCourseStudentCount();

    @Select("SELECT COALESCE(AVG(rating_score), 0) FROM course WHERE is_delete = 0 AND rating_score > 0")
    double avgCourseRating();

    @Select("SELECT id, title, student_count, rating_score FROM course WHERE is_delete = 0 AND status = 1 ORDER BY student_count DESC LIMIT 5")
    List<Map<String, Object>> topCoursesByStudentCount();

    // ==================== 订单/收入统计 ====================

    @Select("SELECT COUNT(*) FROM user_course WHERE is_delete = 0 AND create_time >= #{start} AND create_time < #{end}")
    long countOrders(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Select("SELECT COALESCE(SUM(price), 0) FROM user_course WHERE is_delete = 0 AND status = 1 AND payment_time >= #{start} AND payment_time < #{end}")
    double sumRevenue(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    // ==================== 会员统计 ====================

    @Select("SELECT COUNT(*) FROM user_membership WHERE is_delete = 0 AND status = 1")
    long countActiveMembers();

    @Select("SELECT mp.name, COUNT(*) as cnt FROM user_membership um " +
            "JOIN membership_plan mp ON um.plan_id = mp.id " +
            "WHERE um.is_delete = 0 AND um.status = 1 GROUP BY mp.name")
    List<Map<String, Object>> countMembersByPlan();

    @Select("SELECT COUNT(*) FROM user_membership WHERE is_delete = 0 AND status = 1 " +
            "AND expire_time IS NOT NULL AND expire_time BETWEEN #{now} AND #{deadline}")
    long countExpiringMembers(@Param("now") LocalDateTime now, @Param("deadline") LocalDateTime deadline);

    // ==================== 学情分析（learning_activity） ====================

    @Select("SELECT COUNT(DISTINCT user_id) FROM learning_activity WHERE activity_date = #{date}")
    long countDau(@Param("date") LocalDate date);

    @Select("SELECT activity_type, COUNT(*) as cnt FROM learning_activity " +
            "WHERE activity_date >= #{start} AND activity_date <= #{end} GROUP BY activity_type")
    List<Map<String, Object>> countActivityByType(@Param("start") LocalDate start, @Param("end") LocalDate end);

    @Select("SELECT COALESCE(SUM(duration_sec), 0) FROM learning_activity " +
            "WHERE activity_date >= #{start} AND activity_date <= #{end}")
    long sumTotalDuration(@Param("start") LocalDate start, @Param("end") LocalDate end);

    @Select("SELECT activity_date, COUNT(DISTINCT user_id) as dau, COALESCE(SUM(duration_sec), 0) as total_duration " +
            "FROM learning_activity WHERE activity_date >= #{start} AND activity_date <= #{end} " +
            "GROUP BY activity_date ORDER BY activity_date")
    List<Map<String, Object>> dailyActiveStats(@Param("start") LocalDate start, @Param("end") LocalDate end);

    @Select("SELECT user_id, COUNT(*) as activity_count, COALESCE(SUM(duration_sec), 0) as total_duration " +
            "FROM learning_activity WHERE activity_date >= #{start} AND activity_date <= #{end} " +
            "GROUP BY user_id ORDER BY activity_count DESC LIMIT 10")
    List<Map<String, Object>> topActiveUsers(@Param("start") LocalDate start, @Param("end") LocalDate end);

    @Select("SELECT class_id, COUNT(*) as activity_count FROM learning_activity " +
            "WHERE class_id IS NOT NULL AND activity_date >= #{start} AND activity_date <= #{end} " +
            "GROUP BY class_id ORDER BY activity_count DESC LIMIT 10")
    List<Map<String, Object>> topActiveClasses(@Param("start") LocalDate start, @Param("end") LocalDate end);

    @Select("SELECT CASE WHEN COALESCE(SUM(max_score), 0) = 0 THEN 0 " +
            "ELSE ROUND(COALESCE(SUM(score), 0) * 100.0 / SUM(max_score), 1) END " +
            "FROM learning_activity WHERE activity_type = 'HOMEWORK_SUBMIT' " +
            "AND activity_date >= #{start} AND activity_date <= #{end}")
    double avgHomeworkScoreRate(@Param("start") LocalDate start, @Param("end") LocalDate end);

    // ==================== 学情 — 教师班级范围 ====================

    @Select("SELECT COUNT(DISTINCT la.user_id) FROM learning_activity la " +
            "JOIN class_member cm ON la.user_id = cm.user_id " +
            "JOIN class_info ci ON cm.class_id = ci.id " +
            "WHERE ci.creator_id = #{teacherId} AND ci.is_delete = 0 AND la.activity_date = #{date}")
    long countDauByTeacher(@Param("teacherId") Long teacherId, @Param("date") LocalDate date);

    @Select("SELECT la.activity_type, COUNT(*) as cnt FROM learning_activity la " +
            "JOIN class_member cm ON la.user_id = cm.user_id " +
            "JOIN class_info ci ON cm.class_id = ci.id " +
            "WHERE ci.creator_id = #{teacherId} AND ci.is_delete = 0 " +
            "AND la.activity_date >= #{start} AND la.activity_date <= #{end} GROUP BY la.activity_type")
    List<Map<String, Object>> countActivityByTypeForTeacher(@Param("teacherId") Long teacherId,
                                                             @Param("start") LocalDate start,
                                                             @Param("end") LocalDate end);

    @Select("SELECT la.activity_date, COUNT(DISTINCT la.user_id) as dau, COALESCE(SUM(la.duration_sec), 0) as total_duration " +
            "FROM learning_activity la " +
            "JOIN class_member cm ON la.user_id = cm.user_id " +
            "JOIN class_info ci ON cm.class_id = ci.id " +
            "WHERE ci.creator_id = #{teacherId} AND ci.is_delete = 0 " +
            "AND la.activity_date >= #{start} AND la.activity_date <= #{end} " +
            "GROUP BY la.activity_date ORDER BY la.activity_date")
    List<Map<String, Object>> dailyActiveStatsForTeacher(@Param("teacherId") Long teacherId,
                                                          @Param("start") LocalDate start,
                                                          @Param("end") LocalDate end);

    @Select("SELECT la.user_id, COUNT(*) as activity_count, COALESCE(SUM(la.duration_sec), 0) as total_duration " +
            "FROM learning_activity la " +
            "JOIN class_member cm ON la.user_id = cm.user_id " +
            "JOIN class_info ci ON cm.class_id = ci.id " +
            "WHERE ci.creator_id = #{teacherId} AND ci.is_delete = 0 " +
            "AND la.activity_date >= #{start} AND la.activity_date <= #{end} " +
            "GROUP BY la.user_id ORDER BY activity_count DESC LIMIT 10")
    List<Map<String, Object>> topActiveUsersForTeacher(@Param("teacherId") Long teacherId,
                                                        @Param("start") LocalDate start,
                                                        @Param("end") LocalDate end);

    @Select("SELECT CASE WHEN COALESCE(SUM(la.max_score), 0) = 0 THEN 0 " +
            "ELSE ROUND(COALESCE(SUM(la.score), 0) * 100.0 / SUM(la.max_score), 1) END " +
            "FROM learning_activity la " +
            "JOIN class_member cm ON la.user_id = cm.user_id " +
            "JOIN class_info ci ON cm.class_id = ci.id " +
            "WHERE ci.creator_id = #{teacherId} AND ci.is_delete = 0 " +
            "AND la.activity_type = 'HOMEWORK_SUBMIT' " +
            "AND la.activity_date >= #{start} AND la.activity_date <= #{end}")
    double avgHomeworkScoreRateForTeacher(@Param("teacherId") Long teacherId,
                                          @Param("start") LocalDate start,
                                          @Param("end") LocalDate end);

    // ==================== 教师 — 班级与学生统计 ====================

    @Select("SELECT COUNT(*) FROM class_info WHERE creator_id = #{teacherId} AND is_delete = 0")
    long countClassesByTeacher(@Param("teacherId") Long teacherId);

    @Select("SELECT COUNT(DISTINCT cm.user_id) FROM class_member cm " +
            "JOIN class_info ci ON cm.class_id = ci.id " +
            "WHERE ci.creator_id = #{teacherId} AND ci.is_delete = 0")
    long countStudentsByTeacher(@Param("teacherId") Long teacherId);

    // ==================== 内容统计 ====================

    @Select("SELECT COUNT(*) FROM daily_article WHERE is_delete = 0")
    long countTotalArticles();

    @Select("SELECT COALESCE(SUM(view_count), 0) FROM daily_article WHERE is_delete = 0")
    long sumArticleViews();

    @Select("SELECT COALESCE(SUM(like_count), 0) FROM daily_article WHERE is_delete = 0")
    long sumArticleLikes();

    @Select("SELECT id, title, view_count, like_count FROM daily_article WHERE is_delete = 0 ORDER BY view_count DESC LIMIT 5")
    List<Map<String, Object>> topArticlesByViews();

    @Select("SELECT COUNT(*) FROM daily_word WHERE is_delete = 0")
    long countTotalWords();

    @Select("SELECT COUNT(*) FROM exam_paper WHERE is_delete = 0")
    long countTotalExamPapers();

    @Select("SELECT subject, COUNT(*) as cnt FROM exam_paper WHERE is_delete = 0 GROUP BY subject")
    List<Map<String, Object>> countExamPapersBySubject();

    @Select("SELECT COUNT(*) FROM question WHERE is_delete = 0")
    long countTotalQuestions();

    @Select("SELECT COUNT(*) FROM book WHERE is_delete = 0")
    long countTotalBooks();

    @Select("SELECT COUNT(*) FROM post WHERE is_delete = 0")
    long countTotalPosts();

    @Select("SELECT COUNT(*) FROM post WHERE is_delete = 0 AND create_time >= #{start} AND create_time < #{end}")
    long countNewPosts(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Select("SELECT COALESCE(SUM(thumb_num), 0) FROM post WHERE is_delete = 0")
    long sumPostLikes();

    @Select("SELECT COALESCE(SUM(comment_num), 0) FROM post WHERE is_delete = 0")
    long sumPostComments();

    @Select("SELECT id, title, thumb_num, comment_num FROM post WHERE is_delete = 0 ORDER BY thumb_num DESC LIMIT 5")
    List<Map<String, Object>> topPostsByLikes();

    // ==================== AI & 系统 ====================

    @Select("SELECT COUNT(*) FROM ai_chat_session WHERE is_delete = 0")
    long countTotalAiSessions();

    @Select("SELECT COUNT(*) FROM ai_chat_session WHERE is_delete = 0 AND create_time >= #{start} AND create_time < #{end}")
    long countNewAiSessions(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Select("SELECT COUNT(*) FROM ai_chat_message WHERE is_delete = 0")
    long countTotalAiMessages();

    @Select("SELECT COUNT(*) FROM ai_chat_message WHERE is_delete = 0 AND create_time >= #{start} AND create_time < #{end}")
    long countNewAiMessages(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Select("SELECT COUNT(*) FROM homework_submission WHERE is_delete = 0")
    long countTotalSubmissions();

    @Select("SELECT COUNT(*) FROM homework_submission WHERE is_delete = 0 AND create_time >= #{start} AND create_time < #{end}")
    long countNewSubmissions(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Select("SELECT status, COUNT(*) as cnt FROM homework_submission WHERE is_delete = 0 GROUP BY status")
    List<Map<String, Object>> countSubmissionsByStatus();

    @Select("SELECT subject, COUNT(*) as cnt FROM homework_submission WHERE is_delete = 0 AND subject IS NOT NULL GROUP BY subject")
    List<Map<String, Object>> countSubmissionsBySubject();

    @Select("SELECT COUNT(*) FROM ppt_generation_session WHERE is_delete = 0")
    long countTotalPptSessions();

    @Select("SELECT COUNT(*) FROM ppt_generation_session WHERE is_delete = 0 AND create_time >= #{start} AND create_time < #{end}")
    long countNewPptSessions(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Select("SELECT COUNT(*) FROM ppt_generation_session WHERE is_delete = 0 AND state = 'completed'")
    long countCompletedPptSessions();

    @Select("SELECT feature_type, COALESCE(SUM(usage_count), 0) as total_usage FROM ai_usage_record " +
            "WHERE usage_date = #{date} GROUP BY feature_type")
    List<Map<String, Object>> aiUsageTodayByFeature(@Param("date") LocalDate date);

    @Select("SELECT feature_type, COALESCE(SUM(usage_count), 0) as total_usage FROM ai_usage_record GROUP BY feature_type")
    List<Map<String, Object>> aiUsageTotalByFeature();

    @Select("SELECT COUNT(*) FROM ai_workflow WHERE is_delete = 0")
    long countTotalWorkflows();

    @Select("SELECT COUNT(*) FROM workflow_execution WHERE deleted = 0")
    long countTotalWorkflowExecutions();

    @Select("SELECT COUNT(*) FROM workflow_execution WHERE deleted = 0 AND status = 'COMPLETED'")
    long countCompletedWorkflowExecutions();

    // ==================== 待办 & 预警 ====================

    @Select("SELECT COUNT(*) FROM user_feedback WHERE is_delete = 0 AND status IN (0, 1)")
    long countPendingFeedbacks();

    @Select("SELECT id, title, feedback_type, status, create_time FROM user_feedback " +
            "WHERE is_delete = 0 AND status IN (0, 1) ORDER BY create_time DESC LIMIT 5")
    List<Map<String, Object>> recentPendingFeedbacks();

    @Select("SELECT COUNT(*) FROM user_checkin WHERE checkin_date = #{date}")
    long countTodayCheckins(@Param("date") LocalDate date);

    @Select("SELECT COUNT(*) FROM scraper_task WHERE status = 2 AND create_time >= #{start}")
    long countFailedScraperTasks(@Param("start") LocalDateTime start);

    // ==================== 趋势：每日新增用户 ====================

    @Select("SELECT create_time::date as day, COUNT(*) as cnt FROM \"user\" " +
            "WHERE is_delete = 0 AND create_time >= #{start} AND create_time < #{end} " +
            "GROUP BY create_time::date ORDER BY day")
    List<Map<String, Object>> dailyNewUsers(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    // ==================== 趋势：每日订单收入 ====================

    @Select("SELECT payment_time::date as day, COUNT(*) as order_count, COALESCE(SUM(price), 0) as revenue " +
            "FROM user_course WHERE is_delete = 0 AND status = 1 " +
            "AND payment_time >= #{start} AND payment_time < #{end} " +
            "GROUP BY payment_time::date ORDER BY day")
    List<Map<String, Object>> dailyRevenue(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);
}
