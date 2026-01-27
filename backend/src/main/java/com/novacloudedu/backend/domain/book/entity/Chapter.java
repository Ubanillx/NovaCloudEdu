package com.novacloudedu.backend.domain.book.entity;

import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Chapter {

    private ChapterId id;
    private BookId bookId;
    private String title;
    private Integer chapterIndex;
    private Integer wordCount;
    private String content;
    private String contentHash;
    private String encryptionIv;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static Chapter create(BookId bookId, String title, Integer chapterIndex,
                                String content) {
        Chapter chapter = new Chapter();
        chapter.bookId = bookId;
        chapter.title = title;
        chapter.chapterIndex = chapterIndex;
        chapter.content = content;
        chapter.wordCount = calculateWordCount(content);
        chapter.contentHash = generateContentHash(content);
        chapter.createTime = LocalDateTime.now();
        chapter.updateTime = LocalDateTime.now();
        return chapter;
    }

    public static Chapter reconstruct(ChapterId id, BookId bookId, String title,
                                     Integer chapterIndex, Integer wordCount,
                                     String content, String contentHash,
                                     String encryptionIv,
                                     LocalDateTime createTime, LocalDateTime updateTime) {
        Chapter chapter = new Chapter();
        chapter.id = id;
        chapter.bookId = bookId;
        chapter.title = title;
        chapter.chapterIndex = chapterIndex;
        chapter.wordCount = wordCount;
        chapter.content = content;
        chapter.contentHash = contentHash;
        chapter.encryptionIv = encryptionIv;
        chapter.createTime = createTime;
        chapter.updateTime = updateTime;
        return chapter;
    }

    public void assignId(ChapterId id) {
        if (this.id != null) {
            throw new IllegalStateException("章节ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateContent(String content) {
        this.content = content;
        this.wordCount = calculateWordCount(content);
        this.contentHash = generateContentHash(content);
        this.updateTime = LocalDateTime.now();
    }

    public void setEncryptedContent(String encryptedContent, String iv) {
        this.content = encryptedContent;
        this.encryptionIv = iv;
        this.updateTime = LocalDateTime.now();
    }

    public boolean isEncrypted() {
        return this.encryptionIv != null && !this.encryptionIv.isEmpty();
    }

    private static Integer calculateWordCount(String content) {
        if (content == null || content.isEmpty()) {
            return 0;
        }
        String plainText = content.replaceAll("<[^>]*>", "");
        plainText = plainText.replaceAll("\\s+", "");
        return plainText.length();
    }

    private static String generateContentHash(String content) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(content.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256算法不可用", e);
        }
    }
}
