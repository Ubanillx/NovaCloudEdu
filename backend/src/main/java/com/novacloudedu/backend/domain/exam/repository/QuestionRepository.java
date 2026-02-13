package com.novacloudedu.backend.domain.exam.repository;

import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.valueobject.QuestionId;
import com.novacloudedu.backend.domain.exam.valueobject.QuestionType;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface QuestionRepository {

    Question save(Question question);

    Optional<Question> findById(QuestionId id);

    List<Question> findByIds(List<QuestionId> ids);

    void deleteById(QuestionId id);

    QuestionPage findByCondition(QuestionQueryCondition condition);

    /**
     * 查询条件
     */
    record QuestionQueryCondition(
            String keyword,
            QuestionType type,
            Subject subject,
            String grade,
            Integer difficulty,
            UserId creatorId,
            int pageNum,
            int pageSize
    ) {
        public static QuestionQueryCondition of(String keyword, QuestionType type, Subject subject,
                                                String grade, Integer difficulty, UserId creatorId,
                                                int pageNum, int pageSize) {
            return new QuestionQueryCondition(keyword, type, subject, grade, difficulty, creatorId, pageNum, pageSize);
        }
    }

    /**
     * 分页结果
     */
    record QuestionPage(
            List<Question> questions,
            long total,
            int pageNum,
            int pageSize
    ) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
