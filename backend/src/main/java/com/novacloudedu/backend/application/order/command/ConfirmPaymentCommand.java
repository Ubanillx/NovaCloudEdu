package com.novacloudedu.backend.application.order.command;

/**
 * 确认支付命令
 */
public record ConfirmPaymentCommand(
        String orderNo,
        Integer paymentMethod,
        Integer validityDays
) {}
