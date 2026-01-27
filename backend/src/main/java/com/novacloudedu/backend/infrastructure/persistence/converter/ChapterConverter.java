package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.infrastructure.persistence.po.ChapterPO;
import org.springframework.stereotype.Component;

@Component
public class ChapterConverter {

    public ChapterPO toChapterPO(Chapter chapter) {
        ChapterPO po = new ChapterPO();
        if (chapter.getId() != null) {
            po.setId(chapter.getId().value());
        }
        po.setBookId(chapter.getBookId().value());
        po.setTitle(chapter.getTitle());
        po.setChapterIndex(chapter.getChapterIndex());
        po.setWordCount(chapter.getWordCount());
        po.setContent(chapter.getContent());
        po.setContentHash(chapter.getContentHash());
        po.setEncryptionIv(chapter.getEncryptionIv());
        po.setCreateTime(chapter.getCreateTime());
        po.setUpdateTime(chapter.getUpdateTime());
        return po;
    }

    public Chapter toChapter(ChapterPO po) {
        return Chapter.reconstruct(
                ChapterId.of(po.getId()),
                BookId.of(po.getBookId()),
                po.getTitle(),
                po.getChapterIndex(),
                po.getWordCount(),
                po.getContent(),
                po.getContentHash(),
                po.getEncryptionIv(),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
