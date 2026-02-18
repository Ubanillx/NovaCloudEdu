package com.novacloudedu.backend.interfaces.rest.membership;

import com.novacloudedu.backend.application.membership.service.MembershipApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.interfaces.rest.membership.dto.PurchaseMembershipRequest;
import com.novacloudedu.backend.interfaces.rest.membership.dto.UserMembershipDetailResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/membership")
@RequiredArgsConstructor
@Tag(name = "会员管理", description = "用户侧会员相关接口")
public class MembershipController {

    private final MembershipApplicationService membershipApplicationService;

    @GetMapping("/plans")
    @Operation(summary = "获取所有会员计划")
    public BaseResponse<List<MembershipPlan>> listPlans() {
        return ResultUtils.success(membershipApplicationService.listPlans());
    }

    @GetMapping("/plans/{planId}")
    @Operation(summary = "获取计划详情")
    public BaseResponse<MembershipPlan> getPlan(@PathVariable Long planId) {
        return ResultUtils.success(membershipApplicationService.getPlan(planId));
    }

    @PostMapping("/purchase")
    @Operation(summary = "购买会员（创建待支付订单）")
    public BaseResponse<String> purchaseMembership(@Valid @RequestBody PurchaseMembershipRequest request,
                                                    Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        String orderNo = membershipApplicationService.purchaseMembership(userId, request.getPlanId());
        return ResultUtils.success(orderNo);
    }

    @GetMapping("/current")
    @Operation(summary = "查询我的当前会员详细信息")
    public BaseResponse<UserMembershipDetailResponse> getCurrentMembership(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        return ResultUtils.success(membershipApplicationService.getCurrentMembershipDetail(userId).orElse(null));
    }

    @GetMapping("/history")
    @Operation(summary = "查询我的会员历史")
    public BaseResponse<List<UserMembership>> getMembershipHistory(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        return ResultUtils.success(membershipApplicationService.getMembershipHistory(userId));
    }

    @GetMapping("/ai-quota")
    @Operation(summary = "查询我的AI功能剩余额度")
    public BaseResponse<Map<String, Map<String, Integer>>> getAiQuota(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        return ResultUtils.success(membershipApplicationService.getAiQuota(userId));
    }

    @PostMapping("/cancel")
    @Operation(summary = "取消会员")
    public BaseResponse<Void> cancelMembership(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        membershipApplicationService.cancelMembership(userId);
        return ResultUtils.success(null);
    }
}
