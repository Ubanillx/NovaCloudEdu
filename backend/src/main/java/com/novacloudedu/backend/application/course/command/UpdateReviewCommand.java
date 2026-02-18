package com.novacloudedu.backend.application.course.command;

/**
 * 更新评价命令
 */
public record UpdateReviewCommand(
        Long reviewId,
        Integer newRating
) {}
