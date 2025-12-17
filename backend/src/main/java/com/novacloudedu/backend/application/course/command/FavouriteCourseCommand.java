package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.CourseFavourite;
import com.novacloudedu.backend.domain.course.repository.CourseFavouriteRepository;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class FavouriteCourseCommand {

    private final CourseFavouriteRepository favouriteRepository;
    private final CourseRepository courseRepository;

    @Transactional
    public void execute(UserId userId, Long courseId) {
        courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        if (favouriteRepository.existsByUserIdAndCourseId(userId, CourseId.of(courseId))) {
            throw new BusinessException(40330, "已收藏该课程");
        }

        CourseFavourite favourite = CourseFavourite.create(userId, CourseId.of(courseId));
        favouriteRepository.save(favourite);
    }
}
