package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.dailylearning.command.*;
import com.novacloudedu.backend.application.recommendation.service.GraphDataSyncService;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyArticle;
import com.novacloudedu.backend.domain.dailylearning.entity.UserDailyWord;
import com.novacloudedu.backend.domain.dailylearning.entity.UserWordBook;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.UserDailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.repository.UserWordBookRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.dailylearning.valueobject.LearningStatus;
import com.novacloudedu.backend.domain.dailylearning.valueobject.MasteryLevel;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 每日学习应用服务
 * 负责每日文章、每日单词的CRUD及用户交互用例编排
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class DailyLearningApplicationService {

    private final DailyArticleRepository dailyArticleRepository;
    private final DailyWordRepository dailyWordRepository;
    private final UserDailyArticleRepository userDailyArticleRepository;
    private final UserDailyWordRepository userDailyWordRepository;
    private final UserWordBookRepository userWordBookRepository;
    private final GraphDataSyncService graphDataSyncService;

    // ==================== 每日文章管理 ====================

    @Transactional
    public Long createDailyArticle(CreateDailyArticleCommand command, UserId adminId) {
        DailyArticle article = DailyArticle.create(
                command.title(), command.content(), command.summary(), command.coverImage(),
                command.author(), command.source(), command.sourceUrl(), command.category(),
                command.tags(), Difficulty.fromCode(command.difficulty()), command.readTime(),
                command.publishDate(), adminId
        );
        dailyArticleRepository.save(article);
        graphDataSyncService.syncArticleToGraph(article);
        log.info("每日文章创建成功: articleId={}", article.getId().value());
        return article.getId().value();
    }

    @Transactional
    public void updateDailyArticle(UpdateDailyArticleCommand command) {
        DailyArticle article = dailyArticleRepository.findById(DailyArticleId.of(command.articleId()))
                .orElseThrow(() -> new BusinessException(40400, "每日文章不存在"));
        article.updateInfo(command.title(), command.content(), command.summary(), command.coverImage(),
                command.author(), command.source(), command.sourceUrl(), command.category(),
                command.tags(), Difficulty.fromCode(command.difficulty()), command.readTime(), command.publishDate());
        dailyArticleRepository.save(article);
        graphDataSyncService.syncArticleToGraph(article);
        log.info("每日文章更新成功: articleId={}", command.articleId());
    }

    @Transactional
    public void deleteDailyArticle(Long articleId) {
        dailyArticleRepository.deleteById(DailyArticleId.of(articleId));
        log.info("每日文章删除成功: articleId={}", articleId);
    }

    // ==================== 文章交互 ====================

    @Transactional
    public void markArticleAsRead(Long userId, Long articleId) {
        DailyArticleId dailyArticleId = DailyArticleId.of(articleId);
        UserId userIdObj = UserId.of(userId);

        DailyArticle article = dailyArticleRepository.findById(dailyArticleId)
                .orElseThrow(() -> new BusinessException(40400, "文章不存在"));

        UserDailyArticle userDailyArticle = userDailyArticleRepository
                .findByUserIdAndArticleId(userIdObj, dailyArticleId)
                .orElseGet(() -> UserDailyArticle.create(userIdObj, dailyArticleId));

        article.handleRead(userDailyArticle);
        dailyArticleRepository.save(article);
        userDailyArticleRepository.save(userDailyArticle);
    }

    @Transactional
    public void toggleArticleLike(Long userId, Long articleId) {
        DailyArticleId dailyArticleId = DailyArticleId.of(articleId);
        UserId userIdObj = UserId.of(userId);

        DailyArticle article = dailyArticleRepository.findById(dailyArticleId)
                .orElseThrow(() -> new BusinessException(40400, "文章不存在"));

        UserDailyArticle userDailyArticle = userDailyArticleRepository
                .findByUserIdAndArticleId(userIdObj, dailyArticleId)
                .orElseGet(() -> UserDailyArticle.create(userIdObj, dailyArticleId));

        article.handleLikeToggle(userDailyArticle);
        dailyArticleRepository.save(article);
        userDailyArticleRepository.save(userDailyArticle);
    }

    @Transactional
    public void toggleArticleCollect(Long userId, Long articleId) {
        DailyArticleId dailyArticleId = DailyArticleId.of(articleId);
        UserId userIdObj = UserId.of(userId);

        DailyArticle article = dailyArticleRepository.findById(dailyArticleId)
                .orElseThrow(() -> new BusinessException(40400, "文章不存在"));

        UserDailyArticle userDailyArticle = userDailyArticleRepository
                .findByUserIdAndArticleId(userIdObj, dailyArticleId)
                .orElseGet(() -> UserDailyArticle.create(userIdObj, dailyArticleId));

        article.handleCollectToggle(userDailyArticle);
        dailyArticleRepository.save(article);
        userDailyArticleRepository.save(userDailyArticle);
    }

    @Transactional
    public void addArticleComment(Long userId, Long articleId, String content) {
        DailyArticleId dailyArticleId = DailyArticleId.of(articleId);
        UserId userIdObj = UserId.of(userId);

        dailyArticleRepository.findById(dailyArticleId)
                .orElseThrow(() -> new BusinessException(40400, "文章不存在"));

        UserDailyArticle userDailyArticle = userDailyArticleRepository
                .findByUserIdAndArticleId(userIdObj, dailyArticleId)
                .orElseGet(() -> UserDailyArticle.create(userIdObj, dailyArticleId));

        userDailyArticle.addComment(content);
        userDailyArticleRepository.save(userDailyArticle);
    }

    // ==================== 每日单词管理 ====================

    @Transactional
    public Long createDailyWord(CreateDailyWordCommand command, UserId adminId) {
        DailyWord dailyWord = DailyWord.create(
                command.word(), command.pronunciationUs(), command.pronunciationUk(),
                command.audioUrlUs(), command.audioUrlUk(), command.translation(),
                command.example(), command.exampleTranslation(),
                Difficulty.fromCode(command.difficulty()), command.category(),
                command.notes(), command.publishDate(), adminId
        );
        dailyWordRepository.save(dailyWord);
        log.info("每日单词创建成功: wordId={}", dailyWord.getId().value());
        return dailyWord.getId().value();
    }

    @Transactional
    public void updateDailyWord(UpdateDailyWordCommand command) {
        DailyWord dailyWord = dailyWordRepository.findById(DailyWordId.of(command.wordId()))
                .orElseThrow(() -> new BusinessException(40400, "每日单词不存在"));
        dailyWord.updateInfo(command.word(), command.pronunciationUs(), command.pronunciationUk(),
                command.audioUrlUs(), command.audioUrlUk(), command.translation(),
                command.example(), command.exampleTranslation(),
                Difficulty.fromCode(command.difficulty()), command.category(),
                command.notes(), command.publishDate());
        dailyWordRepository.save(dailyWord);
        log.info("每日单词更新成功: wordId={}", command.wordId());
    }

    @Transactional
    public void deleteDailyWord(Long wordId) {
        dailyWordRepository.deleteById(DailyWordId.of(wordId));
        log.info("每日单词删除成功: wordId={}", wordId);
    }

    // ==================== 单词学习交互 ====================

    @Transactional
    public void studyWord(Long userId, Long wordId) {
        DailyWordId dailyWordId = DailyWordId.of(wordId);
        UserId userIdObj = UserId.of(userId);

        dailyWordRepository.findById(dailyWordId)
                .orElseThrow(() -> new BusinessException(40400, "单词不存在"));

        UserDailyWord userDailyWord = userDailyWordRepository
                .findByUserIdAndWordId(userIdObj, dailyWordId)
                .orElseGet(() -> UserDailyWord.create(userIdObj, dailyWordId));

        userDailyWord.markAsStudied();
        userDailyWordRepository.save(userDailyWord);
    }

    @Transactional
    public void updateWordMastery(Long userId, Long wordId, Integer masteryLevel) {
        DailyWordId dailyWordId = DailyWordId.of(wordId);
        UserId userIdObj = UserId.of(userId);

        UserDailyWord userDailyWord = userDailyWordRepository
                .findByUserIdAndWordId(userIdObj, dailyWordId)
                .orElseThrow(() -> new BusinessException(40400, "用户单词记录不存在"));

        userDailyWord.updateMasteryLevel(MasteryLevel.fromCode(masteryLevel));
        userDailyWordRepository.save(userDailyWord);
    }

    @Transactional
    public void toggleWordCollect(Long userId, Long wordId) {
        DailyWordId dailyWordId = DailyWordId.of(wordId);
        UserId userIdObj = UserId.of(userId);

        dailyWordRepository.findById(dailyWordId)
                .orElseThrow(() -> new BusinessException(40400, "单词不存在"));

        UserDailyWord userDailyWord = userDailyWordRepository
                .findByUserIdAndWordId(userIdObj, dailyWordId)
                .orElseGet(() -> UserDailyWord.create(userIdObj, dailyWordId));

        userDailyWord.toggleCollect();
        userDailyWordRepository.save(userDailyWord);
    }

    // ==================== 生词本 ====================

    @Transactional
    public Long addToWordBook(Long userId, Long wordId) {
        DailyWordId dailyWordId = DailyWordId.of(wordId);
        UserId userIdObj = UserId.of(userId);

        dailyWordRepository.findById(dailyWordId)
                .orElseThrow(() -> new BusinessException(40400, "单词不存在"));

        UserWordBook existingWordBook = userWordBookRepository
                .findByUserIdAndWordId(userIdObj, dailyWordId)
                .orElse(null);

        if (existingWordBook != null) {
            if (existingWordBook.isDeleted()) {
                existingWordBook.restore();
                userWordBookRepository.save(existingWordBook);
                return existingWordBook.getId();
            }
            throw new BusinessException(40000, "单词已在生词本中");
        }

        UserWordBook wordBook = UserWordBook.create(userIdObj, dailyWordId);
        userWordBookRepository.save(wordBook);
        return wordBook.getId();
    }

    @Transactional
    public void updateWordBookLearningStatus(Long userId, Long wordBookId, Integer status) {
        UserWordBook wordBook = userWordBookRepository.findById(wordBookId)
                .orElseThrow(() -> new BusinessException(40400, "生词本记录不存在"));

        try {
            wordBook.ensureOwnedBy(UserId.of(userId));
        } catch (IllegalStateException e) {
            throw new BusinessException(40300, e.getMessage());
        }

        wordBook.updateLearningStatus(LearningStatus.fromCode(status));
        userWordBookRepository.save(wordBook);
    }

    @Transactional
    public void removeFromWordBook(Long userId, Long wordBookId) {
        UserWordBook wordBook = userWordBookRepository.findById(wordBookId)
                .orElseThrow(() -> new BusinessException(40400, "生词本记录不存在"));

        try {
            wordBook.ensureOwnedBy(UserId.of(userId));
        } catch (IllegalStateException e) {
            throw new BusinessException(40300, e.getMessage());
        }

        wordBook.markAsDeleted();
        userWordBookRepository.save(wordBook);
    }
}
