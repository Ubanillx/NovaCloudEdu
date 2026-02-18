package com.novacloudedu.backend.application.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.application.book.dto.ChapterContentDTO;
import com.novacloudedu.backend.application.book.dto.ChapterDTO;
import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.service.ContentSecurityService;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChapterApplicationService {

    private static final String CACHE_CHAPTER_LIST = "book:chapters:";
    private static final String CACHE_CHAPTER_CONTENT = "book:chapter:";
    private static final long CHAPTER_LIST_TTL_MINUTES = 10;
    private static final long CHAPTER_CONTENT_TTL_MINUTES = 30;

    private final ChapterRepository chapterRepository;
    private final ContentSecurityService contentSecurityService;
    private final StringRedisTemplate redisTemplate;
    private final ObjectMapper objectMapper;
    
    @Value("${book.content.encryption.enabled:false}")
    private boolean encryptionEnabled;
    
    @Value("${book.content.encryption.secret-key:NovaCloudEduBookKey1}")
    private String encryptionSecretKey;

    public List<ChapterDTO> getBookChapters(Long bookId) {
        String cacheKey = CACHE_CHAPTER_LIST + bookId;
        try {
            String cached = redisTemplate.opsForValue().get(cacheKey);
            if (cached != null) {
                return objectMapper.readValue(cached, new TypeReference<List<ChapterDTO>>() {});
            }
        } catch (Exception e) {
            log.warn("读取章节列表缓存失败: {}", e.getMessage());
        }

        List<ChapterDTO> result = chapterRepository.findByBookIdOrderByIndex(BookId.of(bookId)).stream()
                .map(this::toChapterDTO)
                .collect(Collectors.toList());

        try {
            redisTemplate.opsForValue().set(cacheKey, objectMapper.writeValueAsString(result),
                    CHAPTER_LIST_TTL_MINUTES, TimeUnit.MINUTES);
        } catch (Exception e) {
            log.warn("写入章节列表缓存失败: {}", e.getMessage());
        }
        return result;
    }

    public ChapterContentDTO getChapterContent(Long bookId, Integer chapterIndex) {
        Chapter chapter = chapterRepository.findByBookIdAndIndex(
                        BookId.of(bookId), 
                        chapterIndex
                )
                .orElseThrow(() -> new RuntimeException("章节不存在"));

        // 尝试从缓存获取（缓存的是解密后的内容）
        String contentCacheKey = CACHE_CHAPTER_CONTENT + bookId + ":" + chapterIndex;
        try {
            String cached = redisTemplate.opsForValue().get(contentCacheKey);
            if (cached != null) {
                return objectMapper.readValue(cached, ChapterContentDTO.class);
            }
        } catch (Exception e) {
            log.warn("读取章节内容缓存失败: {}", e.getMessage());
        }

        String content = chapter.getContent();
        
        // 如果启用了加密且章节已加密（通过encryptionIv判断），尝试解密内容
        if (encryptionEnabled && chapter.isEncrypted()) {
            try {
                content = contentSecurityService.decrypt(content, encryptionSecretKey, chapter.getEncryptionIv());
            } catch (Exception e) {
                throw new RuntimeException("内容解密失败: " + e.getMessage(), e);
            }
        }

        ChapterContentDTO dto = ChapterContentDTO.builder()
                .id(chapter.getId().value())
                .title(chapter.getTitle())
                .chapterIndex(chapter.getChapterIndex())
                .content(content)
                .wordCount(chapter.getWordCount())
                .build();

        try {
            redisTemplate.opsForValue().set(contentCacheKey, objectMapper.writeValueAsString(dto),
                    CHAPTER_CONTENT_TTL_MINUTES, TimeUnit.MINUTES);
        } catch (Exception e) {
            log.warn("写入章节内容缓存失败: {}", e.getMessage());
        }
        return dto;
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
        evictChapterCache(bookId, chapterIndex);
    }

    /**
     * 批量加密指定书籍的所有未加密章节
     * @param bookId 书籍ID
     * @return 实际加密的章节数量
     */
    public int encryptAllChapters(Long bookId) {
        if (!encryptionEnabled) {
            throw new RuntimeException("加密功能未启用");
        }

        // 一次性查出所有未加密章节（含content字段）
        List<Chapter> unencrypted = chapterRepository.findUnencryptedByBookId(BookId.of(bookId));
        if (unencrypted.isEmpty()) {
            return 0;
        }

        // 内存中批量加密
        for (Chapter chapter : unencrypted) {
            ContentSecurityService.EncryptedContent encrypted =
                    contentSecurityService.encrypt(chapter.getContent(), encryptionSecretKey);
            chapter.setEncryptedContent(encrypted.getContent(), encrypted.getIv());
        }

        // 批量写回数据库，500条为一批
        chapterRepository.batchUpdate(unencrypted, 500);

        evictBookChapterCache(bookId);
        return unencrypted.size();
    }

    private void evictChapterCache(Long bookId, Integer chapterIndex) {
        try {
            redisTemplate.delete(CACHE_CHAPTER_LIST + bookId);
            redisTemplate.delete(CACHE_CHAPTER_CONTENT + bookId + ":" + chapterIndex);
        } catch (Exception e) {
            log.warn("清除章节缓存失败: {}", e.getMessage());
        }
    }

    private void evictBookChapterCache(Long bookId) {
        try {
            redisTemplate.delete(CACHE_CHAPTER_LIST + bookId);
            // 批量删除该书所有章节内容缓存
            var keys = redisTemplate.keys(CACHE_CHAPTER_CONTENT + bookId + ":*");
            if (keys != null && !keys.isEmpty()) {
                redisTemplate.delete(keys);
            }
        } catch (Exception e) {
            log.warn("清除书籍章节缓存失败: {}", e.getMessage());
        }
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
