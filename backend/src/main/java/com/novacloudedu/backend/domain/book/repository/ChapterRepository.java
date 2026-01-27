package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;

import java.util.List;
import java.util.Optional;

public interface ChapterRepository {

    Chapter save(Chapter chapter);

    void saveAll(List<Chapter> chapters);

    Optional<Chapter> findById(ChapterId id);

    Optional<Chapter> findByBookIdAndIndex(BookId bookId, Integer chapterIndex);

    List<Chapter> findByBookId(BookId bookId);

    List<Chapter> findByBookIdOrderByIndex(BookId bookId);

    long countByBookId(BookId bookId);

    void deleteById(ChapterId id);

    void deleteByBookId(BookId bookId);

    List<Chapter> searchByContentKeyword(String keyword, int page, int size);

    List<Chapter> searchByBookIdAndKeyword(Long bookId, String keyword, int page, int size);
}
