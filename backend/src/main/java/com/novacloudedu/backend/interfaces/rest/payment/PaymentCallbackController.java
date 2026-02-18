package com.novacloudedu.backend.interfaces.rest.payment;

import com.novacloudedu.backend.application.membership.service.MembershipApplicationService;
import com.novacloudedu.backend.application.service.OrderApplicationService;
import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.domain.payment.service.PaymentGateway;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 支付回调统一入口 - 预留接口
 * 
 * TODO: 接入真实支付平台后启用
 * 当前所有支付均通过管理员手动确认完成。
 * 接入真实支付后，支付平台会异步回调此接口通知支付结果。
 */
@Slf4j
@RestController
@RequestMapping("/api/payment/callback")
@RequiredArgsConstructor
@Tag(name = "支付回调（预留）", description = "支付平台异步回调接口，当前未启用")
public class PaymentCallbackController {

    private final PaymentGateway paymentGateway;
    private final OrderApplicationService orderApplicationService;
    private final MembershipApplicationService membershipApplicationService;

    /**
     * 支付宝异步回调
     * 
     * TODO: 接入真实支付宝后实现
     * 1. 验证签名
     * 2. 解析订单号和支付状态
     * 3. 根据订单号前缀判断是课程订单还是会员订单
     * 4. 调用对应的确认支付逻辑
     * 5. 返回 "success" 给支付宝
     */
    @PostMapping("/alipay")
    @Operation(summary = "支付宝异步回调（预留）")
    public String alipayCallback(@RequestBody String params) {
        log.info("【预留】收到支付宝回调请求，当前未启用真实支付");

        // TODO: 真实支付接入后取消注释
        // if (!paymentGateway.verifyCallback(params)) {
        //     log.warn("支付宝回调签名验证失败");
        //     return "fail";
        // }
        //
        // String orderNo = extractOrderNo(params);
        // String tradeStatus = extractTradeStatus(params);
        //
        // if ("TRADE_SUCCESS".equals(tradeStatus)) {
        //     if (orderNo.startsWith("ORDER")) {
        //         confirmPaymentCommand.execute(orderNo, PaymentMethod.ALIPAY, null);
        //     } else if (orderNo.startsWith("MEM")) {
        //         membershipApplicationService.confirmMembershipPayment(orderNo);
        //     }
        // }
        //
        // return "success";

        return "fail";
    }

    /**
     * 微信支付异步回调
     * 
     * TODO: 接入真实微信支付后实现
     */
    @PostMapping("/wechat")
    @Operation(summary = "微信支付异步回调（预留）")
    public String wechatCallback(@RequestBody String params) {
        log.info("【预留】收到微信支付回调请求，当前未启用真实支付");

        // TODO: 真实支付接入后取消注释
        // 1. 验证签名
        // 2. 解析XML/JSON
        // 3. 确认支付

        return "<xml><return_code><![CDATA[FAIL]]></return_code></xml>";
    }
}
