package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.ReadingNote;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface ReadingNoteRepository {
    
    ReadingNote save(ReadingNote note);
    
    Optional<ReadingNote> findById(Long id);
    
    List<ReadingNote> findByUserIdAndBookId(UserId userId, BookId bookId);
    
    List<ReadingNote> findByUserIdAndChapterId(UserId userId, ChapterId chapterId);
    
    List<ReadingNote> findByUserId(UserId userId, int page, int size);
    
    long countByUserId(UserId userId);
    
    void deleteById(Long id);
    
    void deleteByUserIdAndBookId(UserId userId, BookId bookId);
}
