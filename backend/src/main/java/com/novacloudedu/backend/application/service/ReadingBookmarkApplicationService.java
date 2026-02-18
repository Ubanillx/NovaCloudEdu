package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.book.dto.ReadingBookmarkDTO;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.book.entity.ReadingBookmark;
import com.novacloudedu.backend.domain.book.repository.ReadingBookmarkRepository;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReadingBookmarkApplicationService {

    private final ReadingBookmarkRepository readingBookmarkRepository;

    @Transactional
    public ReadingBookmarkDTO createBookmark(Long bookId, Long userId, Long chapterId,
                                             Integer chapterIndex, Integer position,
                                             String bookmarkTitle, String note) {
        ReadingBookmark bookmark = ReadingBookmark.create(
                UserId.of(userId),
                BookId.of(bookId),
                ChapterId.of(chapterId),
                chapterIndex,
                position,
                bookmarkTitle,
                note
        );
        ReadingBookmark saved = readingBookmarkRepository.save(bookmark);
        log.info("阅读书签创建成功: bookmarkId={}, userId={}, bookId={}", saved.getId(), userId, bookId);
        return ReadingBookmarkDTO.from(saved);
    }

    public List<ReadingBookmarkDTO> getBookmarksByBook(Long bookId, Long userId) {
        List<ReadingBookmark> bookmarks = readingBookmarkRepository.findByUserIdAndBookId(
                UserId.of(userId), BookId.of(bookId));
        return bookmarks.stream().map(ReadingBookmarkDTO::from).collect(Collectors.toList());
    }

    @Transactional
    public ReadingBookmarkDTO updateBookmark(Long bookmarkId, String bookmarkTitle, String note) {
        ReadingBookmark bookmark = readingBookmarkRepository.findById(bookmarkId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "书签不存在"));

        if (bookmarkTitle != null) {
            bookmark.updateTitle(bookmarkTitle);
        }
        if (note != null) {
            bookmark.updateNote(note);
        }

        ReadingBookmark updated = readingBookmarkRepository.save(bookmark);
        log.info("阅读书签更新成功: bookmarkId={}", bookmarkId);
        return ReadingBookmarkDTO.from(updated);
    }

    @Transactional
    public void deleteBookmark(Long bookmarkId) {
        readingBookmarkRepository.findById(bookmarkId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "书签不存在"));
        readingBookmarkRepository.deleteById(bookmarkId);
        log.info("阅读书签删除成功: bookmarkId={}", bookmarkId);
    }
}
