package com.novacloudedu.backend.infrastructure.workflow;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * 数据库元数据服务
 * 维护工作流可安全访问的表白名单，暴露表名和字段信息
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DatabaseMetadataService {

    private final JdbcTemplate jdbcTemplate;

    /**
     * 安全表白名单：工作流数据库查询节点只允许查询这些表
     * <p>
     * 仅包含业务数据表，排除以下类型的表：
     * - 系统内部表（工作流定义/执行、知识库向量分块、抓取配置等）
     * - 隐私通信表（私聊消息、群聊消息、好友关系等）
     * - AI 对话消息表（含用户私密对话内容）
     * - 文件上传表（含文件 URL，存在安全风险）
     * - 讲师申请表（含审核信息）
     * <p>
     * 敏感字段（如 user_password）由 {@link #BLOCKED_COLUMNS} 字段黑名单过滤。
     */
    private static final Set<String> ALLOWED_TABLES = Set.of(
            // ===== 用户领域 =====
            "user",                   // 用户表（密码字段由字段黑名单过滤）
            "level_privilege",        // 等级特权
            "user_learning_stats",    // 用户学习统计（天）
            "user_daily_goal",        // 用户每日学习目标
            "user_course_table",      // 用户课程表（学期配置）
            "user_course_table_item", // 用户课程表项目（具体课程）

            // ===== 课程领域 =====
            "course",                 // 课程
            "teacher",                // 讲师
            "course_chapter",         // 课程章节
            "course_section",         // 课程小节
            "user_course",            // 用户课程购买记录
            "user_course_progress",   // 用户学习进度
            "course_review",          // 课程评价
            "course_favourite",       // 课程收藏

            // ===== 图书/阅读领域 =====
            "book",                   // 书籍
            "chapter",                // 章节
            "user_book_shelf",        // 用户书架
            "book_tag",               // 书籍标签
            "reading_note",           // 阅读笔记
            "reading_bookmark",       // 阅读书签
            "chapter_summary",        // 章节总结
            "knowledge_point",        // 知识点

            // ===== 帖子/社区领域 =====
            "post",                   // 帖子
            "post_thumb",             // 帖子点赞
            "post_favour",            // 帖子收藏
            "post_comment",           // 帖子评论
            "post_comment_reply",     // 帖子评论回复

            // ===== 公告领域 =====
            "announcement",           // 系统公告
            "announcement_read",      // 公告已读记录

            // ===== 签到领域 =====
            "user_checkin",           // 用户打卡
            "user_checkin_stats",     // 用户打卡统计

            // ===== 班级领域 =====
            "class_info",             // 班级信息
            "class_member",           // 班级成员
            "class_course",           // 班级课程关联

            // ===== 排课领域 =====
            "class_schedule_setting", // 班级课程表配置
            "class_schedule_item",    // 班级课程表项

            // ===== 每日学习领域 =====
            "daily_word",             // 每日单词
            "daily_article",          // 每日文章
            "user_daily_article",     // 用户每日文章关联
            "user_daily_word",        // 用户每日单词关联
            "user_word_book",         // 用户生词本

            // ===== 用户偏好/推荐 =====
            "user_preference",        // 用户喜好
            "user_behavior_log",      // 用户行为日志
            "recommendation_history", // 推荐记录

            // ===== 社交（仅关注关系，不含私聊） =====
            "user_follow",            // 用户关注

            // ===== 反馈（仅反馈主表） =====
            "user_feedback",          // 用户反馈

            // ===== 轮播图 =====
            "banner",                 // 首页轮播图

            // ===== AI 相关（仅公开/统计信息） =====
            "ai_assistant",           // AI助手（公开信息）
            "ai_chat_session",        // AI通用聊天会话（仅标题/统计）
            "user_ai_assistant"       // 用户AI助手收藏
    );

    /**
     * 字段黑名单：即使表在白名单中，这些字段也不会暴露给前端
     */
    private static final Set<String> BLOCKED_COLUMNS = Set.of(
            "password", "user_password", "passwd", "pwd",
            "secret", "token", "refresh_token", "access_token",
            "salt", "api_key", "private_key",
            "content_hash", "encryption_iv",       // 加密相关
            "content_vector", "content_search_vector", "search_vector", "embedding", // 向量字段
            "memory_summary"                       // AI会话记忆摘要
    );

    /**
     * 从 SQL 中提取引用的表名（支持 FROM / JOIN）
     */
    private static final Pattern TABLE_REF_PATTERN = Pattern.compile(
            "(?:FROM|JOIN)\\s+([a-zA-Z_][a-zA-Z0-9_]*)",
            Pattern.CASE_INSENSITIVE
    );

    /**
     * 获取所有允许的表名列表
     */
    public List<String> getAllowedTableNames() {
        return ALLOWED_TABLES.stream().sorted().collect(Collectors.toList());
    }

    /**
     * 判断表名是否在白名单中
     */
    public boolean isTableAllowed(String tableName) {
        return tableName != null && ALLOWED_TABLES.contains(tableName.toLowerCase().trim());
    }

    /**
     * 校验 SQL 中引用的所有表是否都在白名单中
     * @return 不在白名单中的表名列表，空列表表示全部合法
     */
    public List<String> validateSqlTables(String sql) {
        if (sql == null || sql.isBlank()) return List.of();
        
        Set<String> referencedTables = extractTableNames(sql);
        List<String> illegalTables = new ArrayList<>();
        for (String table : referencedTables) {
            if (!ALLOWED_TABLES.contains(table.toLowerCase())) {
                illegalTables.add(table);
            }
        }
        return illegalTables;
    }

    /**
     * 从 SQL 语句中提取所有表名
     */
    public Set<String> extractTableNames(String sql) {
        Set<String> tables = new LinkedHashSet<>();
        Matcher matcher = TABLE_REF_PATTERN.matcher(sql);
        while (matcher.find()) {
            tables.add(matcher.group(1).toLowerCase());
        }
        return tables;
    }

    /**
     * 获取指定表的列信息（仅白名单表，过滤敏感字段）
     */
    public List<ColumnInfo> getTableColumns(String tableName) {
        if (!isTableAllowed(tableName)) {
            throw new IllegalArgumentException("表 '" + tableName + "' 不在允许的查询范围内");
        }

        String sql = """
            SELECT column_name, data_type, is_nullable, column_default,
                   character_maximum_length, numeric_precision, numeric_scale,
                   col_description((table_schema || '.' || table_name)::regclass, ordinal_position) as column_comment
            FROM information_schema.columns
            WHERE table_schema = 'public' AND table_name = ?
            ORDER BY ordinal_position
            """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> ColumnInfo.builder()
                .name(rs.getString("column_name"))
                .dataType(rs.getString("data_type"))
                .nullable("YES".equals(rs.getString("is_nullable")))
                .defaultValue(rs.getString("column_default"))
                .maxLength(rs.getObject("character_maximum_length") != null ? rs.getInt("character_maximum_length") : null)
                .comment(rs.getString("column_comment"))
                .build(), tableName
        ).stream()
                .filter(col -> !BLOCKED_COLUMNS.contains(col.getName().toLowerCase()))
                .collect(Collectors.toList());
    }

    /**
     * 获取所有白名单表及其列信息
     */
    public List<TableInfo> getAllAllowedTablesWithColumns() {
        List<TableInfo> result = new ArrayList<>();

        // 先查有哪些白名单表真实存在于数据库中
        String existSql = """
            SELECT table_name,
                   obj_description((table_schema || '.' || table_name)::regclass) as table_comment
            FROM information_schema.tables
            WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
              AND table_name = ANY(?)
            ORDER BY table_name
            """;

        String[] allowedArray = ALLOWED_TABLES.toArray(new String[0]);

        List<Map<String, Object>> existingTables = jdbcTemplate.queryForList(existSql, (Object) allowedArray);

        for (Map<String, Object> row : existingTables) {
            String tableName = (String) row.get("table_name");
            String tableComment = (String) row.get("table_comment");
            try {
                List<ColumnInfo> columns = getTableColumns(tableName);
                result.add(TableInfo.builder()
                        .name(tableName)
                        .comment(tableComment)
                        .columns(columns)
                        .build());
            } catch (Exception e) {
                log.warn("获取表 {} 的列信息失败: {}", tableName, e.getMessage());
            }
        }

        return result;
    }

    /**
     * 表信息
     */
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TableInfo {
        private String name;
        private String comment;
        private List<ColumnInfo> columns;
    }

    /**
     * 列信息
     */
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ColumnInfo {
        private String name;
        private String dataType;
        private boolean nullable;
        private String defaultValue;
        private Integer maxLength;
        private String comment;
    }
}
