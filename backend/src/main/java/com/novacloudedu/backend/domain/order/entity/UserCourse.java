package com.novacloudedu.backend.domain.order.entity;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.order.valueobject.OrderStatus;
import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
public class UserCourse {

    private Long id;
    private final UserId userId;
    private final CourseId courseId;
    private String orderNo;
    private BigDecimal price;
    private PaymentMethod paymentMethod;
    private LocalDateTime paymentTime;
    private LocalDateTime expireTime;
    private OrderStatus status;
    private final LocalDateTime createTime;
    private LocalDateTime updateTime;

    private UserCourse(Long id, UserId userId, CourseId courseId, String orderNo,
                      BigDecimal price, PaymentMethod paymentMethod, LocalDateTime paymentTime,
                      LocalDateTime expireTime, OrderStatus status,
                      LocalDateTime createTime, LocalDateTime updateTime) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.orderNo = orderNo;
        this.price = price;
        this.paymentMethod = paymentMethod;
        this.paymentTime = paymentTime;
        this.expireTime = expireTime;
        this.status = status;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public static UserCourse create(UserId userId, CourseId courseId, String orderNo, BigDecimal price) {
        LocalDateTime now = LocalDateTime.now();
        return new UserCourse(null, userId, courseId, orderNo, price, null, null,
                null, OrderStatus.UNPAID, now, now);
    }

    public static UserCourse reconstruct(Long id, UserId userId, CourseId courseId, String orderNo,
                                        BigDecimal price, PaymentMethod paymentMethod,
                                        LocalDateTime paymentTime, LocalDateTime expireTime,
                                        OrderStatus status, LocalDateTime createTime,
                                        LocalDateTime updateTime) {
        return new UserCourse(id, userId, courseId, orderNo, price, paymentMethod,
                paymentTime, expireTime, status, createTime, updateTime);
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("订单ID已存在");
        }
        this.id = id;
    }

    public void confirmPayment(PaymentMethod paymentMethod, LocalDateTime expireTime) {
        if (this.status != OrderStatus.UNPAID) {
            throw new IllegalStateException("只有未支付的订单才能确认支付");
        }
        this.status = OrderStatus.PAID;
        this.paymentMethod = paymentMethod;
        this.paymentTime = LocalDateTime.now();
        this.expireTime = expireTime;
        this.updateTime = LocalDateTime.now();
    }

    public void expire() {
        if (this.status != OrderStatus.PAID) {
            throw new IllegalStateException("只有已支付的订单才能过期");
        }
        this.status = OrderStatus.EXPIRED;
        this.updateTime = LocalDateTime.now();
    }

    public void refund() {
        if (this.status != OrderStatus.PAID) {
            throw new IllegalStateException("只有已支付的订单才能退款");
        }
        this.status = OrderStatus.REFUNDED;
        this.updateTime = LocalDateTime.now();
    }

    public boolean isPaid() {
        return this.status == OrderStatus.PAID;
    }

    public boolean isValid() {
        return this.status == OrderStatus.PAID && 
               (this.expireTime == null || this.expireTime.isAfter(LocalDateTime.now()));
    }
}
