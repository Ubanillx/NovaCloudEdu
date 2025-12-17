package com.novacloudedu.backend.interfaces.rest.order.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "订单信息响应")
public class OrderResponse {

    @Schema(description = "订单ID")
    private Long id;

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "课程ID")
    private Long courseId;

    @Schema(description = "订单号")
    private String orderNo;

    @Schema(description = "购买价格")
    private BigDecimal price;

    @Schema(description = "支付方式")
    private Integer paymentMethod;

    @Schema(description = "支付方式描述")
    private String paymentMethodDesc;

    @Schema(description = "支付时间")
    private LocalDateTime paymentTime;

    @Schema(description = "过期时间")
    private LocalDateTime expireTime;

    @Schema(description = "订单状态：0-未支付，1-已支付，2-已过期，3-已退款")
    private Integer status;

    @Schema(description = "订单状态描述")
    private String statusDesc;

    @Schema(description = "是否有效")
    private Boolean isValid;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
