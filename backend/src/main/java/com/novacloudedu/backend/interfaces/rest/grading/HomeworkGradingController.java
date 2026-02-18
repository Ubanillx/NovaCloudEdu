package com.novacloudedu.backend.interfaces.rest.grading;

import com.novacloudedu.backend.application.grading.command.SubmitHomeworkCommand;
import com.novacloudedu.backend.application.grading.service.GradingStatsApplicationService;
import com.novacloudedu.backend.application.grading.service.HomeworkGradingApplicationService;
import com.novacloudedu.backend.application.grading.service.KnowledgeProfileApplicationService;
import com.novacloudedu.backend.application.grading.service.SimilarQuestionService;
import com.novacloudedu.backend.application.service.UserApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.GradingResult;
import com.novacloudedu.backend.domain.grading.entity.HomeworkSubmission;
import com.novacloudedu.backend.domain.grading.entity.QuestionGrading;
import com.novacloudedu.backend.domain.grading.entity.StudentKnowledgeProfile;
import com.novacloudedu.backend.domain.grading.valueobject.ErrorCategory;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.grading.dto.request.SubmitHomeworkRequest;
import com.novacloudedu.backend.interfaces.rest.grading.dto.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 智能批改控制器
 */
@Tag(name = "智能批改", description = "作业提交、OCR识别、AI批改、结果查询")
@RestController
@RequestMapping("/api/grading")
@RequiredArgsConstructor
@Slf4j
public class HomeworkGradingController {

    private final HomeworkGradingApplicationService gradingService;
    private final KnowledgeProfileApplicationService profileService;
    private final GradingStatsApplicationService statsService;
    private final SimilarQuestionService similarQuestionService;
    private final UserApplicationService userApplicationService;

    @PostMapping(value = "/submit", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "提交作业并开始批改（SSE流式返回进度）")
    public SseEmitter submitHomework(@RequestBody @Valid SubmitHomeworkRequest request) {
        Long userId = userApplicationService.getCurrentUser().getId().value();

        SubmitHomeworkCommand command = new SubmitHomeworkCommand(
                request.getGradingMode(),
                request.getTitle(),
                request.getSubject(),
                request.getGrade(),
                request.getImageUrls(),
                request.getClassId(),
                request.getExamPaperId()
        );

        return gradingService.submitAndGrade(command, userId);
    }

    @GetMapping("/{submissionId}/status")
    @Operation(summary = "查询批改状态")
    public BaseResponse<SubmissionStatusResponse> getStatus(@PathVariable Long submissionId) {
        HomeworkSubmission submission = gradingService.getSubmission(submissionId)
                .orElseThrow(() -> new BusinessException(40400, "作业提交不存在"));

        SubmissionStatusResponse response = toStatusResponse(submission);
        return ResultUtils.success(response);
    }

    @GetMapping("/{submissionId}/result")
    @Operation(summary = "获取批改结果")
    public BaseResponse<GradingResultResponse> getResult(@PathVariable Long submissionId) {
        GradingResult result = gradingService.getGradingResult(submissionId)
                .orElseThrow(() -> new BusinessException(40400, "批改结果不存在"));

        GradingResultResponse response = toResultResponse(result);
        return ResultUtils.success(response);
    }

    @GetMapping("/history")
    @Operation(summary = "查询批改历史")
    public BaseResponse<List<SubmissionStatusResponse>> getHistory(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        Long userId = userApplicationService.getCurrentUser().getId().value();
        List<HomeworkSubmission> submissions = gradingService.getHistory(userId, page, size);
        List<SubmissionStatusResponse> responses = submissions.stream()
                .map(sub -> {
                    SubmissionStatusResponse resp = toStatusResponse(sub);
                    // 关联查询得分
                    gradingService.getGradingResult(sub.getId().getValue()).ifPresent(result -> {
                        resp.setTotalScore(result.getTotalScore());
                        resp.setMaxScore(result.getMaxScore());
                    });
                    return resp;
                }).toList();
        return ResultUtils.success(responses);
    }

    // ==================== 试卷选择 API ====================

