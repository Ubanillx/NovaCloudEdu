package com.novacloudedu.backend.interfaces.rest.progress;

import com.novacloudedu.backend.application.progress.command.CompleteSectionCommand;
import com.novacloudedu.backend.application.progress.command.ResetProgressCommand;
import com.novacloudedu.backend.application.progress.command.UpdateProgressCommand;
import com.novacloudedu.backend.application.progress.query.GetProgressQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.progress.entity.UserCourseProgress;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.interfaces.rest.progress.assembler.ProgressAssembler;
import com.novacloudedu.backend.interfaces.rest.progress.dto.CourseProgressSummaryResponse;
import com.novacloudedu.backend.interfaces.rest.progress.dto.ProgressResponse;
import com.novacloudedu.backend.interfaces.rest.progress.dto.UpdateProgressRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/progress")
@RequiredArgsConstructor
@Tag(name = "学习进度", description = "用户学习进度相关接口")
public class ProgressController {

    private final UpdateProgressCommand updateProgressCommand;
    private final CompleteSectionCommand completeSectionCommand;
    private final ResetProgressCommand resetProgressCommand;
    private final GetProgressQuery getProgressQuery;
    private final ProgressAssembler progressAssembler;

    @PostMapping
    @Operation(summary = "更新学习进度")
    public BaseResponse<Void> updateProgress(@Valid @RequestBody UpdateProgressRequest request,
                                            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        updateProgressCommand.execute(
                UserId.of(userId),
                request.getCourseId(),
                request.getSectionId(),
                request.getLastPosition(),
                request.getWatchDuration(),
                request.getProgress()
        );
        return ResultUtils.success(null);
    }

    @PostMapping("/section/{sectionId}/complete")
    @Operation(summary = "标记小节为已完成")
    public BaseResponse<Void> completeSection(@PathVariable @Parameter(description = "小节ID") Long sectionId,
                                             @RequestParam @Parameter(description = "课程ID") Long courseId,
                                             Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        completeSectionCommand.execute(UserId.of(userId), courseId, sectionId);
        return ResultUtils.success(null);
    }

    @PostMapping("/section/{sectionId}/reset")
    @Operation(summary = "重置小节进度")
    public BaseResponse<Void> resetProgress(@PathVariable @Parameter(description = "小节ID") Long sectionId,
                                           Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        resetProgressCommand.execute(UserId.of(userId), sectionId);
        return ResultUtils.success(null);
    }

    @GetMapping("/section/{sectionId}")
    @Operation(summary = "获取小节学习进度")
    public BaseResponse<ProgressResponse> getSectionProgress(@PathVariable @Parameter(description = "小节ID") Long sectionId,
                                                            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        Optional<UserCourseProgress> progress = getProgressQuery.executeByUserIdAndSectionId(UserId.of(userId), sectionId);
        
        if (progress.isEmpty()) {
            return ResultUtils.success(null);
        }
        
        return ResultUtils.success(progressAssembler.toProgressResponse(progress.get()));
    }

    @GetMapping("/course/{courseId}")
    @Operation(summary = "获取课程所有小节的学习进度")
    public BaseResponse<List<ProgressResponse>> getCourseProgress(@PathVariable @Parameter(description = "课程ID") Long courseId,
                                                                 Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        List<UserCourseProgress> progressList = getProgressQuery.executeByUserIdAndCourseId(UserId.of(userId), courseId);
        
        List<ProgressResponse> responses = progressList.stream()
                .map(progressAssembler::toProgressResponse)
                .collect(Collectors.toList());
        
        return ResultUtils.success(responses);
    }

    @GetMapping("/course/{courseId}/summary")
    @Operation(summary = "获取课程进度汇总")
    public BaseResponse<CourseProgressSummaryResponse> getCourseProgressSummary(
            @PathVariable @Parameter(description = "课程ID") Long courseId,
            Authentication authentication) {
        
        Long userId = Long.parseLong(authentication.getName());
        UserId userIdVO = UserId.of(userId);
        
        long totalSections = getProgressQuery.countTotalSections(courseId);
        long completedSections = getProgressQuery.countCompletedSections(userIdVO, courseId);
        int overallProgress = getProgressQuery.calculateCourseProgress(userIdVO, courseId);
        
        int completionRate = totalSections > 0 ? (int) ((completedSections * 100) / totalSections) : 0;
        
        CourseProgressSummaryResponse response = CourseProgressSummaryResponse.builder()
                .courseId(courseId)
                .totalSections(totalSections)
                .completedSections(completedSections)
                .overallProgress(overallProgress)
                .completionRate(completionRate)
                .build();
        
        return ResultUtils.success(response);
    }
}
