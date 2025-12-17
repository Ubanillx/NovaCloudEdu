package com.novacloudedu.backend.application.order.query;

import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.order.valueobject.OrderStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetOrderQuery {

    private final UserCourseRepository userCourseRepository;

    public Optional<UserCourse> execute(Long orderId) {
        return userCourseRepository.findById(orderId);
    }

    public Optional<UserCourse> executeByOrderNo(String orderNo) {
        return userCourseRepository.findByOrderNo(orderNo);
    }

    public List<UserCourse> executeByUserId(UserId userId, int page, int size) {
        return userCourseRepository.findByUserId(userId, page, size);
    }

    public List<UserCourse> executeByStatus(OrderStatus status, int page, int size) {
        return userCourseRepository.findByStatus(status, page, size);
    }

    public long countByStatus(OrderStatus status) {
        return userCourseRepository.countByStatus(status);
    }
}