    @GetMapping("/papers")
    @Operation(summary = "查询已发布试卷列表（供批改选择）")
    public BaseResponse<Map<String, Object>> getPublishedPapers(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String subject,
            @RequestParam(required = false) String grade,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        var paperPage = gradingService.queryPublishedPapers(keyword, subject, grade, page, size);
        List<PublishedExamPaperItem> items = paperPage.papers().stream().map(paper -> {
            PublishedExamPaperItem item = new PublishedExamPaperItem();
            item.setId(String.valueOf(paper.getId().value()));
            item.setTitle(paper.getTitle());
            item.setSubtitle(paper.getSubtitle());
            item.setSubject(paper.getSubject() != null ? paper.getSubject().getCode() : null);
            item.setSubjectName(paper.getSubject() != null ? paper.getSubject().getDescription() : null);
            item.setGrade(paper.getGrade());
            item.setTotalScore(paper.getTotalScore());
            item.setDurationMin(paper.getDurationMin());
            return item;
        }).toList();

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("records", items);
        result.put("total", paperPage.total());
        result.put("pageNum", paperPage.pageNum());
        result.put("pageSize", paperPage.pageSize());
        return ResultUtils.success(result);
    }

    // ==================== 知识画像 API ====================

    @GetMapping("/profile")
    @Operation(summary = "查询学生全部知识画像")
    public BaseResponse<List<SubjectProfileSummary>> getAllProfiles() {
        Long userId = userApplicationService.getCurrentUser().getId().value();
        List<StudentKnowledgeProfile> all = profileService.getAllProfiles(userId);
        List<SubjectProfileSummary> summaries = buildSubjectSummaries(all);
        return ResultUtils.success(summaries);
    }

    @GetMapping("/profile/{subjectCode}")
    @Operation(summary = "查询某学科知识画像详情")
    public BaseResponse<SubjectProfileSummary> getSubjectProfile(@PathVariable String subjectCode) {
        Long userId = userApplicationService.getCurrentUser().getId().value();
        List<StudentKnowledgeProfile> profiles = profileService.getSubjectProfile(userId, subjectCode);
        SubjectProfileSummary summary = buildSingleSubjectSummary(subjectCode, profiles);
        return ResultUtils.success(summary);
    }

    @GetMapping("/profile/{subjectCode}/weak")
    @Operation(summary = "查询某学科薄弱知识点")
    public BaseResponse<List<KnowledgeProfileResponse>> getWeakPoints(@PathVariable String subjectCode) {
        Long userId = userApplicationService.getCurrentUser().getId().value();
        List<StudentKnowledgeProfile> weakPoints = profileService.getWeakPoints(userId, subjectCode);
        List<KnowledgeProfileResponse> responses = weakPoints.stream()
                .map(this::toProfileResponse).toList();
        return ResultUtils.success(responses);
    }

    // ==================== 统计 API ====================

