package com.novacloudedu.backend.infrastructure.search;

import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.BookRepository;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.service.BookSearchService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * PostgreSQL LIKE 搜索降级方案
 * 当 search.elasticsearch.enabled=false（或未配置）时激活
 */
@Service
@RequiredArgsConstructor
@ConditionalOnProperty(name = "search.elasticsearch.enabled", havingValue = "false", matchIfMissing = true)
public class PostgresBookSearchService implements BookSearchService {

    private final BookRepository bookRepository;
    private final ChapterRepository chapterRepository;

    @Override
    public List<Book> searchBooks(String keyword, int page, int size) {
        // 使用现有的 searchByKeyword 方法
        return bookRepository.searchByKeyword(keyword, page, size);
    }

    @Override
    public List<Chapter> searchChapterContent(String keyword, int page, int size) {
        return chapterRepository.searchByContentKeyword(keyword, page, size);
    }

    @Override
    public List<Chapter> searchInBook(Long bookId, String keyword, int page, int size) {
        return chapterRepository.searchByBookIdAndKeyword(bookId, keyword, page, size);
    }

    @Override
    public String highlightSearchResult(String content, String keyword) {
        if (content == null || keyword == null || keyword.trim().isEmpty()) {
            return content;
        }

        // 使用正则表达式进行大小写不敏感的匹配和高亮
        String escapedKeyword = Pattern.quote(keyword);
        Pattern pattern = Pattern.compile(escapedKeyword, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(content);
        
        StringBuffer result = new StringBuffer();
        while (matcher.find()) {
            matcher.appendReplacement(result, 
                "<mark class=\"search-highlight\">" + matcher.group() + "</mark>");
        }
        matcher.appendTail(result);
        
        return result.toString();
    }
}
