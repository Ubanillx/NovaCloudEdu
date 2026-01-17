package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.book.entity.Book;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.BookStatus;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.BookPO;
import org.springframework.stereotype.Component;

@Component
public class BookConverter {

    public BookPO toBookPO(Book book) {
        BookPO po = new BookPO();
        if (book.getId() != null) {
            po.setId(book.getId().value());
        }
        po.setTitle(book.getTitle());
        po.setAuthor(book.getAuthor());
        po.setCoverUrl(book.getCoverUrl());
        po.setOriginFileUrl(book.getOriginFileUrl());
        po.setFileType(book.getFileType().getCode());
        po.setStatus(book.getStatus().getCode());
        po.setTotalChapters(book.getTotalChapters());
        po.setWordCount(book.getWordCount());
        po.setFileSize(book.getFileSize());
        po.setAdminId(book.getAdminId().value());
        po.setCreateTime(book.getCreateTime());
        po.setUpdateTime(book.getUpdateTime());
        return po;
    }

    public Book toBook(BookPO po) {
        return Book.reconstruct(
                BookId.of(po.getId()),
                po.getTitle(),
                po.getAuthor(),
                po.getCoverUrl(),
                po.getOriginFileUrl(),
                FileType.fromCode(po.getFileType()),
                BookStatus.fromCode(po.getStatus()),
                po.getTotalChapters(),
                po.getWordCount(),
                po.getFileSize(),
                UserId.of(po.getAdminId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
