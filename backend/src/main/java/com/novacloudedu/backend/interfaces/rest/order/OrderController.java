package com.novacloudedu.backend.interfaces.rest.order;

import com.novacloudedu.backend.application.order.command.CreateOrderCommand;
import com.novacloudedu.backend.application.order.query.GetOrderQuery;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.interfaces.rest.order.assembler.OrderAssembler;
import com.novacloudedu.backend.interfaces.rest.order.dto.CreateOrderRequest;
import com.novacloudedu.backend.interfaces.rest.order.dto.OrderResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/order")
@RequiredArgsConstructor
@Tag(name = "订单管理", description = "课程订单相关接口")
public class OrderController {

    private final CreateOrderCommand createOrderCommand;
    private final GetOrderQuery getOrderQuery;
    private final OrderAssembler orderAssembler;

    @PostMapping
    @Operation(summary = "创建订单（用户下单）")
    public BaseResponse<String> createOrder(@Valid @RequestBody CreateOrderRequest request,
                                           Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        String orderNo = createOrderCommand.execute(UserId.of(userId), request.getCourseId());
        return ResultUtils.success(orderNo);
    }

    @GetMapping("/{orderNo}")
    @Operation(summary = "查询订单详情")
    public BaseResponse<OrderResponse> getOrder(@PathVariable @Parameter(description = "订单号") String orderNo,
                                               Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        UserCourse order = getOrderQuery.executeByOrderNo(orderNo)
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR));

        if (!order.getUserId().value().equals(userId)) {
            throw new BusinessException(ErrorCode.NO_AUTH_ERROR);
        }

        return ResultUtils.success(orderAssembler.toOrderResponse(order));
    }

    @GetMapping("/my")
    @Operation(summary = "获取我的订单列表")
    public BaseResponse<List<OrderResponse>> getMyOrders(
            @RequestParam(defaultValue = "1") @Parameter(description = "页码") int page,
            @RequestParam(defaultValue = "10") @Parameter(description = "每页数量") int size,
            Authentication authentication) {
        
        Long userId = Long.parseLong(authentication.getName());
        List<UserCourse> orders = getOrderQuery.executeByUserId(UserId.of(userId), page, size);
        
        List<OrderResponse> responses = orders.stream()
                .map(orderAssembler::toOrderResponse)
                .collect(Collectors.toList());
        
        return ResultUtils.success(responses);
    }
}
