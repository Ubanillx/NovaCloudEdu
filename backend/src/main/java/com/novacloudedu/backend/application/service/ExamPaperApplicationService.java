package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.exam.command.*;
import com.novacloudedu.backend.application.exam.query.ExamPaperQuery;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.exam.entity.ExamPaper;
import com.novacloudedu.backend.domain.exam.entity.PaperQuestion;
import com.novacloudedu.backend.domain.exam.entity.PaperSection;
import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.repository.ExamPaperRepository;
import com.novacloudedu.backend.domain.exam.repository.ExamPaperRepository.ExamPaperPage;
import com.novacloudedu.backend.domain.exam.repository.ExamPaperRepository.ExamPaperQueryCondition;
import com.novacloudedu.backend.domain.exam.repository.PaperQuestionRepository;
import com.novacloudedu.backend.domain.exam.repository.PaperSectionRepository;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository;
import com.novacloudedu.backend.domain.exam.valueobject.*;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.exam.TypstCompileServiceImpl;
import com.novacloudedu.backend.application.service.UserApplicationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 试卷应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ExamPaperApplicationService {

    private final ExamPaperRepository examPaperRepository;
    private final PaperSectionRepository paperSectionRepository;
    private final PaperQuestionRepository paperQuestionRepository;
    private final QuestionRepository questionRepository;
    private final UserApplicationService userApplicationService;
    private final TypstCompileServiceImpl typstCompileService;
    private final ExamTemplateApplicationService examTemplateApplicationService;

    // ==================== 试卷 CRUD ====================

    /**
     * 创建试卷
     */
    @Transactional
    public Long createExamPaper(CreateExamPaperCommand command) {
        User creator = userApplicationService.getCurrentUser();

        ExamPaper paper = ExamPaper.create(
                command.title(),
                command.subtitle(),
                Subject.fromCode(command.subject()),
                command.grade(),
                command.durationMin(),
                command.layout(),
                creator.getId()
        );

        if (command.templateId() != null) {
            paper.updateTemplateId(command.templateId());
        }

        examPaperRepository.save(paper);
        log.info("创建试卷: paperId={}, title={}", paper.getId().value(), command.title());
        return paper.getId().value();
    }

    /**
     * 更新试卷基本信息
     */
    @Transactional
    public void updateExamPaper(UpdateExamPaperCommand command) {
        ExamPaper paper = examPaperRepository.findById(ExamPaperId.of(command.id()))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷不存在"));

        paper.updateBasicInfo(
                command.title(),
                command.subtitle(),
                Subject.fromCode(command.subject()),
                command.grade(),
                command.durationMin(),
                command.layout()
        );
        paper.updateTemplateId(command.templateId());

        examPaperRepository.save(paper);
        log.info("更新试卷: paperId={}", command.id());
    }

    /**
     * 删除试卷（级联删除大题和关联）
     */
    @Transactional
    public void deleteExamPaper(Long id) {
        ExamPaperId paperId = ExamPaperId.of(id);
        examPaperRepository.findById(paperId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷不存在"));

        // 级联删除：先删题目关联，再删大题，最后删试卷
        List<PaperSection> sections = paperSectionRepository.findByPaperId(paperId);
        List<PaperSectionId> sectionIds = sections.stream()
                .map(PaperSection::getId)
                .toList();
        if (!sectionIds.isEmpty()) {
            paperQuestionRepository.deleteBySectionIds(sectionIds);
        }
        paperSectionRepository.deleteByPaperId(paperId);
        examPaperRepository.deleteById(paperId);
        log.info("删除试卷: paperId={}", id);
    }

    /**
     * 获取试卷详情
     */
    @Transactional(readOnly = true)
    public ExamPaper getExamPaperById(Long id) {
        return examPaperRepository.findById(ExamPaperId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷不存在"));
    }

    /**
     * 分页查询试卷
     */
    @Transactional(readOnly = true)
    public ExamPaperPage queryExamPapers(ExamPaperQuery query) {
        User creator = userApplicationService.getCurrentUser();
        Subject subject = query.subject() != null ? Subject.fromCode(query.subject()) : null;
        PaperStatus status = query.status() != null ? PaperStatus.fromCode(query.status()) : null;

        ExamPaperQueryCondition condition = ExamPaperQueryCondition.of(
                query.keyword(),
                subject,
                query.grade(),
                status,
                creator.getId(),
                query.pageNum(),
                query.pageSize()
        );
        return examPaperRepository.findByCondition(condition);
    }

    /**
     * 发布试卷
     */
    @Transactional
    public void publishExamPaper(Long id) {
        ExamPaper paper = examPaperRepository.findById(ExamPaperId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷不存在"));

        // 重新计算总分
        recalculateTotalScore(paper);
        paper.publish();
        examPaperRepository.save(paper);
        log.info("发布试卷: paperId={}", id);
    }

    /**
     * 撤回试卷
     */
    @Transactional
    public void unpublishExamPaper(Long id) {
        ExamPaper paper = examPaperRepository.findById(ExamPaperId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷不存在"));

        paper.unpublish();
        examPaperRepository.save(paper);
        log.info("撤回试卷: paperId={}", id);
    }

    // ==================== 大题管理 ====================

    /**
     * 添加大题
     */
    @Transactional
    public Long addSection(AddPaperSectionCommand command) {
        ExamPaperId paperId = ExamPaperId.of(command.paperId());
        examPaperRepository.findById(paperId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷不存在"));

        QuestionType questionType = command.questionType() != null
                ? QuestionType.fromCode(command.questionType())
                : null;

        PaperSection section = PaperSection.create(
                paperId,
                command.title(),
                command.description(),
                questionType,
                command.sortOrder()
        );

        paperSectionRepository.save(section);
        log.info("添加大题: sectionId={}, paperId={}", section.getId().value(), command.paperId());
        return section.getId().value();
    }

    /**
     * 更新大题
     */
    @Transactional
    public void updateSection(UpdatePaperSectionCommand command) {
        PaperSection section = paperSectionRepository.findById(PaperSectionId.of(command.id()))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "大题不存在"));

        QuestionType questionType = command.questionType() != null
                ? QuestionType.fromCode(command.questionType())
                : null;

        section.update(command.title(), command.description(), questionType, command.sortOrder());
        paperSectionRepository.save(section);
        log.info("更新大题: sectionId={}", command.id());
    }

    /**
     * 删除大题（级联删除关联题目）
     */
    @Transactional
    public void deleteSection(Long id) {
        PaperSectionId sectionId = PaperSectionId.of(id);
        PaperSection section = paperSectionRepository.findById(sectionId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "大题不存在"));

        paperQuestionRepository.deleteBySectionId(sectionId);
        paperSectionRepository.deleteById(sectionId);

        // 重新计算总分
        ExamPaper paper = examPaperRepository.findById(section.getPaperId())
                .orElse(null);
        if (paper != null) {
            recalculateTotalScore(paper);
            examPaperRepository.save(paper);
        }
        log.info("删除大题: sectionId={}", id);
    }

    /**
     * 获取试卷的所有大题
     */
    @Transactional(readOnly = true)
    public List<PaperSection> getSections(Long paperId) {
        return paperSectionRepository.findByPaperId(ExamPaperId.of(paperId));
    }

    // ==================== 题目关联管理 ====================

    /**
     * 向大题添加题目
     */
    @Transactional
    public Long addQuestionToSection(AddPaperQuestionCommand command) {
        PaperSectionId sectionId = PaperSectionId.of(command.sectionId());
        PaperSection section = paperSectionRepository.findById(sectionId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "大题不存在"));

        // 校验题目存在
        QuestionId questionId = QuestionId.of(command.questionId());
        questionRepository.findById(questionId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "题目不存在"));

        PaperQuestion pq = PaperQuestion.create(
                sectionId,
                questionId,
                command.score(),
                command.sortOrder()
        );

        paperQuestionRepository.save(pq);

        // 重新计算总分
        ExamPaper paper = examPaperRepository.findById(section.getPaperId())
                .orElse(null);
        if (paper != null) {
            recalculateTotalScore(paper);
            examPaperRepository.save(paper);
        }

        log.info("添加题目到大题: pqId={}, sectionId={}, questionId={}",
                pq.getId().value(), command.sectionId(), command.questionId());
        return pq.getId().value();
    }

    /**
     * 更新题目分值/排序
     */
    @Transactional
    public void updatePaperQuestion(UpdatePaperQuestionCommand command) {
        PaperQuestion pq = paperQuestionRepository.findById(PaperQuestionId.of(command.id()))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷题目关联不存在"));

        pq.update(command.score(), command.sortOrder());
        paperQuestionRepository.save(pq);

        // 重新计算总分
        PaperSection section = paperSectionRepository.findById(pq.getSectionId())
                .orElse(null);
        if (section != null) {
            ExamPaper paper = examPaperRepository.findById(section.getPaperId())
                    .orElse(null);
            if (paper != null) {
                recalculateTotalScore(paper);
                examPaperRepository.save(paper);
            }
        }

        log.info("更新试卷题目: pqId={}", command.id());
    }

    /**
     * 从大题移除题目
     */
    @Transactional
    public void removePaperQuestion(Long id) {
        PaperQuestion pq = paperQuestionRepository.findById(PaperQuestionId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷题目关联不存在"));

        PaperSectionId sectionId = pq.getSectionId();
        paperQuestionRepository.deleteById(PaperQuestionId.of(id));

        // 重新计算总分
        PaperSection section = paperSectionRepository.findById(sectionId)
                .orElse(null);
        if (section != null) {
            ExamPaper paper = examPaperRepository.findById(section.getPaperId())
                    .orElse(null);
            if (paper != null) {
                recalculateTotalScore(paper);
                examPaperRepository.save(paper);
            }
        }

        log.info("移除试卷题目: pqId={}", id);
    }

    /**
     * 获取大题下的所有题目关联
     */
    @Transactional(readOnly = true)
    public List<PaperQuestion> getPaperQuestions(Long sectionId) {
        return paperQuestionRepository.findBySectionId(PaperSectionId.of(sectionId));
    }

    // ==================== 内部方法 ====================

    // ==================== PDF 预览 & 导出 ====================

    /**
     * 预览试卷 PDF
     */
    @Transactional(readOnly = true)
    public byte[] previewPdf(Long id) {
        return compilePaper(id, "exam_paper", false);
    }

    /**
     * 导出参考答案 PDF
     */
    @Transactional(readOnly = true)
    public byte[] exportAnswerKey(Long id) {
        return compilePaper(id, "answer_key", true);
    }

    /**
     * 编译试卷为 PDF
     */
    private byte[] compilePaper(Long id, String template, boolean includeAnswer) {
        ExamPaper paper = examPaperRepository.findById(ExamPaperId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "试卷不存在"));

        List<PaperSection> sections = paperSectionRepository.findByPaperId(paper.getId());
        List<PaperSectionId> sectionIds = sections.stream().map(PaperSection::getId).toList();
        List<PaperQuestion> allPqs = sectionIds.isEmpty()
                ? List.of()
                : paperQuestionRepository.findBySectionIds(sectionIds);

        // 收集所有题目 ID 并批量查询
        List<QuestionId> questionIds = allPqs.stream().map(PaperQuestion::getQuestionId).toList();
        List<Question> questions = questionIds.isEmpty()
                ? List.of()
                : questionRepository.findByIds(questionIds);
        Map<Long, Question> questionMap = new HashMap<>();
        for (Question q : questions) {
            questionMap.put(q.getId().value(), q);
        }

        // 构建 JSON 数据
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("title", paper.getTitle());
        data.put("subtitle", paper.getSubtitle());
        data.put("paper_size", "a4");
        data.put("columns", 1);

        // 解析 layout JSON
        try {
            if (paper.getLayout() != null && !paper.getLayout().equals("{}")) {
                @SuppressWarnings("unchecked")
                Map<String, Object> layout = new com.fasterxml.jackson.databind.ObjectMapper()
                        .readValue(paper.getLayout(), Map.class);
                if (layout.containsKey("paperSize")) data.put("paper_size", layout.get("paperSize"));
                if (layout.containsKey("columns")) data.put("columns", layout.get("columns"));
                if (layout.containsKey("fontSize")) data.put("font_size", layout.get("fontSize"));
            }
        } catch (Exception e) {
            log.warn("解析 layout JSON 失败: {}", e.getMessage());
        }

        // 构建 sections 数据
        List<Map<String, Object>> sectionsData = new ArrayList<>();
        int questionNumber = 1;

        for (PaperSection section : sections) {
            Map<String, Object> sectionData = new LinkedHashMap<>();
            sectionData.put("title", section.getTitle());
            sectionData.put("description", section.getDescription());

            List<Map<String, Object>> questionsData = new ArrayList<>();
            List<PaperQuestion> sectionPqs = allPqs.stream()
                    .filter(pq -> pq.getSectionId().value().equals(section.getId().value()))
                    .toList();

            for (PaperQuestion pq : sectionPqs) {
                Question q = questionMap.get(pq.getQuestionId().value());
                if (q == null) continue;

                Map<String, Object> qData = new LinkedHashMap<>();
                qData.put("number", questionNumber++);
                qData.put("type", q.getType().getCode());
                qData.put("content", q.getContent());
                qData.put("score", pq.getScore());

                // 解析选项
                if (q.getOptions() != null && !q.getOptions().isBlank()) {
                    try {
                        @SuppressWarnings("unchecked")
                        List<Map<String, String>> opts = new com.fasterxml.jackson.databind.ObjectMapper()
                                .readValue(q.getOptions(), List.class);
                        List<String> optTexts = opts.stream()
                                .map(o -> o.getOrDefault("text", ""))
                                .toList();
                        qData.put("options", optTexts);
                    } catch (Exception e) {
                        log.warn("解析选项 JSON 失败: questionId={}", q.getId().value());
                    }
                }

                if (includeAnswer) {
                    qData.put("answer", q.getAnswer());
                    qData.put("explanation", q.getExplanation());
                }

                questionsData.add(qData);
            }

            sectionData.put("questions", questionsData);
            sectionsData.add(sectionData);
        }

        data.put("sections", sectionsData);

        // 如果试卷关联了自定义模板，使用自定义模板编译
        if (paper.getTemplateId() != null) {
            try {
                String templateContent = examTemplateApplicationService.getTemplateContent(paper.getTemplateId());
                return typstCompileService.compileWithTemplate(templateContent, data);
            } catch (Exception e) {
                log.warn("自定义模板编译失败，回退到系统默认模板: {}", e.getMessage());
            }
        }

        return typstCompileService.compile(template, data);
    }

    // ==================== 内部方法 ====================

    /**
     * 重新计算试卷总分
     */
    private void recalculateTotalScore(ExamPaper paper) {
        List<PaperSection> sections = paperSectionRepository.findByPaperId(paper.getId());
        List<PaperSectionId> sectionIds = sections.stream()
                .map(PaperSection::getId)
                .toList();

        int totalScore = 0;
        if (!sectionIds.isEmpty()) {
            List<PaperQuestion> allQuestions = paperQuestionRepository.findBySectionIds(sectionIds);
            totalScore = allQuestions.stream()
                    .mapToInt(PaperQuestion::getScore)
                    .sum();
        }
        paper.updateTotalScore(totalScore);
    }
}
