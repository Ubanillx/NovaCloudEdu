package com.novacloudedu.backend.interfaces.rest.order;

import com.novacloudedu.backend.application.service.OrderApplicationService;
import com.novacloudedu.backend.application.order.query.GetOrderQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.domain.membership.repository.MembershipPlanRepository;
import com.novacloudedu.backend.domain.membership.repository.UserMembershipRepository;
import com.novacloudedu.backend.domain.membership.valueobject.MembershipStatus;
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

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/admin/order")
@RequiredArgsConstructor
@Tag(name = "订单管理（管理员）", description = "管理员订单管理接口")
public class OrderAdminController {

    private final OrderApplicationService orderApplicationService;
    private final GetOrderQuery getOrderQuery;
    private final OrderAssembler orderAssembler;
    private final UserMembershipRepository membershipRepository;
    private final MembershipPlanRepository membershipPlanRepository;

    @PostMapping("/confirm")
    @Operation(summary = "确认收款（管理员手动确认）")
    public BaseResponse<Void> confirmPayment(@Valid @RequestBody ConfirmPaymentRequest request) {
        orderApplicationService.confirmPayment(
                request.getOrderNo(),
                PaymentMethod.fromCode(request.getPaymentMethod()),
                request.getValidityDays()
        );
        return ResultUtils.success(null);
    }

    @PostMapping("/{orderNo}/refund")
    @Operation(summary = "退款（管理员）")
    public BaseResponse<Void> refund(@PathVariable @Parameter(description = "订单号") String orderNo) {
        orderApplicationService.refundOrder(orderNo);
        return ResultUtils.success(null);
    }

    @GetMapping("/list")
    @Operation(summary = "获取订单列表（管理员，包含课程订单和会员订单）")
    public BaseResponse<List<OrderResponse>> listOrders(
            @RequestParam(required = false) @Parameter(description = "订单状态：0-未支付，1-已支付，2-已过期，3-已退款/已取消") Integer status,
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size) {

        // 1. 查课程订单
        List<UserCourse> courseOrders;
        if (status != null) {
            courseOrders = getOrderQuery.executeByStatus(OrderStatus.fromCode(status), page, size);
        } else {
            courseOrders = getOrderQuery.executeByStatus(OrderStatus.UNPAID, page, size);
        }
        List<OrderResponse> responses = new ArrayList<>(courseOrders.stream()
                .map(orderAssembler::toOrderResponse)
                .collect(Collectors.toList()));

        // 2. 查会员订单（状态码相同：0=PENDING/UNPAID, 1=ACTIVE/PAID, 2=EXPIRED, 3=CANCELLED/REFUNDED）
        MembershipStatus membershipStatus = status != null
                ? MembershipStatus.fromCode(status)
                : MembershipStatus.PENDING;
        List<UserMembership> membershipOrders = membershipRepository.findByStatus(membershipStatus, page, size);
        for (UserMembership m : membershipOrders) {
            MembershipPlan plan = membershipPlanRepository.findById(m.getPlanId()).orElse(null);
            responses.add(orderAssembler.toOrderResponse(m, plan));
        }

        // 3. 按创建时间倒序排列
        responses.sort(Comparator.comparing(OrderResponse::getCreateTime, Comparator.nullsLast(Comparator.reverseOrder())));

        return ResultUtils.success(responses);
    }

    @GetMapping("/statistics")
    @Operation(summary = "订单统计（管理员，包含课程+会员）")
    public BaseResponse<OrderStatistics> getStatistics() {
        long unpaidCount = getOrderQuery.countByStatus(OrderStatus.UNPAID)
                + membershipRepository.countByStatus(MembershipStatus.PENDING);
        long paidCount = getOrderQuery.countByStatus(OrderStatus.PAID)
                + membershipRepository.countByStatus(MembershipStatus.ACTIVE);
        long expiredCount = getOrderQuery.countByStatus(OrderStatus.EXPIRED)
                + membershipRepository.countByStatus(MembershipStatus.EXPIRED);
        long refundedCount = getOrderQuery.countByStatus(OrderStatus.REFUNDED)
                + membershipRepository.countByStatus(MembershipStatus.CANCELLED);

        OrderStatistics statistics = new OrderStatistics(unpaidCount, paidCount, expiredCount, refundedCount);
        return ResultUtils.success(statistics);
    }

    public record OrderStatistics(long unpaidCount, long paidCount, long expiredCount, long refundedCount) {}
}
