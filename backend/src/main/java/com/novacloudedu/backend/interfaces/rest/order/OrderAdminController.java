package com.novacloudedu.backend.interfaces.rest.order;

import com.novacloudedu.backend.application.order.command.ConfirmPaymentCommand;
import com.novacloudedu.backend.application.order.command.RefundOrderCommand;
import com.novacloudedu.backend.application.order.query.GetOrderQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.valueobject.OrderStatus;
import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.interfaces.rest.order.assembler.OrderAssembler;
import com.novacloudedu.backend.interfaces.rest.order.dto.ConfirmPaymentRequest;
import com.novacloudedu.backend.interfaces.rest.order.dto.OrderResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/admin/order")
@RequiredArgsConstructor
@Tag(name = "订单管理（管理员）", description = "管理员订单管理接口")
public class OrderAdminController {

    private final ConfirmPaymentCommand confirmPaymentCommand;
    private final RefundOrderCommand refundOrderCommand;
    private final GetOrderQuery getOrderQuery;
    private final OrderAssembler orderAssembler;

    @PostMapping("/confirm")
    @Operation(summary = "确认收款（管理员手动确认）")
    public BaseResponse<Void> confirmPayment(@Valid @RequestBody ConfirmPaymentRequest request) {
        confirmPaymentCommand.execute(
                request.getOrderNo(),
                PaymentMethod.fromCode(request.getPaymentMethod()),
                request.getValidityDays()
        );
        return ResultUtils.success(null);
    }

    @PostMapping("/{orderNo}/refund")
    @Operation(summary = "退款（管理员）")
    public BaseResponse<Void> refund(@PathVariable @Parameter(description = "订单号") String orderNo) {
        refundOrderCommand.execute(orderNo);
        return ResultUtils.success(null);
    }

    @GetMapping("/list")
    @Operation(summary = "获取订单列表（管理员）")
    public BaseResponse<List<OrderResponse>> listOrders(
            @RequestParam(required = false) @Parameter(description = "订单状态：0-未支付，1-已支付，2-已过期，3-已退款") Integer status,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {
        
        List<UserCourse> orders;
        if (status != null) {
            orders = getOrderQuery.executeByStatus(OrderStatus.fromCode(status), page, size);
        } else {
            orders = getOrderQuery.executeByStatus(OrderStatus.UNPAID, page, size);
        }
        
        List<OrderResponse> responses = orders.stream()
                .map(orderAssembler::toOrderResponse)
                .collect(Collectors.toList());
        
        return ResultUtils.success(responses);
    }

    @GetMapping("/statistics")
    @Operation(summary = "订单统计（管理员）")
    public BaseResponse<OrderStatistics> getStatistics() {
        long unpaidCount = getOrderQuery.countByStatus(OrderStatus.UNPAID);
        long paidCount = getOrderQuery.countByStatus(OrderStatus.PAID);
        long expiredCount = getOrderQuery.countByStatus(OrderStatus.EXPIRED);
        long refundedCount = getOrderQuery.countByStatus(OrderStatus.REFUNDED);
        
        OrderStatistics statistics = new OrderStatistics(unpaidCount, paidCount, expiredCount, refundedCount);
        return ResultUtils.success(statistics);
    }

    public record OrderStatistics(long unpaidCount, long paidCount, long expiredCount, long refundedCount) {}
}
