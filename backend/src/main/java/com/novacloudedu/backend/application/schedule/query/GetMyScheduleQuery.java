package com.novacloudedu.backend.application.schedule.query;

import com.novacloudedu.backend.domain.clazz.entity.ClassMember;
import com.novacloudedu.backend.domain.clazz.repository.ClassMemberRepository;
import com.novacloudedu.backend.domain.schedule.entity.ClassScheduleItem;
import com.novacloudedu.backend.domain.schedule.repository.ScheduleRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GetMyScheduleQuery {

    private final ScheduleRepository scheduleRepository;
    private final ClassMemberRepository classMemberRepository;

    public List<ClassScheduleItem> execute(Long userId) {
        UserId uid = UserId.of(userId);
        
        // 1. Get Personal Items
        List<ClassScheduleItem> personalItems = scheduleRepository.findItemsByUserId(uid);
        
        // 2. Get Teacher Items (Active)
        List<ClassScheduleItem> teacherItems = scheduleRepository.findActiveItemsByTeacherId(TeacherId.of(userId));
        
        // 3. Get Class Items (Active Settings for classes user is a member of)
        List<ClassScheduleItem> classItems = new ArrayList<>();
        List<ClassMember> memberships = classMemberRepository.findByUserId(uid);
        
        for (ClassMember member : memberships) {
            // Only consider if student? Or all members?
            // Assuming if you join a class, you want its schedule.
            // But if you are a teacher, maybe you don't want to see all courses?
            // For now, let's include all. Front-end can filter if needed, or we assume membership implies subscription.
            scheduleRepository.findActiveSettingByClassId(member.getClassId())
                    .ifPresent(setting -> {
                        classItems.addAll(scheduleRepository.findItemsBySettingId(setting.getId()));
                    });
        }

        // 4. Merge and Deduplicate
        // Use a Map to deduplicate by ID
        Map<Long, ClassScheduleItem> itemMap = personalItems.stream()
                .collect(Collectors.toMap(ClassScheduleItem::getId, Function.identity(), (existing, replacement) -> existing));
        
        teacherItems.forEach(item -> itemMap.putIfAbsent(item.getId(), item));
        classItems.forEach(item -> itemMap.putIfAbsent(item.getId(), item));

        // Return sorted list? The individual queries were sorted, but merging breaks it.
        // Re-sort by Day and Start Section
        return itemMap.values().stream()
                .sorted((a, b) -> {
                    int dayCompare = Integer.compare(a.getDayOfWeek(), b.getDayOfWeek());
                    if (dayCompare != 0) return dayCompare;
                    return Integer.compare(a.getStartSection(), b.getStartSection());
                })
                .collect(Collectors.toList());
    }
}
