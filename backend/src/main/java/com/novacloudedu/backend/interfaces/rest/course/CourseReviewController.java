package com.novacloudedu.backend.interfaces.rest.course;

import com.novacloudedu.backend.application.course.command.ReviewCourseCommand;
import com.novacloudedu.backend.application.course.command.UpdateReviewCommand;
import com.novacloudedu.backend.application.course.query.GetCourseReviewQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.course.assembler.CourseAssembler;
import com.novacloudedu.backend.interfaces.rest.course.dto.CourseReviewResponse;
import com.novacloudedu.backend.interfaces.rest.course.dto.ReviewCourseRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/course/review")
@RequiredArgsConstructor
@Tag(name = "课程评价", description = "课程评价相关接口")
public class CourseReviewController {

    private final ReviewCourseCommand reviewCommand;
    private final UpdateReviewCommand updateReviewCommand;
    private final GetCourseReviewQuery getReviewQuery;
    private final CourseAssembler courseAssembler;

    @PostMapping("/{courseId}")
    @Operation(summary = "评价课程")
    public BaseResponse<Long> reviewCourse(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                          @Valid @RequestBody ReviewCourseRequest request,
                                          Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        Long reviewId = reviewCommand.execute(UserId.of(userId), courseId, request.getRating());
        return ResultUtils.success(reviewId);
    }

    @PutMapping("/{reviewId}")
    @Operation(summary = "更新评价")
    public BaseResponse<Void> updateReview(@PathVariable @Parameter(description = "评价ID") Long reviewId,
                                          @Valid @RequestBody ReviewCourseRequest request) {
        updateReviewCommand.execute(reviewId, request.getRating());
        return ResultUtils.success(null);
    }

    @GetMapping("/{courseId}/list")
    @Operation(summary = "获取课程评价列表")
    public BaseResponse<List<CourseReviewResponse>> listReviews(
            @PathVariable @Parameter(description = "课程ID") Long courseId,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        
        List<CourseReview> reviews = getReviewQuery.executeByCourseId(courseId, page, size);
        List<CourseReviewResponse> responses = reviews.stream()
                .map(courseAssembler::toReviewResponse)
                .collect(Collectors.toList());
        return ResultUtils.success(responses);
    }

    @GetMapping("/{courseId}/my")
    @Operation(summary = "获取我对该课程的评价")
    public BaseResponse<CourseReviewResponse> getMyReview(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                                          Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        CourseReview review = getReviewQuery.executeByUserIdAndCourseId(UserId.of(userId), courseId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));
        return ResultUtils.success(courseAssembler.toReviewResponse(review));
    }

    @GetMapping("/{courseId}/count")
    @Operation(summary = "获取课程评价数")
    public BaseResponse<Long> getReviewCount(@PathVariable @Parameter(description = "课程ID") Long courseId) {
        long count = getReviewQuery.countByCourseId(courseId);
        return ResultUtils.success(count);
    }
}
