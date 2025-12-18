package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.repository.DailyArticleRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyArticleId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DeleteDailyArticleCommand {

    private final DailyArticleRepository dailyArticleRepository;

    @Transactional
    public void execute(Long id) {
        dailyArticleRepository.deleteById(DailyArticleId.of(id));
    }
}
