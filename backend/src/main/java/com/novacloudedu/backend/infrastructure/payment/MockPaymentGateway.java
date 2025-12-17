package com.novacloudedu.backend.infrastructure.payment;

import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.domain.payment.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 模拟支付网关实现 - 仅用于测试
 * 生产环境需要替换为真实的支付网关实现
 */
@Slf4j
@Component
public class MockPaymentGateway implements PaymentGateway {

    @Override
    public PaymentResult createPayment(String orderNo, BigDecimal amount, PaymentMethod paymentMethod, Long userId) {
        log.info("【模拟支付】创建支付订单 - 订单号: {}, 金额: {}, 支付方式: {}, 用户ID: {}", 
                orderNo, amount, paymentMethod.getDescription(), userId);
        
        return PaymentResult.builder()
                .success(true)
                .message("支付订单创建成功（模拟）")
                .orderNo(orderNo)
                .paymentData("mock_payment_data_" + orderNo)
                .paymentUrl("https://mock-payment.example.com/pay?orderNo=" + orderNo)
                .build();
    }

    @Override
    public PaymentQueryResult queryPayment(String orderNo) {
        log.info("【模拟支付】查询支付状态 - 订单号: {}", orderNo);
        
        return PaymentQueryResult.builder()
                .success(true)
                .orderNo(orderNo)
                .paid(false)
                .amount(BigDecimal.ZERO)
                .paymentTime(null)
                .message("订单未支付（模拟）")
                .build();
    }

    @Override
    public boolean verifyCallback(String params) {
        log.info("【模拟支付】验证回调签名 - 参数: {}", params);
        return true;
    }

    @Override
    public RefundResult refund(String orderNo, BigDecimal amount) {
        log.info("【模拟支付】退款 - 订单号: {}, 金额: {}", orderNo, amount);
        
        return RefundResult.builder()
                .success(true)
                .orderNo(orderNo)
                .refundAmount(amount)
                .message("退款成功（模拟）")
                .build();
    }
}
