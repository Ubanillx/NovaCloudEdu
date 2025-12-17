package com.novacloudedu.backend.domain.payment;

import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;

import java.math.BigDecimal;

/**
 * 支付网关接口 - 用于后期接入真实支付平台
 * 当前为测试环境，实现类返回模拟数据
 * 生产环境需要实现真实的支付宝、微信等支付接口
 */
public interface PaymentGateway {

    /**
     * 创建支付订单
     * @param orderNo 订单号
     * @param amount 支付金额
     * @param paymentMethod 支付方式
     * @param userId 用户ID
     * @return 支付参数（如支付宝的form表单、微信的prepay_id等）
     */
    PaymentResult createPayment(String orderNo, BigDecimal amount, PaymentMethod paymentMethod, Long userId);

    /**
     * 查询支付状态
     * @param orderNo 订单号
     * @return 支付查询结果
     */
    PaymentQueryResult queryPayment(String orderNo);

    /**
     * 验证支付回调签名
     * @param params 回调参数
     * @return 是否验证通过
     */
    boolean verifyCallback(String params);

    /**
     * 退款
     * @param orderNo 订单号
     * @param amount 退款金额
     * @return 退款结果
     */
    RefundResult refund(String orderNo, BigDecimal amount);
}
