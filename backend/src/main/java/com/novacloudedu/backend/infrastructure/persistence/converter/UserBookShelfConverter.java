package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.book.entity.UserBookShelf;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserBookShelfPO;
import org.springframework.stereotype.Component;

@Component
public class UserBookShelfConverter {

    public UserBookShelfPO toUserBookShelfPO(UserBookShelf shelf) {
        UserBookShelfPO po = new UserBookShelfPO();
        po.setUserId(shelf.getUserId().value());
        po.setBookId(shelf.getBookId().value());
        po.setLastChapterIndex(shelf.getLastChapterIndex());
        po.setLastPosition(shelf.getLastPosition());
        po.setReadingProgress(shelf.getReadingProgress());
        po.setAddedTime(shelf.getAddedTime());
        po.setLastReadTime(shelf.getLastReadTime());
        return po;
    }

    public UserBookShelf toUserBookShelf(UserBookShelfPO po) {
        return UserBookShelf.reconstruct(
                UserId.of(po.getUserId()),
                BookId.of(po.getBookId()),
                po.getLastChapterIndex(),
                po.getLastPosition(),
                po.getReadingProgress(),
                po.getAddedTime(),
                po.getLastReadTime()
        );
    }
}
