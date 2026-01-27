package com.novacloudedu.backend.application.book.service;

import com.novacloudedu.backend.application.book.dto.ChapterContentDTO;
import com.novacloudedu.backend.application.book.dto.ChapterDTO;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.service.ContentSecurityService;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ChapterApplicationService {

    private final ChapterRepository chapterRepository;
    private final ContentSecurityService contentSecurityService;
    
    @Value("${book.content.encryption.enabled:false}")
    private boolean encryptionEnabled;
    
    @Value("${book.content.encryption.secret-key:NovaCloudEduBookKey1}")
    private String encryptionSecretKey;

    public List<ChapterDTO> getBookChapters(Long bookId) {
        return chapterRepository.findByBookIdOrderByIndex(BookId.of(bookId)).stream()
                .map(this::toChapterDTO)
                .collect(Collectors.toList());
    }

    public ChapterContentDTO getChapterContent(Long bookId, Integer chapterIndex) {
        Chapter chapter = chapterRepository.findByBookIdAndIndex(
                        BookId.of(bookId), 
                        chapterIndex
                )
                .orElseThrow(() -> new RuntimeException("章节不存在"));

        String content = chapter.getContent();
        
        // 如果启用了加密且内容已加密,尝试解密内容
        if (encryptionEnabled && isEncrypted(content) && chapter.getEncryptionIv() != null) {
            try {
                content = contentSecurityService.decrypt(content, encryptionSecretKey, chapter.getEncryptionIv());
            } catch (Exception e) {
                throw new RuntimeException("内容解密失败: " + e.getMessage(), e);
            }
        }

        return ChapterContentDTO.builder()
                .id(chapter.getId().value())
                .title(chapter.getTitle())
                .chapterIndex(chapter.getChapterIndex())
                .content(content)
                .wordCount(chapter.getWordCount())
                .build();
    }
    
    /**
     * 加密指定章节的内容
     * @param bookId 书籍ID
     * @param chapterIndex 章节序号
     */
    public void encryptChapterContent(Long bookId, Integer chapterIndex) {
        if (!encryptionEnabled) {
            throw new RuntimeException("加密功能未启用");
        }
        
        Chapter chapter = chapterRepository.findByBookIdAndIndex(BookId.of(bookId), chapterIndex)
                .orElseThrow(() -> new RuntimeException("章节不存在"));
        
        if (chapter.isEncrypted()) {
            throw new RuntimeException("章节内容已加密");
        }
        
        String originalContent = chapter.getContent();
        ContentSecurityService.EncryptedContent encrypted = 
                contentSecurityService.encrypt(originalContent, encryptionSecretKey);
        
        chapter.setEncryptedContent(encrypted.getContent(), encrypted.getIv());
        chapterRepository.save(chapter);
    }

    /**
     * 简单判断内容是否已加密(Base64编码的内容)
     */
    private boolean isEncrypted(String content) {
        if (content == null || content.isEmpty()) {
            return false;
        }
        // 加密后的内容是Base64编码,不包含HTML标签
        return !content.contains("<") && !content.contains(">");
    }

    private ChapterDTO toChapterDTO(Chapter chapter) {
        return ChapterDTO.builder()
                .id(chapter.getId().value())
                .bookId(chapter.getBookId().value())
                .title(chapter.getTitle())
                .chapterIndex(chapter.getChapterIndex())
                .wordCount(chapter.getWordCount())
                .build();
    }
}