    @GetMapping("/stats")
    @Operation(summary = "查询批改历史统计")
    public BaseResponse<GradingStatsResponse> getStats() {
        Long userId = userApplicationService.getCurrentUser().getId().value();

        GradingStatsResponse resp = new GradingStatsResponse();
        resp.setTotalSubmissions(statsService.getTotalSubmissions(userId));

        // 得分趋势（最近10次）
        List<GradingStatsApplicationService.SubmissionWithResult> recent =
                statsService.getRecentSubmissions(userId, 10);
        List<GradingStatsResponse.ScoreTrendItem> trend = new ArrayList<>();
        double totalRate = 0;
        int ratedCount = 0;
        Map<String, List<Double>> subjectRates = new LinkedHashMap<>();

        for (var swr : recent) {
            GradingStatsResponse.ScoreTrendItem item = new GradingStatsResponse.ScoreTrendItem();
            item.setSubmissionId(String.valueOf(swr.submission().getId().getValue()));
            item.setSubject(swr.submission().getSubject().getCode());
            item.setCreateTime(swr.submission().getCreateTime().toString());
            if (swr.result() != null && swr.result().getMaxScore() != null && swr.result().getMaxScore() > 0) {
                item.setScore(swr.result().getTotalScore());
                item.setMaxScore(swr.result().getMaxScore());
                double rate = (double) swr.result().getTotalScore() / swr.result().getMaxScore();
                totalRate += rate;
                ratedCount++;
                subjectRates.computeIfAbsent(swr.submission().getSubject().getCode(), k -> new ArrayList<>()).add(rate);
            }
            trend.add(item);
        }
        resp.setScoreTrend(trend);
        resp.setAvgScoreRate(ratedCount > 0 ? totalRate / ratedCount : 0);

        // 学科得分率
        Map<String, Double> subjectAvg = new LinkedHashMap<>();
        subjectRates.forEach((sub, rates) ->
                subjectAvg.put(sub, rates.stream().mapToDouble(Double::doubleValue).average().orElse(0)));
        resp.setSubjectScoreRates(subjectAvg);

        // 错因分布
        Map<String, Long> errorDist = statsService.getErrorDistribution(userId, 20);
        List<GradingStatsResponse.ErrorCategoryCount> errorList = errorDist.entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .map(e -> {
                    GradingStatsResponse.ErrorCategoryCount ec = new GradingStatsResponse.ErrorCategoryCount();
                    ec.setCategory(e.getKey());
                    ec.setCategoryName(ErrorCategory.getDescription(e.getKey()));
                    ec.setCount(e.getValue());
                    return ec;
                }).toList();
        resp.setErrorDistribution(errorList);

        return ResultUtils.success(resp);
    }

    // ==================== 同类题推荐 API ====================

    @GetMapping("/{submissionId}/recommend")
    @Operation(summary = "获取错题的同类题推荐")
    public BaseResponse<List<Map<String, Object>>> getRecommendations(@PathVariable Long submissionId) {
        Long userId = userApplicationService.getCurrentUser().getId().value();
        HomeworkSubmission submission = gradingService.getSubmission(submissionId)
                .orElseThrow(() -> new BusinessException(40400, "作业提交不存在"));
        GradingResult result = gradingService.getGradingResult(submissionId)
                .orElseThrow(() -> new BusinessException(40400, "批改结果不存在"));

        List<SimilarQuestionService.QuestionRecommendation> recs =
                similarQuestionService.recommendForGradingResult(
                        result.getQuestionGradings(), submission.getSubject().getCode(), userId);

        List<Map<String, Object>> response = recs.stream().map(rec -> {
            Map<String, Object> map = new LinkedHashMap<>();
            map.put("errorQuestionIndex", rec.errorQuestionIndex());
            map.put("knowledgePoints", rec.knowledgePoints());
            map.put("errorCategories", rec.errorCategories());
            map.put("recommendedQuestions", rec.recommendedQuestions().stream().map(q -> {
                Map<String, Object> qMap = new LinkedHashMap<>();
                qMap.put("id", String.valueOf(q.getId().value()));
                qMap.put("content", q.getContent());
                qMap.put("type", q.getType().getCode());
                qMap.put("difficulty", q.getDifficulty().getLevel());
                qMap.put("knowledgeTags", q.getKnowledgeTags());
                return qMap;
            }).toList());
            return map;
        }).toList();

        return ResultUtils.success(response);
    }

    // ==================== 转换方法 ====================

    private SubmissionStatusResponse toStatusResponse(HomeworkSubmission submission) {
        SubmissionStatusResponse resp = new SubmissionStatusResponse();
        resp.setSubmissionId(String.valueOf(submission.getId().getValue()));
        resp.setGradingMode(submission.getGradingMode() != null ? submission.getGradingMode().getCode() : "GENERAL");
        resp.setTitle(submission.getTitle());
        resp.setSubject(submission.getSubject() != null ? submission.getSubject().getCode() : null);
        resp.setGrade(submission.getGrade());
        resp.setImageUrls(submission.getImageUrls());
        resp.setStatus(submission.getStatus().getCode());
        resp.setExamPaperId(submission.getExamPaperId() != null
                ? String.valueOf(submission.getExamPaperId()) : null);
        resp.setCreateTime(submission.getCreateTime());
        return resp;
    }

