package com.novacloudedu.backend.application.schedule.command;

import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DeleteScheduleItemCommand {

    private final ScheduleRepository scheduleRepository;

    @Transactional
    public void execute(Long itemId) {
        scheduleRepository.deleteItem(itemId);
    }
}
