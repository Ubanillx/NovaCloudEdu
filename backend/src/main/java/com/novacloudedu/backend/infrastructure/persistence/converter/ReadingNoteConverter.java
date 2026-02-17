package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.book.entity.ReadingNote;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ReadingNotePO;
import org.springframework.stereotype.Component;

@Component
public class ReadingNoteConverter {

    public ReadingNotePO toPO(ReadingNote note) {
        ReadingNotePO po = new ReadingNotePO();
        po.setId(note.getId());
        po.setUserId(note.getUserId().value());
        po.setBookId(note.getBookId().value());
        po.setChapterId(note.getChapterId().value());
        po.setChapterIndex(note.getChapterIndex());
        po.setNoteContent(note.getNoteContent());
        po.setSelectedText(note.getSelectedText());
        po.setPositionStart(note.getStartPosition());
        po.setPositionEnd(note.getEndPosition());
        po.setNoteColor(note.getNoteColor());
        po.setCreateTime(note.getCreateTime());
        po.setUpdateTime(note.getUpdateTime());
        return po;
    }

    public ReadingNote toDomain(ReadingNotePO po) {
        if (po == null) {
            return null;
        }
        return ReadingNote.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                BookId.of(po.getBookId()),
                ChapterId.of(po.getChapterId()),
                po.getChapterIndex(),
                po.getNoteContent(),
                po.getSelectedText(),
                po.getPositionStart(),
                po.getPositionEnd(),
                po.getNoteColor(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
