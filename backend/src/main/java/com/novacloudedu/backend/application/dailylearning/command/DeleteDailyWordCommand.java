package com.novacloudedu.backend.application.dailylearning.command;

import com.novacloudedu.backend.domain.dailylearning.repository.DailyWordRepository;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DeleteDailyWordCommand {

    private final DailyWordRepository dailyWordRepository;

    @Transactional
    public void execute(Long id) {
        dailyWordRepository.deleteById(DailyWordId.of(id));
    }
}
