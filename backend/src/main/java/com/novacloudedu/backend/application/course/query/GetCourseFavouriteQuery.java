package com.novacloudedu.backend.application.course.query;

import com.novacloudedu.backend.domain.course.entity.CourseFavourite;
import com.novacloudedu.backend.domain.course.repository.CourseFavouriteRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class GetCourseFavouriteQuery {

    private final CourseFavouriteRepository favouriteRepository;

    public List<CourseFavourite> executeByUserId(UserId userId, int page, int size) {
        return favouriteRepository.findByUserId(userId, page, size);
    }

    public boolean isFavourite(UserId userId, Long courseId) {
        return favouriteRepository.existsByUserIdAndCourseId(userId, CourseId.of(courseId));
    }

    public long countByCourseId(Long courseId) {
        return favouriteRepository.countByCourseId(CourseId.of(courseId));
    }
}
