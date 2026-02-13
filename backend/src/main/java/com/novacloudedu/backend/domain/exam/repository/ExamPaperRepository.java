package com.novacloudedu.backend.domain.exam.repository;

import com.novacloudedu.backend.domain.exam.entity.ExamPaper;
import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperStatus;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface ExamPaperRepository {

    ExamPaper save(ExamPaper paper);

    Optional<ExamPaper> findById(ExamPaperId id);

    void deleteById(ExamPaperId id);

    ExamPaperPage findByCondition(ExamPaperQueryCondition condition);

    /**
     * 查询条件
     */
    record ExamPaperQueryCondition(
            String keyword,
            Subject subject,
            String grade,
            PaperStatus status,
            UserId creatorId,
            int pageNum,
            int pageSize
    ) {
        public static ExamPaperQueryCondition of(String keyword, Subject subject, String grade,
                                                 PaperStatus status, UserId creatorId,
                                                 int pageNum, int pageSize) {
            return new ExamPaperQueryCondition(keyword, subject, grade, status, creatorId, pageNum, pageSize);
        }
    }

    /**
     * 分页结果
     */
    record ExamPaperPage(
            List<ExamPaper> papers,
            long total,
            int pageNum,
            int pageSize
    ) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