    private GradingResultResponse toResultResponse(GradingResult result) {
        GradingResultResponse resp = new GradingResultResponse();
        resp.setSubmissionId(String.valueOf(result.getSubmissionId().getValue()));
        resp.setTotalScore(result.getTotalScore());
        resp.setMaxScore(result.getMaxScore());
        resp.setOverallComment(result.getOverallComment());
        resp.setModelId(result.getModelId());
        resp.setGradingTime(result.getGradingTime());

        List<GradingResultResponse.QuestionGradingItem> items = result.getQuestionGradings().stream()
                .map(this::toQuestionItem).toList();
        resp.setQuestions(items);
        return resp;
    }

    private KnowledgeProfileResponse toProfileResponse(StudentKnowledgeProfile profile) {
        KnowledgeProfileResponse resp = new KnowledgeProfileResponse();
        resp.setKnowledgePoint(profile.getKnowledgePoint());
        resp.setSubject(profile.getSubject().getCode());
        resp.setMasteryLevel(profile.getMasteryLevel());
        resp.setMasteryGrade(KnowledgeProfileResponse.toMasteryGrade(profile.getMasteryLevel()));
        resp.setTotalAttempts(profile.getTotalAttempts());
        resp.setCorrectCount(profile.getCorrectCount());
        resp.setCorrectRate(profile.getTotalAttempts() > 0
                ? (double) profile.getCorrectCount() / profile.getTotalAttempts() : 0);
        resp.setRecentErrorCategories(profile.getRecentErrorCategories());
        resp.setWeakPoint(profile.isWeakPoint());
        resp.setLastUpdated(profile.getLastUpdated());
        return resp;
    }

    private List<SubjectProfileSummary> buildSubjectSummaries(List<StudentKnowledgeProfile> all) {
        Map<String, List<StudentKnowledgeProfile>> grouped = all.stream()
                .collect(Collectors.groupingBy(p -> p.getSubject().getCode(), LinkedHashMap::new, Collectors.toList()));
        return grouped.entrySet().stream()
                .map(e -> buildSingleSubjectSummary(e.getKey(), e.getValue())).toList();
    }

    private SubjectProfileSummary buildSingleSubjectSummary(String subjectCode, List<StudentKnowledgeProfile> profiles) {
        SubjectProfileSummary summary = new SubjectProfileSummary();
        summary.setSubject(subjectCode);
        try {
            summary.setSubjectName(Subject.fromCode(subjectCode).getDescription());
        } catch (Exception e) {
            summary.setSubjectName(subjectCode);
        }
        summary.setTotalPoints(profiles.size());
        summary.setAvgMasteryLevel(profiles.stream().mapToDouble(StudentKnowledgeProfile::getMasteryLevel).average().orElse(0));

        List<KnowledgeProfileResponse> weak = profiles.stream()
                .filter(StudentKnowledgeProfile::isWeakPoint)
                .map(this::toProfileResponse).toList();
        List<KnowledgeProfileResponse> strong = profiles.stream()
                .filter(p -> p.getMasteryLevel() >= 0.8 && p.getTotalAttempts() >= 3)
                .map(this::toProfileResponse).toList();

        summary.setWeakPointCount(weak.size());
        summary.setStrongPointCount(strong.size());
        summary.setWeakPoints(weak);
        summary.setStrongPoints(strong);
        return summary;
    }

    private GradingResultResponse.QuestionGradingItem toQuestionItem(QuestionGrading grading) {
        GradingResultResponse.QuestionGradingItem item = new GradingResultResponse.QuestionGradingItem();
        item.setQuestionIndex(grading.getQuestionIndex());
        item.setQuestionContent(grading.getQuestionContent());
        item.setQuestionType(grading.getQuestionType());
        item.setStudentAnswer(grading.getStudentAnswer());
        item.setStandardAnswer(grading.getStandardAnswer());
        item.setScore(grading.getScore());
        item.setMaxScore(grading.getMaxScore());
        item.setErrorCategories(grading.getErrorCategories());
        item.setErrorDetail(grading.getErrorDetail());
        item.setKnowledgePoints(grading.getKnowledgePoints());
        item.setComment(grading.getComment());
        return item;
    }
}
