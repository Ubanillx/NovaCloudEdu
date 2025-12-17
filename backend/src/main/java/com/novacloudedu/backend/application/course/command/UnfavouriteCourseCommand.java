package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.repository.CourseFavouriteRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UnfavouriteCourseCommand {

    private final CourseFavouriteRepository favouriteRepository;

    @Transactional
    public void execute(UserId userId, Long courseId) {
        favouriteRepository.deleteByUserIdAndCourseId(userId, CourseId.of(courseId));
    }
}
