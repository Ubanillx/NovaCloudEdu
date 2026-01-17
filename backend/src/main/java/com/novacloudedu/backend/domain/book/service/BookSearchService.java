package com.novacloudedu.backend.domain.book.service;

import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.entity.Chapter;

import java.util.List;

/**
 * 书籍全文搜索服务
 * 使用 PostgreSQL 全文检索功能
 */
public interface BookSearchService {
    
    /**
     * 在书籍标题和作者中搜索
     */
    List<Book> searchBooks(String keyword, int page, int size);
    
    /**
     * 在章节内容中搜索
     */
    List<Chapter> searchChapterContent(String keyword, int page, int size);
    
    /**
     * 在指定书籍的章节中搜索
     */
    List<Chapter> searchInBook(Long bookId, String keyword, int page, int size);
    
    /**
     * 高亮搜索结果
     */
    String highlightSearchResult(String content, String keyword);
}
