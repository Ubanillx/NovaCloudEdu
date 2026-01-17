package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.novacloudedu.backend.domain.book.entity.ReadingQuiz;
import com.novacloudedu.backend.domain.book.repository.ReadingQuizRepository;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.QuestionDifficulty;
import com.novacloudedu.backend.domain.book.valueobject.QuestionType;
import com.novacloudedu.backend.domain.book.valueobject.ReadingQuizId;
import com.novacloudedu.backend.infrastructure.persistence.mapper.ReadingQuizMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ReadingQuizPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 阅读测试仓储实现
 */
@Repository
@RequiredArgsConstructor
public class ReadingQuizRepositoryImpl implements ReadingQuizRepository {

    private final ReadingQuizMapper mapper;

    @Override
    public ReadingQuiz save(ReadingQuiz quiz) {
        ReadingQuizPO po = toPO(quiz);
        
        if (po.getId() == null) {
            po.setCreateTime(LocalDateTime.now());
            po.setIsDelete(0);
            mapper.insert(po);
        } else {
            mapper.updateById(po);
        }
        
        return toDomain(po);
    }

    @Override
    public Optional<ReadingQuiz> findById(ReadingQuizId id) {
        ReadingQuizPO po = mapper.selectById(id.getValue());
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public List<ReadingQuiz> findByChapterId(ChapterId chapterId) {
        List<ReadingQuizPO> pos = mapper.findByChapterId(chapterId.value());
        return pos.stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public Optional<ReadingQuiz> findLatestByChapterId(ChapterId chapterId) {
        ReadingQuizPO po = mapper.findLatestByChapterId(chapterId.value());
        return Optional.ofNullable(po).map(this::toDomain);
    }

    @Override
    public void delete(ReadingQuizId id) {
        mapper.deleteById(id.getValue());
    }

    @Override
    public void deleteByChapterId(ChapterId chapterId) {
        mapper.deleteByChapterId(chapterId.value());
    }

    private ReadingQuizPO toPO(ReadingQuiz quiz) {
        ReadingQuizPO po = new ReadingQuizPO();
        if (quiz.getId() != null) {
            po.setId(quiz.getId().getValue());
        }
        po.setChapterId(quiz.getChapterId().value());
        
        // 转换问题列表
        List<Map<String, Object>> questions = quiz.getQuestions().stream()
                .map(q -> Map.<String, Object>of(
                        "type", q.getType().name(),
                        "difficulty", q.getDifficulty().name(),
                        "question", q.getQuestion(),
                        "options", q.getOptions(),
                        "correctAnswer", q.getCorrectAnswer(),
                        "explanation", q.getExplanation()
                ))
                .collect(Collectors.toList());
        po.setQuestions(questions);
        
        po.setAiModel(quiz.getAiModel());
        return po;
    }

    @SuppressWarnings("unchecked")
    private ReadingQuiz toDomain(ReadingQuizPO po) {
        // 转换问题列表
        List<ReadingQuiz.QuizQuestion> questions = po.getQuestions().stream()
                .map(q -> ReadingQuiz.QuizQuestion.create(
                        QuestionType.valueOf((String) q.get("type")),
                        QuestionDifficulty.valueOf((String) q.get("difficulty")),
                        (String) q.get("question"),
                        (List<String>) q.get("options"),
                        (String) q.get("correctAnswer"),
                        (String) q.get("explanation")
                ))
                .collect(Collectors.toList());

        return ReadingQuiz.reconstruct(
                ReadingQuizId.of(po.getId()),
                ChapterId.of(po.getChapterId()),
                questions,
                po.getAiModel(),
                po.getCreateTime()
        );
    }
}
