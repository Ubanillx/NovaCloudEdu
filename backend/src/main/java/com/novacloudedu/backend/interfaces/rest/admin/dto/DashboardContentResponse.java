package com.novacloudedu.backend.interfaces.rest.admin.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 仪表盘内容运营响应
 */
@Data
@Builder
public class DashboardContentResponse {

    // 课程
    private long totalCourses;
    private long totalCourseStudents;
    private double avgCourseRating;
    private List<Map<String, Object>> topCourses;

    // 每日文章
    private long totalArticles;
    private long totalArticleViews;
    private long totalArticleLikes;
    private List<Map<String, Object>> topArticles;

    // 每日单词
    private long totalWords;

    // 试卷题库
    private long totalExamPapers;
    private long totalQuestions;
    private List<Map<String, Object>> examPapersBySubject;

    // 电子书
    private long totalBooks;

    // 社区帖子
    private long totalPosts;
    private long todayNewPosts;
    private long totalPostLikes;
    private long totalPostComments;
    private List<Map<String, Object>> topPosts;
}
