package com.novacloudedu.backend.infrastructure.payment;

import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.domain.payment.*;
import lombok.extern.slf4j.Slf4j;

import java.math.BigDecimal;

/**
 * 微信支付网关实现 - 预留接口
 * 
 * TODO: 接入真实微信支付
 * 1. 引入 wechatpay-java 依赖
 * 2. 配置 appId、mchId、apiKey、证书路径
 * 3. 实现各方法的真实调用逻辑
 * 4. 使用 @ConditionalOnProperty(name = "payment.wechat.enabled", havingValue = "true") 启用
 * 
 * 当前为空壳实现，不注册为Spring Bean，不会被使用。
 */
@Slf4j
public class WechatPayPaymentGateway implements PaymentGateway {

    // TODO: 注入微信支付配置
    // private String appId;
    // private String mchId;
    // private String apiKey;
    // private String notifyUrl;

    @Override
    public PaymentResult createPayment(String orderNo, BigDecimal amount, PaymentMethod paymentMethod, Long userId) {
        // TODO: 实现微信支付统一下单
        // WxPayUnifiedOrderV3Request request = new WxPayUnifiedOrderV3Request();
        // ...
        throw new UnsupportedOperationException("微信支付尚未接入，请使用管理员手动确认");
    }

    @Override
    public PaymentQueryResult queryPayment(String orderNo) {
        // TODO: 实现微信支付订单查询
        throw new UnsupportedOperationException("微信支付查询尚未接入");
    }

    @Override
    public boolean verifyCallback(String params) {
        // TODO: 实现微信支付回调签名验证
        throw new UnsupportedOperationException("微信支付回调验签尚未接入");
    }

    @Override
    public RefundResult refund(String orderNo, BigDecimal amount) {
        // TODO: 实现微信支付退款
        throw new UnsupportedOperationException("微信支付退款尚未接入");
    }
}
