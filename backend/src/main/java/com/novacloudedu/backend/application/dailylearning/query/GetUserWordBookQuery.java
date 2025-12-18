package com.novacloudedu.backend.application.dailylearning.query;

import com.novacloudedu.backend.domain.dailylearning.entity.UserWordBook;
import com.novacloudedu.backend.domain.dailylearning.repository.UserWordBookRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.LearningStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetUserWordBookQuery {

    private final UserWordBookRepository userWordBookRepository;

    public Optional<UserWordBook> executeById(Long id) {
        return userWordBookRepository.findById(id);
    }

    public List<UserWordBook> executeByUserId(Long userId, int page, int size) {
        return userWordBookRepository.findByUserId(UserId.of(userId), page, size);
    }

    public List<UserWordBook> executeByUserIdAndStatus(Long userId, Integer status, int page, int size) {
        return userWordBookRepository.findByUserIdAndStatus(
                UserId.of(userId), LearningStatus.fromCode(status), page, size);
    }

    public long countByUserId(Long userId) {
        return userWordBookRepository.countByUserId(UserId.of(userId));
    }

    public long countByUserIdAndStatus(Long userId, Integer status) {
        return userWordBookRepository.countByUserIdAndStatus(UserId.of(userId), LearningStatus.fromCode(status));
    }
}
