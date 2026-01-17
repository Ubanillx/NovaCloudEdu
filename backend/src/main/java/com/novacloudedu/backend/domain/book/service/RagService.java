package com.novacloudedu.backend.domain.book.service;

import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;

import java.util.List;

/**
 * RAG（检索增强生成）服务接口
 */
public interface RagService {

    /**
     * RAG搜索结果
     */
    class RagSearchResult {
        private final ChapterId chapterId;
        private final String chapterTitle;
        private final String content;
        private final double similarity;

        public RagSearchResult(ChapterId chapterId, String chapterTitle, String content, double similarity) {
            this.chapterId = chapterId;
            this.chapterTitle = chapterTitle;
            this.content = content;
            this.similarity = similarity;
        }

        public ChapterId getChapterId() {
            return chapterId;
        }

        public String getChapterTitle() {
            return chapterTitle;
        }

        public String getContent() {
            return content;
        }

        public double getSimilarity() {
            return similarity;
        }
    }

    /**
     * 基于问题检索相关章节内容
     * 
     * @param bookId 书籍ID
     * @param question 用户问题
     * @param topK 返回Top-K个结果
     * @return 相关章节列表
     */
    List<RagSearchResult> retrieveRelevantChapters(BookId bookId, String question, int topK);

    /**
     * 基于问题检索特定章节的相关内容
     * 
     * @param chapterId 章节ID
     * @param question 用户问题
     * @param topK 返回Top-K个结果
     * @return 相关内容片段列表
     */
    List<RagSearchResult> retrieveRelevantContent(ChapterId chapterId, String question, int topK);

    /**
     * 生成RAG增强的回答
     * 
     * @param bookId 书籍ID
     * @param question 用户问题
     * @param conversationHistory 对话历史
     * @return AI回答及来源
     */
    RagAnswer generateAnswer(BookId bookId, String question, List<String> conversationHistory);

    /**
     * RAG回答结果
     */
    class RagAnswer {
        private final String answer;
        private final List<RagSearchResult> sources;
        private final double confidence;

        public RagAnswer(String answer, List<RagSearchResult> sources, double confidence) {
            this.answer = answer;
            this.sources = sources;
            this.confidence = confidence;
        }

        public String getAnswer() {
            return answer;
        }

        public List<RagSearchResult> getSources() {
            return sources;
        }

        public double getConfidence() {
            return confidence;
        }
    }
}
