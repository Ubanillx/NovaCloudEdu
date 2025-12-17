package com.novacloudedu.backend.domain.order.repository;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.valueobject.OrderStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface UserCourseRepository {

    UserCourse save(UserCourse userCourse);

    Optional<UserCourse> findById(Long id);

    Optional<UserCourse> findByOrderNo(String orderNo);

    Optional<UserCourse> findByUserIdAndCourseId(UserId userId, CourseId courseId);

    List<UserCourse> findByUserId(UserId userId, int page, int size);

    List<UserCourse> findByStatus(OrderStatus status, int page, int size);

    boolean existsByUserIdAndCourseId(UserId userId, CourseId courseId);

    long countByStatus(OrderStatus status);

    void deleteById(Long id);
}
