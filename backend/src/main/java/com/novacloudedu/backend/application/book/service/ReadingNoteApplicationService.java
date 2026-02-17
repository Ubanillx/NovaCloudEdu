package com.novacloudedu.backend.application.book.service;

import com.novacloudedu.backend.application.book.command.CreateReadingNoteCommand;
import com.novacloudedu.backend.application.book.dto.ReadingNoteDTO;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.book.entity.ReadingNote;
import com.novacloudedu.backend.domain.book.repository.ReadingNoteRepository;
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
public class ReadingNoteApplicationService {

    private final ReadingNoteRepository readingNoteRepository;

    @Transactional
    public ReadingNoteDTO createNote(Long bookId, CreateReadingNoteCommand command) {
        ReadingNote note = ReadingNote.create(
                UserId.of(command.getUserId()),
                BookId.of(bookId),
                ChapterId.of(command.getChapterId()),
                command.getChapterIndex(),
                command.getNoteContent(),
                command.getSelectedText(),
                command.getStartPosition(),
                command.getEndPosition(),
                command.getNoteColor()
        );
        ReadingNote saved = readingNoteRepository.save(note);
        log.info("阅读笔记创建成功: noteId={}, userId={}, bookId={}", saved.getId(), command.getUserId(), bookId);
        return ReadingNoteDTO.from(saved);
    }

    public List<ReadingNoteDTO> getNotesByBook(Long bookId, Long userId) {
        List<ReadingNote> notes = readingNoteRepository.findByUserIdAndBookId(
                UserId.of(userId), BookId.of(bookId));
        return notes.stream().map(ReadingNoteDTO::from).collect(Collectors.toList());
    }

    public List<ReadingNoteDTO> getNotesByChapter(Long bookId, Long chapterId, Long userId) {
        List<ReadingNote> notes = readingNoteRepository.findByUserIdAndChapterId(
                UserId.of(userId), ChapterId.of(chapterId));
        return notes.stream().map(ReadingNoteDTO::from).collect(Collectors.toList());
    }

    @Transactional
    public ReadingNoteDTO updateNote(Long noteId, String noteContent, String noteColor) {
        ReadingNote note = readingNoteRepository.findById(noteId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "笔记不存在"));

        if (noteContent != null) {
            note.updateContent(noteContent);
        }
        if (noteColor != null) {
            note.updateColor(noteColor);
        }

        ReadingNote updated = readingNoteRepository.save(note);
        log.info("阅读笔记更新成功: noteId={}", noteId);
        return ReadingNoteDTO.from(updated);
    }

    @Transactional
    public void deleteNote(Long noteId) {
        readingNoteRepository.findById(noteId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "笔记不存在"));
        readingNoteRepository.deleteById(noteId);
        log.info("阅读笔记删除成功: noteId={}", noteId);
    }
}
