package com.novacloudedu.backend.application.order.command;

import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.payment.PaymentGateway;
import com.novacloudedu.backend.domain.payment.RefundResult;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class RefundOrderCommand {

    private final UserCourseRepository userCourseRepository;
    private final PaymentGateway paymentGateway;

    @Transactional
    public void execute(String orderNo) {
        UserCourse userCourse = userCourseRepository.findByOrderNo(orderNo)
                .orElseThrow(() -> new BusinessException(40400, "订单不存在"));

        RefundResult result = paymentGateway.refund(orderNo, userCourse.getPrice());
        
        if (!result.isSuccess()) {
            throw new BusinessException(50000, "退款失败: " + result.getMessage());
        }

        userCourse.refund();
        userCourseRepository.save(userCourse);
    }
}
