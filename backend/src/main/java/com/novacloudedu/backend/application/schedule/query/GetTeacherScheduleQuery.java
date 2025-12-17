package com.novacloudedu.backend.application.schedule.query;

import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class GetTeacherScheduleQuery {

    private final ScheduleRepository scheduleRepository;

    public List<ClassScheduleItem> execute(Long teacherId) {
        return scheduleRepository.findActiveItemsByTeacherId(TeacherId.of(teacherId));
    }
}
