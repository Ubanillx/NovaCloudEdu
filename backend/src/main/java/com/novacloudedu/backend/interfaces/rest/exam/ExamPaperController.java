package com.novacloudedu.backend.interfaces.rest.exam;

import com.novacloudedu.backend.application.exam.command.UpdatePaperSectionCommand;
import com.novacloudedu.backend.application.service.ExamPaperApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.exam.entity.ExamPaper;
import com.novacloudedu.backend.domain.exam.entity.PaperQuestion;
import com.novacloudedu.backend.domain.exam.entity.PaperSection;
import com.novacloudedu.backend.domain.exam.repository.ExamPaperRepository.ExamPaperPage;
import com.novacloudedu.backend.interfaces.rest.exam.assembler.ExamAssembler;
import com.novacloudedu.backend.interfaces.rest.exam.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.exam.dto.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 试卷管理控制器
 */
@Tag(name = "试卷管理", description = "试卷创建、编辑、大题管理、题目关联、发布")
@RestController
@RequestMapping("/api/exam-papers")
@RequiredArgsConstructor
@Slf4j
public class ExamPaperController {

    private final ExamPaperApplicationService examPaperApplicationService;
    private final ExamAssembler examAssembler;

    // ==================== 试卷 CRUD ====================

    /**
     * 创建试卷
     */
    @Operation(summary = "创建试卷")
    @PostMapping
    public BaseResponse<Long> createExamPaper(@RequestBody @Valid CreateExamPaperRequest request) {
        Long id = examPaperApplicationService.createExamPaper(
                examAssembler.toCreateExamPaperCommand(request)
        );
        return ResultUtils.success(id);
    }

