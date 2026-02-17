package com.novacloudedu.backend.infrastructure.payment;

import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.domain.payment.*;
import lombok.extern.slf4j.Slf4j;

import java.math.BigDecimal;

/**
 * 支付宝支付网关实现 - 预留接口
 * 
 * TODO: 接入真实支付宝支付
 * 1. 引入 alipay-sdk-java 依赖
 * 2. 配置 appId、商户私钥、支付宝公钥
 * 3. 实现各方法的真实调用逻辑
 * 4. 使用 @ConditionalOnProperty(name = "payment.alipay.enabled", havingValue = "true") 启用
 * 
 * 当前为空壳实现，不注册为Spring Bean，不会被使用。
 * 生产环境启用时需要：
 * - 添加 @Component 注解
 * - 添加 @ConditionalOnProperty 条件
 * - 移除 MockPaymentGateway 的 @Primary 或使用 @Profile 区分
 */
@Slf4j
public class AlipayPaymentGateway implements PaymentGateway {

    // TODO: 注入支付宝配置
    // private String appId;
    // private String merchantPrivateKey;
    // private String alipayPublicKey;
    // private String notifyUrl;
    // private String returnUrl;

    @Override
    public PaymentResult createPayment(String orderNo, BigDecimal amount, PaymentMethod paymentMethod, Long userId) {
        // TODO: 实现支付宝下单
        // AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        // request.setNotifyUrl(notifyUrl);
        // request.setReturnUrl(returnUrl);
        // ...
        throw new UnsupportedOperationException("支付宝支付尚未接入，请使用管理员手动确认");
    }

    @Override
    public PaymentQueryResult queryPayment(String orderNo) {
        // TODO: 实现支付宝订单查询
        // AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
        // ...
        throw new UnsupportedOperationException("支付宝支付查询尚未接入");
    }

    @Override
    public boolean verifyCallback(String params) {
        // TODO: 实现支付宝回调签名验证
        // AlipaySignature.rsaCheckV1(paramsMap, alipayPublicKey, charset, signType)
        throw new UnsupportedOperationException("支付宝回调验签尚未接入");
    }

    @Override
    public RefundResult refund(String orderNo, BigDecimal amount) {
        // TODO: 实现支付宝退款
        // AlipayTradeRefundRequest request = new AlipayTradeRefundRequest();
        // ...
        throw new UnsupportedOperationException("支付宝退款尚未接入");
    }
}
