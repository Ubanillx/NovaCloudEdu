package com.novacloudedu.backend.application.exam.service;

import com.novacloudedu.backend.application.exam.command.CreateQuestionCommand;
import com.novacloudedu.backend.application.exam.command.UpdateQuestionCommand;
import com.novacloudedu.backend.application.exam.query.QuestionQuery;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository.QuestionPage;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository.QuestionQueryCondition;
import com.novacloudedu.backend.domain.exam.valueobject.*;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.application.service.UserApplicationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 题库应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class QuestionBankApplicationService {

    private final QuestionRepository questionRepository;
    private final UserApplicationService userApplicationService;

    /**
     * 创建题目
     */
    @Transactional
    public Long createQuestion(CreateQuestionCommand command) {
        User creator = userApplicationService.getCurrentUser();

        QuestionSource source = command.source() != null
                ? QuestionSource.fromCode(command.source())
                : QuestionSource.MANUAL;

        Question question = Question.create(
                QuestionType.fromCode(command.type()),
                Subject.fromCode(command.subject()),
                command.grade(),
                DifficultyLevel.fromLevel(command.difficulty()),
                command.content(),
                command.options(),
                command.answer(),
                command.explanation(),
                command.knowledgeTags(),
                command.imageUrl(),
                source,
                creator.getId()
        );

        questionRepository.save(question);
        log.info("创建题目: questionId={}, type={}, subject={}",
                question.getId().value(), command.type(), command.subject());
        return question.getId().value();
    }

    /**
     * 更新题目
     */
    @Transactional
    public void updateQuestion(UpdateQuestionCommand command) {
        Question question = questionRepository.findById(QuestionId.of(command.id()))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "题目不存在"));

        question.update(
                QuestionType.fromCode(command.type()),
                Subject.fromCode(command.subject()),
                command.grade(),
                DifficultyLevel.fromLevel(command.difficulty()),
                command.content(),
                command.options(),
                command.answer(),
                command.explanation(),
                command.knowledgeTags(),
                command.imageUrl()
        );

        questionRepository.save(question);
        log.info("更新题目: questionId={}", command.id());
    }

    /**
     * 删除题目
     */
    @Transactional
    public void deleteQuestion(Long id) {
        QuestionId questionId = QuestionId.of(id);
        questionRepository.findById(questionId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "题目不存在"));

        questionRepository.deleteById(questionId);
        log.info("删除题目: questionId={}", id);
    }

    /**
     * 获取题目详情
     */
    @Transactional(readOnly = true)
    public Question getQuestionById(Long id) {
        return questionRepository.findById(QuestionId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "题目不存在"));
    }

    /**
     * 分页查询题目
     */
    @Transactional(readOnly = true)
    public QuestionPage queryQuestions(QuestionQuery query) {
        QuestionType type = query.type() != null ? QuestionType.fromCode(query.type()) : null;
        Subject subject = query.subject() != null ? Subject.fromCode(query.subject()) : null;

        QuestionQueryCondition condition = QuestionQueryCondition.of(
                query.keyword(),
                type,
                subject,
                query.grade(),
                query.difficulty(),
                null,
                query.pageNum(),
                query.pageSize()
        );
        return questionRepository.findByCondition(condition);
    }

    /**
     * 查询我的题目
     */
    @Transactional(readOnly = true)
    public QuestionPage queryMyQuestions(QuestionQuery query) {
        User creator = userApplicationService.getCurrentUser();
        QuestionType type = query.type() != null ? QuestionType.fromCode(query.type()) : null;
        Subject subject = query.subject() != null ? Subject.fromCode(query.subject()) : null;

        QuestionQueryCondition condition = QuestionQueryCondition.of(
                query.keyword(),
                type,
                subject,
                query.grade(),
                query.difficulty(),
                creator.getId(),
                query.pageNum(),
                query.pageSize()
        );
        return questionRepository.findByCondition(condition);
    }
}
