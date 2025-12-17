package com.novacloudedu.backend.interfaces.rest.order.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "确认支付请求（管理员）")
public class ConfirmPaymentRequest {

    @NotBlank(message = "订单号不能为空")
    @Schema(description = "订单号")
    private String orderNo;

    @NotNull(message = "支付方式不能为空")
    @Schema(description = "支付方式：0-手动确认，1-支付宝，2-微信支付，3-银联支付")
    private Integer paymentMethod;

    @Schema(description = "有效期（天数），null表示永久有效")
    private Integer validityDays;
}