    /**
     * 更新试卷
     */
    @Operation(summary = "更新试卷基本信息")
    @PutMapping
    public BaseResponse<Boolean> updateExamPaper(@RequestBody @Valid UpdateExamPaperRequest request) {
        examPaperApplicationService.updateExamPaper(
                examAssembler.toUpdateExamPaperCommand(request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 删除试卷
     */
    @Operation(summary = "删除试卷")
    @DeleteMapping("/{id}")
    public BaseResponse<Boolean> deleteExamPaper(@PathVariable Long id) {
        examPaperApplicationService.deleteExamPaper(id);
        return ResultUtils.success(true);
    }

    /**
     * 获取试卷详情
     */
    @Operation(summary = "获取试卷详情")
    @GetMapping("/{id}")
    public BaseResponse<ExamPaperResponse> getExamPaper(@PathVariable Long id) {
        ExamPaper paper = examPaperApplicationService.getExamPaperById(id);
        return ResultUtils.success(examAssembler.toExamPaperResponse(paper));
    }

    /**
     * 分页查询我的试卷
     */
    @Operation(summary = "分页查询我的试卷")
    @GetMapping
    public BaseResponse<ExamPaperPageResponse> queryExamPapers(QueryExamPaperRequest request) {
        ExamPaperPage page = examPaperApplicationService.queryExamPapers(
                examAssembler.toExamPaperQuery(request)
        );
        return ResultUtils.success(examAssembler.toExamPaperPageResponse(page));
    }

    /**
     * 发布试卷
     */
    @Operation(summary = "发布试卷")
    @PostMapping("/{id}/publish")
    public BaseResponse<Boolean> publishExamPaper(@PathVariable Long id) {
        examPaperApplicationService.publishExamPaper(id);
        return ResultUtils.success(true);
    }

    /**
     * 撤回试卷
     */
    @Operation(summary = "撤回试卷为草稿")
    @PostMapping("/{id}/unpublish")
    public BaseResponse<Boolean> unpublishExamPaper(@PathVariable Long id) {
        examPaperApplicationService.unpublishExamPaper(id);
        return ResultUtils.success(true);
    }

    // ==================== PDF 预览 & 导出 ====================

    /**
     * 预览试卷 PDF
     */
    @Operation(summary = "预览试卷PDF")
    @PostMapping("/{id}/preview")
    public ResponseEntity<byte[]> previewPdf(@PathVariable Long id) {
        byte[] pdf = examPaperApplicationService.previewPdf(id);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_PDF_VALUE)
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=preview.pdf")
                .body(pdf);
    }

    /**
     * 导出参考答案 PDF
     */
    @Operation(summary = "导出参考答案PDF")
    @PostMapping("/{id}/export-answer-key")
    public ResponseEntity<byte[]> exportAnswerKey(@PathVariable Long id) {
        byte[] pdf = examPaperApplicationService.exportAnswerKey(id);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_PDF_VALUE)
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=answer_key.pdf")
                .body(pdf);
    }

    // ==================== 大题管理 ====================

    /**
     * 获取试卷的所有大题
     */
    @Operation(summary = "获取试卷的所有大题")
    @GetMapping("/{paperId}/sections")
    public BaseResponse<List<PaperSectionResponse>> getSections(@PathVariable Long paperId) {
        List<PaperSection> sections = examPaperApplicationService.getSections(paperId);
        List<PaperSectionResponse> responses = sections.stream()
                .map(examAssembler::toPaperSectionResponse)
                .toList();
        return ResultUtils.success(responses);
    }

    /**
     * 添加大题
     */
    @Operation(summary = "添加大题")
    @PostMapping("/{paperId}/sections")
    public BaseResponse<Long> addSection(@PathVariable Long paperId,
                                         @RequestBody @Valid AddPaperSectionRequest request) {
        Long id = examPaperApplicationService.addSection(
                examAssembler.toAddSectionCommand(paperId, request)
        );
        return ResultUtils.success(id);
    }

    /**
     * 更新大题
     */
    @Operation(summary = "更新大题")
    @PutMapping("/{paperId}/sections/{sectionId}")
    public BaseResponse<Boolean> updateSection(@PathVariable Long paperId,
                                               @PathVariable Long sectionId,
                                               @RequestBody @Valid AddPaperSectionRequest request) {
        examPaperApplicationService.updateSection(
                new UpdatePaperSectionCommand(
                        sectionId, request.title(), request.description(),
                        request.questionType(), request.sortOrder()
                )
        );
        return ResultUtils.success(true);
    }

    /**
     * 删除大题
     */
    @Operation(summary = "删除大题")
    @DeleteMapping("/{paperId}/sections/{sectionId}")
    public BaseResponse<Boolean> deleteSection(@PathVariable Long paperId,
                                               @PathVariable Long sectionId) {
        examPaperApplicationService.deleteSection(sectionId);
        return ResultUtils.success(true);
    }

    // ==================== 题目关联管理 ====================

    /**
     * 获取大题下的所有题目
     */
    @Operation(summary = "获取大题下的所有题目关联")
    @GetMapping("/{paperId}/sections/{sectionId}/questions")
    public BaseResponse<List<PaperQuestionResponse>> getPaperQuestions(
            @PathVariable Long paperId,
            @PathVariable Long sectionId) {
        List<PaperQuestion> pqs = examPaperApplicationService.getPaperQuestions(sectionId);
        List<PaperQuestionResponse> responses = pqs.stream()
                .map(examAssembler::toPaperQuestionResponse)
                .toList();
        return ResultUtils.success(responses);
    }

    /**
     * 向大题添加题目
     */
    @Operation(summary = "向大题添加题目")
    @PostMapping("/{paperId}/sections/{sectionId}/questions")
    public BaseResponse<Long> addQuestionToSection(
            @PathVariable Long paperId,
            @PathVariable Long sectionId,
            @RequestBody @Valid AddPaperQuestionRequest request) {
        Long id = examPaperApplicationService.addQuestionToSection(
                examAssembler.toAddPaperQuestionCommand(sectionId, request)
        );
        return ResultUtils.success(id);
    }

    /**
     * 更新题目分值/排序
     */
    @Operation(summary = "更新试卷题目分值/排序")
    @PutMapping("/{paperId}/sections/{sectionId}/questions/{pqId}")
    public BaseResponse<Boolean> updatePaperQuestion(
            @PathVariable Long paperId,
            @PathVariable Long sectionId,
            @PathVariable Long pqId,
            @RequestBody @Valid UpdatePaperQuestionRequest request) {
        examPaperApplicationService.updatePaperQuestion(
                examAssembler.toUpdatePaperQuestionCommand(pqId, request)
        );
        return ResultUtils.success(true);
    }

    /**
     * 从大题移除题目
     */
    @Operation(summary = "从大题移除题目")
    @DeleteMapping("/{paperId}/sections/{sectionId}/questions/{pqId}")
    public BaseResponse<Boolean> removePaperQuestion(
            @PathVariable Long paperId,
            @PathVariable Long sectionId,
            @PathVariable Long pqId) {
        examPaperApplicationService.removePaperQuestion(pqId);
        return ResultUtils.success(true);
    }
}
