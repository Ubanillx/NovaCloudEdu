package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.ReadingBookmark;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface ReadingBookmarkRepository {
    
    ReadingBookmark save(ReadingBookmark bookmark);
    
    Optional<ReadingBookmark> findById(Long id);
    
    List<ReadingBookmark> findByUserIdAndBookId(UserId userId, BookId bookId);
    
    List<ReadingBookmark> findByUserIdAndChapterId(UserId userId, ChapterId chapterId);
    
    List<ReadingBookmark> findByUserId(UserId userId, int page, int size);
    
    long countByUserId(UserId userId);
    
    void deleteById(Long id);
    
    void deleteByUserIdAndBookId(UserId userId, BookId bookId);
}
