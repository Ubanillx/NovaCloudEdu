package com.novacloudedu.backend.interfaces.rest.exam.assembler;

import com.novacloudedu.backend.application.exam.command.*;
import com.novacloudedu.backend.application.exam.query.ExamPaperQuery;
import com.novacloudedu.backend.application.exam.query.QuestionQuery;
import com.novacloudedu.backend.domain.exam.entity.ExamPaper;
import com.novacloudedu.backend.domain.exam.entity.PaperQuestion;
import com.novacloudedu.backend.domain.exam.entity.PaperSection;
import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.repository.ExamPaperRepository.ExamPaperPage;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository.QuestionPage;
import com.novacloudedu.backend.interfaces.rest.exam.dto.request.*;
import com.novacloudedu.backend.interfaces.rest.exam.dto.response.*;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 试卷系统组装器
 */
@Component
public class ExamAssembler {

    // ==================== Question ====================

    public CreateQuestionCommand toCreateQuestionCommand(CreateQuestionRequest request) {
        return new CreateQuestionCommand(
                request.type(), request.subject(), request.grade(),
                request.difficulty(), request.content(), request.options(),
                request.answer(), request.explanation(), request.knowledgeTags(),
                request.imageUrl(), request.source()
        );
    }

    public UpdateQuestionCommand toUpdateQuestionCommand(UpdateQuestionRequest request) {
        return new UpdateQuestionCommand(
                request.id(), request.type(), request.subject(), request.grade(),
                request.difficulty(), request.content(), request.options(),
                request.answer(), request.explanation(), request.knowledgeTags(),
                request.imageUrl()
        );
    }

    public QuestionQuery toQuestionQuery(QueryQuestionRequest request) {
        return new QuestionQuery(
                request.keyword(), request.type(), request.subject(),
                request.grade(), request.difficulty(),
                request.getPageNum(), request.getPageSize()
        );
    }

    public QuestionResponse toQuestionResponse(Question question) {
        return new QuestionResponse(
                question.getId().value(),
                question.getType().getCode(),
                question.getType().getDescription(),
                question.getSubject().getCode(),
                question.getSubject().getDescription(),
                question.getGrade(),
                question.getDifficulty().getLevel(),
                question.getDifficulty().getDescription(),
                question.getContent(),
                question.getOptions(),
                question.getAnswer(),
                question.getExplanation(),
                question.getKnowledgeTags(),
                question.getImageUrl(),
                question.getSource().getCode(),
                question.getCreatorId().value(),
                question.getCreateTime(),
                question.getUpdateTime()
        );
    }

    public QuestionPageResponse toQuestionPageResponse(QuestionPage page) {
        List<QuestionResponse> records = page.questions().stream()
                .map(this::toQuestionResponse)
                .toList();
        return new QuestionPageResponse(
                records, page.total(), page.pageNum(), page.pageSize(), page.getTotalPages()
        );
    }

    // ==================== ExamPaper ====================

    public CreateExamPaperCommand toCreateExamPaperCommand(CreateExamPaperRequest request) {
        return new CreateExamPaperCommand(
                request.title(), request.subtitle(), request.subject(),
                request.grade(), request.durationMin(), request.layout(),
                request.templateId()
        );
    }

    public UpdateExamPaperCommand toUpdateExamPaperCommand(UpdateExamPaperRequest request) {
        return new UpdateExamPaperCommand(
                request.id(), request.title(), request.subtitle(),
                request.subject(), request.grade(), request.durationMin(), request.layout(),
                request.templateId()
        );
    }

    public ExamPaperQuery toExamPaperQuery(QueryExamPaperRequest request) {
        return new ExamPaperQuery(
                request.keyword(), request.subject(), request.grade(),
                request.status(), request.getPageNum(), request.getPageSize()
        );
    }

    public ExamPaperResponse toExamPaperResponse(ExamPaper paper) {
        return new ExamPaperResponse(
                paper.getId().value(),
                paper.getTitle(),
                paper.getSubtitle(),
                paper.getSubject().getCode(),
                paper.getSubject().getDescription(),
                paper.getGrade(),
                paper.getTotalScore(),
                paper.getDurationMin(),
                paper.getLayout(),
                paper.getStatus().getCode(),
                paper.getStatus().getDescription(),
                paper.getTemplateId(),
                paper.getCreatorId().value(),
                paper.getCreateTime(),
                paper.getUpdateTime()
        );
    }

    public ExamPaperPageResponse toExamPaperPageResponse(ExamPaperPage page) {
        List<ExamPaperResponse> records = page.papers().stream()
                .map(this::toExamPaperResponse)
                .toList();
        return new ExamPaperPageResponse(
                records, page.total(), page.pageNum(), page.pageSize(), page.getTotalPages()
        );
    }

    // ==================== PaperSection ====================

    public AddPaperSectionCommand toAddSectionCommand(Long paperId, AddPaperSectionRequest request) {
        return new AddPaperSectionCommand(
                paperId, request.title(), request.description(),
                request.questionType(), request.sortOrder()
        );
    }

    public PaperSectionResponse toPaperSectionResponse(PaperSection section) {
        String questionTypeDesc = section.getQuestionType() != null
                ? section.getQuestionType().getDescription()
                : null;
        return new PaperSectionResponse(
                section.getId().value(),
                section.getPaperId().value(),
                section.getTitle(),
                section.getDescription(),
                section.getQuestionType() != null ? section.getQuestionType().getCode() : null,
                questionTypeDesc,
                section.getSortOrder(),
                section.getCreateTime(),
                section.getUpdateTime()
        );
    }

    // ==================== PaperQuestion ====================

    public AddPaperQuestionCommand toAddPaperQuestionCommand(Long sectionId, AddPaperQuestionRequest request) {
        return new AddPaperQuestionCommand(
                sectionId, request.questionId(), request.score(), request.sortOrder()
        );
    }

    public UpdatePaperQuestionCommand toUpdatePaperQuestionCommand(Long id, UpdatePaperQuestionRequest request) {
        return new UpdatePaperQuestionCommand(id, request.score(), request.sortOrder());
    }

    public PaperQuestionResponse toPaperQuestionResponse(PaperQuestion pq) {
        return new PaperQuestionResponse(
                pq.getId().value(),
                pq.getSectionId().value(),
                pq.getQuestionId().value(),
                pq.getScore(),
                pq.getSortOrder(),
                pq.getCreateTime(),
                pq.getUpdateTime()
        );
    }
}
