package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.book.entity.ReadingBookmark;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ReadingBookmarkPO;
import org.springframework.stereotype.Component;

@Component
public class ReadingBookmarkConverter {

    public ReadingBookmarkPO toPO(ReadingBookmark bookmark) {
        ReadingBookmarkPO po = new ReadingBookmarkPO();
        po.setId(bookmark.getId());
        po.setUserId(bookmark.getUserId().value());
        po.setBookId(bookmark.getBookId().value());
        po.setChapterId(bookmark.getChapterId().value());
        po.setChapterIndex(bookmark.getChapterIndex());
        po.setPosition(bookmark.getPosition());
        po.setBookmarkName(bookmark.getBookmarkTitle());
        po.setNote(bookmark.getNote());
        po.setCreateTime(bookmark.getCreateTime());
        return po;
    }

    public ReadingBookmark toDomain(ReadingBookmarkPO po) {
        if (po == null) {
            return null;
        }
        return ReadingBookmark.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                BookId.of(po.getBookId()),
                ChapterId.of(po.getChapterId()),
                po.getChapterIndex(),
                po.getPosition(),
                po.getBookmarkName(),
                po.getNote(),
                po.getCreateTime()
        );
    }
}
